<?php
include '../includes/auth.php';
require_login();
include '../config/db.php';

// Ambil 20 user dengan XP tertinggi
$result = $conn->query("SELECT name, xp, avatar FROM users ORDER BY xp DESC LIMIT 20");
$users = [];
while ($row = $result->fetch_assoc()) {
    $users[] = $row;
}
?>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Leaderboard Gramifiq</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@3.3.0/dist/tailwind.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.1/flowbite.min.css" rel="stylesheet" />
</head>
<body class="bg-white min-h-screen flex flex-col justify-between font-sans">
    <div class="flex-1 flex flex-col items-center justify-center pt-10 pb-28">
        <div class="w-full max-w-md bg-white rounded-2xl shadow-2xl p-7 mx-2">
            <div class="flex flex-col items-center mb-7">
                <div class="bg-gradient-to-br from-yellow-400 to-blue-400 rounded-full w-24 h-24 flex items-center justify-center shadow-2xl mb-3 border-4 border-white">
                    <svg class="w-14 h-14 text-white" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M12 17l-5 3 1.9-5.6L4 10.5l5.7-.4L12 5l2.3 5.1 5.7.4-4.9 3.9L17 20z"/></svg>
                </div>
                <h2 class="text-3xl font-extrabold text-center text-yellow-700 drop-shadow mb-1 tracking-tight">Leaderboard Pengguna</h2>
                <p class="text-base text-gray-500 text-center mb-2">20 besar pengguna dengan progres tertinggi</p>
            </div>
            <div class="overflow-x-auto">
                <table class="min-w-full text-base">
                    <thead>
                        <tr class="text-left text-gray-600 border-b">
                            <th class="py-2 px-2">No</th>
                            <th class="py-2 px-2">Nama</th>
                            <th class="py-2 px-2">Level</th>
                            <th class="py-2 px-2">Progress</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($users as $i => $u): ?>
                        <tr class="border-b hover:bg-yellow-50 transition">
                            <td class="py-2 px-2 font-bold text-yellow-700"><?php echo $i+1; ?></td>
                            <td class="py-2 px-2 flex items-center gap-2">
                                <?php
                                    $avatarPath = !empty($u['avatar']) ? __DIR__ . '/../file/' . $u['avatar'] : '';
                                    $avatarUrl = !empty($u['avatar']) ? '../file/' . rawurlencode($u['avatar']) : '';
                                    if (!empty($u['avatar']) && file_exists($avatarPath)) {
                                        $imgSrc = $avatarUrl;
                                    } else {
                                        $imgSrc = 'https://ui-avatars.com/api/?name=' . urlencode($u['name']);
                                    }
                                    $xp = isset($u['xp']) ? intval($u['xp']) : 0;
                                    $xp_total = 5000;
                                    $progress_percent = min(100, round(($xp/$xp_total)*100, 2));
                                    $level = floor($xp/100) + 1;
                                ?>
                                <img src="<?php echo $imgSrc; ?>" alt="avatar" class="w-9 h-9 rounded-full object-cover border-2 border-yellow-200">
                                <span class="font-semibold text-gray-700"><?php echo htmlspecialchars($u['name']); ?></span>
                            </td>
                            <td class="py-2 px-2 font-semibold text-blue-700"><?php echo $level; ?></td>
                            <td class="py-2 px-2">
                                <div class="w-28 bg-gray-200 rounded-full h-3">
                                    <div class="bg-gradient-to-r from-yellow-400 to-blue-400 h-3 rounded-full" style="width:<?php echo $progress_percent; ?>%"></div>
                                </div>
                                <span class="ml-2 text-xs text-gray-600"><?php echo $progress_percent; ?>% &bull; <?php echo $xp; ?> XP</span>
                            </td>
                        </tr>
                        <?php endforeach; ?>
                        <?php if (empty($users)): ?>
                        <tr><td colspan="4" class="text-center py-4 text-gray-400">Belum ada data.</td></tr>
                        <?php endif; ?>
                    </tbody>
                </table>
            </div>
            <a href="dashboard.php" class="duo-3d-btn bg-white text-blue-700 border-blue-200 mt-7">Kembali ke Dashboard</a>
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