<?php
include '../includes/auth.php';
require_login();
include '../config/db.php';
if (!isset($_GET['subbab'])) {
    echo 'Subbab tidak ditemukan.';
    exit;
}
$subbab_id = intval($_GET['subbab']);

$user_id = $_SESSION['user_id'];
// Waktu mulai kuis (per subbab) disimpan di session
if (!isset($_SESSION['kuis_mulai'][$subbab_id])) {
    if (!isset($_SESSION['kuis_mulai'])) $_SESSION['kuis_mulai'] = [];
    $_SESSION['kuis_mulai'][$subbab_id] = time();
}
// Ambil id soal yang sudah dijawab benar oleh user (sementara, sebelum klaim)
$soal_sudah = [];
// Ambil id soal yang sudah dijawab benar oleh user pada subbab ini
$res = $conn->query("SELECT ju.id_soal FROM jawaban_user ju JOIN soal_kuis sq ON ju.id_soal = sq.id WHERE ju.id_user=$user_id AND sq.id_subbab=$subbab_id AND ju.benar=1");
while($r = $res->fetch_assoc()) $soal_sudah[] = $r['id_soal'];
// Ambil soal berikutnya yang belum dijawab benar
$soal = $conn->query("SELECT * FROM soal_kuis WHERE id_subbab=$subbab_id " . (count($soal_sudah) ? "AND id NOT IN (".implode(",", $soal_sudah).")" : "") . " ORDER BY id ASC LIMIT 1");
$soal_row = $soal->fetch_assoc();


// Proses jawaban user
$feedback = '';
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['soal_id'])) {
    $soal_id = intval($_POST['soal_id']);
    $jawab = trim($_POST['jawaban'] ?? '');
    $cek = $conn->query("SELECT * FROM soal_kuis WHERE id=$soal_id")->fetch_assoc();
    // Cek sudah benar sebelumnya (berdasarkan subbab)
    $sudah_benar = $conn->query("SELECT ju.id FROM jawaban_user ju JOIN soal_kuis sq ON ju.id_soal = sq.id WHERE ju.id_user=$user_id AND ju.id_soal=$soal_id AND ju.benar=1 AND sq.id_subbab=$subbab_id")->num_rows > 0;
    if ($cek && !$sudah_benar) {
        $is_benar = (strtolower($jawab) == strtolower($cek['jawaban_benar']));
        $conn->query("INSERT INTO jawaban_user (id_user, id_soal, jawaban, benar) VALUES ($user_id, $soal_id, '".$conn->real_escape_string($jawab)."', ".($is_benar?1:0).")");
        if ($is_benar) {
            // Redirect ke kuis.php?subbab=... untuk soal berikutnya
            header("Location: kuis.php?subbab=$subbab_id&berhasil=1");
            exit;
        } else {
            $feedback = '<div class="mb-4 p-3 bg-red-100 text-red-700 rounded">Jawaban salah! Jawaban benar: <b>'.htmlspecialchars($cek['jawaban_benar']).'</b></div>';
        }
    }
    // Refresh soal berikutnya
    $soal = $conn->query("SELECT * FROM soal_kuis WHERE id_subbab=$subbab_id " . (count($soal_sudah) ? "AND id NOT IN (".implode(",", $soal_sudah).")" : "") . " ORDER BY id ASC LIMIT 1");
    $soal_row = $soal->fetch_assoc();
}

// Proses klaim XP
$show_popup = false;
$rekap = [];
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['klaim_xp'])) {
    // Hitung total benar dan total soal subbab ini
    $q = $conn->query("SELECT COUNT(*) as total, SUM(benar) as benar FROM jawaban_user ju JOIN soal_kuis sq ON ju.id_soal = sq.id WHERE ju.id_user=$user_id AND sq.id_subbab=$subbab_id");
    $d = $q->fetch_assoc();
    $total = intval($d['total']);
    $benar = intval($d['benar']);
    $xp = $benar * 10;
    // Cek apakah sudah pernah klaim XP subbab ini
    $cek_klaim = $conn->query("SELECT * FROM xp_klaim WHERE id_user=$user_id AND id_subbab=$subbab_id")->num_rows > 0;
    if (!$cek_klaim) {
        // Tambah XP user
        $conn->query("UPDATE users SET xp = xp + $xp WHERE id=$user_id");
        // Catat klaim
        $conn->query("INSERT INTO xp_klaim (id_user, id_subbab, xp, waktu_klaim) VALUES ($user_id, $subbab_id, $xp, NOW())");
        $show_popup = true;
        $rekap = ['xp'=>$xp, 'benar'=>$benar, 'total'=>$total, 'waktu'=>time()-$_SESSION['kuis_mulai'][$subbab_id]];
        unset($_SESSION['kuis_mulai'][$subbab_id]);
    }
}
?>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kuis Fiqih</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@3.3.0/dist/tailwind.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.1/flowbite.min.css" rel="stylesheet" />
</head>
<body class="bg-white min-h-screen flex flex-col justify-between font-sans">
    <div class="flex-1 flex flex-col items-center justify-center pt-10 pb-32">
        <div class="w-full max-w-md bg-white rounded-2xl shadow-2xl p-7 mx-2">
            <h2 class="text-3xl font-extrabold mb-6 text-center text-blue-700 drop-shadow tracking-tight">Kuis Fiqih</h2>
            <?php if ($soal_row): ?>
                <?php
                // Progress bar logic
                $total_soal = $conn->query("SELECT COUNT(*) as c FROM soal_kuis WHERE id_subbab=$subbab_id")->fetch_assoc()['c'];
                $soal_ke = $total_soal - count($soal_sudah);
                $progress = ($soal_ke > 0 && $total_soal > 0) ? (($total_soal - $soal_ke + 1) / $total_soal * 100) : 0;
                ?>
                <div class="mb-6">
                  <div class="flex items-center justify-between mb-1">
                    <span class="text-xs font-bold text-green-700">Soal <?php echo ($total_soal - $soal_ke + 1); ?> dari <?php echo $total_soal; ?></span>
                    <span class="text-xs text-red-500 flex items-center gap-1"><svg class="w-4 h-4 inline" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M12 21C12 21 4 17 4 12V7.5C4 5.01472 6.01472 3 8.5 3C10.9853 3 13 5.01472 13 7.5V12C13 17 5 21 5 21Z"/></svg> 5</span>
                  </div>
                  <div class="w-full bg-gray-200 rounded-full h-3">
                    <div class="bg-green-400 h-3 rounded-full transition-all duration-500" style="width: <?php echo $progress; ?>%"></div>
                  </div>
                </div>
                <div id="feedback-area"><?php echo $feedback; ?></div>
                <form method="post" class="space-y-6 mb-20" id="quiz-form">
                    <input type="hidden" name="soal_id" value="<?php echo $soal_row['id']; ?>">
                    <div class="mb-4">
                        <p class="font-semibold mb-2 text-gray-700">Soal: <?php echo htmlspecialchars($soal_row['soal']); ?></p>
                        <?php if($soal_row['tipe_jawaban'] == 'radio'): ?>
                            <?php
                                $opsi = [];
                                if (!empty($soal_row['pilihan_a'])) $opsi[] = $soal_row['pilihan_a'];
                                if (!empty($soal_row['pilihan_b'])) $opsi[] = $soal_row['pilihan_b'];
                                if (!empty($soal_row['pilihan_c'])) $opsi[] = $soal_row['pilihan_c'];
                                if (!empty($soal_row['pilihan_d'])) $opsi[] = $soal_row['pilihan_d'];
                                foreach($opsi as $o):
                            ?>
                                <label class="duo-3d-radio-btn cursor-pointer mb-2 w-full block">
                                    <input type="radio" name="jawaban" value="<?php echo htmlspecialchars($o); ?>" class="hidden peer" required>
                                    <span class="block px-4 py-2 rounded-xl border-2 border-blue-200 bg-white font-semibold text-blue-700 shadow text-base transition-all duration-150 peer-checked:bg-blue-100 peer-checked:border-blue-500 peer-checked:shadow-lg peer-checked:scale-105 hover:bg-blue-50"> <?php echo htmlspecialchars($o); ?> </span>
                                </label>
    <style>
    .duo-3d-btn {
        display: block;
        border-radius: 1.25rem;
        border-width: 2px;
        font-weight: 700;
        font-size: 1.25rem;
        padding: 1.5rem;
        margin-bottom: 0.5rem;
        box-shadow: 0 4px 0 0 #e5e7eb, 0 2px 8px 0 rgba(0,0,0,0.08);
        transition: transform 0.1s, box-shadow 0.1s, background 0.2s;
        background: #fff;
        position: relative;
        text-align: center;
        user-select: none;
    }
    .duo-3d-btn:hover {
        transform: translateY(-2px) scale(1.03);
        box-shadow: 0 2px 0 0 #e5e7eb, 0 4px 16px 0 rgba(0,0,0,0.10);
        background: #f3f4f6;
        z-index: 2;
    }
    .duo-3d-nav {
        display: flex;
        flex-direction: column;
        align-items: center;
        font-weight: 600;
        font-size: 1rem;
        padding: 0.5rem 0.75rem;
        border-radius: 1rem;
        background: #fff;
        box-shadow: 0 2px 0 0 #e5e7eb, 0 1px 4px 0 rgba(0,0,0,0.06);
        transition: transform 0.1s, box-shadow 0.1s, background 0.2s;
        user-select: none;
    }
    .duo-3d-nav:hover {
        transform: translateY(-2px) scale(1.04);
        box-shadow: 0 4px 0 0 #e5e7eb, 0 2px 8px 0 rgba(0,0,0,0.10);
        background: #f3f4f6;
        z-index: 2;
    }
    .duo-3d-radio-btn input[type="radio"]:focus + span {
        outline: 2px solid #3b82f6;
        outline-offset: 2px;
    }
    .duo-3d-radio-btn .peer:checked + span {
        background: linear-gradient(180deg, #e0f2fe 60%, #bae6fd 100%);
        border-color: #2563eb;
        color: #2563eb;
        box-shadow: 0 8px 0 0 #93c5fd, 0 4px 16px 0 rgba(37,99,235,0.10);
        transform: scale(1.0) translateY(-2px);
        z-index: 3;
        transition: background 0.2s, border 0.2s, color 0.2s, box-shadow 0.2s, transform 0.15s;
    }
    .duo-3d-radio-btn .peer:not(:checked) + span {
        background: #fff;
        border-color: #bfdbfe;
        color: #1d4ed8;
        box-shadow: 0 4px 0 0 #e5e7eb, 0 2px 8px 0 rgba(0,0,0,0.08);
        transform: scale(1) translateY(0);
        z-index: 1;
        transition: background 0.2s, border 0.2s, color 0.2s, box-shadow 0.2s, transform 0.15s;
    }
    </style>
                            <?php endforeach; ?>
                        <?php elseif($soal_row['tipe_jawaban'] == 'text'): ?>
                            <input type="text" name="jawaban" class="w-full px-3 py-2 border border-blue-200 rounded focus:outline-none focus:ring-2 focus:ring-blue-300 transition" required>
                        <?php elseif($soal_row['tipe_jawaban'] == 'voice'): ?>
                            <input type="text" name="jawaban" placeholder="Jawab dengan suara (fitur belum tersedia)" class="w-full px-3 py-2 border border-blue-200 rounded focus:outline-none focus:ring-2 focus:ring-blue-300 transition" required>
                        <?php endif; ?>
                    </div>
                    <button type="submit" class="duo-3d-btn bg-white text-green-700 border-green-200">Kirim Jawaban</button>
                </form>
                <!-- Sound effect -->
                <audio id="audio-correct" src="https://cdn.pixabay.com/audio/2022/07/26/audio_124bfae5b6.mp3" preload="auto"></audio>
                <audio id="audio-wrong" src="https://cdn.pixabay.com/audio/2022/07/26/audio_124bfae5b6.mp3" preload="auto"></audio>
                <audio id="audio-click" src="https://cdn.pixabay.com/audio/2022/07/26/audio_124bfae5b6.mp3" preload="auto"></audio>
                <script>
                // Play sound on button click
                document.querySelectorAll('button, input[type="radio"]').forEach(el => {
                  el.addEventListener('click', function() {
                    document.getElementById('audio-click').play();
                  });
                });
                // Animasi feedback salah/benar
                const quizForm = document.getElementById('quiz-form');
                if (quizForm) {
                  quizForm.addEventListener('submit', function(e) {
                    // Cek jawaban benar/salah dari feedback-area
                    setTimeout(() => {
                      const feedback = document.getElementById('feedback-area');
                      if (feedback && feedback.innerText.includes('Jawaban salah')) {
                        document.getElementById('audio-wrong').play();
                        feedback.classList.add('animate-shake');
                        setTimeout(()=>feedback.classList.remove('animate-shake'), 700);
                      } else if (feedback && feedback.innerText.includes('berhasil')) {
                        document.getElementById('audio-correct').play();
                      }
                    }, 200);
                  });
                }
                // Animasi shake
                const style = document.createElement('style');
                style.innerHTML = `.animate-shake { animation: shake 0.7s; } @keyframes shake { 10%, 90% { transform: translateX(-2px); } 20%, 80% { transform: translateX(4px); } 30%, 50%, 70% { transform: translateX(-8px); } 40%, 60% { transform: translateX(8px); } }`;
                document.head.appendChild(style);
                </script>
            <?php else: ?>
                <?php
                // Tampilkan popup rekap jika sudah klaim, atau form klaim jika belum
                $q = $conn->query("SELECT COUNT(*) as total, SUM(benar) as benar FROM jawaban_user ju JOIN soal_kuis sq ON ju.id_soal = sq.id WHERE ju.id_user=$user_id AND sq.id_subbab=$subbab_id");
                $d = $q->fetch_assoc();
                $total = intval($d['total']);
                $benar = intval($d['benar']);
                $xp = $benar * 10;
                $waktu = isset($_SESSION['kuis_mulai'][$subbab_id]) ? (time()-$_SESSION['kuis_mulai'][$subbab_id]) : 0;
                $cek_klaim = $conn->query("SELECT * FROM xp_klaim WHERE id_user=$user_id AND id_subbab=$subbab_id")->num_rows > 0;
                ?>
                <?php if ($show_popup || $cek_klaim): ?>
                    <div id="popup-xp" class="fixed inset-0 flex items-center justify-center bg-black bg-opacity-40 z-50">
                        <div class="bg-white rounded-lg shadow-lg p-8 max-w-sm w-full text-center">
                            <h3 class="text-xl font-bold mb-4 text-blue-700">Rekap Kuis Selesai!</h3>
                            <div class="mb-2">Total XP: <b><?php echo $xp; ?></b></div>
                            <div class="mb-2">Akurasi: <b><?php echo $total ? round($benar/$total*100,1) : 0; ?>%</b> (<?php echo $benar; ?>/<?php echo $total; ?>)</div>
                            <div class="mb-4">Waktu: <b><?php echo gmdate('i\:s', $waktu); ?></b></div>
                            <div class="mb-4 text-green-600 font-semibold">XP sudah diklaim!</div>
                            <a href="dashboard.php" class="duo-3d-btn bg-white text-blue-700 border-blue-200 mt-2">Kembali ke Dashboard</a>
                        </div>
                    </div>
                <?php else: ?>
                    <div id="popup-xp" class="fixed inset-0 flex items-center justify-center bg-black bg-opacity-40 z-50">
                        <div class="bg-white rounded-lg shadow-lg p-8 max-w-sm w-full text-center">
                            <h3 class="text-xl font-bold mb-4 text-blue-700">Rekap Kuis Selesai!</h3>
                            <div class="mb-2">Total XP: <b><?php echo $xp; ?></b></div>
                            <div class="mb-2">Akurasi: <b><?php echo $total ? round($benar/$total*100,1) : 0; ?>%</b> (<?php echo $benar; ?>/<?php echo $total; ?>)</div>
                            <div class="mb-4">Waktu: <b><?php echo gmdate('i\:s', $waktu); ?></b></div>
                            <form method="post">
                                <input type="hidden" name="klaim_xp" value="1">
                                <button type="submit" class="duo-3d-btn bg-white text-green-700 border-green-200">Klaim XP</button>
                            </form>
                        </div>
                    </div>
                <?php endif; ?>
            <?php endif; ?>
        </div>
    </div>
    <nav class="fixed bottom-0 left-0 right-0 bg-white border-t shadow-lg flex justify-between items-center h-16 z-50 px-2 md:px-8">
        <a href="dashboard.php" class="duo-3d-nav text-blue-600">
            <svg class="w-6 h-6 mb-1" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M4 6h16M4 12h16M4 18h16"/></svg>
            <span class="text-xs font-semibold">Home</span>
        </a>
        <a href="leaderboard.php" class="duo-3d-nav text-yellow-500">
            <svg class="w-6 h-6 mb-1" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <circle cx="12" cy="8" r="4" stroke="currentColor" stroke-width="2" fill="none"/>
                <path d="M7 20l5-5 5 5" stroke="currentColor" stroke-width="2" fill="none"/>
                <path d="M12 12v3" stroke="currentColor" stroke-width="2" fill="none"/>
            </svg>
            <span class="text-xs font-semibold">Leaderboard</span>
        </a>
        <a href="chat.php" class="duo-3d-nav text-green-600">
            <svg class="w-6 h-6 mb-1" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M8 10h.01M12 10h.01M16 10h.01M21 12c0 4-7 8-9 8s-9-4-9-8a9 9 0 0118 0z"/></svg>
            <span class="text-xs font-semibold">Chat</span>
        </a>
        <a href="profil.php" class="duo-3d-nav text-purple-600">
            <svg class="w-6 h-6 mb-1" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"/></svg>
            <span class="text-xs font-semibold">Profil</span>
        </a>
        <a href="../logout.php" class="duo-3d-nav text-red-600">
            <svg class="w-6 h-6 mb-1" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a2 2 0 01-2 2H7a2 2 0 01-2-2V7a2 2 0 012-2h6a2 2 0 012 2v1"/></svg>
            <span class="text-xs font-semibold">Logout</span>
        </a>
    </nav>
    <style>
    .duo-3d-btn {
        display: block;
        border-radius: 1.25rem;
        border-width: 2px;
        font-weight: 700;
        font-size: 1.25rem;
        padding: 1.5rem;
        margin-bottom: 0.5rem;
        box-shadow: 0 4px 0 0 #e5e7eb, 0 2px 8px 0 rgba(0,0,0,0.08);
        transition: transform 0.1s, box-shadow 0.1s, background 0.2s;
        background: #fff;
        position: relative;
        text-align: center;
        user-select: none;
    }
    .duo-3d-btn:hover {
        transform: translateY(-2px) scale(1.03);
        box-shadow: 0 8px 0 0 #e5e7eb, 0 4px 16px 0 rgba(0,0,0,0.10);
        background: #f3f4f6;
        z-index: 2;
    }
    .duo-3d-nav {
        display: flex;
        flex-direction: column;
        align-items: center;
        font-weight: 600;
        font-size: 1rem;
        padding: 0.5rem 0.75rem;
        border-radius: 1rem;
        background: #fff;
        box-shadow: 0 2px 0 0 #e5e7eb, 0 1px 4px 0 rgba(0,0,0,0.06);
        transition: transform 0.1s, box-shadow 0.1s, background 0.2s;
        user-select: none;
    }
    .duo-3d-nav:hover {
        transform: translateY(-2px) scale(1.04);
        box-shadow: 0 4px 0 0 #e5e7eb, 0 2px 8px 0 rgba(0,0,0,0.10);
        background: #f3f4f6;
        z-index: 2;
    }
    </style>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.1/flowbite.min.js"></script>
</body>
</html>
