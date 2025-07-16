<?php
include '../includes/auth.php';
require_login();
$user = get_user();
if (!is_array($user) || !isset($user['id'])) {
    header('Location: ../pages/login.php');
    exit;
}
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    include '../config/db.php';
    $id = isset($_SESSION['user_id']) ? $_SESSION['user_id'] : null;
    if (!$id) {
        header('Location: ../pages/login.php');
        exit;
    }
    $name = $_POST['name'];
    $email = $_POST['email'];
    $password = $_POST['password'];
    // Handle avatar upload
    $avatar = is_array($user) && isset($user['avatar']) ? $user['avatar'] : '';
    if (isset($_FILES['avatar']) && $_FILES['avatar']['error'] === UPLOAD_ERR_OK) {
        $ext = pathinfo($_FILES['avatar']['name'], PATHINFO_EXTENSION);
        $filename = 'avatar_' . $id . '_' . time() . '.' . $ext;
        $target = '../file/' . $filename;
        if (move_uploaded_file($_FILES['avatar']['tmp_name'], $target)) {
            $avatar = 'file/' . $filename;
        }
    }
    // Update query
    if (!empty($password)) {
        $password_hash = password_hash($password, PASSWORD_DEFAULT);
        $sql = "UPDATE users SET name=?, email=?, avatar=?, password=? WHERE id=?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param('ssssi', $name, $email, $avatar, $password_hash, $id);
    } else {
        $sql = "UPDATE users SET name=?, email=?, avatar=? WHERE id=?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param('sssi', $name, $email, $avatar, $id);
    }
    if ($stmt->execute()) {
        $success = 'Profil berhasil diupdate!';
        $user = get_user(); // Refresh user data
        if (!is_array($user) || !isset($user['id'])) {
            $avatar = '';
        } else {
            $avatar = isset($user['avatar']) ? $user['avatar'] : '';
        }
    } else {
        $error = 'Gagal update profil!';
    }
}
?>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profil Gramifiq</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@3.3.0/dist/tailwind.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.1/flowbite.min.css" rel="stylesheet" />
    <link rel="shortcut icon" href="logo.png" type="image/x-icon">
</head>
<body class="bg-white min-h-screen flex flex-col justify-between font-sans">
    <div class="flex-1 flex flex-col items-center justify-center pt-10 pb-28">
        <div class="w-full max-w-md bg-white rounded-2xl shadow-2xl p-7 mx-2">
            <div class="flex flex-col items-center mb-7">
                <div class="bg-gradient-to-br from-purple-400 to-blue-400 rounded-full w-24 h-24 flex items-center justify-center shadow-2xl mb-3 border-4 border-white">
                    <?php
                    $avatarSrc = $user['avatar'] ? $user['avatar'] : 'https://ui-avatars.com/api/?name=' . urlencode($user['name']) . '&background=random&size=128';
                    if (strpos($avatarSrc, 'file/') === 0) {
                        $avatarSrc = '../' . $avatarSrc;
                    }
                    ?>
                    <img src="<?php echo htmlspecialchars($avatarSrc); ?>" alt="Avatar" class="w-20 h-20 rounded-full object-cover border-4 border-white shadow" />
                </div>
                <h2 class="text-3xl font-extrabold text-center text-purple-700 drop-shadow mb-1 tracking-tight">Profil Pengguna</h2>
                <p class="text-base text-gray-500 text-center mb-2">Edit data akun kamu di bawah ini</p>
            </div>
            <?php if(isset($success)) echo '<p class="text-green-600 text-center mb-2">'.$success.'</p>'; ?>
            <?php if(isset($error)) echo '<p class="text-red-600 text-center mb-2">'.$error.'</p>'; ?>
            <form method="POST" enctype="multipart/form-data" class="space-y-4">
                <input type="text" name="name" value="<?php echo htmlspecialchars($user['name']); ?>" required class="duo-3d-input border-purple-200" placeholder="Nama Lengkap">
                <input type="password" name="password" placeholder="Password (kosongkan jika tidak ingin mengubah)" class="duo-3d-input border-purple-200">
                <input type="file" name="avatar" accept="image/*" class="duo-3d-input border-purple-200 mb-2">
                <input type="email" name="email" value="<?php echo htmlspecialchars($user['email']); ?>" required class="duo-3d-input border-purple-200" placeholder="Email">
                <button type="submit" class="duo-3d-btn bg-white text-purple-700 border-purple-200">Update Profil</button>
            </form>
            <div class="mt-7">
                <div class="flex justify-between text-base mb-1">
                    <span class="font-semibold text-blue-700">Level: <?php echo $user['level']; ?></span>
                    <span class="font-semibold text-yellow-700">Total XP: <?php echo isset($user['xp']) ? $user['xp'] : 0; ?></span>
                    <?php
                    $xp_total = 5000;
                    $xp_user = isset($user['xp']) ? intval($user['xp']) : 0;
                    $progress_percent = min(100, round($xp_user / $xp_total * 100, 2));
                    ?>
                    <span class="font-semibold text-green-700">Progress: <?php echo $progress_percent; ?>%</span>
                </div>
                <div class="w-full bg-gray-200 rounded-full h-3">
                    <?php
                    $xp_total = 5000;
                    $xp_user = isset($user['xp']) ? intval($user['xp']) : 0;
                    $progress_percent = min(100, round($xp_user / $xp_total * 100, 2));
                    ?>
                    <div class="bg-gradient-to-r from-green-400 to-blue-400 h-3 rounded-full transition-all duration-500" style="width: <?php echo $progress_percent; ?>%"></div>
                </div>
            </div>
            <a href="../logout.php" class="duo-3d-btn bg-white text-red-600 border-red-200 mt-7">Logout</a>
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
    .duo-3d-input {
        width: 100%;
        padding: 0.75rem 1rem;
        border-radius: 1rem;
        border-width: 2px;
        font-size: 1.1rem;
        margin-bottom: 0.25rem;
        box-shadow: 0 2px 0 0 #e5e7eb, 0 1px 4px 0 rgba(0,0,0,0.06);
        transition: box-shadow 0.1s, border-color 0.1s, background 0.2s;
        background: #fff;
    }
    .duo-3d-input:focus {
        outline: none;
        border-color: #a78bfa;
        box-shadow: 0 4px 0 0 #e5e7eb, 0 2px 8px 0 rgba(0,0,0,0.10);
        background: #f3f4f6;
    }
    </style>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.1/flowbite.min.js"></script>
</body>
</html>
