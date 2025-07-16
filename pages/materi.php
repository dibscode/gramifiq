<?php
include '../includes/auth.php';
require_login();
include '../config/db.php';
// Ambil daftar bab dari tabel bab_fiqih
$bab = $conn->query('SELECT * FROM bab_fiqih ORDER BY id ASC');

// Ambil XP user dari session (atau query user login)
$user_id = $_SESSION['user_id'] ?? null;
$user_xp = 0;
if ($user_id) {
    $res = $conn->query("SELECT xp FROM users WHERE id=" . intval($user_id));
    if ($row = $res->fetch_assoc()) {
        $user_xp = intval($row['xp']);
    }
}
$xp_per_bab = 100;
?>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Materi Fiqih</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@3.3.0/dist/tailwind.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.1/flowbite.min.css" rel="stylesheet" />
</head>
<body class="bg-white min-h-screen flex flex-col justify-between font-sans">
    <div class="flex-1 flex flex-col items-center justify-center pt-10 pb-28">
        <div class="w-full max-w-2xl bg-white rounded-2xl shadow-2xl p-7 mx-2">
            <h2 class="text-3xl font-extrabold mb-6 text-center text-blue-700 tracking-tight">Struktur Bab Fiqih (Dasar – Menengah)</h2>
            <div class="overflow-x-auto">
                <table class="min-w-full text-base mb-8">
                    <thead>
                        <tr class="bg-blue-50 text-blue-700">
                            <th class="py-2 px-2">No</th>
                            <th class="py-2 px-2">Bab Fiqih</th>
                            <th class="py-2 px-2">Deskripsi Singkat</th>
                            <th class="py-2 px-2">Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php $i = 0; while($row = $bab->fetch_assoc()): $i++; ?>
                        <?php $unlocked = ($user_xp >= ($i-1) * $xp_per_bab); ?>
                        <tr class="border-b">
                            <td class="py-2 px-2 font-bold text-blue-700"><?php echo $i; ?></td>
                            <td class="py-2 px-2 font-semibold"><?php echo htmlspecialchars($row['judul']); ?></td>
                            <td class="py-2 px-2"><?php echo htmlspecialchars($row['deskripsi']); ?></td>
                            <td class="py-2 px-2">
                                <?php if ($unlocked): ?>
                                    <span class="inline-flex items-center px-2 py-1 bg-green-100 text-green-700 rounded text-xs font-medium"><svg class="w-4 h-4 mr-1 text-green-500" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M5 13l4 4L19 7"/></svg>Terbuka</span>
                                <?php else: ?>
                                    <span class="inline-flex items-center px-2 py-1 bg-gray-100 text-gray-500 rounded text-xs font-medium"><svg class="w-4 h-4 mr-1 text-gray-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"/><path d="M12 8v4l3 3"/></svg>Terkunci</span>
                                <?php endif; ?>
                            </td>
                        </tr>
                        <?php endwhile; ?>
                    </tbody>
                </table>
            </div>
            <div id="accordion-bab" data-accordion="collapse" class="mb-4">
                <?php
                $bab = $conn->query('SELECT * FROM bab_fiqih ORDER BY id ASC');
                $i = 0;
                while($row = $bab->fetch_assoc()):
                    $i++;
                    $bab_id = $row['id'];
                    $subbab = $conn->query("SELECT * FROM subbab_fiqih WHERE id_bab=$bab_id ORDER BY id ASC");
                    $unlocked = ($user_xp >= ($i-1) * $xp_per_bab);
                ?>
                <h2 id="accordion-bab-heading-<?php echo $bab_id; ?>">
                    <button type="button" class="duo-3d-btn bg-white text-blue-700 border-blue-200 text-left flex items-center justify-between w-full p-3 font-medium border border-b-0 rounded-t" data-accordion-target="#accordion-bab-body-<?php echo $bab_id; ?>" aria-expanded="false" aria-controls="accordion-bab-body-<?php echo $bab_id; ?>">
                        <span>Bab <?php echo $i; ?>: <?php echo htmlspecialchars($row['judul']); ?></span>
                        <svg data-accordion-icon class="w-4 h-4 rotate-0 shrink-0" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M19 9l-7 7-7-7"/></svg>
                    </button>
                </h2>
                <div id="accordion-bab-body-<?php echo $bab_id; ?>" class="hidden" aria-labelledby="accordion-bab-heading-<?php echo $bab_id; ?>">
                    <div class="p-3 border border-b-0 border-blue-200 bg-blue-50">
                        <ul class="list-disc pl-5">
                        <?php $j = 0; while($sub = $subbab->fetch_assoc()): $j++; ?>
                            <li class="mb-1">
                                <?php if ($unlocked): ?>
                                    <a href="kuis.php?subbab=<?php echo $sub['id']; ?>" class="duo-3d-btn bg-white text-green-700 border-green-200 py-2 px-4 text-base inline-block">Subbab <?php echo $j; ?>: <?php echo htmlspecialchars($sub['judul']); ?></a>
                                <?php else: ?>
                                    <span class="text-gray-400 cursor-not-allowed">Subbab <?php echo $j; ?>: <?php echo htmlspecialchars($sub['judul']); ?> <svg class="inline w-4 h-4 text-gray-300 ml-1" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"/><path d="M12 8v4l3 3"/></svg></span>
                                <?php endif; ?>
                            </li>
                        <?php endwhile; if ($j == 0): ?>
                            <li class="text-gray-400">Subbab belum tersedia</li>
                        <?php endif; ?>
                        </ul>
                        <div class="mt-2 text-xs text-gray-500">Setiap subbab memiliki 10 soal kuis (radio, text, voice).</div>
                    </div>
                </div>
                <?php endwhile; ?>
            </div>
            <div class="text-xs text-gray-500 mt-2">Bab baru akan terbuka jika XP Anda mencukupi.</div>
        </div>
    </div>
    <nav class="fixed bottom-0 left-0 right-0 bg-white border-t shadow-lg flex justify-between items-center h-16 z-50 px-2 md:px-8">
        <a href="dashboard.php" class="duo-3d-nav text-blue-600">
            <svg class="w-6 h-6 mb-1" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M4 6h16M4 12h16M4 18h16"/></svg>
            <span class="text-xs font-semibold">Home</span>
        </a>
        <a href="materi.php" class="duo-3d-nav text-blue-600">
            <svg class="w-6 h-6 mb-1" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M4 6h16M4 12h16M4 18h16"/></svg>
            <span class="text-xs font-semibold">Materi</span>
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
