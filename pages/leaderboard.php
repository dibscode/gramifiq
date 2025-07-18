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
    <link rel="shortcut icon" href="../logo.png" type="image/x-icon">
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@3.3.0/dist/tailwind.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.1/flowbite.min.css" rel="stylesheet" />
</head>
<body class="bg-yellow-50 min-h-screen flex flex-col justify-center font-sans">
    <div class="flex-1 flex flex-col items-center justify-center px-3 sm:px-6 md:px-10 pt-10 pb-28">
        <div class="w-full max-w-md rounded-2xl shadow-2xl p-7 mx-2">
            <div class="flex flex-col items-center mb-7">
                <img src="../logo.png" alt="" class="w-8 h-8 mb-3">
                <h2 class="text-3xl font-extrabold text-center text-yellow-700 drop-shadow mb-1 tracking-tight">Leaderboard Pengguna</h2>
                <p class="text-base text-gray-500 text-center mb-2">Rank pengguna dengan progres tertinggi</p>
            </div>
            <div class="overflow-x-auto">
                <table class="min-w-full text-base">
                    <thead>
                        <tr class="text-left text-gray-600 border-b">
                            <th class="py-2 px-2">Rank</th>
                            <th class="py-2 px-2">Nama</th>
                            <th class="py-2 px-2">Progress</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($users as $i => $u): ?>
                        <tr class="border-b hover:bg-yellow-50 transition">
                            <td class="py-2 px-2 font-bold text-yellow-700"><?php echo $i+1; ?></td>
                            <td class="py-2 px-2 flex items-center gap-2">
                                <?php
                                    // Path avatar profesional dan konsisten
                                    $avatarFile = !empty($u['avatar']) ? $u['avatar'] : '';
                                    $avatarPath = $avatarFile ? $_SERVER['DOCUMENT_ROOT'] . '/gramifiq/' . $avatarFile : '';
                                    $avatarUrl = $avatarFile ? '/gramifiq/' . rawurlencode($avatarFile) : '';
                                    if ($avatarFile && file_exists($avatarPath)) {
                                        $imgSrc = $avatarUrl;
                                    } else {
                                        $imgSrc = 'https://ui-avatars.com/api/?name=' . urlencode($u['name']);
                                    }
                                    $xp = isset($u['xp']) ? intval($u['xp']) : 0;
                                    $xp_total = 5000;
                                    $progress_percent = min(100, round(($xp/$xp_total)*100, 2));
                                    $level = floor($xp/100) + 1;
                                ?>
                                <img src="<?php echo $imgSrc; ?>" alt="avatar" class="w-9 h-9 rounded-lg object-cover">
                                <span class="font-semibold text-gray-700"><?php echo htmlspecialchars($u['name']); ?></span>
                            </td>
                            <td class="py-2 px-2">
                                <div class="w-28 bg-gray-200 rounded-full h-3">
                                    <div class="bg-yellow-300 h-3 rounded-full" style="width:<?php echo $progress_percent; ?>%"></div>
                                </div>
                                <span class="ml-2 text-xs text-gray-600"><?php echo $xp; ?> XP</span>
                            </td>
                        </tr>
                        <?php endforeach; ?>
                        <?php if (empty($users)): ?>
                        <tr><td colspan="4" class="text-center py-4 text-gray-400">Belum ada data.</td></tr>
                        <?php endif; ?>
                    </tbody>
                </table>
            </div>
            <a href="materi.php" class="pushable mt-7"><span class="front">Push Rank Anda</span></a>
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
                <i class="fas fa-trophy text-2xl pt-1 mb-1 block text-yellow-300"></i>
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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
    <style>
    .pushable {
      background: #FEBE10;
      border-radius: 12px;
      border: none;
      padding: 0;
      cursor: pointer;
      outline-offset: 4px;
      box-shadow: 0 4px 0 0 #bbf7d0, 0 2px 8px 0 rgba(16,185,129,0.08);
      display: block;
      margin-bottom: 0.5rem;
      width: 100%;
      text-align: center;
      transition: box-shadow 0.15s;
    }
    .front {
      display: block;
      padding: 18px 0;
      border-radius: 12px;
      font-size: 1.25rem;
      font-weight: 700;
      background: #FFD700;
      color: white;
      transform: translateY(-6px);
      box-shadow: 0 2px 8px 0 rgba(16,185,129,0.10);
      transition: transform 0.1s, background 0.2s;
      width: 100%;
      box-sizing: border-box;
    }
    .pushable:active .front {
      transform: translateY(-2px);
      background: #FEBE10;
    }
    @media (max-width: 640px) {
      .pushable, .front {
        width: 100% !important;
        min-width: 0 !important;
        max-width: 100% !important;
        box-sizing: border-box !important;
      }
    }
    </style>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.1/flowbite.min.js"></script>
</body>