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
    <link rel="shortcut icon" href="../logo.png" type="image/x-icon">
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@3.3.0/dist/tailwind.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.1/flowbite.min.css" rel="stylesheet" />
    <link rel="shortcut icon" href="logo.png" type="image/x-icon">
</head>

<body class="bg-yellow-50 min-h-screen flex flex-col justify-center font-sans">

  <div class="flex-1 flex flex-col items-center justify-center px-3 sm:px-6 md:px-10 pt-10 pb-28">
    <div class="w-full max-w-md rounded-2xl p-7 mx-2">
        <!-- Header: Avatar + Nama + Info -->
        <div class="flex items-center gap-4 mb-4">
            <div class="bg-gradient-to-br from-yellow-200 to-green-200 rounded-full w-20 h-20 flex items-center justify-center">
            <?php
            $avatarSrc = $user['avatar'] ? $user['avatar'] : 'https://ui-avatars.com/api/?name=' . urlencode($user['name']) . '&background=random&size=128';
            if (strpos($avatarSrc, 'file/') === 0) {
                $avatarSrc = '../' . $avatarSrc;
            }
            ?>
            <img src="<?php echo htmlspecialchars($avatarSrc); ?>" alt="Avatar" class="w-16 h-16 rounded-lg object-cover border-4 border-yellow-200 shadow" />
            </div>
            <div class="flex-1">
            
            <h2 class="text-xl font-extrabold text-green-700 drop-shadow mb-1 tracking-tight"><?php echo htmlspecialchars($user['name']); ?></h2>
            <div class="mb-4 text-xs text-gray-500 font-medium">Terdaftar sejak: <?php echo isset($user['created_at']) ? date('d M Y', strtotime($user['created_at'])) : '-'; ?></div>
            
            </div>
        </div>
        <!-- Progress Bar -->
        <div class="w-full bg-gray-200 rounded-full h-3 mb-4 mt-2">
            <?php
            $xp_total = 5000;
            $xp_user = isset($user['xp']) ? intval($user['xp']) : 0;
            $progress_percent = min(100, round($xp_user / $xp_total * 100, 2));
            ?>
            <div class="h-3 rounded-full transition-all duration-500" style="width: <?php echo $progress_percent; ?>%; background: #FFD700;"></div>
        </div>
        <!-- Statistik User ala Duolingo -->
        <div class="mb-4">
            <h3 class="font-bold text-gray-700 text-base mb-2">Statistik</h3>
            <div class="grid grid-cols-2 gap-3">
            <!-- Runtunan hari (dummy, ganti sesuai data jika ada)-->
            <div class="rounded-xl bg-white border border-yellow-100 shadow-sm flex flex-col items-center py-3 px-2">
                <span class="text-orange-500 text-xl mb-1"><i class="fas fa-fire"></i></span>
                <span class="font-bold text-gray-900 text-lg">
                    <?php
                        $xp_total = 5000;
                        $xp_user = isset($user['xp']) ? intval($user['xp']) : 0;
                        $progress_percent = min(100, round($xp_user / $xp_total * 100, 2));
                        echo $progress_percent . '%';
                    ?>
                </span>
                <span class="text-xs text-gray-500">Progres</span>
            </div>
            <!-- Total XP -->
            <div class="rounded-xl bg-white border border-yellow-100 shadow-sm flex flex-col items-center py-3 px-2">
                <span class="text-yellow-400 text-xl mb-1"><i class="fas fa-bolt"></i></span>
                <span class="font-bold text-gray-900 text-lg"><?php echo isset($user['xp']) ? $user['xp'] : 0; ?></span>
                <span class="text-xs text-gray-500">Total XP</span>
            </div>
            <div class="rounded-xl bg-white border border-gray-200 shadow-sm flex flex-col items-center py-3 px-2">
                <span class="text-blue-400 text-xl mb-1"><i class="fas fa-shield-alt"></i></span>
                <span class="font-bold text-gray-500 text-lg">
                    <?php
                    // Level dihitung dari XP: level = floor(xp/100) + 1
                    $xp_user = isset($user['xp']) ? intval($user['xp']) : 0;
                    $level = floor($xp_user / 100) + 1;
                    echo $level;
                    ?>
                </span>
                <span class="text-xs text-gray-400">Level</span>
            </div>
            <div class="rounded-xl bg-white border border-gray-200 shadow-sm flex flex-col items-center py-3 px-2">
                <span class="text-yellow-400 text-xl mb-1"><i class="fas fa-medal"></i></span>
                <span class="font-bold text-gray-500 text-lg">
                    <?php
                        $myxp = isset($user['xp']) ? intval($user['xp']) : 0;
                        $myrank = 1;
                        if (isset($conn)) {
                            $res = $conn->query("SELECT COUNT(*)+1 as rank FROM users WHERE xp > $myxp");
                            if ($res && $row = $res->fetch_assoc()) {
                                $myrank = $row['rank'];
                            }
                        }
                        echo $myrank;
                        ?>
                </span>
                <span class="text-xs text-gray-400">Rank</span>
            </div>
            </div>
        </div>
        
        <button id="editProfileBtn" class="pushable mb-2 mt-2"><span class="front">Edit Profil</span></button>
        <a href="../logout.php" class="pushablelogout mt-2" style="padding-top:4px;"><span class="front" style="background:#ef4444">Logout</span></a>
        </div>
    </div>

  <!-- Modal Edit Profil -->
  <div id="editProfileModal" class="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-40 hidden">
    <div class="bg-white rounded-lg shadow-xl p-6 w-full max-w-md mx-2 relative">
      <h3 class="text-lg font-bold text-green-700 mb-4">Edit Profil</h3>
      <form id="editProfileForm" method="POST" enctype="multipart/form-data" class="space-y-4">
        <input type="text" name="name" value="<?php echo htmlspecialchars($user['name']); ?>" required class="pushable-input border-yellow-200" placeholder="Nama Lengkap">
        <input type="password" name="password" placeholder="Password (kosongkan jika tidak ingin mengubah)" class="pushable-input border-yellow-200">
        <input type="file" name="avatar" accept="image/*" class="pushable-input border-yellow-200 mb-2">
        <input type="email" name="email" value="<?php echo htmlspecialchars($user['email']); ?>" required class="pushable-input border-yellow-200" placeholder="Email">
        <div class="flex gap-2 mt-4">
          <button type="submit" class="pushable flex-1"><span class="front">Simpan</span></button>
          <button type="button" id="cancelEditProfile" class="pushablelogout flex-1"><span class="front" style="background:#ef4444">Batal</span></button>
        </div>
      </form>
      <?php if(isset($success)) echo '<p class="text-green-600 text-center mt-2">'.$success.'</p>'; ?>
      <?php if(isset($error)) echo '<p class="text-red-600 text-center mt-2">'.$error.'</p>'; ?>
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
                <i class="fas fa-user text-2xl pt-1 mb-1 block text-yellow-300"></i>
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
    .pushablelogout {
      background: red;
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
    .pushable-input {
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
    .pushable-input:focus {
      outline: none;
      border-color: #facc15;
      box-shadow: 0 4px 0 0 #bbf7d0, 0 2px 8px 0 rgba(16,185,129,0.10);
      background: #fef9c3;
    }
    @media (max-width: 640px) {
      .pushable, .front, .pushable-input {
        width: 100% !important;
        min-width: 0 !important;
        max-width: 100% !important;
        box-sizing: border-box !important;
      }
    }
  </style>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.1/flowbite.min.js"></script>
  <script>
    // Modal logic
    document.addEventListener('DOMContentLoaded', function() {
      var modal = document.getElementById('editProfileModal');
      var openBtn = document.getElementById('editProfileBtn');
      var cancelBtn = document.getElementById('cancelEditProfile');
      if (openBtn && modal) {
        openBtn.onclick = function() {
          modal.classList.remove('hidden');
        }
      }
      if (cancelBtn && modal) {
        cancelBtn.onclick = function() {
          modal.classList.add('hidden');
        }
      }
    });
  </script>
</body>
</html>