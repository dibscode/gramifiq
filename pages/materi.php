<?php
include '../includes/auth.php';
require_login();
include '../config/db.php';
// Ambil daftar bab dari tabel bab_fiqih
$bab = $conn->query('SELECT * FROM bab_fiqih ORDER BY id ASC');

// Ambil XP user dari session (atau query user login)
$user_id = $_SESSION['user_id'] ?? null;
$user_xp = 0;
if ($user_id) {
    $res = $conn->query("SELECT xp FROM users WHERE id=" . intval($user_id));
    if ($row = $res->fetch_assoc()) {
        $user_xp = intval($row['xp']);
    }
}
$xp_per_bab = 100;
?>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Materi Fiqih</title>
    <link rel="shortcut icon" href="../logo.png" type="image/x-icon">
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@3.3.0/dist/tailwind.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.1/flowbite.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
</head>
<body class="bg-white min-h-screen flex flex-col justify-between font-sans">
    <div class="flex-1 flex flex-col items-center justify-center pt-6 pb-28">
        <div class="w-full max-w-md bg-white rounded-2xl shadow-2xl p-4 mx-2">
            <h2 class="text-xl font-extrabold mb-4 text-center text-green-700 tracking-tight">Struktur Bab Fiqih</h2>
            <?php
            $bab = $conn->query('SELECT * FROM bab_fiqih ORDER BY id ASC');
            $i = 0;
            while($row = $bab->fetch_assoc()):
                $i++;
                $bab_id = $row['id'];
                $subbab = $conn->query("SELECT * FROM subbab_fiqih WHERE id_bab=$bab_id ORDER BY id ASC");
                // Hitung syarat XP untuk bab ini
                $unlock_xp_bab = 0;
                if ($i > 1) {
                    // Hitung jumlah soal bab sebelumnya
                    $prev_bab = $conn->query("SELECT id FROM bab_fiqih ORDER BY id ASC LIMIT ".($i-1));
                    $prev_bab_ids = [];
                    if ($prev_bab) {
                        while($pb = $prev_bab->fetch_assoc()) {
                            $prev_bab_ids[] = $pb['id'];
                        }
                    }
                    if (count($prev_bab_ids) > 0) {
                        $prev_bab_ids_str = implode(',', $prev_bab_ids);
                        $qsoal = $conn->query("SELECT COUNT(*) as total FROM subbab_fiqih WHERE id_bab IN ($prev_bab_ids_str)");
                        $rowsoal = $qsoal && ($tmp = $qsoal->fetch_assoc()) ? $tmp : ['total'=>0];
                        $unlock_xp_bab = intval($rowsoal['total']) * 10;
                    } else {
                        $unlock_xp_bab = 0;
                    }
                }
            ?>
            <div class="mb-8">
                <div class="font-bold text-green-700 text-base mb-2">Bab <?php echo $i; ?>: <?php echo htmlspecialchars($row['judul']); ?></div>
                <div class="flex flex-col items-center gap-6">
                    <?php
                    $j = 0;
                    while($sub = $subbab->fetch_assoc()):
                        $j++;
                        // Untuk bab pertama, subbab pertama selalu terbuka
                        if ($i == 1 && $j == 1) {
                            $unlocked = true;
                        } else if ($j == 1) {
                            // Subbab pertama bab ke-2 dst: unlocked jika XP user >= unlock_xp_bab
                            $unlocked = $user_xp >= $unlock_xp_bab;
                        } else {
                            // Subbab berikutnya: unlocked jika XP user >= unlock_xp_bab + (j-1)*100
                            $unlocked = $user_xp >= ($unlock_xp_bab + ($j-1)*100);
                        }
                        $icon = $unlocked ? 'fa-lock-open' : 'fa-lock';
                        $circleColor = $unlocked ? 'bg-yellow-300 shadow-lg text-white border-4 border-yellow-200' : 'bg-gray-200 text-gray-400 border-4 border-gray-300';
                        $iconColor = $unlocked ? 'text-white' : 'text-gray-400';
                    ?>
                    <div class="flex flex-col items-center">
                        <?php if ($unlocked): ?>
                        <a href="kuis.php?subbab=<?php echo $sub['id']; ?>" class="flex items-center justify-center w-20 h-20 rounded-full <?php echo $circleColor; ?> mb-2 text-3xl font-bold pushable-skill transition-all hover:scale-105">
                            <i class="fas <?php echo $icon; ?> <?php echo $iconColor; ?>"></i>
                        </a>
                        <?php else: ?>
                        <div class="flex items-center justify-center w-20 h-20 rounded-full <?php echo $circleColor; ?> mb-2 text-3xl font-bold pushable-skill opacity-60">
                            <i class="fas <?php echo $icon; ?> <?php echo $iconColor; ?>"></i>
                        </div>
                        <?php endif; ?>
                        <div class="text-center text-base font-semibold <?php echo $unlocked ? 'text-green-700' : 'text-gray-400'; ?>">
                            <?php echo htmlspecialchars($sub['judul']); ?>
                        </div>
                    </div>
                    <?php endwhile; if ($j == 0): ?>
                        <div class="text-gray-400 text-center">Subbab belum tersedia</div>
                    <?php endif; ?>
                </div>
            </div>
            <?php endwhile; ?>
            <div class="text-xs text-gray-500 mt-2 text-center">Bab/subbab baru akan terbuka jika XP Anda mencukupi.</div>
        </div>
    </div>
    <div class="fixed bottom-0 left-0 right-0 px-3 pb-2 py-4 z-50 bg-white rounded-12">
        <div class="flex justify-between items-center h-16 px-1 sm:px-4 md:px-8">
        <div class="flex-1 group">
            <a href="dashboard.php" class="flex items-end justify-center text-center mx-auto px-2 pt-2 w-full text-gray-400 group-hover:text-green-600 border-b-2 border-transparent group-hover:border-green-600 transition-all">
            <span class="block px-1 pt-1 pb-2">
                <i class="fas fa-home text-2xl pt-1 mb-1 block"></i>
                <span class="block text-xs pb-1">Home</span>
            </span>
            </a>
        </div>
        <div class="flex-1 group">
            <a href="leaderboard.php" class="flex items-end justify-center text-center mx-auto px-2 pt-2 w-full text-gray-400 group-hover:text-yellow-500 border-b-2 border-transparent group-hover:border-yellow-500 transition-all">
            <span class="block px-1 pt-1 pb-2">
                <i class="fas fa-trophy text-2xl pt-1 mb-1 block"></i>
                <span class="block text-xs pb-1">Leaderboard</span>
            </span>
            </a>
        </div>
        <div class="flex-1 group">
            <a href="chat.php" class="flex items-end justify-center text-center mx-auto px-2 pt-2 w-full text-gray-400 group-hover:text-green-500 border-b-2 border-transparent group-hover:border-green-500 transition-all">
            <span class="block px-1 pt-1 pb-2">
                <i class="fas fa-comments text-2xl pt-1 mb-1 block"></i>
                <span class="block text-xs pb-1">Chat</span>
            </span>
            </a>
        </div>
        <div class="flex-1 group">
            <a href="profil.php" class="flex items-end justify-center text-center mx-auto px-2 pt-2 w-full text-gray-400 group-hover:text-purple-500 border-b-2 border-transparent group-hover:border-purple-500 transition-all">
            <span class="block px-1 pt-1 pb-2">
                <i class="fas fa-user text-2xl pt-1 mb-1 block"></i>
                <span class="block text-xs pb-1">Profil</span>
            </span>
            </a>
        </div>
        </div>
    </div>
    <style>
    .pushable-skill {
        box-shadow: 0 6px 0 0 #FEBE10, 0 2px 8px 0 rgba(16,185,129,0.10);
        border: none;
        outline: none;
        transition: box-shadow 0.15s, transform 0.1s;
        cursor: pointer;
    }
    .pushable-skill:active {
        box-shadow: 0 2px 0 0 #FEBE10, 0 1px 4px 0 rgba(16,185,129,0.10);
        transform: scale(0.97);
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
