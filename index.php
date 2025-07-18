<!DOCTYPE html>
<html lang="id">
<head>
  <meta charset="UTF-8">
</head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Gramifiq - Belajar Fiqih Modern</title>
  <link rel="shortcut icon" href="logo.png" type="image/x-icon">
  <link href="https://fonts.cdnfonts.com/css/gasoek-one" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/tailwindcss@3.3.0/dist/tailwind.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
  <script src="https://cdn.jsdelivr.net/npm/@lottiefiles/lottie-player@2.0.0/dist/lottie-player.js"></script>
</head>
<body class="bg-gradient-to-b from-green-50 to-green-200 min-h-screen flex flex-col">
  <!-- Hero Section -->
  <header class="w-full bg-white/80 backdrop-blur sticky top-0 z-30 shadow-sm flex items-center justify-center px-4 py-2">
 
      <img src="logo.png" alt="Gramifiq Logo" class="h-14 rounded-full p-2">
      <p style="font-family: 'Gasoek One', sans-serif;" class="text-yellow-500 text-xl tracking-widest">Gramifiq</p>

  </header>

  <section class="relative flex flex-col items-center justify-center text-center py-16 md:py-24 bg-gradient-to-br from-green-100 via-blue-50 to-blue-100 overflow-hidden">
    <div class="absolute -top-10 left-0 w-40 h-40 bg-green-200 rounded-full blur-2xl opacity-40 animate-pulse"></div>
    <div class="absolute -bottom-10 right-0 w-40 h-40 bg-blue-200 rounded-full blur-2xl opacity-40 animate-pulse"></div>
    <lottie-player src="https://lottie.host/439c753a-4f2e-4b44-b8c7-1ec6bee0c061/JEcHQK3glH.json" background="transparent" speed="1" style="width: 220px; height: 220px; margin:auto;" loop autoplay></lottie-player>
    <h1 class="text-4xl md:text-5xl font-extrabold text-green-700 drop-shadow mb-4">Cara Gratis, Seru, dan Efektif untuk Belajar Fiqih!</h1>
    <p class="text-lg md:text-xl text-gray-600 mb-8 max-w-2xl mx-auto">Belajar fiqih kini semudah main game. Dapatkan pengalaman belajar yang menyenangkan, interaktif, dan didukung ilmu pengetahuan.</p>
    <div class="flex md:flex-row gap-4 justify-center">
      <a href="pages/register.php" class="pushable"><span class="front">Daftar</span></a>
      <a href="pages/login.php" class="pushable"><span class="front">Login</span></a>
    </div>
  </section>

  <!-- Fitur Section -->
  <section id="fitur" class="max-w-7xl mx-auto py-16 px-4 md:px-8 grid grid-cols-1 md:grid-cols-2 gap-12 items-center">
    <div class="flex flex-col gap-8 items-center">
      <lottie-player src="https://assets2.lottiefiles.com/packages/lf20_1pxqjqps.json" background="transparent" speed="1" style="width: 320px; height: 320px;" loop autoplay></lottie-player>
    </div>
    <div class="space-y-8">
      <h2 class="text-3xl md:text-4xl font-extrabold text-green-700 mb-4">Gratis. Seru. Efektif.</h2>
      <ul class="space-y-6 text-lg text-gray-700">
        <li class="flex items-start gap-4"><span class="inline-block w-8 h-8 bg-green-100 rounded-full flex items-center justify-center text-green-600 text-xl font-bold">✓</span> Materi fiqih lengkap, terstruktur dari bab hingga subbab, sesuai rujukan kitab.</li>
        <li class="flex items-start gap-4"><span class="inline-block w-8 h-8 bg-green-100 rounded-full flex items-center justify-center text-green-600 text-xl font-bold">✓</span> Kuis interaktif, dapatkan XP dan naik level seperti main game.</li>
        <li class="flex items-start gap-4"><span class="inline-block w-8 h-8 bg-green-100 rounded-full flex items-center justify-center text-green-600 text-xl font-bold">✓</span> Konsultasi AI ustadz fiqih, tanya jawab 24 jam gratis.</li>
        <li class="flex items-start gap-4"><span class="inline-block w-8 h-8 bg-green-100 rounded-full flex items-center justify-center text-green-600 text-xl font-bold">✓</span> Didukung ilmu pengetahuan dan pembelajaran yang dipersonalisasi.</li>
      </ul>
    </div>
  </section>

  <!-- Section Interaktif & Motivasi -->
  <section class="bg-gradient-to-br from-green-50 to-blue-50 py-16">
    <div class="max-w-7xl mx-auto grid grid-cols-1 md:grid-cols-2 gap-12 items-center px-4 md:px-8">
      <div class="flex flex-col gap-8">
        <div class="flex items-center gap-4">
          <lottie-player src="https://assets2.lottiefiles.com/packages/lf20_2ks3pjua.json" background="transparent" speed="1" style="width: 100px; height: 100px;" loop autoplay></lottie-player>
          <div>
            <h3 class="text-2xl font-bold text-green-700 mb-1">Tetap Termotivasi</h3>
            <p class="text-gray-600">Sistem XP, level, dan badge membuatmu semangat belajar setiap hari.</p>
          </div>
        </div>
        <div class="flex items-center gap-4">
          <lottie-player src="https://assets2.lottiefiles.com/packages/lf20_1pxqjqps.json" background="transparent" speed="1" style="width: 100px; height: 100px;" loop autoplay></lottie-player>
          <div>
            <h3 class="text-2xl font-bold text-green-700 mb-1">Belajar Kapan Saja</h3>
            <p class="text-gray-600">Akses Gramifiq di HP, tablet, atau laptop. Belajar fiqih di mana pun, kapan pun.</p>
          </div>
        </div>
      </div>
      <div class="flex flex-col gap-8 items-center">
        <img src="logo.png" alt="Gramifiq App" class="w-40 drop-shadow-sm animate-bounce">
      </div>
    </div>
  </section>

  <!-- Testimoni Section -->
  <section id="testimoni" class="py-16 bg-gradient-to-b from-blue-50 to-green-100">
    <div class="max-w-4xl mx-auto px-4">
      <h2 class="text-3xl md:text-4xl font-extrabold text-center text-green-700 mb-10">Apa Kata Pengguna?</h2>
      <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
        <div class="bg-white rounded-2xl shadow-lg p-6 flex flex-col items-center">
          <img src="https://randomuser.me/api/portraits/men/32.jpg" class="w-16 h-16 rounded-full mb-3 border-4 border-green-200" alt="User">
          <p class="text-gray-700 italic mb-2">“Belajar fiqih jadi seru dan nggak membosankan. XP dan level bikin semangat!”</p>
          <span class="text-green-600 font-bold">- Ahmad, Mahasiswa</span>
        </div>
        <div class="bg-white rounded-2xl shadow-lg p-6 flex flex-col items-center">
          <img src="https://randomuser.me/api/portraits/women/44.jpg" class="w-16 h-16 rounded-full mb-3 border-4 border-blue-200" alt="User">
          <p class="text-gray-700 italic mb-2">“Materinya lengkap, penjelasan mudah dipahami, dan bisa konsultasi ke AI ustadz!”</p>
          <span class="text-blue-600 font-bold">- Siti, Pelajar</span>
        </div>
        <div class="bg-white rounded-2xl shadow-lg p-6 flex flex-col items-center">
          <img src="https://randomuser.me/api/portraits/men/65.jpg" class="w-16 h-16 rounded-full mb-3 border-4 border-green-200" alt="User">
          <p class="text-gray-700 italic mb-2">“Bisa belajar fiqih di HP kapan saja, cocok buat generasi digital!”</p>
          <span class="text-green-600 font-bold">- Budi, Santri</span>
        </div>
      </div>
    </div>
  </section>

  <!-- Download Section -->
  <section class="py-16 bg-gradient-to-br from-blue-100 to-green-100 text-center">
    <h2 class="text-3xl md:text-4xl font-extrabold text-green-700 mb-6">Belajar Kapan Pun, di Mana Pun</h2>
    <p class="text-lg text-gray-700 mb-8">Gramifiq bisa diakses di semua perangkat. Download aplikasi mobile (segera hadir!)</p>
    <div class="flex flex-col md:flex-row gap-4 justify-center items-center">
      <a href="#" class="bg-black text-white px-6 py-3 rounded-xl font-bold flex items-center gap-2 opacity-60 cursor-not-allowed"><svg class="w-6 h-6" fill="currentColor" viewBox="0 0 24 24"><path d="M17.564 12.095c-.025-2.568 2.099-3.797 2.192-3.857-1.197-1.75-3.06-1.993-3.719-2.018-1.584-.161-3.09.927-3.894.927-.803 0-2.033-.904-3.346-.88-1.72.025-3.312 1.003-4.195 2.547-1.797 3.116-.459 7.719 1.29 10.25.857 1.23 1.872 2.61 3.21 2.56 1.297-.051 1.785-.828 3.354-.828 1.568 0 1.995.828 3.354.803 1.387-.025 2.256-1.253 3.11-2.48.98-1.426 1.386-2.807 1.41-2.88-.03-.014-2.71-1.04-2.736-4.13z"/><path d="M15.272 4.36c.703-.85 1.18-2.037 1.05-3.22-1.016.04-2.24.676-2.97 1.526-.652.75-1.225 1.95-1.01 3.1 1.13.09 2.23-.57 2.93-1.406z"/></svg> Segera di App Store</a>
      <a href="#" class="bg-black text-white px-6 py-3 rounded-xl font-bold flex items-center gap-2 opacity-60 cursor-not-allowed"><svg class="w-6 h-6" fill="currentColor" viewBox="0 0 24 24"><path d="M17.564 12.095c-.025-2.568 2.099-3.797 2.192-3.857-1.197-1.75-3.06-1.993-3.719-2.018-1.584-.161-3.09.927-3.894.927-.803 0-2.033-.904-3.346-.88-1.72.025-3.312 1.003-4.195 2.547-1.797 3.116-.459 7.719 1.29 10.25.857 1.23 1.872 2.61 3.21 2.56 1.297-.051 1.785-.828 3.354-.828 1.568 0 1.995.828 3.354.803 1.387-.025 2.256-1.253 3.11-2.48.98-1.426 1.386-2.807 1.41-2.88-.03-.014-2.71-1.04-2.736-4.13z"/><path d="M15.272 4.36c.703-.85 1.18-2.037 1.05-3.22-1.016.04-2.24.676-2.97 1.526-.652.75-1.225 1.95-1.01 3.1 1.13.09 2.23-.57 2.93-1.406z"/></svg> Segera di Play Store</a>
    </div>
  </section>

  <!-- Call to Action -->
  <section id="daftar" class="py-16 bg-green-500 text-white text-center">
    <h2 class="text-3xl md:text-4xl font-extrabold mb-4">Belajar Fiqih dengan Gramifiq</h2>
    <p class="text-lg mb-8">Gabung sekarang dan rasakan pengalaman belajar fiqih yang seru, gratis, dan modern!</p>
    <a href="pages/register.php" class="pushable" style="max-width:320px;margin:auto;"><span class="front">Daftar Gratis</span></a>
  </section>

  <footer class="bg-green-600 text-white py-8 mt-auto">
  <style>
    .pushable {
      background: #FEBE10;
      border-radius: 12px;
      border: none;
      padding: 0;;
      cursor: pointer;
      outline-offset: 4px;
      box-shadow: 0 4px 0 0 #bbf7d0, 0 2px 8px 0 rgba(16,185,129,0.08);
      display: inline-block;
      margin-bottom: 0.5rem;
      width: auto;
      text-align: center;
      transition: box-shadow 0.15s;
    }
    .front {
      display: block;
      padding: 16px 32px;
      border-radius: 12px;
      font-size: 1.15rem;
      font-weight: 700;
      background: linear-gradient(90deg,#FFD700 60%,#4ade80 100%);
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
  </style>
    <div class="max-w-7xl mx-auto px-4 flex flex-col md:flex-row justify-between items-center gap-4">
      <div class="flex items-center gap-2">
        <img src="logo.png" alt="Gramifiq Logo" class="h-8 w-8 rounded-full">
        <span class="font-bold text-lg tracking-tight">Gramifiq</span>
      </div>
      <div class="text-sm">&copy; 2025 Gramifiq. All rights reserved.</div>
      <div class="flex gap-4">
        <a href="#fitur" class="hover:underline">Fitur</a>
        <a href="#testimoni" class="hover:underline">Testimoni</a>
        <a href="#daftar" class="hover:underline">Daftar</a>
      </div>
    </div>
  </footer>

  <script>
    // Animasi scroll smooth untuk anchor
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
      anchor.addEventListener('click', function (e) {
        const href = this.getAttribute('href');
        if (href.length > 1 && document.querySelector(href)) {
          e.preventDefault();
          document.querySelector(href).scrollIntoView({ behavior: 'smooth' });
        }
      });
    });

    // Hamburger menu logic
    const hamburgerBtn = document.getElementById('hamburgerBtn');
    const mobileMenu = document.getElementById('mobileMenu');
    const closeMenuBtn = document.getElementById('closeMenu');
    function openMobileMenu() {
      mobileMenu.classList.add('opacity-100');
      mobileMenu.classList.remove('opacity-0', 'pointer-events-none');
      mobileMenu.classList.add('pointer-events-auto');
      document.body.style.overflow = 'hidden';
    }
    function closeMobileMenu() {
      mobileMenu.classList.remove('opacity-100', 'pointer-events-auto');
      mobileMenu.classList.add('opacity-0', 'pointer-events-none');
      document.body.style.overflow = '';
    }
    hamburgerBtn.addEventListener('click', openMobileMenu);
    closeMenuBtn.addEventListener('click', closeMobileMenu);
  </script>
</body>
</html>
