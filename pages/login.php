<?php
session_start();
include '../config/db.php';
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = $_POST['email'];
    $password = $_POST['password'];
    $sql = "SELECT * FROM users WHERE email = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param('s', $email);
    $stmt->execute();
    $result = $stmt->get_result();
    if ($result->num_rows === 1) {
        $user = $result->fetch_assoc();
        if (password_verify($password, $user['password'])) {
            $_SESSION['user_id'] = $user['id'];
            $_SESSION['name'] = $user['name'];
            header('Location: dashboard.php');
            exit;
        } else {
            $error = 'Password salah!';
        }
    } else {
        $error = 'Email tidak ditemukan!';
    }
}
?>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Gramifiq</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@3.3.0/dist/tailwind.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.1/flowbite.min.css" rel="stylesheet" />
</head>
<body class="bg-gray-50 min-h-screen flex flex-col justify-between">
    <div class="flex-1 flex flex-col items-center justify-center pt-8 pb-24">
        <div class="w-full max-w-xs bg-white rounded-lg shadow p-6">
            <h2 class="text-xl font-bold mb-4 text-center text-blue-600">Login</h2>
            <?php if(isset($error)) echo '<p class="text-red-600 text-center mb-2">'.$error.'</p>'; ?>
            <form method="post" class="space-y-4">
                <input type="email" name="email" placeholder="Email" required class="w-full px-3 py-2 border rounded focus:outline-none focus:ring focus:border-blue-300">
                <input type="password" name="password" placeholder="Password" required class="w-full px-3 py-2 border rounded focus:outline-none focus:ring focus:border-blue-300">
                <button type="submit" class="w-full bg-blue-600 text-white py-2 rounded hover:bg-blue-700 transition">Login</button>
            </form>
            <p class="mt-4 text-center text-sm">Belum punya akun? <a href="register.php" class="text-blue-600 hover:underline">Daftar</a></p>
        </div>
    </div>
    <nav class="fixed bottom-0 left-0 right-0 bg-white border-t shadow flex justify-around items-center h-16 z-50">
        <a href="register.php" class="flex flex-col items-center text-blue-600 hover:text-blue-800">
            <svg class="w-6 h-6 mb-1" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M9 12h12m0 0l-4-4m4 4l-4 4"/></svg>
            <span class="text-xs">Register</span>
        </a>
    </nav>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.1/flowbite.min.js"></script>
</body>
</html>
