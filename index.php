<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gramifiq - Register</title>
    <style>
        body { margin:0; padding:0; font-family:Arial,sans-serif; background:#f4f4f4; }
        #loader {
            position:fixed; left:0; top:0; width:100vw; height:100vh;
            background:#fff; display:flex; align-items:center; justify-content:center; z-index:9999;
        }
        .spinner {
            border:8px solid #eee; border-top:8px solid #3498db; border-radius:50%; width:60px; height:60px; animation:spin 1s linear infinite;
        }
        @keyframes spin { 100% { transform:rotate(360deg); } }
        #register-form {
            display:none; max-width:400px; margin:100px auto; background:#fff; padding:30px; border-radius:8px; box-shadow:0 2px 8px rgba(0,0,0,0.1);
        }
        #register-form h2 { margin-bottom:20px; }
        #register-form input[type="text"], #register-form input[type="email"], #register-form input[type="password"] {
            width:100%; padding:10px; margin-bottom:15px; border:1px solid #ccc; border-radius:4px;
        }
        #register-form button {
            width:100%; padding:10px; background:#3498db; color:#fff; border:none; border-radius:4px; font-size:16px;
        }
    </style>
</head>
<body>
    <div id="loader">
        <div class="spinner"></div>
    </div>
    <div id="register-form">
        <h2>Register Gramifiq</h2>
        <form action="pages/register.php" method="post">
            <input type="text" name="name" placeholder="Nama Lengkap" required>
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>
            <button type="submit">Register</button>
        </form>
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
                document.getElementById('register-form').style.display = 'block';
                // Deteksi error dari URL
                const params = new URLSearchParams(window.location.search);
                if(params.get('error') === 'email') {
                    document.getElementById('modal').style.display = 'flex';
                }
            }, 2000); // 2 detik loader
        };
    </script>
</body>
</html>
