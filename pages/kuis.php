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
<body class="bg-gradient-to-br from-blue-50 to-blue-100 min-h-screen flex flex-col justify-between">
    <div class="flex-1 flex flex-col items-center justify-center pt-8 pb-48">
        <div class="w-full max-w-md bg-white rounded-2xl shadow-lg p-6 mx-2">
            <h2 class="text-2xl font-extrabold mb-6 text-center text-blue-700 drop-shadow">Kuis Fiqih</h2>
            <?php if ($soal_row): ?>
                <?php echo $feedback; ?>
                <form method="post" class="space-y-6 mb-20">
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
                                <label class="flex items-center mb-1 cursor-pointer hover:bg-blue-50 rounded px-2 py-1 transition">
                                    <input type="radio" name="jawaban" value="<?php echo htmlspecialchars($o); ?>" class="mr-2 accent-blue-600" required>
                                    <span><?php echo htmlspecialchars($o); ?></span>
                                </label>
                            <?php endforeach; ?>
                        <?php elseif($soal_row['tipe_jawaban'] == 'text'): ?>
                            <input type="text" name="jawaban" class="w-full px-3 py-2 border border-blue-200 rounded focus:outline-none focus:ring-2 focus:ring-blue-300 transition" required>
                        <?php elseif($soal_row['tipe_jawaban'] == 'voice'): ?>
                            <input type="text" name="jawaban" placeholder="Jawab dengan suara (fitur belum tersedia)" class="w-full px-3 py-2 border border-blue-200 rounded focus:outline-none focus:ring-2 focus:ring-blue-300 transition" required>
                        <?php endif; ?>
                    </div>
                    <button type="submit" class="w-full bg-gradient-to-r from-green-600 to-green-400 text-white py-2 rounded-lg font-semibold shadow hover:from-green-700 hover:to-green-500 transition">Kirim Jawaban</button>
                </form>
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
                            <a href="dashboard.php" class="inline-block mt-2 px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700">Kembali ke Dashboard</a>
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
                                <button type="submit" class="w-full bg-gradient-to-r from-green-600 to-green-400 text-white py-2 rounded-lg font-semibold shadow hover:from-green-700 hover:to-green-500 transition">Klaim XP</button>
                            </form>
                        </div>
                    </div>
                <?php endif; ?>
            <?php endif; ?>
        </div>
    </div>
    <nav class="fixed bottom-0 left-0 right-0 bg-white border-t shadow flex justify-between items-center h-16 z-50 px-2 md:px-8">
        <a href="dashboard.php" class="flex flex-col items-center text-blue-600 hover:text-blue-800 transition">
            <svg class="w-6 h-6 mb-1" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M4 6h16M4 12h16M4 18h16"/></svg>
            <span class="text-xs font-medium">Home</span>
        </a>
        <a href="leaderboard.php" class="flex flex-col items-center text-yellow-500 hover:text-yellow-700 transition">
            <svg class="w-6 h-6 mb-1" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <circle cx="12" cy="8" r="4" stroke="currentColor" stroke-width="2" fill="none"/>
                <path d="M7 20l5-5 5 5" stroke="currentColor" stroke-width="2" fill="none"/>
                <path d="M12 12v3" stroke="currentColor" stroke-width="2" fill="none"/>
            </svg>
            <span class="text-xs font-medium">Leaderboard</span>
        </a>
        <a href="chat.php" class="flex flex-col items-center text-green-600 hover:text-green-800 transition">
            <svg class="w-6 h-6 mb-1" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M8 10h.01M12 10h.01M16 10h.01M21 12c0 4-7 8-9 8s-9-4-9-8a9 9 0 0118 0z"/></svg>
            <span class="text-xs font-medium">Chat</span>
        </a>
        <a href="profil.php" class="flex flex-col items-center text-purple-600 hover:text-purple-800 transition">
            <svg class="w-6 h-6 mb-1" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"/></svg>
            <span class="text-xs font-medium">Profil</span>
        </a>
        <a href="../logout.php" class="flex flex-col items-center text-red-600 hover:text-red-800 transition">
            <svg class="w-6 h-6 mb-1" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a2 2 0 01-2 2H7a2 2 0 01-2-2V7a2 2 0 012-2h6a2 2 0 012 2v1"/></svg>
            <span class="text-xs font-medium">Logout</span>
        </a>
    </nav>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.1/flowbite.min.js"></script>
</body>
</html>
