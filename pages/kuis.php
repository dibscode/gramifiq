<?php
include '../includes/auth.php';
require_login();
include '../config/db.php';
if (!isset($_GET['subbab'])) {
    echo 'Subbab tidak ditemukan.';
    exit;
}
$subbab_id = intval($_GET['subbab']);
$soal = $conn->query("SELECT * FROM soal WHERE subbab_id=$subbab_id ORDER BY id ASC LIMIT 10");
$user_id = $_SESSION['user_id'];
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $benar = 0;
    foreach ($_POST as $key => $jawab) {
        if (strpos($key, 'soal_') === 0) {
            $soal_id = intval(str_replace('soal_', '', $key));
            $cek = $conn->query("SELECT * FROM soal WHERE id=$soal_id")->fetch_assoc();
            if (strtolower(trim($jawab)) == strtolower(trim($cek['jawaban']))) {
                $benar++;
            }
        }
    }
    $poin = round(($benar/10)*100);
    $conn->query("UPDATE users SET progres=progres+$poin WHERE id=$user_id");
    echo "<p>Skor Anda: $poin. Jawaban benar: $benar dari 10 soal.</p>";
    echo '<a href="dashboard.php">Kembali ke Dashboard</a>';
    exit;
}
?>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kuis Fiqih</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@3.3.0/dist/tailwind.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.1/flowbite.min.css" rel="stylesheet" />
</head>
<body class="bg-gray-50 min-h-screen flex flex-col justify-between">
    <div class="flex-1 flex flex-col items-center justify-center pt-8 pb-24">
        <div class="w-full max-w-xs bg-white rounded-lg shadow p-6">
            <h2 class="text-xl font-bold mb-4 text-center text-blue-600">Kuis Fiqih</h2>
            <form method="post" class="space-y-6">
                <?php $no=1; while($row = $soal->fetch_assoc()): ?>
                    <div class="mb-4">
                        <p class="font-semibold mb-2"><?php echo $no . '. ' . htmlspecialchars($row['pertanyaan']); ?></p>
                        <?php if($row['tipe'] == 'radio'): ?>
                            <?php $opsi = explode('|', $row['opsi']); foreach($opsi as $o): ?>
                                <label class="block mb-1"><input type="radio" name="soal_<?php echo $row['id']; ?>" value="<?php echo htmlspecialchars($o); ?>" class="mr-2"> <?php echo htmlspecialchars($o); ?></label>
                            <?php endforeach; ?>
                        <?php elseif($row['tipe'] == 'text'): ?>
                            <input type="text" name="soal_<?php echo $row['id']; ?>" class="w-full px-3 py-2 border rounded focus:outline-none focus:ring focus:border-blue-300">
                        <?php elseif($row['tipe'] == 'voice'): ?>
                            <input type="text" name="soal_<?php echo $row['id']; ?>" placeholder="Jawab dengan suara (fitur belum tersedia)" class="w-full px-3 py-2 border rounded focus:outline-none focus:ring focus:border-blue-300">
                        <?php endif; ?>
                    </div>
                <?php $no++; endwhile; ?>
                <button type="submit" class="w-full bg-blue-600 text-white py-2 rounded hover:bg-blue-700 transition">Kirim Jawaban</button>
            </form>
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
</html>
