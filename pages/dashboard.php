<?php
include '../includes/auth.php';
require_login();
$user = get_user();
?>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Gramifiq</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@3.3.0/dist/tailwind.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.1/flowbite.min.css" rel="stylesheet" />
</head>
<body class="bg-gradient-to-br from-blue-50 to-purple-100 min-h-screen flex flex-col justify-between">
    <div class="flex-1 flex flex-col items-center justify-center pt-8 pb-24">
        <div class="flex flex-col items-center mb-6">
            <div class="bg-gradient-to-br from-blue-400 to-purple-400 rounded-full w-20 h-20 flex items-center justify-center shadow-lg mb-2">
                <svg class="w-12 h-12 text-white" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"/></svg>
            </div>
            <h2 class="text-2xl font-extrabold text-center text-blue-700 drop-shadow mb-1">Selamat datang,<br><span class="text-purple-700"><?php echo htmlspecialchars($user['name']); ?></span>!</h2>
            <p class="text-sm text-gray-500 text-center mb-2">Ayo lanjutkan belajar dan konsultasi fiqih!</p>
        </div>
        <div class="w-full max-w-md">
            <div class="grid grid-cols-1 gap-4">
                <a href="materi.php" class="block rounded-xl bg-gradient-to-r from-blue-100 to-blue-50 shadow p-6 text-center text-blue-700 font-bold text-lg hover:from-blue-200 hover:to-blue-100 transition border border-blue-200">📚 Materi Fiqih</a>
                <a href="leaderboard.php" class="block rounded-xl bg-gradient-to-r from-yellow-100 to-yellow-50 shadow p-6 text-center text-yellow-700 font-bold text-lg hover:from-yellow-200 hover:to-yellow-100 transition border border-yellow-200">Leaderboard</a>
                <a href="chat.php" class="block rounded-xl bg-gradient-to-r from-green-100 to-blue-50 shadow p-6 text-center text-green-700 font-bold text-lg hover:from-green-200 hover:to-blue-100 transition border border-green-200">💬 Konsultasi Chat</a>
                <a href="profil.php" class="block rounded-xl bg-gradient-to-r from-purple-100 to-blue-50 shadow p-6 text-center text-purple-700 font-bold text-lg hover:from-purple-200 hover:to-blue-100 transition border border-purple-200">👤 Profil</a>
            </div>
        </div>
    </div>
    <!-- Navbar bawah -->
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
