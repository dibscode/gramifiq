<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gramifiq - Register</title>
    <link rel="shortcut icon" href="logo.png" type="image/x-icon">
    <!-- Google Fonts CDN -->
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@700&family=Quicksand:wght@400;500&display=swap" rel="stylesheet">
    <style>
        body { margin:0; padding:0; font-family:'Quicksand', 'DIN Round', Arial, sans-serif; background:#f4f4f4; }
        h1, h2, h3, h4, h5, h6 { font-family:'Montserrat', 'Feather', Arial, sans-serif; }
        #loader {
            position:fixed; left:0; top:0; width:100vw; height:100vh;
            background:#fff; display:flex; align-items:center; justify-content:center; z-index:9999;
        }
        .spinner {
            border:8px solid #eee; border-top:8px solid #30b90eff; border-radius:50%; width:60px; height:60px; animation:spin 1s linear infinite;
        }
        @keyframes spin { 100% { transform:rotate(360deg); } }
        #register-form {
            display:none; max-width:400px; margin:100px auto; background:#fff; padding:30px; border-radius:8px; box-shadow:0 2px 8px rgba(0,0,0,0.1);
        }
        #register-form h2 { margin-bottom:20px; font-family:'Montserrat', 'Feather', Arial, sans-serif; }
        #register-form input[type="text"], #register-form input[type="email"], #register-form input[type="password"] {
            width:100%; padding:10px; margin-bottom:15px; border:1px solid #ccc; border-radius:4px; font-family:'Quicksand', 'DIN Round', Arial, sans-serif;
        }
        #register-form button {
            width:100%; padding:10px; background:#3498db; color:#fff; border:none; border-radius:4px; font-size:16px; font-family:'Montserrat', 'Feather', Arial, sans-serif;
        }
        /* Untuk heading di landing section */
        #landing h1, #landing h2, #landing h3 { font-family:'Montserrat', 'Feather', Arial, sans-serif; }
        #landing p, #landing blockquote, #landing a, #landing button { font-family:'Quicksand', 'DIN Round', Arial, sans-serif; }
    </style>
</head>
<body>
    <div id="loader">
        <div class="spinner"></div>
    </div>
    <main id="landing" style="display:block;">
        <section style="text-align:center;padding:60px 20px 40px 20px;background:#e6f7ff;">
            <img src="logo.png" alt="Logo" style="height:60px;margin-bottom:20px;">
            <h1 style="font-size:2.5rem;font-weight:bold;color:#30b90eff;">Gramifiq</h1>
            <p style="font-size:1.2rem;color:#333;margin:20px 0 30px 0;">Belajar Fiqih dengan cara interaktif, mudah, dan menyenangkan!</p>
            <a href="pages/register.php" style="padding:15px 40px;font-size:1.2rem;background:#34c759;color:#fff;border:none;border-radius:30px;font-weight:bold;box-shadow:0 2px 8px rgba(0,0,0,0.08);margin-right:10px;cursor:pointer;text-decoration: none;">Daftar Gratis</a>
            <a href="pages/login.php" style="padding:15px 40px;font-size:1.2rem;background:#fff;color:#3498db;border:2px solid #3498db;border-radius:30px;font-weight:bold;text-decoration:none;box-shadow:0 2px 8px rgba(0,0,0,0.08);">Login</a>
        </section>
        <section style="display:flex;flex-wrap:wrap;justify-content:center;gap:30px;padding:40px 10px 20px 10px;">
            <div style="background:#fff;border-radius:16px;box-shadow:0 2px 8px rgba(0,0,0,0.07);padding:30px;max-width:300px;text-align:center;">
                <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" style="height:50px;margin-bottom:10px;">
                <h3 style="color:#3498db;font-size:1.1rem;font-weight:bold;">Materi Fiqih Lengkap</h3>
                <p style="color:#555;font-size:1rem;">Dapatkan penjelasan fiqih dari bab hingga subbab, sesuai rujukan kitab.</p>
            </div>
            <div style="background:#fff;border-radius:16px;box-shadow:0 2px 8px rgba(0,0,0,0.07);padding:30px;max-width:300px;text-align:center;">
                <img src="https://cdn-icons-png.flaticon.com/512/1828/1828884.png" style="height:50px;margin-bottom:10px;">
                <h3 style="color:#3498db;font-size:1.1rem;font-weight:bold;">Kuis Interaktif</h3>
                <p style="color:#555;font-size:1rem;">Uji pemahamanmu dengan kuis dan dapatkan XP serta level baru!</p>
            </div>
            <div style="background:#fff;border-radius:16px;box-shadow:0 2px 8px rgba(0,0,0,0.07);padding:30px;max-width:300px;text-align:center;">
                <img src="https://cdn-icons-png.flaticon.com/512/1077/1077012.png" style="height:50px;margin-bottom:10px;">
                <h3 style="color:#3498db;font-size:1.1rem;font-weight:bold;">Konsultasi Chat</h3>
                <p style="color:#555;font-size:1rem;">Tanya langsung ke AI ustadz fiqih kapan saja, gratis!</p>
            </div>
        </section>
        <section style="padding:40px 10px 20px 10px;text-align:center;">
            <blockquote style="font-size:1.2rem;color:#555;font-style:italic;max-width:600px;margin:auto;">“Belajar fiqih itu mudah dan menyenangkan bersama Gramifiq!”</blockquote>
            <p style="margin-top:10px;color:#888;">- Pengguna Gramifiq</p>
        </section>
        <footer style="background:#f4f4f4;padding:20px;text-align:center;color:#888;font-size:0.95rem;">&copy; 2025 Gramifiq. All rights reserved.</footer>
    </main>
    <div id="register-form" style="display:none;">
        <h2 style="text-align:center;color:#3498db;margin-bottom:20px;">Register Gramifiq</h2>
        <form action="pages/register.php" method="post" style="max-width:400px;margin:0 auto;background:#fff;padding:30px;border-radius:8px;box-shadow:0 2px 8px rgba(0,0,0,0.1);">
            <input type="text" name="name" placeholder="Nama Lengkap" required style="width:100%;padding:10px;margin-bottom:15px;border:1px solid #ccc;border-radius:4px;">
            <input type="email" name="email" placeholder="Email" required style="width:100%;padding:10px;margin-bottom:15px;border:1px solid #ccc;border-radius:4px;">
            <input type="password" name="password" placeholder="Password" required style="width:100%;padding:10px;margin-bottom:15px;border:1px solid #ccc;border-radius:4px;">
            <button type="submit" style="width:100%;padding:10px;background:#3498db;color:#fff;border:none;border-radius:4px;font-size:16px;">Register</button>
        </form>
        <p style="text-align:center;margin-top:20px;">Sudah punya akun? <a href="pages/login.php" style="color:#3498db;text-decoration:underline;">Login</a></p>
    </div>
    <!-- Modal Popup -->
    <div id="modal" style="display:none;position:fixed;top:0;left:0;width:100vw;height:100vh;background:rgba(0,0,0,0.4);z-index:10000;align-items:center;justify-content:center;">
        <div style="background:#fff;padding:30px 20px;border-radius:8px;max-width:350px;margin:auto;text-align:center;box-shadow:0 2px 8px rgba(0,0,0,0.2);">
            <h3 style="color:#e74c3c;margin-bottom:15px;">Email sudah terdaftar!</h3>
            <p>Silakan gunakan email lain untuk registrasi.</p>
            <button onclick="document.getElementById('modal').style.display='none'" style="margin-top:20px;padding:8px 20px;background:#3498db;color:#fff;border:none;border-radius:4px;">Tutup</button>
        </div>
    </div>
    <script>
        window.onload = function() {
            setTimeout(function() {
                document.getElementById('loader').style.display = 'none';
                document.getElementById('landing').style.display = 'block';
                // Deteksi error dari URL
                const params = new URLSearchParams(window.location.search);
                if(params.get('error') === 'email') {
                    document.getElementById('modal').style.display = 'flex';
                }
            }, 500); // 2 detik loader
        };
        document.getElementById('showRegister').onclick = function() {
            document.getElementById('landing').style.display = 'none';
            document.getElementById('register-form').style.display = 'block';
        };
    </script>
</body>
</html>
