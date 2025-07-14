<?php
include '../config/db.php';
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    try {
        $name = $_POST['name'];
        $email = $_POST['email'];
        $password = password_hash($_POST['password'], PASSWORD_DEFAULT);
        $level = 1;
        $xp = 0;
        $progress = 0;
        $sql = "INSERT INTO users (name, email, password, level, xp, progress) VALUES (?, ?, ?, ?, ?, ?)";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param('sssiii', $name, $email, $password, $level, $xp, $progress);
        $stmt->execute();
        header('Location: login.php?register=success');
        exit;
    } catch (mysqli_sql_exception $e) {
        if ($e->getCode() === 1062) {
            header('Location: ../index.php?error=email');
            exit;
        } else {
            $error = 'Registrasi gagal! ' . $e->getMessage();
        }
    }
}
?>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register Gramifiq</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@3.3.0/dist/tailwind.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.1/flowbite.min.css" rel="stylesheet" />
</head>
<body class="bg-gray-50 min-h-screen flex flex-col justify-between">
    <div class="flex-1 flex flex-col items-center justify-center pt-8 pb-24">
        <div class="w-full max-w-xs bg-white rounded-lg shadow p-6">
            <h2 class="text-xl font-bold mb-4 text-center text-blue-600">Register</h2>
            <?php if(isset($error)) echo '<p class="text-red-600 text-center mb-2">'.$error.'</p>'; ?>
            <form method="post" class="space-y-4">
                <input type="text" name="name" placeholder="Nama Lengkap" required class="w-full px-3 py-2 border rounded focus:outline-none focus:ring focus:border-blue-300">
                <input type="email" name="email" placeholder="Email" required class="w-full px-3 py-2 border rounded focus:outline-none focus:ring focus:border-blue-300">
                <input type="password" name="password" placeholder="Password" required class="w-full px-3 py-2 border rounded focus:outline-none focus:ring focus:border-blue-300">
                <button type="submit" class="w-full bg-blue-600 text-white py-2 rounded hover:bg-blue-700 transition">Daftar</button>
            </form>
            <p class="mt-4 text-center text-sm">Sudah punya akun? <a href="login.php" class="text-blue-600 hover:underline">Login</a></p>
        </div>
    </div>
    <nav class="fixed bottom-0 left-0 right-0 bg-white border-t shadow flex justify-around items-center h-16 z-50">
        <a href="login.php" class="flex flex-col items-center text-blue-600 hover:text-blue-800">
            <svg class="w-6 h-6 mb-1" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M15 12H3m0 0l4-4m-4 4l4 4"/></svg>
            <span class="text-xs">Login</span>
        </a>
    </nav>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.1/flowbite.min.js"></script>
</body>
</html>
