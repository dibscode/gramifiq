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
        $avatar = '';
        if (isset($_FILES['avatar']) && $_FILES['avatar']['error'] === UPLOAD_ERR_OK) {
            $ext = pathinfo($_FILES['avatar']['name'], PATHINFO_EXTENSION);
            $filename = 'avatar_' . time() . '_' . rand(1000,9999) . '.' . $ext;
            $target = '../file/' . $filename;
            if (move_uploaded_file($_FILES['avatar']['tmp_name'], $target)) {
                $avatar = 'file/' . $filename;
            }
        } else {
            $avatar = 'https://ui-avatars.com/api/?name=' . urlencode($name) . '&background=random&size=128';
        }
        $sql = "INSERT INTO users (name, email, password, avatar, level, xp, progress) VALUES (?, ?, ?, ?, ?, ?, ?)";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param('ssssiii', $name, $email, $password, $avatar, $level, $xp, $progress);
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
    <link rel="shortcut icon" href="./logo.png" type="image/x-icon">
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@3.3.0/dist/tailwind.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.1/flowbite.min.css" rel="stylesheet" />
</head>
<body class="bg-yellow-50 min-h-screen flex flex-col justify-center font-sans">
    <div class="flex-1 flex flex-col items-center justify-center px-3 sm:px-6 md:px-10 pt-10 pb-28">
        <div class="flex flex-col items-center mb-8 w-full">
            
        <img src="../logo.png" alt="" class="w-8 h-8 mb-3">
            
            <h2 class="text-2xl font-extrabold text-center text-green-700 drop-shadow mb-1 tracking-tight">Daftar Akun Gramifiq</h2>
        </div>
        <div class="w-full max-w-md">
            <div class="bg-white rounded-2xl p-6">
                <?php if(isset($error)) echo '<p class="text-red-600 text-center mb-2">'.$error.'</p>'; ?>
                <form method="post" enctype="multipart/form-data" class="space-y-4">
                    <input type="text" name="name" placeholder="Nama Lengkap" required class="w-full px-4 py-3 border border-yellow-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-yellow-300 transition text-base">
                    <input type="email" name="email" placeholder="Email" required class="w-full px-4 py-3 border border-yellow-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-yellow-300 transition text-base">
                    <input type="password" name="password" placeholder="Password" required class="w-full px-4 py-3 border border-yellow-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-yellow-300 transition text-base">
                    <input type="file" name="avatar" accept="image/*" placeholder="Foto Profile" class="w-full px-4 py-3 border border-yellow-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-yellow-300 transition text-base">
                    <button type="submit" class="pushable"><span class="front">Daftar</span></button>
                </form>
                <div class="mt-4 text-center text-sm">
                  <a href="login.php" class="pushable"><span class="front">Sudah punya akun? Login</span></a>
                </div>
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
</html>
