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
<body class="bg-white min-h-screen flex flex-col justify-between font-sans">
    <div class="flex-1 flex flex-col items-center justify-center pt-10 pb-28">
        <div class="flex flex-col items-center mb-8">
            <div class="bg-gradient-to-br from-blue-400 to-purple-400 rounded-full w-24 h-24 flex items-center justify-center shadow-2xl mb-3 border-4 border-white">
                <svg class="w-14 h-14 text-white" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"/></svg>
            </div>
            <h2 class="text-3xl font-extrabold text-center text-blue-700 drop-shadow mb-1 tracking-tight">Selamat datang,<br><span class="text-purple-700"><?php echo htmlspecialchars($user['name']); ?></span>!</h2>
            <p class="text-base text-gray-500 text-center mb-2">Ayo lanjutkan belajar dan konsultasi fiqih!</p>
        </div>
        <div class="w-full max-w-md">
            <div class="grid grid-cols-1 gap-5">
                <a href="materi.php" class="duo-3d-btn bg-white text-blue-700 border-blue-200">📚 Materi Fiqih</a>
                <a href="leaderboard.php" class="duo-3d-btn bg-white text-yellow-700 border-yellow-200">🏆 Leaderboard</a>
                <a href="chat.php" class="duo-3d-btn bg-white text-green-700 border-green-200">💬 Konsultasi Chat</a>
                <a href="profil.php" class="duo-3d-btn bg-white text-purple-700 border-purple-200">👤 Profil</a>
            </div>
        </div>
    </div>
    <!-- Navbar bawah -->
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
