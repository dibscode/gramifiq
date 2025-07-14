<?php
include '../includes/auth.php';
require_login();
$user = get_user();
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    include '../config/db.php';
    $name = $_POST['name'];
    $email = $_POST['email'];
    $id = $user['id'];
    $sql = "UPDATE users SET name=?, email=? WHERE id=?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param('ssi', $name, $email, $id);
    if ($stmt->execute()) {
        $user['name'] = $name;
        $user['email'] = $email;
        $success = 'Profil berhasil diupdate!';
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
</head>
<body class="bg-gray-50 min-h-screen flex flex-col justify-between">
    <div class="flex-1 flex flex-col items-center justify-center pt-8 pb-24">
        <div class="w-full max-w-xs bg-white rounded-lg shadow p-6">
            <h2 class="text-xl font-bold mb-4 text-center text-purple-600">Profil Pengguna</h2>
            <?php if(isset($success)) echo '<p class="text-green-600 text-center mb-2">'.$success.'</p>'; ?>
            <?php if(isset($error)) echo '<p class="text-red-600 text-center mb-2">'.$error.'</p>'; ?>
            <form method="post" class="space-y-4">
                <input type="text" name="name" value="<?php echo htmlspecialchars($user['name']); ?>" required class="w-full px-3 py-2 border rounded focus:outline-none focus:ring focus:border-purple-300">
                <input type="email" name="email" value="<?php echo htmlspecialchars($user['email']); ?>" required class="w-full px-3 py-2 border rounded focus:outline-none focus:ring focus:border-purple-300">
                <button type="submit" class="w-full bg-purple-600 text-white py-2 rounded hover:bg-purple-700 transition">Update Profil</button>
            </form>
            <p class="mt-4 text-center text-sm">Level: <span class="font-bold text-blue-600"><?php echo $user['level']; ?></span> | Progress: <span class="font-bold text-green-600"><?php echo $user['progress']; ?>%</span></p>
            <a href="../logout.php" class="block mt-4 text-center text-red-600 hover:underline">Logout</a>
        </div>
    </div>
    <nav class="fixed bottom-0 left-0 right-0 bg-white border-t shadow flex justify-around items-center h-16 z-50">
        <a href="dashboard.php" class="flex flex-col items-center text-blue-600 hover:text-blue-800">
            <svg class="w-6 h-6 mb-1" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M4 6h16M4 12h16M4 18h16"/></svg>
            <span class="text-xs">Home</span>
        </a>
        <a href="materi.php" class="flex flex-col items-center text-blue-600 hover:text-blue-800">
            <svg class="w-6 h-6 mb-1" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M4 6h16M4 12h16M4 18h16"/></svg>
            <span class="text-xs">Materi</span>
        </a>
        <a href="chat.php" class="flex flex-col items-center text-green-600 hover:text-green-800">
            <svg class="w-6 h-6 mb-1" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M8 10h.01M12 10h.01M16 10h.01M21 12c0 4-7 8-9 8s-9-4-9-8a9 9 0 0118 0z"/></svg>
            <span class="text-xs">Chat</span>
        </a>
        <a href="profil.php" class="flex flex-col items-center text-purple-600 hover:text-purple-800">
            <svg class="w-6 h-6 mb-1" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"/></svg>
            <span class="text-xs">Profil</span>
        </a>
        <a href="../logout.php" class="flex flex-col items-center text-red-600 hover:text-red-800">
            <svg class="w-6 h-6 mb-1" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a2 2 0 01-2 2H7a2 2 0 01-2-2V7a2 2 0 012-2h6a2 2 0 012 2v1"/></svg>
            <span class="text-xs">Logout</span>
        </a>
    </nav>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.1/flowbite.min.js"></script>
</body>
