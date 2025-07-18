CREATE DATABASE gramifiq;

USE gramifiq;

CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100) UNIQUE,
  password VARCHAR(255),
  avatar VARCHAR(255),
  level INT DEFAULT 1,
  xp INT DEFAULT 0,
  progress FLOAT DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE bab_fiqih (
  id INT AUTO_INCREMENT PRIMARY KEY,
  judul VARCHAR(255),
  deskripsi TEXT
);

CREATE TABLE subbab_fiqih (
  id INT AUTO_INCREMENT PRIMARY KEY,
  id_bab INT,
  judul VARCHAR(255),
  deskripsi TEXT,
  FOREIGN KEY (id_bab) REFERENCES bab_fiqih(id)
);

CREATE TABLE soal_kuis (
  id INT AUTO_INCREMENT PRIMARY KEY,
  id_subbab INT,
  soal TEXT,
  tipe_jawaban ENUM('radio','text','voice'),
  pilihan_a VARCHAR(255),
  pilihan_b VARCHAR(255),
  pilihan_c VARCHAR(255),
  pilihan_d VARCHAR(255),
  jawaban_benar VARCHAR(255),
  poin INT,
  FOREIGN KEY (id_subbab) REFERENCES subbab_fiqih(id)
);

CREATE TABLE jawaban_user (
  id INT AUTO_INCREMENT PRIMARY KEY,
  id_user INT,
  id_soal INT,
  jawaban VARCHAR(255),
  benar BOOLEAN,
  waktu DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_user) REFERENCES users(id),
  FOREIGN KEY (id_soal) REFERENCES soal_kuis(id)
);

CREATE TABLE chat_logs (
  id INT AUTO_INCREMENT PRIMARY KEY,
  id_user INT,
  question TEXT,
  answer TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_user) REFERENCES users(id)
);

CREATE TABLE xp_klaim (
  id INT AUTO_INCREMENT PRIMARY KEY,
  id_user INT,
  id_subbab INT,
  xp INT,
  waktu_klaim DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_user) REFERENCES users(id),
  FOREIGN KEY (id_subbab) REFERENCES subbab_fiqih(id)
);

-- 500 Soal Kuis Fiqih (10 soal per subbab)

-- Bab Fiqih
INSERT INTO bab_fiqih (judul, deskripsi) VALUES
('Thaharah (Bersuci)', 'Hukum air, wudhu, mandi, tayamum, najis'),
('Shalat', 'Syarat, rukun, macam-macam shalat'),
('Puasa (Shaum)', 'Syarat, jenis, hal yang membatalkan'),
('Zakat', 'Jenis zakat, nisab, mustahik, waktu'),
('Haji dan Umrah', 'Rukun, wajib, sunnah, larangan');

-- Subbab Fiqih
INSERT INTO subbab_fiqih (id_bab, judul, deskripsi) VALUES
(1, 'Pengertian Thaharah', 'Pembahasan tentang Pengertian Thaharah'),
(1, 'Macam-macam Air', 'Pembahasan tentang Macam-macam Air'),
(1, 'Air yang Mensucikan', 'Pembahasan tentang Air yang Mensucikan'),
(1, 'Air Musta’mal', 'Pembahasan tentang Air Musta’mal'),
(1, 'Najis dan Cara Mensucikan', 'Pembahasan tentang Najis dan Cara Mensucikan'),
(1, 'Tayamum', 'Pembahasan tentang Tayamum'),
(1, 'Wudhu dan Rukunnya', 'Pembahasan tentang Wudhu dan Rukunnya'),
(1, 'Sunnah Wudhu', 'Pembahasan tentang Sunnah Wudhu'),
(1, 'Hal yang Membatalkan Wudhu', 'Pembahasan tentang Hal yang Membatalkan Wudhu'),
(1, 'Mandi Wajib', 'Pembahasan tentang Mandi Wajib'),
(2, 'Syarat Wajib Shalat', 'Pembahasan tentang Syarat Wajib Shalat'),
(2, 'Rukun Shalat', 'Pembahasan tentang Rukun Shalat'),
(2, 'Sunnah Shalat', 'Pembahasan tentang Sunnah Shalat'),
(2, 'Shalat Wajib', 'Pembahasan tentang Shalat Wajib'),
(2, 'Shalat Sunnah Rawatib', 'Pembahasan tentang Shalat Sunnah Rawatib'),
(2, 'Shalat Jumat', 'Pembahasan tentang Shalat Jumat'),
(2, 'Shalat Jama’ dan Qashar', 'Pembahasan tentang Shalat Jama’ dan Qashar'),
(2, 'Shalat dalam Perjalanan', 'Pembahasan tentang Shalat dalam Perjalanan'),
(2, 'Tertib Shalat', 'Pembahasan tentang Tertib Shalat'),
(2, 'Hal yang Membatalkan Shalat', 'Pembahasan tentang Hal yang Membatalkan Shalat'),
(3, 'Definisi Puasa', 'Pembahasan tentang Definisi Puasa'),
(3, 'Syarat Sah Puasa', 'Pembahasan tentang Syarat Sah Puasa'),
(3, 'Rukun Puasa', 'Pembahasan tentang Rukun Puasa'),
(3, 'Niat dan Waktu Puasa', 'Pembahasan tentang Niat dan Waktu Puasa'),
(3, 'Puasa Wajib dan Sunnah', 'Pembahasan tentang Puasa Wajib dan Sunnah'),
(3, 'Hal yang Membatalkan Puasa', 'Pembahasan tentang Hal yang Membatalkan Puasa'),
(3, 'Kafarat dan Qadha', 'Pembahasan tentang Kafarat dan Qadha'),
(3, 'Puasa Ramadhan', 'Pembahasan tentang Puasa Ramadhan'),
(3, 'Puasa Syawal', 'Pembahasan tentang Puasa Syawal'),
(3, 'Puasa Arafah', 'Pembahasan tentang Puasa Arafah'),
(4, 'Pengertian Zakat', 'Pembahasan tentang Pengertian Zakat'),
(4, 'Syarat Wajib Zakat', 'Pembahasan tentang Syarat Wajib Zakat'),
(4, 'Jenis-jenis Zakat', 'Pembahasan tentang Jenis-jenis Zakat'),
(4, 'Zakat Fitrah', 'Pembahasan tentang Zakat Fitrah'),
(4, 'Zakat Maal', 'Pembahasan tentang Zakat Maal'),
(4, 'Nisab Zakat', 'Pembahasan tentang Nisab Zakat'),
(4, 'Zakat Profesi', 'Pembahasan tentang Zakat Profesi'),
(4, 'Mustahik Zakat', 'Pembahasan tentang Mustahik Zakat'),
(4, 'Waktu Pengeluaran', 'Pembahasan tentang Waktu Pengeluaran'),
(4, 'Distribusi Zakat', 'Pembahasan tentang Distribusi Zakat'),
(5, 'Pengertian Haji', 'Pembahasan tentang Pengertian Haji'),
(5, 'Syarat Haji', 'Pembahasan tentang Syarat Haji'),
(5, 'Rukun Haji', 'Pembahasan tentang Rukun Haji'),
(5, 'Wajib Haji', 'Pembahasan tentang Wajib Haji'),
(5, 'Tawaf', 'Pembahasan tentang Tawaf'),
(5, 'Sa’i', 'Pembahasan tentang Sa’i'),
(5, 'Wukuf di Arafah', 'Pembahasan tentang Wukuf di Arafah'),
(5, 'Larangan Saat Haji', 'Pembahasan tentang Larangan Saat Haji'),
(5, 'Dam Haji', 'Pembahasan tentang Dam Haji'),
(5, 'Umrah', 'Pembahasan tentang Umrah');

-- BAB 1: THAHARAH (100 soal)
-- Subbab 1: Pengertian Thaharah (10 soal)
INSERT INTO soal_kuis (id_subbab, soal, tipe_jawaban, pilihan_a, pilihan_b, pilihan_c, pilihan_d, jawaban_benar, poin) VALUES 
(1, 'Apa yang dimaksud dengan thaharah menurut bahasa?', 'radio', 'Kebersihan dan kesucian', 'Bersuci dengan air', 'Menghilangkan najis', 'Ritual keagamaan', 'Kebersihan dan kesucian', 10),
(1, 'Thaharah secara istilah syara adalah...', 'radio', 'Membersihkan badan dari kotoran', 'Menghilangkan hadats dan najis', 'Mandi dengan air suci', 'Berwudhu sebelum shalat', 'Menghilangkan hadats dan najis', 10),
(1, 'Berapa macam thaharah menurut hukum Islam?', 'radio', 'Satu macam', 'Dua macam', 'Tiga macam', 'Empat macam', 'Dua macam', 10),
(1, 'Thaharah dibagi menjadi dua, yaitu...', 'radio', 'Thaharah wajib dan sunnah', 'Thaharah hadats dan najis', 'Thaharah kecil dan besar', 'Thaharah air dan debu', 'Thaharah hadats dan najis', 10),
(1, 'Apa yang dimaksud dengan hadats?', 'radio', 'Kotoran yang terlihat', 'Sesuatu yang membatalkan wudhu', 'Najis yang menempel di badan', 'Air yang tidak suci', 'Sesuatu yang membatalkan wudhu', 10),
(1, 'Hadats dibagi menjadi berapa macam?', 'radio', 'Satu macam', 'Dua macam', 'Tiga macam', 'Empat macam', 'Dua macam', 10),
(1, 'Contoh hadats kecil adalah...', 'radio', 'Junub', 'Haid', 'Buang air kecil', 'Nifas', 'Buang air kecil', 10),
(1, 'Contoh hadats besar adalah...', 'radio', 'Kentut', 'Tidur', 'Junub', 'Menyentuh kemaluan', 'Junub', 10),
(1, 'Hikmah dari thaharah adalah...', 'radio', 'Mendapat pahala', 'Kebersihan dan kesehatan', 'Menjalankan perintah Allah', 'Semua jawaban benar', 'Semua jawaban benar', 10),
(1, 'Thaharah merupakan syarat sah untuk...', 'radio', 'Makan dan minum', 'Shalat dan thawaf', 'Tidur dan istirahat', 'Bekerja dan belajar', 'Shalat dan thawaf', 10),

-- Subbab 2: Macam-macam Air (10 soal)
(2, 'Berdasarkan hukum penggunaannya, air dibagi menjadi berapa macam?', 'radio', 'Dua macam', 'Tiga macam', 'Empat macam', 'Lima macam', 'Tiga macam', 10),
(2, 'Air yang suci dan mensucikan disebut...', 'radio', 'Air mutlak', 'Air mustamal', 'Air najis', 'Air muqayyad', 'Air mutlak', 10),
(2, 'Contoh air mutlak adalah...', 'radio', 'Air teh', 'Air hujan', 'Air kopi', 'Air sirup', 'Air hujan', 10),
(2, 'Air yang suci tapi tidak mensucikan disebut...', 'radio', 'Air mutlak', 'Air mustamal', 'Air muqayyad', 'Air najis', 'Air muqayyad', 10),
(2, 'Air laut termasuk jenis air...', 'radio', 'Air muqayyad', 'Air mustamal', 'Air mutlak', 'Air najis', 'Air mutlak', 10),
(2, 'Air yang tidak suci dan tidak mensucikan adalah...', 'radio', 'Air mutlak', 'Air mustamal', 'Air najis', 'Air muqayyad', 'Air najis', 10),
(2, 'Air sumur termasuk jenis...', 'radio', 'Air muqayyad', 'Air mutlak', 'Air najis', 'Air mustamal', 'Air mutlak', 10),
(2, 'Air yang tercampur dengan najis disebut...', 'radio', 'Air mutlak', 'Air najis', 'Air muqayyad', 'Air mustamal', 'Air najis', 10),
(2, 'Air es yang mencair termasuk...', 'radio', 'Air muqayyad', 'Air mutlak', 'Air najis', 'Air mustamal', 'Air mutlak', 10),
(2, 'Air yang boleh digunakan untuk berwudhu adalah...', 'radio', 'Air najis', 'Air muqayyad', 'Air mutlak', 'Air mustamal', 'Air mutlak', 10),

-- Subbab 3: Air yang Mensucikan (10 soal)
(3, 'Air yang dapat digunakan untuk bersuci adalah...', 'radio', 'Air mutlak saja', 'Air muqayyad saja', 'Air mutlak dan muqayyad', 'Semua jenis air', 'Air mutlak saja', 10),
(3, 'Syarat air yang mensucikan adalah...', 'radio', 'Suci dan tidak berubah', 'Banyak dan jernih', 'Dingin dan segar', 'Mengalir dan deras', 'Suci dan tidak berubah', 10),
(3, 'Air hujan dapat digunakan untuk...', 'radio', 'Minum saja', 'Mandi saja', 'Wudhu dan mandi', 'Mencuci pakaian saja', 'Wudhu dan mandi', 10),
(3, 'Air yang berubah karena tanah masih...', 'radio', 'Najis', 'Tidak boleh dipakai', 'Boleh dipakai untuk bersuci', 'Menjadi muqayyad', 'Boleh dipakai untuk bersuci', 10),
(3, 'Air zamzam termasuk air...', 'radio', 'Muqayyad', 'Najis', 'Mutlak', 'Mustamal', 'Mutlak', 10),
(3, 'Air yang tercampur dengan minyak...', 'radio', 'Tetap suci mensucikan', 'Menjadi najis', 'Menjadi muqayyad', 'Tidak boleh dipakai', 'Menjadi muqayyad', 10),
(3, 'Minimal air yang dapat digunakan untuk wudhu adalah...', 'radio', 'Satu liter', 'Satu mud', 'Dua qullah', 'Tidak ada batas minimal', 'Satu mud', 10),
(3, 'Air yang berubah warna karena najis...', 'radio', 'Tetap suci', 'Menjadi najis', 'Menjadi muqayyad', 'Masih boleh dipakai', 'Menjadi najis', 10),
(3, 'Air sungai yang jernih termasuk...', 'radio', 'Air muqayyad', 'Air najis', 'Air mutlak', 'Air mustamal', 'Air mutlak', 10),
(3, 'Air yang dipakai untuk mencuci najis...', 'radio', 'Tetap suci', 'Menjadi najis', 'Menjadi muqayyad', 'Menjadi mustamal', 'Menjadi najis', 10),

-- Subbab 4: Air mustamal (10 soal)
(4, 'Air mustamal adalah air yang...', 'radio', 'Sudah dipakai untuk bersuci', 'Tercampur dengan najis', 'Berubah warna dan rasa', 'Terlalu sedikit', 'Sudah dipakai untuk bersuci', 10),
(4, 'Hukum air mustamal menurut madzhab Syafii adalah...', 'radio', 'Suci dan mensucikan', 'Suci tapi tidak mensucikan', 'Najis', 'Makruh digunakan', 'Suci tapi tidak mensucikan', 10),
(4, 'Air bekas wudhu termasuk...', 'radio', 'Air mutlak', 'Air mustamal', 'Air najis', 'Air muqayyad', 'Air mustamal', 10),
(4, 'Air mustamal boleh digunakan untuk...', 'radio', 'Wudhu lagi', 'Minum', 'Mencuci pakaian', 'Semua jawaban benar', 'Mencuci pakaian', 10),
(4, 'Air yang menetes dari anggota wudhu...', 'radio', 'Tetap suci mensucikan', 'Menjadi mustamal', 'Menjadi najis', 'Menjadi muqayyad', 'Menjadi mustamal', 10),
(4, 'Air bekas mandi junub termasuk...', 'radio', 'Air mutlak', 'Air mustamal', 'Air najis', 'Air muqayyad', 'Air mustamal', 10),
(4, 'Perbedaan air mustamal dengan air najis adalah...', 'radio', 'Tidak ada perbedaan', 'Air mustamal masih suci', 'Air najis lebih kotor', 'Air mustamal lebih bersih', 'Air mustamal masih suci', 10),
(4, 'Air yang tersisa setelah wudhu dalam wadah...', 'radio', 'Menjadi najis', 'Tetap mutlak', 'Menjadi mustamal', 'Menjadi muqayyad', 'Tetap mutlak', 10),
(4, 'Hikmah larangan menggunakan air mustamal adalah...', 'radio', 'Menjaga kebersihan', 'Menghormati air', 'Kehati-hatian dalam bersuci', 'Semua jawaban benar', 'Semua jawaban benar', 10),
(4, 'Air mustamal yang bercampur dengan air mutlak...', 'radio', 'Tetap mustamal', 'Menjadi mutlak', 'Menjadi najis', 'Tergantung jumlahnya', 'Tergantung jumlahnya', 10),

-- Subbab 5: Najis dan Cara Mensucikan (10 soal)
(5, 'Najis menurut istilah syara adalah...', 'radio', 'Kotoran yang terlihat', 'Sesuatu yang kotor secara zahir', 'Sesuatu yang dianggap kotor oleh syara', 'Benda yang berbau busuk', 'Sesuatu yang dianggap kotor oleh syara', 10),
(5, 'Najis dibagi menjadi berapa macam berdasarkan tingkat kekotorannya?', 'radio', 'Dua macam', 'Tiga macam', 'Empat macam', 'Lima macam', 'Tiga macam', 10),
(5, 'Najis mukhoffafah adalah najis...', 'radio', 'Berat', 'Ringan', 'Sedang', 'Sangat berat', 'Ringan', 10),
(5, 'Contoh najis mukhoffafah adalah...', 'radio', 'Kotoran manusia', 'Kencing bayi laki-laki', 'Darah haid', 'Bangkai anjing', 'Kencing bayi laki-laki', 10),
(5, 'Najis mutawassithah adalah najis...', 'radio', 'Ringan', 'Sedang', 'Berat', 'Sangat ringan', 'Sedang', 10),
(5, 'Cara mensucikan najis mutawassithah adalah...', 'radio', 'Dipercik air', 'Dibasuh dengan air', 'Dihilangkan zatnya', 'Dijemur di matahari', 'Dibasuh dengan air', 10),
(5, 'Najis mugholladzah adalah najis...', 'radio', 'Ringan', 'Sedang', 'Berat', 'Sangat ringan', 'Berat', 10),
(5, 'Contoh najis mugholladzah adalah...', 'radio', 'Kencing kucing', 'Liur anjing', 'Kotoran ayam', 'Kencing sapi', 'Liur anjing', 10),
(5, 'Cara mensucikan najis mugholladzah adalah...', 'radio', 'Dibasuh sekali', 'Dibasuh 7 kali, salah satunya dengan tanah', 'Dipercik air', 'Dihilangkan zatnya', 'Dibasuh 7 kali, salah satunya dengan tanah', 10),
(5, 'Najis yang dimaafkan adalah...', 'radio', 'Najis mugholladzah', 'Najis dalam jumlah sedikit', 'Najis yang tidak terlihat', 'Najis yang sulit dihindari', 'Najis yang sulit dihindari', 10),

-- Subbab 6: Tayamum (10 soal)
(6, 'Tayamum secara bahasa berarti...', 'radio', 'Bersuci dengan air', 'Menuju atau menyengaja', 'Membersihkan diri', 'Menghilangkan najis', 'Menuju atau menyengaja', 10),
(6, 'Tayamum secara istilah adalah...', 'radio', 'Bersuci dengan air', 'Bersuci dengan debu suci', 'Bersuci dengan tanah', 'Bersuci tanpa air', 'Bersuci dengan debu suci', 10),
(6, 'Kapan tayamum diperbolehkan?', 'radio', 'Setiap saat', 'Ketika tidak ada air', 'Ketika malas wudhu', 'Ketika terburu-buru', 'Ketika tidak ada air', 10),
(6, 'Media yang boleh digunakan untuk tayamum adalah...', 'radio', 'Air dan tanah', 'Tanah dan debu suci', 'Pasir dan batu', 'Semua jawaban benar', 'Tanah dan debu suci', 10),
(6, 'Rukun tayamum ada berapa?', 'radio', 'Tiga', 'Empat', 'Lima', 'Enam', 'Empat', 10),
(6, 'Urutan rukun tayamum yang benar adalah...', 'radio', 'Niat, mengusap wajah, mengusap tangan', 'Niat, menepuk tanah, mengusap wajah, mengusap tangan', 'Menepuk tanah, niat, mengusap wajah, mengusap tangan', 'Mengusap wajah, mengusap tangan, niat', 'Niat, menepuk tanah, mengusap wajah, mengusap tangan', 10),
(7, 'Tayamum menggantikan...', 'radio', 'Wudhu saja', 'Mandi saja', 'Wudhu dan mandi', 'Shalat', 'Wudhu dan mandi', 10),
(6, 'Hal yang membatalkan tayamum adalah...', 'radio', 'Sama dengan yang membatalkan wudhu', 'Menemukan air', 'Hilangnya uzur', 'Semua jawaban benar', 'Semua jawaban benar', 10),
(6, 'Berapa kali menepuk tanah dalam tayamum?', 'radio', 'Sekali', 'Dua kali', 'Tiga kali', 'Tidak ada aturan', 'Dua kali', 10),
(6, 'Sunnah tayamum adalah...', 'radio', 'Membaca basmalah', 'Tertib dalam mengusap', 'Mendahulukan kanan', 'Semua jawaban benar', 'Semua jawaban benar', 10),

-- Subbab 7: Wudhu dan Rukunnya (10 soal)
(7, 'Wudhu secara bahasa berarti...', 'radio', 'Bersih dan indah', 'Suci dan jernih', 'Berkilau dan bersinar', 'Semua jawaban benar', 'Bersih dan indah', 10),
(7, 'Wudhu secara istilah adalah...', 'radio', 'Bersuci dengan air', 'Membersihkan anggota tertentu dengan air', 'Menghilangkan hadats kecil', 'Semua jawaban benar', 'Semua jawaban benar', 10),
(7, 'Rukun wudhu ada berapa?', 'radio', 'Empat', 'Lima', 'Enam', 'Tujuh', 'Enam', 10),
(7, 'Rukun wudhu yang pertama adalah...', 'radio', 'Membasuh wajah', 'Niat', 'Membasuh tangan', 'Berkumur', 'Niat', 10),
(7, 'Batas membasuh wajah dalam wudhu adalah...', 'radio', 'Dari dahi sampai dagu', 'Dari telinga ke telinga', 'Dari batas rambut sampai dagu, dari telinga ke telinga', 'Seluruh kepala', 'Dari batas rambut sampai dagu, dari telinga ke telinga', 10),
(7, 'Membasuh tangan dalam wudhu sampai...', 'radio', 'Pergelangan tangan', 'Siku', 'Ketiak', 'Bahu', 'Siku', 10),
(7, 'Mengusap sebagian kepala hukumnya...', 'radio', 'Sunnah', 'Wajib', 'Mustahab', 'Mubah', 'Wajib', 10),
(7, 'Membasuh kaki dalam wudhu sampai...', 'radio', 'Jari kaki', 'Mata kaki', 'Pergelangan kaki', 'Betis', 'Mata kaki', 10),
(7, 'Tertib dalam wudhu hukumnya...', 'radio', 'Sunnah', 'Wajib', 'Mustahab', 'Mubah', 'Wajib', 10),
(7, 'Doa setelah wudhu dimulai dengan...', 'radio', 'Asyhadu an la ilaha illallah', 'Allahumma ajalni minat tawwabin', 'Bismillahirrahmanirrahim', 'Subhanallahi wa bihamdihi', 'Asyhadu an la ilaha illallah', 10),

-- Subbab 8: Sunnah Wudhu (10 soal)
(8, 'Membaca basmalah sebelum wudhu hukumnya...', 'radio', 'Wajib', 'Sunnah', 'Mubah', 'Mustahab', 'Sunnah', 10),
(8, 'Mencuci telapak tangan sebelum wudhu termasuk...', 'radio', 'Rukun', 'Syarat', 'Sunnah', 'Wajib', 'Sunnah', 10),
(8, 'Berkumur dalam wudhu hukumnya...', 'radio', 'Wajib', 'Sunnah', 'Rukun', 'Syarat', 'Sunnah', 10),
(8, 'Menghirup air ke hidung (istinsyaq) termasuk...', 'radio', 'Rukun wudhu', 'Sunnah wudhu', 'Syarat wudhu', 'Wajib wudhu', 'Sunnah wudhu', 10),
(8, 'Mengusap telinga dalam wudhu hukumnya...', 'radio', 'Wajib', 'Sunnah', 'Rukun', 'Syarat', 'Sunnah', 10),
(8, 'Menyela-nyela jari kaki termasuk...', 'radio', 'Rukun wudhu', 'Sunnah wudhu', 'Syarat wudhu', 'Wajib wudhu', 'Sunnah wudhu', 10),
(8, 'Mendahulukan anggota kanan dalam wudhu adalah...', 'radio', 'Wajib', 'Sunnah', 'Rukun', 'Syarat', 'Sunnah', 10),
(8, 'Membasuh anggota wudhu tiga kali adalah...', 'radio', 'Wajib', 'Sunnah', 'Rukun', 'Syarat', 'Sunnah', 10),
(8, 'Berdoa setelah wudhu hukumnya...', 'radio', 'Wajib', 'Sunnah', 'Rukun', 'Syarat', 'Sunnah', 10),
(8, 'Tidak berbicara saat wudhu termasuk...', 'radio', 'Wajib', 'Sunnah', 'Rukun', 'Haram', 'Sunnah', 10),

-- Subbab 9: Hal yang Membatalkan Wudhu (10 soal)
(9, 'Keluar sesuatu dari qubul atau dubur membatalkan wudhu karena...', 'radio', 'Najis', 'Hadats', 'Kotor', 'Bau', 'Hadats', 10),
(9, 'Tidur yang membatalkan wudhu adalah...', 'radio', 'Tidur sebentar', 'Tidur dalam keadaan duduk', 'Tidur tidak dalam keadaan duduk', 'Semua tidur', 'Tidur tidak dalam keadaan duduk', 10),
(9, 'Hilang akal karena gila atau pingsan...', 'radio', 'Tidak membatalkan wudhu', 'Membatalkan wudhu', 'Makruh', 'Diragukan', 'Membatalkan wudhu', 10),
(9, 'Menyentuh kemaluan dengan telapak tangan...', 'radio', 'Tidak membatalkan wudhu', 'Membatalkan wudhu', 'Sunnah berwudhu', 'Makruh', 'Membatalkan wudhu', 10),
(9, 'Bersentuhan kulit antara laki-laki dan perempuan yang bukan mahram...', 'radio', 'Selalu membatalkan wudhu', 'Tidak membatalkan wudhu', 'Membatalkan jika dengan syahwat', 'Makruh', 'Membatalkan jika dengan syahwat', 10),
(9, 'Keluar darah dari tubuh yang banyak...', 'radio', 'Tidak membatalkan wudhu', 'Membatalkan wudhu', 'Makruh', 'Sunnah berwudhu', 'Membatalkan wudhu', 10),
(9, 'Muntah yang membatalkan wudhu adalah...', 'radio', 'Muntah sedikit', 'Muntah banyak', 'Semua muntah', 'Tidak ada muntah yang membatalkan', 'Muntah banyak', 10),
(9, 'Makan daging unta...', 'radio', 'Tidak membatalkan wudhu', 'Membatalkan wudhu', 'Makruh', 'Sunnah berwudhu', 'Membatalkan wudhu', 10),
(9, 'Murtad (keluar dari Islam)...', 'radio', 'Tidak membatalkan wudhu', 'Membatalkan wudhu', 'Makruh', 'Diragukan', 'Membatalkan wudhu', 10),
(9, 'Bersuara keras saat wudhu...', 'radio', 'Membatalkan wudhu', 'Tidak membatalkan wudhu', 'Makruh', 'Haram', 'Tidak membatalkan wudhu', 10),

-- Subbab 10: Mandi Wajib (10 soal)
(10, 'Mandi wajib disebut juga...', 'radio', 'Mandi sunnah', 'Mandi janabah', 'Mandi istinja', 'Mandi biasa', 'Mandi janabah', 10),
(10, 'Sebab-sebab mandi wajib ada...', 'radio', 'Tiga', 'Empat', 'Lima', 'Enam', 'Lima', 10),
(10, 'Keluar mani karena syahwat mewajibkan...', 'radio', 'Wudhu', 'Mandi', 'Tayamum', 'Tidak ada yang wajib', 'Mandi', 10),
(10, 'Haid dan nifas mewajibkan...', 'radio', 'Wudhu', 'Mandi setelah suci', 'Tayamum', 'Tidak ada yang wajib', 'Mandi setelah suci', 10),
(10, 'Masuk Islam bagi orang kafir mewajibkan...', 'radio', 'Wudhu', 'Mandi', 'Tayamum', 'Tidak ada yang wajib', 'Mandi', 10),
(10, 'Rukun mandi wajib ada...', 'radio', 'Dua', 'Tiga', 'Empat', 'Lima', 'Dua', 10),
(10, 'Rukun mandi wajib adalah...', 'radio', 'Niat dan membasuh seluruh badan', 'Niat dan berkumur', 'Membasuh kepala dan badan', 'Niat dan berdoa', 'Niat dan membasuh seluruh badan', 10),
(10, 'Sunnah mandi wajib adalah...', 'radio', 'Berkumur dan istinsyaq', 'Membasuh kemaluan', 'Wudhu terlebih dahulu', 'Semua jawaban benar', 'Semua jawaban benar', 10),
(10, 'Orang yang junub dilarang...', 'radio', 'Makan dan minum', 'Shalat dan thawaf', 'Tidur dan istirahat', 'Berbicara', 'Shalat dan thawaf', 10),
(10, 'Mandi wajib menggantikan...', 'radio', 'Wudhu', 'Tayamum', 'Wudhu dan tayamum', 'Tidak menggantikan apa-apa', 'Wudhu dan tayamum', 10),

-- BAB 2: SHALAT (100 soal)

-- Subbab 11: Syarat Wajib Shalat (10 soal)
(11, 'Syarat wajib shalat ada berapa?', 'radio', 'Empat', 'Lima', 'Enam', 'Tujuh', 'Lima', 10),
(11, 'Islam merupakan syarat wajib shalat karena...', 'radio', 'Shalat adalah ibadah', 'Orang kafir tidak diperintah shalat', 'Shalat hanya untuk muslim', 'Semua jawaban benar', 'Semua jawaban benar', 10),
(11, 'Umur minimal untuk wajib shalat adalah...', 'radio', 'Baligh', 'Tujuh tahun', 'Sepuluh tahun', 'Dewasa', 'Baligh', 10),
(11, 'Berakal merupakan syarat wajib shalat karena...', 'radio', 'Orang gila tidak bisa shalat', 'Orang gila tidak dibebani hukum', 'Shalat butuh pikiran', 'Semua jawaban benar', 'Orang gila tidak dibebani hukum', 10),
(11, 'Suci dari haid dan nifas berlaku untuk...', 'radio', 'Laki-laki', 'Perempuan', 'Semua orang', 'Anak-anak', 'Perempuan', 10),
(11, 'Mendengar seruan shalat maksudnya...', 'radio', 'Mendengar adzan', 'Tahu waktu shalat', 'Berada di masjid', 'Mendengar imam', 'Tahu waktu shalat', 10),
(11, 'Orang yang tidak baligh...', 'radio', 'Wajib shalat', 'Tidak wajib shalat', 'Disunahkan shalat', 'Dilarang shalat', 'Tidak wajib shalat', 10),
(11, 'Orang yang sedang haid...', 'radio', 'Wajib shalat', 'Tidak wajib shalat', 'Boleh shalat', 'Harus qadha', 'Tidak wajib shalat', 10),
(11, 'Orang yang pingsan saat waktu shalat...', 'radio', 'Wajib shalat', 'Tidak wajib shalat', 'Harus qadha', 'Boleh shalat', 'Tidak wajib shalat', 10),
(11, 'Syarat wajib shalat yang berkaitan dengan waktu adalah...', 'radio', 'Masuk waktu shalat', 'Mendengar seruan', 'Berada di tempat', 'Dalam keadaan sehat', 'Masuk waktu shalat', 10),

-- Subbab 12: Rukun Shalat (10 soal)
(12, 'Rukun shalat ada berapa?', 'radio', 'Tiga belas', 'Empat belas', 'Lima belas', 'Enam belas', 'Empat belas', 10),
(12, 'Rukun shalat yang pertama adalah...', 'radio', 'Takbiratul ihram', 'Niat', 'Berdiri', 'Membaca Al-Fatihah', 'Niat', 10),
(12, 'Berdiri bagi yang mampu hukumnya...', 'radio', 'Sunnah', 'Wajib', 'Rukun', 'Syarat', 'Rukun', 10),
(12, 'Takbiratul ihram adalah...', 'radio', 'Takbir pembuka shalat', 'Takbir saat ruku', 'Takbir saat sujud', 'Takbir penutup', 'Takbir pembuka shalat', 10),
(12, 'Membaca Al-Fatihah hukumnya...', 'radio', 'Sunnah', 'Wajib', 'Rukun', 'Syarat', 'Rukun', 10),
(12, 'Ruku dengan thumaninah maksudnya...', 'radio', 'Ruku sebentar', 'Ruku dengan tenang', 'Ruku sambil berdoa', 'Ruku dengan khusyuk', 'Ruku dengan tenang', 10),
(12, 'Itidal adalah...', 'radio', 'Bangkit dari ruku', 'Berdiri tegak setelah ruku', 'Duduk antara dua sujud', 'Sujud pertama', 'Berdiri tegak setelah ruku', 10),
(12, 'Sujud dilakukan sebanyak...', 'radio', 'Satu kali', 'Dua kali', 'Tiga kali', 'Empat kali', 'Dua kali', 10),
(12, 'Duduk antara dua sujud hukumnya...', 'radio', 'Sunnah', 'Wajib', 'Rukun', 'Syarat', 'Rukun', 10),
(12, 'Salam adalah...', 'radio', 'Pembuka shalat', 'Penutup shalat', 'Doa dalam shalat', 'Bacaan shalat', 'Penutup shalat', 10),

-- Subbab 13: Sunnah Shalat (10 soal)
(13, 'Membaca doa iftitah hukumnya...', 'radio', 'Wajib', 'Rukun', 'Sunnah', 'Syarat', 'Sunnah', 10),
(13, 'Membaca taawudz sebelum Al-Fatihah adalah...', 'radio', 'Wajib', 'Rukun', 'Sunnah', 'Syarat', 'Sunnah', 10),
(13, 'Membaca surat setelah Al-Fatihah hukumnya...', 'radio', 'Wajib', 'Rukun', 'Sunnah', 'Syarat', 'Sunnah', 10),
(13, 'Mengangkat tangan saat takbir adalah...', 'radio', 'Wajib', 'Rukun', 'Sunnah', 'Syarat', 'Sunnah', 10),
(13, 'Meletakkan tangan kanan di atas kiri saat berdiri...', 'radio', 'Wajib', 'Rukun', 'Sunnah', 'Syarat', 'Sunnah', 10),
(13, 'Membaca tasbih saat ruku adalah...', 'radio', 'Wajib', 'Rukun', 'Sunnah', 'Syarat', 'Sunnah', 10),
(13, 'Membaca tasbih saat sujud hukumnya...', 'radio', 'Wajib', 'Rukun', 'Sunnah', 'Syarat', 'Sunnah', 10),
(13, 'Duduk tasyahud awal adalah...', 'radio', 'Wajib', 'Rukun', 'Sunnah', 'Syarat', 'Sunnah', 10),
(13, 'Membaca shalawat pada tasyahud akhir...', 'radio', 'Wajib', 'Rukun', 'Sunnah', 'Syarat', 'Sunnah', 10),
(13, 'Berdoa setelah tasyahud akhir adalah...', 'radio', 'Wajib', 'Rukun', 'Sunnah', 'Syarat', 'Sunnah', 10),

-- Subbab 14: Shalat Wajib (10 soal)
(14, 'Shalat fardhu ada berapa?', 'radio', 'Empat', 'Lima', 'Enam', 'Tujuh', 'Lima', 10),
(14, 'Shalat Subuh terdiri dari...', 'radio', 'Dua rakaat', 'Tiga rakaat', 'Empat rakaat', 'Lima rakaat', 'Dua rakaat', 10),
(14, 'Shalat Maghrib terdiri dari...', 'radio', 'Dua rakaat', 'Tiga rakaat', 'Empat rakaat', 'Lima rakaat', 'Tiga rakaat', 10),
(14, 'Shalat yang empat rakaat adalah...', 'radio', 'Subuh dan Maghrib', 'Dzuhur dan Ashar', 'Dzuhur, Ashar, dan Isya', 'Maghrib dan Isya', 'Dzuhur, Ashar, dan Isya', 10),
(14, 'Shalat yang paling utama adalah...', 'radio', 'Shalat berjamaah', 'Shalat sendirian', 'Shalat di rumah', 'Shalat di masjid', 'Shalat berjamaah', 10),
(14, 'Meninggalkan shalat fardhu hukumnya...', 'radio', 'Makruh', 'Haram', 'Dosa besar', 'Kufur', 'Dosa besar', 10),
(14, 'Shalat yang dibaca jahr (keras) adalah...', 'radio', 'Dzuhur dan Ashar', 'Subuh, Maghrib, Isya', 'Semua shalat', 'Tidak ada', 'Subuh, Maghrib, Isya', 10),
(14, 'Shalat yang dibaca sirr (pelan) adalah...', 'radio', 'Subuh dan Maghrib', 'Dzuhur dan Ashar', 'Maghrib dan Isya', 'Semua shalat', 'Dzuhur dan Ashar', 10),
(14, 'Qadha shalat artinya...', 'radio', 'Mengulangi shalat', 'Mengganti shalat yang terlewat', 'Shalat tambahan', 'Shalat sunnah', 'Mengganti shalat yang terlewat', 10),
(14, 'Shalat fardhu yang tidak boleh di-qadha adalah...', 'radio', 'Subuh', 'Dzuhur', 'Ashar', 'Tidak ada', 'Tidak ada', 10),

-- Subbab 15: Shalat Sunnah Rawatib (10 soal)
(15, 'Shalat rawatib adalah shalat sunnah yang...', 'radio', 'Dilakukan kapan saja', 'Mengikuti shalat fardhu', 'Dilakukan malam hari', 'Dilakukan siang hari', 'Mengikuti shalat fardhu', 10),
(15, 'Shalat rawatib ada berapa macam?', 'radio', 'Satu', 'Dua', 'Tiga', 'Empat', 'Dua', 10),
(15, 'Rawatib muakkad adalah rawatib yang...', 'radio', 'Wajib dilakukan', 'Sangat dianjurkan', 'Boleh ditinggalkan', 'Tidak penting', 'Sangat dianjurkan', 10),
(15, 'Rawatib ghairu muakkad adalah rawatib yang...', 'radio', 'Wajib dilakukan', 'Sangat dianjurkan', 'Biasa saja', 'Tidak perlu', 'Biasa saja', 10),
(15, 'Shalat rawatib Subuh adalah...', 'radio', 'Dua rakaat sebelum', 'Dua rakaat sesudah', 'Empat rakaat sebelum', 'Tidak ada', 'Dua rakaat sebelum', 10),
(15, 'Shalat rawatib Dzuhur yang muakkad adalah...', 'radio', 'Dua rakaat sebelum', 'Dua rakaat sesudah', 'Empat rakaat sebelum, dua rakaat sesudah', 'Empat rakaat sebelum dan sesudah', 'Empat rakaat sebelum, dua rakaat sesudah', 10),
(15, 'Shalat rawatib Ashar adalah...', 'radio', 'Dua rakaat sebelum', 'Empat rakaat sebelum', 'Dua rakaat sesudah', 'Tidak ada yang muakkad', 'Tidak ada yang muakkad', 10),
(15, 'Shalat rawatib Maghrib adalah...', 'radio', 'Dua rakaat sebelum', 'Dua rakaat sesudah', 'Empat rakaat sesudah', 'Tidak ada', 'Dua rakaat sesudah', 10),
(15, 'Shalat rawatib Isya adalah...', 'radio', 'Dua rakaat sebelum', 'Dua rakaat sesudah', 'Empat rakaat sesudah', 'Tidak ada', 'Dua rakaat sesudah', 10),
(15, 'Jumlah total rawatib muakkad dalam sehari adalah...', 'radio', 'Sepuluh rakaat', 'Dua belas rakaat', 'Empat belas rakaat', 'Enam belas rakaat', 'Dua belas rakaat', 10),

-- Subbab 16: Shalat Jumat (10 soal)
(16, 'Shalat Jumat hukumnya...', 'radio', 'Sunnah', 'Wajib ain', 'Wajib kifayah', 'Mustahab', 'Wajib ain', 10),
(16, 'Shalat Jumat terdiri dari...', 'radio', 'Dua rakaat', 'Tiga rakaat', 'Empat rakaat', 'Lima rakaat', 'Dua rakaat', 10),
(16, 'Syarat wajib shalat Jumat salah satunya adalah...', 'radio', 'Perempuan', 'Laki-laki', 'Anak-anak', 'Semua orang', 'Laki-laki', 10),
(16, 'Minimal jamaah untuk shalat Jumat adalah...', 'radio', 'Tiga orang', 'Empat puluh orang', 'Sepuluh orang', 'Tidak ada minimal', 'Empat puluh orang', 10),
(16, 'Khutbah Jumat hukumnya...', 'radio', 'Sunnah', 'Wajib', 'Rukun', 'Syarat', 'Syarat', 10),
(16, 'Khutbah Jumat terdiri dari...', 'radio', 'Satu khutbah', 'Dua khutbah', 'Tiga khutbah', 'Empat khutbah', 'Dua khutbah', 10),
(16, 'Waktu shalat Jumat adalah...', 'radio', 'Waktu Subuh', 'Waktu Dzuhur', 'Waktu Ashar', 'Waktu khusus', 'Waktu Dzuhur', 10),
(16, 'Orang yang tidak wajib shalat Jumat adalah...', 'radio', 'Laki-laki dewasa', 'Perempuan', 'Orang sehat', 'Orang kaya', 'Perempuan', 10),
(16, 'Shalat Jumat menggantikan shalat...', 'radio', 'Subuh', 'Dzuhur', 'Ashar', 'Maghrib', 'Dzuhur', 10),
(16, 'Orang yang terlambat shalat Jumat harus...', 'radio', 'Shalat Jumat sendiri', 'Shalat Dzuhur empat rakaat', 'Tidak perlu shalat', 'Menunggu Jumat berikutnya', 'Shalat Dzuhur empat rakaat', 10),

-- Subbab 17: Shalat Jama' dan Qashar (10 soal)
(17, 'Jama artinya...', 'radio', 'Memendekkan shalat', 'Menggabungkan shalat', 'Meninggalkan shalat', 'Mengulangi shalat', 'Menggabungkan shalat', 10),
(17, 'Qashar artinya...', 'radio', 'Menggabungkan shalat', 'Memendekkan shalat', 'Meninggalkan shalat', 'Mengulangi shalat', 'Memendekkan shalat', 10),
(17, 'Shalat yang boleh di-qashar adalah...', 'radio', 'Subuh dan Maghrib', 'Dzuhur, Ashar, dan Isya', 'Semua shalat', 'Tidak ada', 'Dzuhur, Ashar, dan Isya', 10),
(17, 'Shalat Dzuhur di-qashar menjadi...', 'radio', 'Satu rakaat', 'Dua rakaat', 'Tiga rakaat', 'Tetap empat rakaat', 'Dua rakaat', 10),
(17, 'Syarat boleh qashar adalah...', 'radio', 'Sakit', 'Safar (perjalanan)', 'Hujan', 'Sibuk', 'Safar (perjalanan)', 10),
(17, 'Jarak minimal safar untuk boleh qashar adalah...', 'radio', 'Satu kilometer', 'Dua marhalah', 'Sepuluh kilometer', 'Tidak ada batas', 'Dua marhalah', 10),
(17, 'Jama taqdim adalah...', 'radio', 'Menggabungkan shalat di waktu yang pertama', 'Menggabungkan shalat di waktu yang kedua', 'Memendekkan shalat', 'Meninggalkan shalat', 'Menggabungkan shalat di waktu yang pertama', 10),
(17, 'Jama takhir adalah...', 'radio', 'Menggabungkan shalat di waktu yang pertama', 'Menggabungkan shalat di waktu yang kedua', 'Memendekkan shalat', 'Meninggalkan shalat', 'Menggabungkan shalat di waktu yang kedua', 10),
(17, 'Shalat yang boleh dijama adalah...', 'radio', 'Subuh dan Dzuhur', 'Dzuhur dan Ashar', 'Ashar dan Maghrib', 'Maghrib dan Isya', 'Dzuhur dan Ashar', 10),
(17, 'Hukum jama dan qashar adalah...', 'radio', 'Wajib', 'Sunnah', 'Mubah', 'Makruh', 'Mubah', 10),

-- Subbab 18: Shalat dalam Perjalanan (10 soal)
(18, 'Shalat dalam perjalanan disebut...', 'radio', 'Shalat safar', 'Shalat qashar', 'Shalat jama', 'Semua jawaban benar', 'Semua jawaban benar', 10),
(18, 'Hukum qashar shalat dalam perjalanan adalah...', 'radio', 'Wajib', 'Sunnah', 'Mubah', 'Makruh', 'Sunnah', 10),
(18, 'Shalat yang tidak boleh di-qashar dalam perjalanan adalah...', 'radio', 'Dzuhur', 'Ashar', 'Maghrib', 'Isya', 'Maghrib', 10),
(18, 'Kapan mulai boleh qashar dalam perjalanan?', 'radio', 'Sejak keluar rumah', 'Sejak keluar kota', 'Sejak niat bepergian', 'Sejak sampai tujuan', 'Sejak keluar kota', 10),
(18, 'Kapan berhenti qashar dalam perjalanan?', 'radio', 'Sampai di rumah', 'Sampai di tujuan', 'Niat pulang', 'Masuk kota asal', 'Sampai di rumah', 10),
(18, 'Jika musafir shalat di belakang imam muqim, maka...', 'radio', 'Boleh qashar', 'Tidak boleh qashar', 'Terserah musafir', 'Ikut imam', 'Ikut imam', 10),
(18, 'Jika imam musafir dan makmum muqim, maka...', 'radio', 'Imam qashar, makmum tidak', 'Semua qashar', 'Semua tidak qashar', 'Terserah masing-masing', 'Imam qashar, makmum tidak', 10),
(18, 'Shalat di kendaraan yang bergerak...', 'radio', 'Tidak boleh', 'Boleh jika darurat', 'Boleh untuk sunnah', 'Boleh semua shalat', 'Boleh jika darurat', 10),
(18, 'Arah kiblat dalam kendaraan...', 'radio', 'Harus tetap ke kiblat', 'Boleh ke arah jalan', 'Terserah', 'Menghadap depan', 'Harus tetap ke kiblat', 10),
(18, 'Jika tidak tahu arah kiblat dalam perjalanan...', 'radio', 'Tidak usah shalat', 'Ijtihad menentukan arah', 'Shalat ke segala arah', 'Tanya orang lain', 'Ijtihad menentukan arah', 10),

-- Subbab 19: Tertib Shalat (10 soal)
(19, 'Tertib dalam shalat artinya...', 'radio', 'Berurutan', 'Rapi', 'Tenang', 'Khusyuk', 'Berurutan', 10),
(19, 'Tertib dalam shalat hukumnya...', 'radio', 'Sunnah', 'Wajib', 'Rukun', 'Syarat', 'Rukun', 10),
(19, 'Urutan yang benar dalam shalat adalah...', 'radio', 'Niat, takbir, ruku, sujud', 'Takbir, niat, ruku, sujud', 'Niat, takbir, membaca Al-Fatihah, ruku', 'Takbir, ruku, sujud, niat', 'Niat, takbir, membaca Al-Fatihah, ruku', 10),
(19, 'Jika tertib shalat terganggu, maka...', 'radio', 'Shalat batal', 'Shalat tetap sah', 'Harus diulang', 'Tidak apa-apa', 'Shalat batal', 10),
(19, 'Rukun shalat yang tidak boleh ditukar urutannya adalah...', 'radio', 'Hanya takbir dan salam', 'Hanya bacaan', 'Semua rukun', 'Hanya gerakan', 'Semua rukun', 10),
(19, 'Jika lupa urutan shalat, maka...', 'radio', 'Teruskan shalat', 'Kembali ke urutan yang benar', 'Mulai dari awal', 'Tidak apa-apa', 'Kembali ke urutan yang benar', 10),
(19, 'Tertib berlaku untuk...', 'radio', 'Shalat fardhu saja', 'Shalat sunnah saja', 'Semua shalat', 'Shalat berjamaah saja', 'Semua shalat', 10),
(19, 'Jika ruku sebelum membaca Al-Fatihah...', 'radio', 'Shalat sah', 'Shalat batal', 'Harus Iadah', 'Tidak apa-apa', 'Shalat batal', 10),
(19, 'Jika sujud sebelum ruku...', 'radio', 'Shalat sah', 'Shalat batal', 'Harus Iadah', 'Tidak apa-apa', 'Shalat batal', 10),
(19, 'Tertib juga berlaku untuk...', 'radio', 'Wudhu', 'Tayamum', 'Shalat', 'Semua jawaban benar', 'Semua jawaban benar', 10),

-- Subbab 20: Sujud dalam Shalat (10 soal)
(20, 'Sujud dalam shalat dilakukan sebanyak...', 'radio', '2 kali setiap rakaat', '1 kali setiap rakaat', '3 kali setiap rakaat', '4 kali setiap rakaat', '2 kali setiap rakaat', 10),
(20, 'Bagian tubuh yang menyentuh lantai saat sujud adalah...', 'radio', 'Dahi, dua tangan, dua lutut, dua kaki', 'Dahi dan tangan saja', 'Kedua tangan dan lutut', 'Semua anggota wudhu', 'Dahi, dua tangan, dua lutut, dua kaki', 10),
(20, 'Hukum sujud dalam shalat adalah...', 'radio', 'Sunnah', 'Rukun', 'Makruh', 'Mubah', 'Rukun', 10),
(20, 'Jika tidak sujud dalam shalat, maka...', 'radio', 'Shalat tetap sah', 'Shalat batal', 'Harus sujud sahwi', 'Shalat menjadi sunnah', 'Shalat batal', 10),
(20, 'Tempat sujud yang benar adalah...', 'radio', 'Di atas sajadah yang bersih', 'Di tempat yang tinggi', 'Di tempat yang lembek', 'Di atas kursi', 'Di atas sajadah yang bersih', 10),
(20, 'Saat sujud, bacaan yang diucapkan adalah...', 'radio', 'Subhana Rabbiyal A’la', 'Subhanallah', 'Astaghfirullah', 'Allahu Akbar', 'Subhana Rabbiyal A’la', 10),
(20, 'Sujud harus dilakukan dengan...', 'radio', 'Tenang dan tidak terburu-buru', 'Cepat agar tidak lama', 'Sambil mengantuk', 'Sambil melihat sekeliling', 'Tenang dan tidak terburu-buru', 10),
(20, 'Sujud sahwi dilakukan ketika...', 'radio', 'Lupa rakaat atau rukun shalat', 'Batal wudhu', 'Masuk masjid', 'Tidak membaca doa', 'Lupa rakaat atau rukun shalat', 10),
(20, 'Sujud yang dilakukan karena membaca ayat sajdah disebut...', 'radio', 'Sujud Tilawah', 'Sujud Sahwi', 'Sujud Syukur', 'Sujud Wajib', 'Sujud Tilawah', 10),
(20, 'Sujud syukur dilakukan ketika...', 'radio', 'Mendapatkan nikmat atau terhindar dari musibah', 'Selesai shalat', 'Sebelum tidur', 'Setelah adzan', 'Mendapatkan nikmat atau terhindar dari musibah', 10);

-- Soal Kuis Fiqih - Bab 3: Puasa (Shaum)

-- Subbab 1: Definisi Puasa (10 soal)
(21, 'Apa yang dimaksud dengan puasa menurut istilah syara?', 'radio', 'Menahan diri dari makan dan minum', 'Menahan diri dari segala hal yang membatalkan puasa', 'Menahan diri dari berbicara', 'Menahan diri dari tidur', 'Menahan diri dari segala hal yang membatalkan puasa', 10),
(21, 'Puasa wajib dilaksanakan pada bulan...', 'radio', 'Ramadhan', 'Syawal', 'Dzulhijjah', 'Muharram', 'Ramadhan', 10),
(21, 'Puasa sunnah yang paling utama setelah puasa Ramadhan adalah puasa...', 'radio', 'Senin dan Kamis', 'Arafah', 'Syawal', 'Ashura', 'Arafah', 10),
(21, 'Apa yang membatalkan puasa?', 'radio', 'Makan dan minum', 'Berbicara', 'Tidur', 'Berdoa', 'Makan dan minum', 10),
(21, 'Puasa Ramadhan dimulai pada...', 'radio', '1 Syawal', '1 Ramadhan', '10 Dzulhijjah', '15 Syaban', '1 Ramadhan', 10),
(21, 'Syarat sah puasa adalah...', 'radio', 'Beriman', 'Berakal', 'Baligh', 'Semua jawaban benar', 'Semua jawaban benar', 10),
(21, 'Puasa yang dilakukan pada hari Senin dan Kamis adalah puasa...', 'radio', 'Wajib', 'Sunnah', 'Makruh', 'Haram', 'Sunnah', 10),
(21, 'Puasa yang dilakukan pada hari Arafah bagi yang tidak sedang haji adalah...', 'radio', 'Wajib', 'Sunnah', 'Makruh', 'Haram', 'Sunnah', 10),
(21, 'Apa yang dimaksud dengan puasa mubah?', 'radio', 'Puasa yang tidak ada ketentuan', 'Puasa yang diperintahkan', 'Puasa yang dilarang', 'Puasa yang sunnah', 'Puasa yang tidak ada ketentuan', 10),
(21, 'Puasa yang dilakukan pada hari Ashura adalah puasa...', 'radio', 'Wajib', 'Sunnah', 'Makruh', 'Haram', 'Sunnah', 10);

-- Subbab 2: Syarat Sah Puasa (10 soal)
INSERT INTO soal_kuis (id_subbab, soal, tipe_jawaban, pilihan_a, pilihan_b, pilihan_c, pilihan_d, jawaban_benar, poin) VALUES 
(22, 'Syarat sah puasa yang pertama adalah...', 'radio', 'Niat', 'Beriman', 'Berakal', 'Baligh', 'Niat', 10),
(22, 'Niat puasa Ramadhan harus dilakukan...', 'radio', 'Sebelum sahur', 'Setiap malam', 'Setiap pagi', 'Tidak perlu niat', 'Setiap malam', 10),
(22, 'Puasa tidak sah bagi orang yang...', 'radio', 'Sakit', 'Hamil', 'Makan dengan sengaja', 'Berpergian', 'Makan dengan sengaja', 10),
(22, 'Orang yang tidak mampu berpuasa karena sakit harus...', 'radio', 'Mengganti puasa', 'Membayar fidyah', 'Berpuasa di hari lain', 'Tidak perlu melakukan apa-apa', 'Membayar fidyah', 10),
(22, 'Puasa bagi orang yang sedang haid adalah...', 'radio', 'Wajib', 'Sunnah', 'Dilarang', 'Makruh', 'Dilarang', 10),
(22, 'Syarat sah puasa yang berkaitan dengan waktu adalah...', 'radio', 'Masuk waktu shalat', 'Niat', 'Berada di tempat yang suci', 'Berakal', 'Masuk waktu shalat', 10),
(22, 'Puasa yang dilakukan oleh orang yang gila adalah...', 'radio', 'Sah', 'Tidak sah', 'Sunnah', 'Wajib', 'Tidak sah', 10),
(22, 'Syarat sah puasa yang berkaitan dengan makanan adalah...', 'radio', 'Makanan harus halal', 'Makanan harus enak', 'Makanan harus bergizi', 'Makanan harus banyak', 'Makanan harus halal', 10),
(22, 'Orang yang sedang dalam perjalanan jauh diperbolehkan untuk...', 'radio', 'Berpuasa', 'Tidak berpuasa', 'Berpuasa dengan syarat', 'Berpuasa sunnah', 'Tidak berpuasa', 10),
(22, 'Puasa yang dilakukan tanpa niat di malam hari adalah...', 'radio', 'Sah', 'Tidak sah', 'Sunnah', 'Wajib', 'Tidak sah', 10);

-- Subbab 3: Rukun Puasa (10 soal)
INSERT INTO soal_kuis (id_subbab, soal, tipe_jawaban, pilihan_a, pilihan_b, pilihan_c, pilihan_d, jawaban_benar, poin) VALUES 
(23, 'Rukun puasa yang pertama adalah...', 'radio', 'Niat', 'Menahan diri dari makan dan minum', 'Berdoa', 'Membaca Al-Quran', 'Niat', 10),
(23, 'Rukun puasa yang kedua adalah...', 'radio', 'Menahan diri dari makan dan minum', 'Membaca Al-Quran', 'Berdoa', 'Berzakat', 'Menahan diri dari makan dan minum', 10),
(23, 'Niat puasa Ramadhan harus dilakukan...', 'radio', 'Setiap malam', 'Setiap pagi', 'Sebelum sahur', 'Setiap hari', 'Setiap malam', 10),
(23, 'Apa yang tidak termasuk rukun puasa?', 'radio', 'Niat', 'Menahan diri dari makan dan minum', 'Berdoa', 'Menahan diri dari hal-hal yang membatalkan puasa', 'Berdoa', 10),
(23, 'Rukun puasa yang berkaitan dengan waktu adalah...', 'radio', 'Menahan diri dari makan dan minum', 'Niat', 'Berdoa', 'Membaca Al-Quran', 'Niat', 10),
(23, 'Rukun puasa yang harus dilakukan sebelum fajar adalah...', 'radio', 'Makan sahur', 'Berdoa', 'Membaca Al-Quran', 'Tidur', 'Makan sahur', 10),
(23, 'Menahan diri dari hal-hal yang membatalkan puasa adalah...', 'radio', 'Rukun', 'Syarat', 'Sunnah', 'Makruh', 'Rukun', 10),
(23, 'Rukun puasa yang berkaitan dengan niat adalah...', 'radio', 'Niat harus diucapkan', 'Niat harus dalam hati', 'Niat tidak perlu', 'Niat harus di malam hari', 'Niat harus dalam hati', 10),
(23, 'Rukun puasa yang terakhir adalah...', 'radio', 'Menahan diri dari makan dan minum', 'Niat', 'Berdoa', 'Membaca Al-Quran', 'Menahan diri dari makan dan minum', 10),
(23, 'Jika salah satu rukun puasa tidak dilaksanakan, maka puasa tersebut...', 'radio', 'Sah', 'Tidak sah', 'Sunnah', 'Wajib', 'Tidak sah', 10);

-- Subbab 4: Niat Puasa (10 soal)
INSERT INTO soal_kuis (id_subbab, soal, tipe_jawaban, pilihan_a, pilihan_b, pilihan_c, pilihan_d, jawaban_benar, poin) VALUES 
(24, 'Niat puasa Ramadhan harus dilakukan...', 'radio', 'Setiap malam', 'Setiap pagi', 'Sebelum sahur', 'Setiap hari', 'Setiap malam', 10),
(24, 'Niat puasa harus dilakukan di dalam hati dan...', 'radio', 'Diucapkan', 'Diketahui', 'Dihafal', 'Dibaca', 'Diketahui', 10),
(24, 'Niat puasa sunnah dapat dilakukan...', 'radio', 'Di malam hari', 'Di siang hari', 'Setiap waktu', 'Tidak perlu niat', 'Di malam hari', 10),
(24, 'Niat puasa yang tidak diucapkan tetapi ada dalam hati...', 'radio', 'Sah', 'Tidak sah', 'Makruh', 'Sunnah', 'Sah', 10),
(24, 'Niat puasa yang dilakukan setelah fajar adalah...', 'radio', 'Sah', 'Tidak sah', 'Sunnah', 'Wajib', 'Tidak sah', 10),
(24, 'Niat puasa yang dilakukan sebelum sahur adalah...', 'radio', 'Wajib', 'Sunnah', 'Makruh', 'Haram', 'Wajib', 10),
(24, 'Niat puasa yang dilakukan untuk mengganti puasa yang terlewat adalah...', 'radio', 'Niat qadha', 'Niat sunnah', 'Niat wajib', 'Niat makruh', 'Niat qadha', 10),
(24, 'Niat puasa yang dilakukan untuk puasa Arafah adalah...', 'radio', 'Niat sunnah', 'Niat wajib', 'Niat makruh', 'Niat haram', 'Niat sunnah', 10),
(24, 'Niat puasa yang dilakukan untuk puasa Syawal adalah...', 'radio', 'Niat sunnah', 'Niat wajib', 'Niat makruh', 'Niat haram', 'Niat sunnah', 10),
(24, 'Niat puasa yang tidak dilakukan sama sekali adalah...', 'radio', 'Sah', 'Tidak sah', 'Sunnah', 'Wajib', 'Tidak sah', 10);

-- Subbab 5: Hal-hal yang Membatalkan Puasa (10 soal)
INSERT INTO soal_kuis (id_subbab, soal, tipe_jawaban, pilihan_a, pilihan_b, pilihan_c, pilihan_d, jawaban_benar, poin) VALUES 
(25, 'Apa yang membatalkan puasa?', 'radio', 'Makan dan minum', 'Tidur', 'Berdoa', 'Berbicara', 'Makan dan minum', 10),
(25, 'Mengeluarkan darah dengan sengaja membatalkan puasa jika...', 'radio', 'Darah banyak', 'Darah sedikit', 'Darah tidak terlihat', 'Darah tidak mengalir', 'Darah banyak', 10),
(25, 'Bersentuhan kulit antara laki-laki dan perempuan yang bukan mahram...', 'radio', 'Membatalkan puasa', 'Tidak membatalkan puasa', 'Makruh', 'Sunnah', 'Tidak membatalkan puasa', 10),
(25, 'Muntah yang membatalkan puasa adalah...', 'radio', 'Muntah sedikit', 'Muntah banyak', 'Semua muntah', 'Tidak ada muntah yang membatalkan', 'Muntah banyak', 10),
(25, 'Keluar sesuatu dari qubul atau dubur membatalkan puasa karena...', 'radio', 'Najis', 'Hadats', 'Kotor', 'Bau', 'Hadats', 10),
(25, 'Tidur yang membatalkan puasa adalah...', 'radio', 'Tidur sebentar', 'Tidur dalam keadaan duduk', 'Tidur tidak dalam keadaan duduk', 'Semua tidur', 'Tidur tidak dalam keadaan duduk', 10),
(25, 'Hilang akal karena gila atau pingsan...', 'radio', 'Tidak membatalkan puasa', 'Membatalkan puasa', 'Makruh', 'Diragukan', 'Membatalkan puasa', 10),
(25, 'Makan atau minum dengan tidak sengaja...', 'radio', 'Membatalkan puasa', 'Tidak membatalkan puasa', 'Makruh', 'Sunnah', 'Tidak membatalkan puasa', 10),
(25, 'Bersentuhan kulit antara suami istri saat puasa...', 'radio', 'Membatalkan puasa', 'Tidak membatalkan puasa', 'Makruh', 'Sunnah', 'Tidak membatalkan puasa', 10),
(25, 'Mengeluarkan air mani dengan sengaja membatalkan puasa jika...', 'radio', 'Dengan tangan', 'Dengan pikiran', 'Dengan melihat', 'Dengan semua cara', 'Dengan semua cara', 10);

-- Subbab 6: Kafarat dan Qadha (10 soal)
INSERT INTO soal_kuis (id_subbab, soal, tipe_jawaban, pilihan_a, pilihan_b, pilihan_c, pilihan_d, jawaban_benar, poin) VALUES 
(26, 'Kafarat bagi orang yang membatalkan puasa dengan sengaja adalah...', 'radio', 'Berpuasa dua bulan berturut-turut', 'Memberi makan 60 orang miskin', 'Membayar fidyah', 'Semua jawaban benar', 'Semua jawaban benar', 10),
(26, 'Qadha puasa adalah...', 'radio', 'Mengganti puasa yang terlewat', 'Puasa sunnah', 'Puasa wajib', 'Puasa yang tidak sah', 'Mengganti puasa yang terlewat', 10),
(26, 'Orang yang tidak mampu berpuasa karena sakit harus...', 'radio', 'Mengganti puasa', 'Membayar fidyah', 'Berpuasa di hari lain', 'Tidak perlu melakukan apa-apa', 'Membayar fidyah', 10),
(26, 'Kafarat bagi orang yang berhubungan suami istri saat puasa adalah...', 'radio', 'Berpuasa dua bulan berturut-turut', 'Memberi makan 60 orang miskin', 'Membayar fidyah', 'Semua jawaban benar', 'Semua jawaban benar', 10),
(26, 'Qadha puasa harus dilakukan sebelum...', 'radio', 'Bulan Ramadhan berikutnya', 'Hari raya', 'Hari Jumat', 'Hari Sabtu', 'Bulan Ramadhan berikutnya', 10),
(26, 'Jika seseorang tidak bisa berpuasa karena hamil, maka ia harus...', 'radio', 'Mengganti puasa', 'Membayar fidyah', 'Berpuasa di hari lain', 'Tidak perlu melakukan apa-apa', 'Membayar fidyah', 10),
(26, 'Kafarat bagi orang yang tidak berpuasa karena alasan yang tidak syar’i adalah...', 'radio', 'Berpuasa dua bulan berturut-turut', 'Memberi makan 60 orang miskin', 'Membayar fidyah', 'Semua jawaban benar', 'Semua jawaban benar', 10),
(26, 'Qadha puasa bagi orang yang meninggal dunia adalah...', 'radio', 'Tidak perlu', 'Harus diganti oleh ahli waris', 'Harus dibayar fidyah', 'Harus dilaksanakan', 'Harus diganti oleh ahli waris', 10),
(26, 'Kafarat bagi orang yang berpuasa tetapi tidak berniat adalah...', 'radio', 'Berpuasa dua bulan berturut-turut', 'Memberi makan 60 orang miskin', 'Membayar fidyah', 'Semua jawaban benar', 'Semua jawaban benar', 10),
(26, 'Qadha puasa bagi orang yang tidak berpuasa karena haid adalah...', 'radio', 'Tidak perlu', 'Harus diganti', 'Harus dibayar fidyah', 'Harus dilaksanakan', 'Harus diganti', 10);

-- Subbab 7: Puasa Sunnah (10 soal)
INSERT INTO soal_kuis (id_subbab, soal, tipe_jawaban, pilihan_a, pilihan_b, pilihan_c, pilihan_d, jawaban_benar, poin) VALUES 
(27, 'Puasa sunnah yang paling utama setelah Ramadhan adalah...', 'radio', 'Puasa Senin dan Kamis', 'Puasa Arafah', 'Puasa Syawal', 'Puasa Ashura', 'Puasa Arafah', 10),
(27, 'Puasa Syawal dilakukan pada bulan...', 'radio', 'Setelah Ramadhan', 'Sebelum Ramadhan', 'Di tengah Ramadhan', 'Tidak ada waktu khusus', 'Setelah Ramadhan', 10),
(27, 'Puasa yang dilakukan pada hari Ashura adalah...', 'radio', 'Sunnah', 'Wajib', 'Makruh', 'Haram', 'Sunnah', 10),
(27, 'Puasa yang dilakukan pada hari Senin dan Kamis adalah...', 'radio', 'Sunnah', 'Wajib', 'Makruh', 'Haram', 'Sunnah', 10),
(27, 'Puasa yang dilakukan pada hari Arafah bagi yang tidak haji adalah...', 'radio', 'Sunnah', 'Wajib', 'Makruh', 'Haram', 'Sunnah', 10),
(27, 'Puasa yang dilakukan pada bulan Sya’ban adalah...', 'radio', 'Sunnah', 'Wajib', 'Makruh', 'Haram', 'Sunnah', 10),
(27, 'Puasa yang dilakukan pada hari Jumat adalah...', 'radio', 'Sunnah', 'Wajib', 'Makruh', 'Haram', 'Makruh', 10),
(27, 'Puasa yang dilakukan pada hari Sabtu adalah...', 'radio', 'Sunnah', 'Wajib', 'Makruh', 'Haram', 'Makruh', 10),
(27, 'Puasa yang dilakukan pada hari-hari putih (13, 14, 15) adalah...', 'radio', 'Sunnah', 'Wajib', 'Makruh', 'Haram', 'Sunnah', 10),
(27, 'Puasa yang dilakukan untuk mengqadha puasa Ramadhan adalah...', 'radio', 'Sunnah', 'Wajib', 'Makruh', 'Haram', 'Wajib', 10);

-- Subbab 8: Hikmah Puasa (10 soal)
INSERT INTO soal_kuis (id_subbab, soal, tipe_jawaban, pilihan_a, pilihan_b, pilihan_c, pilihan_d, jawaban_benar, poin) VALUES 
(28, 'Hikmah puasa yang pertama adalah...', 'radio', 'Mendekatkan diri kepada Allah', 'Menjaga kesehatan', 'Menghemat makanan', 'Mendapatkan pahala', 'Mendekatkan diri kepada Allah', 10),
(28, 'Puasa dapat meningkatkan...', 'radio', 'Kesehatan mental', 'Kesehatan fisik', 'Kesehatan spiritual', 'Semua jawaban benar', 'Semua jawaban benar', 10),
(28, 'Salah satu hikmah puasa adalah...', 'radio', 'Menjaga berat badan', 'Membuat lapar', 'Membuat haus', 'Mengurangi energi', 'Menjaga berat badan', 10),
(28, 'Puasa mengajarkan kita untuk...', 'radio', 'Menahan diri', 'Berkeluh kesah', 'Makan berlebihan', 'Tidur terus-menerus', 'Menahan diri', 10),
(28, 'Puasa dapat meningkatkan rasa...', 'radio', 'Syukur', 'Lapar', 'Haus', 'Marah', 'Syukur', 10),
(28, 'Hikmah puasa bagi orang kaya adalah...', 'radio', 'Mengetahui penderitaan orang miskin', 'Mendapatkan harta', 'Menambah makanan', 'Mendapatkan pujian', 'Mengetahui penderitaan orang miskin', 10),
(28, 'Puasa dapat membersihkan...', 'radio', 'Hati', 'Raga', 'Pikiran', 'Semua jawaban benar', 'Semua jawaban benar', 10),
(28, 'Puasa mengajarkan kita untuk lebih...', 'radio', 'Bersyukur', 'Berkeluh kesah', 'Makan berlebihan', 'Tidur terus-menerus', 'Bersyukur', 10),
(28, 'Hikmah puasa yang berkaitan dengan sosial adalah...', 'radio', 'Mendekatkan diri kepada Allah', 'Meningkatkan solidaritas', 'Menjaga kesehatan', 'Menghemat makanan', 'Meningkatkan solidaritas', 10),
(28, 'Puasa dapat meningkatkan kesadaran akan...', 'radio', 'Kekayaan', 'Kepuasan', 'Kekurangan', 'Kesehatan', 'Kekurangan', 10);

-- Subbab 9: Puasa di Bulan Ramadhan (10 soal)
INSERT INTO soal_kuis (id_subbab, soal, tipe_jawaban, pilihan_a, pilihan_b, pilihan_c, pilihan_d, jawaban_benar, poin) VALUES 
(29, 'Puasa di bulan Ramadhan adalah...', 'radio', 'Wajib', 'Sunnah', 'Makruh', 'Haram', 'Wajib', 10),
(29, 'Puasa Ramadhan dimulai dari...', 'radio', 'Fajar', 'Malam', 'Siang', 'Sore', 'Fajar', 10),
(29, 'Puasa Ramadhan diakhiri dengan...', 'radio', 'Hari Raya Idul Adha', 'Hari Raya Idul Fitri', 'Hari Jumat', 'Hari Sabtu', 'Hari Raya Idul Fitri', 10),
(29, 'Sahur adalah...', 'radio', 'Makan sebelum fajar', 'Makan setelah fajar', 'Makan siang', 'Makan malam', 'Makan sebelum fajar', 10),
(29, 'Berbuka puasa dilakukan pada...', 'radio', 'Fajar', 'Malam', 'Maghrib', 'Siang', 'Maghrib', 10),
(29, 'Puasa Ramadhan dilaksanakan selama...', 'radio', '30 hari', '29 hari', '31 hari', 'Tidak ada batas', '30 hari', 10),
(29, 'Puasa Ramadhan adalah salah satu rukun Islam yang ke...', 'radio', 'Pertama', 'Kedua', 'Ketiga', 'Keempat', 'Keempat', 10),
(29, 'Orang yang tidak berpuasa di bulan Ramadhan tanpa alasan syar’i adalah...', 'radio', 'Dosa besar', 'Tidak masalah', 'Sunnah', 'Wajib', 'Dosa besar', 10),
(29, 'Puasa Ramadhan dapat membentuk...', 'radio', 'Kedisiplinan', 'Kekacauan', 'Kehampaan', 'Kekacauan', 'Kedisiplinan', 10),
(29, 'Puasa Ramadhan mengajarkan kita untuk lebih...', 'radio', 'Bersyukur', 'Berkeluh kesah', 'Makan berlebihan', 'Tidur terus-menerus', 'Bersyukur', 10);

-- Subbab 10: Puasa dan Kesehatan (10 soal)
INSERT INTO soal_kuis (id_subbab, soal, tipe_jawaban, pilihan_a, pilihan_b, pilihan_c, pilihan_d, jawaban_benar, poin) VALUES 
(30, 'Puasa dapat membantu menurunkan...', 'radio', 'Berat badan', 'Kesehatan mental', 'Kesehatan fisik', 'Semua jawaban benar', 'Berat badan', 10),
(30, 'Puasa dapat meningkatkan...', 'radio', 'Metabolisme', 'Kelelahan', 'Kekurangan energi', 'Semua jawaban benar', 'Metabolisme', 10),
(30, 'Puasa dapat membantu membersihkan...', 'radio', 'Toksin dalam tubuh', 'Kelelahan', 'Kekurangan energi', 'Semua jawaban benar', 'Toksin dalam tubuh', 10),
(30, 'Puasa dapat meningkatkan kesehatan jantung dengan...', 'radio', 'Mengurangi kolesterol', 'Meningkatkan kolesterol', 'Meningkatkan tekanan darah', 'Mengurangi tekanan darah', 'Mengurangi kolesterol', 10),
(30, 'Puasa dapat membantu mengatur...', 'radio', 'Gula darah', 'Kadar lemak', 'Kadar air', 'Semua jawaban benar', 'Gula darah', 10),
(30, 'Puasa dapat meningkatkan...', 'radio', 'Kesehatan mental', 'Kesehatan fisik', 'Kesehatan spiritual', 'Semua jawaban benar', 'Semua jawaban benar', 10),
(30, 'Puasa dapat membantu mengurangi risiko...', 'radio', 'Diabetes', 'Kanker', 'Penyakit jantung', 'Semua jawaban benar', 'Semua jawaban benar', 10),
(30, 'Puasa dapat meningkatkan...', 'radio', 'Kualitas tidur', 'Kelelahan', 'Kekurangan energi', 'Semua jawaban benar', 'Kualitas tidur', 10),
(30, 'Puasa dapat membantu meningkatkan...', 'radio', 'Konsentrasi', 'Kelelahan', 'Kekurangan energi', 'Semua jawaban benar', 'Konsentrasi', 10),
(30, 'Puasa yang dilakukan dengan benar dapat meningkatkan...', 'radio', 'Kesehatan secara keseluruhan', 'Kelelahan', 'Kekurangan energi', 'Semua jawaban benar', 'Kesehatan secara keseluruhan', 10);

-- Bab 4: Zakat
-- Subbab 1: Pengertian Zakat (10 soal)
INSERT INTO soal_kuis (id_subbab, soal, tipe_jawaban, pilihan_a, pilihan_b, pilihan_c, pilihan_d, jawaban_benar, poin) VALUES
(31, 'Apa pengertian zakat menurut bahasa?', 'radio', 'Bersih', 'Tumbuh', 'Berkembang', 'Semua benar', 'Bersih', 10),
(31, 'Zakat menurut istilah syara adalah...', 'radio', 'Memberikan sebagian harta tertentu', 'Sedekah biasa', 'Infak sunnah', 'Hadiah', 'Memberikan sebagian harta tertentu', 10),
(31, 'Hukum zakat adalah...', 'radio', 'Sunnah', 'Wajib', 'Makruh', 'Mubah', 'Wajib', 10),
(31, 'Zakat termasuk dalam rukun Islam yang ke...', 'radio', '2', '3', '4', '5', '3', 10),
(31, 'Orang yang berhak menerima zakat disebut...', 'radio', 'Mustahik', 'Muzakki', 'Amil', 'Fakir', 'Mustahik', 10),
(31, 'Zakat yang dikeluarkan pada bulan Ramadhan disebut zakat...', 'radio', 'Mal', 'Fitrah', 'Profesi', 'Pertanian', 'Fitrah', 10),
(31, 'Zakat yang dikeluarkan dari harta kekayaan disebut zakat...', 'radio', 'Fitrah', 'Mal', 'Pertanian', 'Perdagangan', 'Mal', 10),
(31, 'Nishab zakat mal ditentukan berdasarkan...', 'radio', 'Jumlah harta', 'Jenis harta', 'Waktu kepemilikan', 'Semua benar', 'Jenis harta', 10),
(31, 'Hukum orang yang mengingkari kewajiban zakat adalah...', 'radio', 'Meninggalkan sunnah', 'Batal puasa', 'Murtad', 'Tetap muslim', 'Murtad', 10),
(31, 'Zakat berfungsi untuk...', 'radio', 'Membersihkan harta', 'Membersihkan jiwa', 'Meningkatkan ekonomi', 'Semua benar', 'Semua benar', 10);

-- Subbab 2: Syarat Wajib Zakat (10 soal)
INSERT INTO soal_kuis (id_subbab, soal, tipe_jawaban, pilihan_a, pilihan_b, pilihan_c, pilihan_d, jawaban_benar, poin) VALUES
(32, 'Syarat wajib zakat yang pertama adalah...', 'radio', 'Islam', 'Merdeka', 'Baligh', 'Semua benar', 'Semua benar', 10),
(32, 'Harta yang dizakati harus...', 'radio', 'Berkembang', 'Dimiliki sempurna', 'Mencapai nishab', 'Semua benar', 'Semua benar', 10),
(32, 'Harta yang dizakati harus dimiliki selama...', 'radio', '1 bulan', '6 bulan', '1 tahun', '2 tahun', '1 tahun', 10),
(32, 'Anak kecil yang memiliki harta...', 'radio', 'Wajib zakat', 'Tidak wajib zakat', 'Sunah zakat', 'Wajib dengan syarat', 'Wajib zakat', 10),
(32, 'Orang gila yang memiliki harta...', 'radio', 'Wajib zakat', 'Tidak wajib zakat', 'Sunah zakat', 'Wajib dengan syarat', 'Tidak wajib zakat', 10),
(32, 'Harta yang belum mencapai haul...', 'radio', 'Wajib zakat', 'Tidak wajib zakat', 'Sunah zakat', 'Wajib jika ingin', 'Tidak wajib zakat', 10),
(32, 'Nishab zakat emas adalah...', 'radio', '85 gram', '50 gram', '75 gram', '100 gram', '85 gram', 10),
(32, 'Nishab zakat perak adalah...', 'radio', '200 dirham', '300 dirham', '400 dirham', '595 gram', '595 gram', 10),
(32, 'Syarat kepemilikan harta untuk zakat adalah...', 'radio', 'Milik pribadi', 'Dikuasai sepenuhnya', 'Bebas dari hutang', 'Semua benar', 'Semua benar', 10),
(32, 'Harta yang berasal dari usaha haram...', 'radio', 'Wajib zakat', 'Tidak wajib zakat', 'Sunah zakat', 'Wajib disedekahkan', 'Tidak wajib zakat', 10);

-- Subbab 3: Jenis-jenis Zakat (10 soal)
INSERT INTO soal_kuis (id_subbab, soal, tipe_jawaban, pilihan_a, pilihan_b, pilihan_c, pilihan_d, jawaban_benar, poin) VALUES
(33, 'Zakat terbagi menjadi berapa jenis utama?', 'radio', '1', '2', '3', '4', '2', 10),
(33, 'Zakat yang berkaitan dengan badan disebut zakat...', 'radio', 'Mal', 'Fitrah', 'Profesi', 'Pertanian', 'Fitrah', 10),
(33, 'Zakat yang berkaitan dengan harta disebut zakat...', 'radio', 'Fitrah', 'Mal', 'Perdagangan', 'Hasil bumi', 'Mal', 10),
(33, 'Berikut yang termasuk zakat mal adalah...', 'radio', 'Zakat emas', 'Zakat fitrah', 'Zakat fitrah', 'Semua benar', 'Zakat emas', 10),
(33, 'Zakat hasil pertanian termasuk zakat...', 'radio', 'Fitrah', 'Mal', 'Profesi', 'Tijarah', 'Mal', 10),
(33, 'Zakat penghasilan termasuk jenis zakat...', 'radio', 'Fitrah', 'Mal', 'Profesi', 'Hasil bumi', 'Profesi', 10),
(33, 'Binatang ternak yang wajib dizakati adalah...', 'radio', 'Kambing', 'Sapi', 'Unta', 'Semua benar', 'Semua benar', 10),
(33, 'Hasil tambang termasuk dalam zakat...', 'radio', 'Fitrah', 'Mal', 'Rikaz', 'Profesi', 'Rikaz', 10),
(33, 'Zakat fitrah dibayarkan dengan...', 'radio', 'Uang', 'Beras', 'Gandum', 'Semua benar', 'Semua benar', 10),
(33, 'Zakat perdagangan termasuk jenis zakat...', 'radio', 'Fitrah', 'Mal', 'Profesi', 'Hasil bumi', 'Mal', 10);

-- Subbab 4: Zakat Fitrah (10 soal)
INSERT INTO soal_kuis (id_subbab, soal, tipe_jawaban, pilihan_a, pilihan_b, pilihan_c, pilihan_d, jawaban_benar, poin) VALUES
(34, 'Zakat fitrah wajib bagi setiap muslim yang...', 'radio', 'Kaya', 'Mampu', 'Hidup di hari raya', 'Semua benar', 'Mampu', 10),
(34, 'Waktu wajib zakat fitrah adalah...', 'radio', 'Awal Ramadhan', 'Akhir Ramadhan', 'Malam Idul Fitri', 'Hari Raya', 'Malam Idul Fitri', 10),
(34, 'Kadar zakat fitrah per orang adalah...', 'radio', '2.5 kg beras', '3 kg beras', '3.5 kg beras', '1 sha' makanan pokok', '1 sha' makanan pokok', 10),
(34, 'Zakat fitrah boleh dibayarkan sejak...', 'radio', 'Awal Ramadhan', 'Pertengahan Ramadhan', '1 Syawal', 'Hanya pada malam Id', 'Awal Ramadhan', 10),
(34, 'Jika zakat fitrah dibayar setelah shalat Id...', 'radio', 'Sah', 'Tidak sah', 'Menjadi sedekah', 'Wajib diulang', 'Menjadi sedekah', 10),
(34, 'Zakat fitrah untuk anak kecil dibayarkan oleh...', 'radio', 'Orang tua', 'Diri sendiri', 'Wali', 'Semua benar', 'Semua benar', 10),
(34, 'Zakat fitrah bertujuan untuk...', 'radio', 'Membersihkan diri', 'Membahagiakan fakir miskin', 'Melengkapi ibadah puasa', 'Semua benar', 'Semua benar', 10),
(34, 'Harta yang digunakan untuk zakat fitrah harus...', 'radio', 'Yang terbaik', 'Yang sedang', 'Yang biasa dikonsumsi', 'Semua benar', 'Yang biasa dikonsumsi', 10),
(34, 'Zakat fitrah boleh dibayarkan dalam bentuk...', 'radio', 'Beras', 'Gandum', 'Uang tunai', 'Semua benar', 'Semua benar', 10),
(34, 'Orang yang meninggal sebelum malam Id...', 'radio', 'Wajib dizakati', 'Tidak wajib dizakati', 'Sunah dizakati', 'Tergantung wasiat', 'Tidak wajib dizakati', 10);

-- Subbab 5: Zakat Mal (10 soal)
INSERT INTO soal_kuis (id_subbab, soal, tipe_jawaban, pilihan_a, pilihan_b, pilihan_c, pilihan_d, jawaban_benar, poin) VALUES
(35, 'Zakat mal adalah zakat yang dikenakan pada...', 'radio', 'Badan', 'Harta', 'Tanah', 'Semua benar', 'Harta', 10),
(35, 'Nishab zakat emas adalah...', 'radio', '75 gram', '85 gram', '90 gram', '100 gram', '85 gram', 10),
(35, 'Kadar zakat emas adalah...', 'radio', '2%', '2.5%', '3%', '5%', '2.5%', 10),
(35, 'Harta yang harus memenuhi haul untuk zakat adalah...', 'radio', 'Emas', 'Perak', 'Uang', 'Semua benar', 'Semua benar', 10),
(35, 'Hasil pertanian dizakati ketika...', 'radio', 'Panen', 'Setahun sekali', 'Dijual', 'Disimpan', 'Panen', 10),
(35, 'Zakat perdagangan dihitung dari...', 'radio', 'Modal', 'Keuntungan', 'Total penjualan', 'Aset bersih', 'Aset bersih', 10),
(35, 'Nishab zakat pertanian untuk pengairan alami adalah...', 'radio', '5 wasaq', '10 wasaq', '15 wasaq', '20 wasaq', '5 wasaq', 10),
(35, 'Zakat ternak wajib setelah mencapai...', 'radio', 'Nishab dan haul', 'Nishab saja', 'Haul saja', 'Kebutuhan', 'Nishab dan haul', 10),
(35, 'Zakat rikaz (harta temuan) kadarnya...', 'radio', '10%', '20%', '30%', '40%', '20%', 10),
(35, 'Harta yang tidak wajib dizakati adalah...', 'radio', 'Rumah tinggal', 'Kendaraan pribadi', 'Peralatan kerja', 'Semua benar', 'Semua benar', 10);

-- Subbab 6: Nishab Zakat (10 soal)
INSERT INTO soal_kuis (id_subbab, soal, tipe_jawaban, pilihan_a, pilihan_b, pilihan_c, pilihan_d, jawaban_benar, poin) VALUES
(36, 'Nishab berarti...', 'radio', 'Ukuran', 'Batas minimal', 'Batas maksimal', 'Kadar', 'Batas minimal', 10),
(36, 'Nishab zakat emas setara dengan...', 'radio', '85 gram emas murni', '50 gram emas', '100 gram perak', 'Tergantung harga', '85 gram emas murni', 10),
(36, 'Jika harta tidak mencapai nishab...', 'radio', 'Wajib zakat', 'Tidak wajib zakat', 'Sunah zakat', 'Wajib sebagian', 'Tidak wajib zakat', 10),
(36, 'Nishab zakat pertanian dengan irigasi modern adalah...', 'radio', '5 wasaq', '10 wasaq', '15 wasaq', '20 wasaq', '10 wasaq', 10),
(36, 'Nishab zakat uang mengikuti...', 'radio', 'Nishab emas', 'Nishab perak', 'Nishab beras', 'Tergantung negara', 'Nishab emas', 10),
(36, 'Nishab hasil pertanian adalah...', 'radio', '653 kg', '750 kg', '1000 kg', 'Tergantung jenis', '653 kg', 10),
(36, 'Nishab zakat ternak sapi adalah...', 'radio', '5 ekor', '10 ekor', '30 ekor', '40 ekor', '30 ekor', 10),
(36, 'Nishab zakat perdagangan mengikuti...', 'radio', 'Nishab emas', 'Nishab perak', 'Nishab hasil pertanian', 'Tergantung barang', 'Nishab emas', 10),
(36, 'Nishab zakat profesi adalah...', 'radio', 'Setara 85 gram emas', 'Setara 595 gram perak', 'Kebutuhan pokok setahun', 'Semua benar', 'Semua benar', 10),
(36, 'Nishab untuk zakat tabungan adalah...', 'radio', 'Berdasar jumlah uang', 'Berdasar harga emas', 'Berdasar pendapatan', 'Semua benar', 'Berdasar harga emas', 10);

-- Subbab 7: Zakat Profesi (10 soal)
INSERT INTO soal_kuis (id_subbab, soal, tipe_jawaban, pilihan_a, pilihan_b, pilihan_c, pilihan_d, jawaban_benar, poin) VALUES
(37, 'Zakat profesi dikenal juga sebagai zakat...', 'radio', 'Pendapatan', 'Mal', 'Fitrah', 'Hasil bumi', 'Pendapatan', 10),
(37, 'Zakat profesi diqiyaskan dengan zakat...', 'radio', 'Emas', 'Pertanian', 'Fitrah', 'Perdagangan', 'Pertanian', 10),
(37, 'Nishab zakat profesi adalah...', 'radio', 'Setara 85 gram emas', 'Setara 595 gram perak', 'Gaji pokok', 'Semua benar', 'Setara 85 gram emas', 10),
(37, 'Perhitungan zakat profesi secara pendekatan pertanian adalah...', 'radio', '2.5% dari penghasilan kotor', '5% dari penghasilan bersih', '10% dari penghasilan', '5% dari penghasilan kotor', '5% dari penghasilan kotor', 10),
(37, 'Waktu pembayaran zakat profesi adalah...', 'radio', 'Setiap menerima gaji', 'Setahun sekali', 'Setiap enam bulan', 'Setiap tiga bulan', 'Setiap menerima gaji', 10),
(37, 'Zakat profesi dikeluarkan setelah dikurangi...', 'radio', 'Hutang', 'Kebutuhan pokok', 'Kebutuhan keluarga', 'Semua benar', 'Semua benar', 10),
(37, 'Yang termasuk penghasilan yang wajib dizakati adalah...', 'radio', 'Gaji', 'Honorarium', 'Bonus', 'Semua benar', 'Semua benar', 10),
(37, 'Zakat profesi mulai diwajibkan ketika...', 'radio', 'Ada kelebihan dari kebutuhan pokok', 'Mencapai nishab', 'Setahun memiliki pekerjaan', 'Semua benar', 'Semua benar', 10),
(37, 'Freelancer yang menerima penghasilan tidak tetap...', 'radio', 'Tetap wajib zakat jika mencapai nishab', 'Tidak wajib zakat', 'Sunah zakat', 'Wajib membayar sekaligus', 'Tetap wajib zakat jika mencapai nishab', 10),
(37, 'Harta dari hasil profesi yang sudah dizakati...', 'radio', 'Tidak perlu dizakati lagi sebagai zakat mal', 'Masih perlu dizakati sebagai zakat mal', 'Tergantung jumlahnya', 'Sunah dizakati lagi', 'Tidak perlu dizakati lagi sebagai zakat mal', 10);

-- Subbab 8: Mustahik Zakat (10 soal)
INSERT INTO soal_kuis (id_subbab, soal, tipe_jawaban, pilihan_a, pilihan_b, pilihan_c, pilihan_d, jawaban_benar, poin) VALUES
(38, 'Golongan penerima zakat disebut...', 'radio', 'Mustahik', 'Muzakki', 'Amil', 'Fakir', 'Mustahik', 10),
(38, 'Orang fakir adalah...', 'radio', 'Tidak memiliki harta', 'Memiliki sedikit harta', 'Tidak mampu memenuhi kebutuhan', 'Semua benar', 'Semua benar', 10),
(38, 'Orang miskin adalah...', 'radio', 'Lebih baik dari fakir', 'Sama dengan fakir', 'Lebih buruk dari fakir', 'Tidak ada bedanya', 'Lebih baik dari fakir', 10),
(38, 'Amil zakat adalah...', 'radio', 'Pengurus zakat', 'Penerima zakat', 'Pembayar zakat', 'Panitia zakat', 'Pengurus zakat', 10),
(38, 'Muallaf adalah...', 'radio', 'Orang yang baru masuk Islam', 'Orang yang sudah lama masuk Islam', 'Orang kafir', 'Semua benar', 'Orang yang baru masuk Islam', 10),
(38, 'Riqab adalah...', 'radio', 'Budak yang ingin memerdekakan diri', 'Orang miskin', 'Orang terbelakang', 'Semua benar', 'Budak yang ingin memerdekakan diri', 10),
(38, 'Gharim adalah...', 'radio', 'Orang yang berhutang', 'Orang fakir', 'Orang kaya', 'Semua benar', 'Orang yang berhutang', 10),
(38, 'Fi sabilillah adalah...', 'radio', 'Orang yang berjuang di jalan Allah', 'Orang yang berdagang', 'Orang yang berkeluarga', 'Semua benar', 'Orang yang berjuang di jalan Allah', 10),
(38, 'Ibnus sabil adalah...', 'radio', 'Musafir yang kehabisan bekal', 'Anak jalanan', 'Orang yang sedang bepergian', 'Semua benar', 'Musafir yang kehabisan bekal', 10),
(38, 'Orang yang tidak berhak menerima zakat adalah...', 'radio', 'Orang kaya', 'Anak yatim', 'Orang tua penerima pensiun', 'Semua benar', 'Orang kaya', 10);

-- Subbab 9: Waktu Pengeluaran Zakat (10 soal)
INSERT INTO soal_kuis (id_subbab, soal, tipe_jawaban, pilihan_a, pilihan_b, pilihan_c, pilihan_d, jawaban_benar, poin) VALUES
(39, 'Zakat fitrah dikeluarkan paling lambat...', 'radio', 'Sebelum shalat Id', 'Saat shalat Id', 'Setelah shalat Id', 'Seharian penuh', 'Sebelum shalat Id', 10),
(39, 'Zakat mal dikeluarkan setelah...', 'radio', 'Mencapai haul', 'Mencapai nishab', 'Lunas hutang', 'Semua benar', 'Semua benar', 10),
(39, 'Zakat pertanian dikeluarkan saat...', 'radio', 'Panen', 'Setahun sekali', 'Dijual', 'Disimpan', 'Panen', 10),
(39, 'Zakat profesi bisa dikeluarkan...', 'radio', 'Setiap menerima gaji', 'Setahun sekali', 'Setiap enam bulan', 'Tergantung kesanggupan', 'Setiap menerima gaji', 10),
(39, 'Jika haul zakat mal jatuh di bulan Ramadhan...', 'radio', 'Wajib segera dikeluarkan', 'Boleh ditunda', 'Sunah segera dikeluarkan', 'Tidak ada ketentuan', 'Sunah segera dikeluarkan', 10),
(39, 'Zakat ternak dikeluarkan...', 'radio', 'Setahun sekali', 'Setiap kali berkembang biak', 'Saat dijual', 'Semua benar', 'Setahun sekali', 10),
(39, 'Zakat perdagangan haulnya...', 'radio', '1 tahun', '6 bulan', '2 tahun', 'Tergantung usaha', '1 tahun', 10),
(39, 'Zakat emas dan perak dikeluarkan setelah...', 'radio', 'Dimiliki selama 1 tahun', 'Mencapai nishab', 'Ada kelebihan', 'Semua benar', 'Semua benar', 10),
(39, 'Zakat bisa dibayar lebih awal (takjil) dengan syarat...', 'radio', 'Sudah mencapai nishab', 'Sudah pasti haul', 'Ada kebutuhan mustahik', 'Semua benar', 'Semua benar', 10),
(39, 'Jika meninggal sebelum membayar zakat maka...', 'radio', 'Diambil dari harta warisan', 'Tidak perlu dibayar', 'Dibayar oleh ahli waris', 'Semua benar', 'Diambil dari harta warisan', 10);

-- Subbab 10: Distribusi Zakat (10 soal)
INSERT INTO soal_kuis (id_subbab, soal, tipe_jawaban, pilihan_a, pilihan_b, pilihan_c, pilihan_d, jawaban_benar, poin) VALUES
(40, 'Zakat sebaiknya didistribusikan di...', 'radio', 'Tempat muzakki', 'Tempat mustahik', 'Tempat yang membutuhkan', 'Semua benar', 'Tempat muzakki', 10),
(40, 'Prioritas penerima zakat adalah...', 'radio', 'Fakir miskin', 'Amil', 'Muallaf', 'Semua benar', 'Semua benar', 10),
(40, 'Zakat bisa diberikan kepada...', 'radio', 'Perorangan', 'Lembaga', 'Badan sosial', 'Semua benar', 'Semua benar', 10),
(40, 'Jika mustahik sudah mampu maka...', 'radio', 'Tetap menerima zakat', 'Tidak lagi menerima zakat', 'Tergantung kebutuhan', 'Semua benar', 'Tidak lagi menerima zakat', 10),
(40, 'Zakat tidak boleh diberikan kepada...', 'radio', 'Orang kaya', 'Keluarga Rasulullah', 'Non-muslim yang memusuhi Islam', 'Semua benar', 'Semua benar', 10),
(40, 'Memberikan zakat kepada keluarga sendiri...', 'radio', 'Boleh dengan syarat', 'Tidak boleh', 'Sunah', 'Wajib', 'Boleh dengan syarat', 10),
(40, 'Mengelola zakat secara profesional adalah tugas...', 'radio', 'Amil', 'Muzakki', 'Mustahik', 'Semua benar', 'Amil', 10),
(40, 'Zakat yang disalurkan melalui lembaga harus...', 'radio', 'Tepat sasaran', 'Transparan', 'Akuntabel', 'Semua benar', 'Semua benar', 10),
(40, 'Pendistribusian zakat bertujuan untuk...', 'radio', 'Membersihkan harta', 'Membantu mustahik', 'Mempererat ukhuwah', 'Semua benar', 'Semua benar', 10),
(40, 'Zakat yang tidak didistribusikan sesuai ketentuan...', 'radio', 'Sah', 'Tidak sah', 'Menjadi sedekah', 'Wajib diulang', 'Tidak sah', 10);

-- Bab 5: Haji dan Umrah
-- Subbab 1: Pengertian Haji (10 soal)
INSERT INTO soal_kuis (id_subbab, soal, tipe_jawaban, pilihan_a, pilihan_b, pilihan_c, pilihan_d, jawaban_benar, poin) VALUES
(41, 'Apa pengertian haji menurut bahasa?', 'radio', 'Berniat', 'Berkunjung', 'Bersuci', 'Berjalan', 'Berkunjung', 10),
(41, 'Haji menurut istilah syara adalah...', 'radio', 'Ziarah ke Masjid Nabawi', 'Ibadah tahunan di Makkah', 'Mengunjungi Baitullah untuk beribadah', 'Safar ke tanah suci', 'Mengunjungi Baitullah untuk beribadah', 10),
(41, 'Hukum haji adalah...', 'radio', 'Sunnah', 'Wajib sekali seumur hidup', 'Wajib setiap tahun', 'Fardhu kifayah', 'Wajib sekali seumur hidup', 10),
(41, 'Haji termasuk dalam rukun Islam yang ke...', 'radio', '4', '5', '3', '2', '5', 10),
(41, 'Waktu pelaksanaan haji adalah pada bulan...', 'radio', 'Ramadhan', 'Syawal', 'Dzulhijjah', 'Muharram', 'Dzulhijjah', 10),
(41, 'Landasan hukum wajibnya haji terdapat dalam...', 'radio', 'Surah Al-Baqarah', 'Surah Ali Imran', 'Surah Al-Maidah', 'Surah Al-Hajj', 'Surah Ali Imran', 10),
(41, 'Ibadah haji diwajibkan pada tahun...', 'radio', '5 H', '6 H', '9 H', '10 H', '9 H', 10),
(41, 'Perbedaan haji dan umrah terletak pada...', 'radio', 'Waktu dan tempat', 'Rukun dan wajib', 'Niat dan doa', 'Semua benar', 'Rukun dan wajib', 10),
(41, 'Haji mabrur adalah haji yang...', 'radio', 'Diterima Allah', 'Dilakukan dengan biaya halal', 'Dilaksanakan sesuai sunnah', 'Semua benar', 'Semua benar', 10),
(41, 'Gelar haji diberikan kepada yang telah...', 'radio', 'Melaksanakan umrah', 'Menyelesaikan ibadah haji', 'Kembali dari Makkah', 'Mendapat sertifikat', 'Menyelesaikan ibadah haji', 10);

-- Subbab 2: Syarat Wajib Haji (10 soal)
INSERT INTO soal_kuis (id_subbab, soal, tipe_jawaban, pilihan_a, pilihan_b, pilihan_c, pilihan_d, jawaban_benar, poin) VALUES
(42, 'Syarat wajib haji yang pertama adalah...', 'radio', 'Islam', 'Baligh', 'Berakal', 'Merdeka', 'Islam', 10),
(42, 'Istithaah dalam haji berarti...', 'radio', 'Kemampuan fisik', 'Kemampuan finansial', 'Keamanan perjalanan', 'Semua benar', 'Semua benar', 10),
(42, 'Perempuan yang akan haji harus...', 'radio', 'Didampingi mahram', 'Minta izin suami', 'Sudah menikah', 'Berusia di atas 40 tahun', 'Didampingi mahram', 10),
(42, 'Orang yang tidak mampu secara finansial...', 'radio', 'Tetap wajib haji', 'Tidak wajib haji', 'Wajib bila mendapat bantuan', 'Sunah haji', 'Tidak wajib haji', 10),
(42, 'Syarat wajib haji tentang kesehatan adalah...', 'radio', 'Sadar tidak sakit', 'Mampu secara fisik', 'Tidak memiliki penyakit menular', 'Semua benar', 'Semua benar', 10),
(42, 'Waktu untuk memenuhi syarat istithaah adalah...', 'radio', 'Saat berniat', 'Saat berangkat', 'Saat pelaksanaan', 'Semua benar', 'Saat berangkat', 10),
(42, 'Anak kecil yang melaksanakan haji...', 'radio', 'Sah dan menggugurkan kewajiban', 'Sah tetapi tidak menggugurkan kewajiban', 'Tidak sah', 'Sunah', 'Sah tetapi tidak menggugurkan kewajiban', 10),
(42, 'Orang gila yang melaksanakan haji...', 'radio', 'Sah dan menggugurkan kewajiban', 'Sah tetapi tidak menggugurkan kewajiban', 'Tidak sah', 'Sunah', 'Tidak sah', 10),
(42, 'Istithaah keamanan berarti...', 'radio', 'Aman dalam perjalanan', 'Tidak ada larangan pergi', 'Tidak ada perang', 'Semua benar', 'Semua benar', 10),
(42, 'Syarat wajib haji bagi laki-laki adalah...', 'radio', 'Harus kaya', 'Tidak ada utang', 'Bebas dari mahram', 'Tidak ada syarat khusus', 'Tidak ada syarat khusus', 10);

-- Subbab 3: Rukun Haji (10 soal)
INSERT INTO soal_kuis (id_subbab, soal, tipe_jawaban, pilihan_a, pilihan_b, pilihan_c, pilihan_d, jawaban_benar, poin) VALUES
(43, 'Berikut yang termasuk rukun haji adalah...', 'radio', 'Ihram', 'Tawaf', 'Sai', 'Semua benar', 'Semua benar', 10),
(43, 'Yang bukan rukun haji adalah...', 'radio', 'Wukuf', 'Tahalul', 'Mabit', 'Lontar jumrah', 'Lontar jumrah', 10),
(43, 'Rukun haji yang pertama adalah...', 'radio', 'Ihram', 'Wukuf', 'Tawaf', 'Sai', 'Ihram', 10),
(43, 'Ihram berarti...', 'radio', 'Memakai pakaian ihram dan berniat', 'Memotong rambut', 'Mengunjungi Baitullah', 'Semua benar', 'Memakai pakaian ihram dan berniat', 10),
(43, 'Wukuf dilaksanakan di...', 'radio', 'Arafah', 'Muzdalifah', 'Mina', 'Masjidil Haram', 'Arafah', 10),
(43, 'Tawaf adalah...', 'radio', 'Mengelilingi Kabah 7 kali', 'Berlari kecil antara Shafa-Marwah', 'Berdiam di Arafah', 'Melempar jumrah', 'Mengelilingi Kabah 7 kali', 10),
(43, 'Sai dilakukan antara...', 'radio', 'Shafa dan Marwah', 'Arafah dan Muzdalifah', 'Mina dan Arafah', 'Masjidil Haram dan Masjid Nabawi', 'Shafa dan Marwah', 10),
(43, 'Jumlah putaran dalam tawaf ifadhah adalah...', 'radio', '3 kali', '5 kali', '7 kali', '9 kali', '7 kali', 10),
(43, 'Mencukur rambut atau tahalul adalah...', 'radio', 'Rukun haji', 'Wajib haji', 'Sunah haji', 'Tidak wajib', 'Rukun haji', 10),
(43, 'Jika salah satu rukun haji ditinggalkan...', 'radio', 'Haji tetap sah', 'Haji tidak sah', 'Haji sah dengan dam', 'Haji perlu diulang', 'Haji tidak sah', 10);

-- Subbab 4: Wajib Haji (10 soal)
INSERT INTO soal_kuis (id_subbab, soal, tipe_jawaban, pilihan_a, pilihan_b, pilihan_c, pilihan_d, jawaban_benar, poin) VALUES
(44, 'Berikut yang termasuk wajib haji adalah...', 'radio', 'Ihram', 'Wukuf', 'Mabit di Mina', 'Tawaf', 'Mabit di Mina', 10),
(44, 'Perbedaan rukun dan wajib haji adalah...', 'radio', 'Rukun menentukan sahnya haji', 'Wajib jika ditinggalkan harus dam', 'Rukun lebih utama', 'Semua benar', 'Semua benar', 10),
(44, 'Wajib haji yang pertama adalah...', 'radio', 'Ihram dari miqat', 'Wukuf', 'Tawaf', 'Sai', 'Ihram dari miqat', 10),
(44, 'Mabit di Muzdalifah adalah...', 'radio', 'Rukun haji', 'Wajib haji', 'Sunah haji', 'Tidak wajib', 'Wajib haji', 10),
(44, 'Melempar jumrah termasuk...', 'radio', 'Rukun haji', 'Wajib haji', 'Sunah haji', 'Bukan ibadah haji', 'Wajib haji', 10),
(44, 'Jika meninggalkan wajib haji, harus...', 'radio', 'Mengulang haji', 'Membayar dam', 'Mengganti dengan umrah', 'Tidak ada konsekuensi', 'Membayar dam', 10),
(44, 'Mabit di Mina pada hari tasyrik adalah...', 'radio', 'Rukun haji', 'Wajib haji', 'Sunah haji', 'Tidak wajib', 'Wajib haji', 10),
(44, 'Berihram dari miqat berarti...', 'radio', 'Memulai ihram tepat di miqat', 'Memakai pakaian ihram', 'Membaca talbiyah', 'Semua benar', 'Memulai ihram tepat di miqat', 10),
(44, 'Tahallul adalah...', 'radio', 'Mencukur sebagian rambut', 'Mengganti pakaian ihram', 'Boleh melakukan larangan ihram', 'Semua benar', 'Semua benar', 10),
(44, 'Dam dalam haji adalah...', 'radio', 'Denda karena melanggar ketentuan', 'Kurban wajib', 'Shalat sunnah', 'Puasa khusus', 'Denda karena melanggar ketentuan', 10);

-- Subbab 5: Tawaf (10 soal)
INSERT INTO soal_kuis (id_subbab, soal, tipe_jawaban, pilihan_a, pilihan_b, pilihan_c, pilihan_d, jawaban_benar, poin) VALUES
(45, 'Tawaf yang merupakan rukun haji adalah...', 'radio', 'Tawaf qudum', 'Tawaf ifadhah', 'Tawaf wada', 'Tawaf sunnah', 'Tawaf ifadhah', 10),
(45, 'Jumlah putaran dalam tawaf adalah...', 'radio', '3 kali', '5 kali', '7 kali', '9 kali', '7 kali', 10),
(45, 'Tawaf diawali dari...', 'radio', 'Hajar Aswad', 'Pintu Kabah', 'Rukun Yamani', 'Multazam', 'Hajar Aswad', 10),
(45, 'Kondisi ketika melakukan tawaf adalah...', 'radio', 'Suci dari hadats besar dan kecil', 'Menutup aurat', 'Kabah berada di sebelah kiri', 'Semua benar', 'Semua benar', 10),
(45, 'Tawaf yang dilakukan saat pertama kali tiba di Makkah disebut...', 'radio', 'Tawaf ifadhah', 'Tawaf qudum', 'Tawaf sunnah', 'Tawaf wada', 'Tawaf qudum', 10),
(45, 'Berlari-lari kecil pada 3 putaran pertama disebut...', 'radio', 'Sai', 'Ramal', 'Idtiba', 'Tahalul', 'Ramal', 10),
(45, 'Menyembunyikan bahu kanan saat tawaf disebut...', 'radio', 'Ramal', 'Idtiba', 'Talbiah', 'Ihram', 'Idtiba', 10),
(45, 'Tawaf perpisahan sebelum pulang disebut...', 'radio', 'Tawaf ifadhah', 'Tawaf qudum', 'Tawaf wada', 'Tawaf sunnah', 'Tawaf wada', 10),
(45, 'Syarat sah tawaf adalah...', 'radio', 'Menutup aurat', 'Suci dari hadats', 'Niat', 'Semua benar', 'Semua benar', 10),
(45, 'Jika terputus shalat saat tawaf maka...', 'radio', 'Tawaf batal', 'Lanjutkan tawaf', 'Ulangi dari awal', 'Dilanjutkan dari putaran terakhir', 'Ulangi dari awal', 10);

-- Subbab 6: Sa'i (10 soal)
INSERT INTO soal_kuis (id_subbab, soal, tipe_jawaban, pilihan_a, pilihan_b, pilihan_c, pilihan_d, jawaban_benar, poin) VALUES
(46, 'Sai adalah berlari-lari kecil antara...', 'radio', 'Shafa dan Marwah', 'Arafah dan Muzdalifah', 'Mina dan Arafah', 'Masjidil Haram dan Masjid Nabawi', 'Shafa dan Marwah', 10),
(46, 'Sai dilakukan sebanyak...', 'radio', '3 kali bolak-balik', '5 kali bolak-balik', '7 kali bolak-balik', '9 kali bolak-balik', '7 kali bolak-balik', 10),
(46, 'Sai dimulai dari bukit...', 'radio', 'Shafa', 'Marwah', 'Pintu Ibrahim', 'Rukun Yamani', 'Shafa', 10),
(46, 'Kisah yang melatarbelakangi sai adalah sejarah...', 'radio', 'Nabi Ibrahim', 'Siti Hajar dan Ismail', 'Nabi Muhammad', 'Nabi Adam', 'Siti Hajar dan Ismail', 10),
(46, 'Bukit yang pertama kali dikunjungi saat sai adalah...', 'radio', 'Marwah', 'Shafa', 'Arafah', 'Muzdalifah', 'Shafa', 10),
(46, 'Tempat berlari-lari kecil dalam sai disebut...', 'radio', 'Mataf', 'Masa', 'Hijr Ismail', 'Multazam', 'Masa', 10),
(46, 'Saat melintasi lampu hijau dalam sai, dianjurkan...', 'radio', 'Berlari kecil', 'Berjalan biasa', 'Berhenti sejenak', 'Mempercepat langkah', 'Berlari kecil', 10),
(46, 'Doa yang dibaca saat naik ke bukit Shafa adalah...', 'radio', 'Basmalah', 'Takbir', 'Talbiah', 'Ayat Sai', 'Ayat Sai', 10),
(46, 'Jika ragu jumlah putaran sai...', 'radio', 'Dilanjutkan dengan hitungan minimal', 'Diulang dari awal', 'Ditambah menjadi 9 putaran', 'Tidak perlu dipikirkan', 'Dilanjutkan dengan hitungan minimal', 10),
(46, 'Sai dilakukan setelah...', 'radio', 'Tawaf ifadhah', 'Tawaf qudum', 'Wukuf', 'Mabit di Mina', 'Tawaf qudum', 10);

-- Subbab 7: Wukuf di Arafah (10 soal)
INSERT INTO soal_kuis (id_subbab, soal, tipe_jawaban, pilihan_a, pilihan_b, pilihan_c, pilihan_d, jawaban_benar, poin) VALUES
(47, 'Wukuf dilaksanakan di...', 'radio', 'Arafah', 'Muzdalifah', 'Mina', 'Masjidil Haram', 'Arafah', 10),
(47, 'Waktu wukuf adalah tanggal...', 'radio', '8 Dzulhijjah', '9 Dzulhijjah', '10 Dzulhijjah', '11 Dzulhijjah', '9 Dzulhijjah', 10),
(47, 'Wukuf dimulai dari...', 'radio', 'Tengah hari sampai maghrib', 'Subuh sampai dzuhur', 'Maghrib sampai subuh', 'Dzuhur sampai subuh', 'Tengah hari sampai maghrib', 10),
(47, 'Rukun wukuf adalah...', 'radio', 'Hadir di Arafah', 'Shalat di Masjid Namirah', 'Mendengarkan khutbah', 'Semua benar', 'Hadir di Arafah', 10),
(47, 'Haji seseorang tidak sah jika meninggalkan...', 'radio', 'Wukuf', 'Tawaf', 'Sai', 'Lontar jumrah', 'Wukuf', 10),
(47, 'Aktivitas utama selama wukuf adalah...', 'radio', 'Berdoa dan dzikir', 'Shalat berjamaah', 'Mendengarkan khutbah', 'Semua benar', 'Berdoa dan dzikir', 10),
(47, 'Tempat yang mustajab untuk berdoa saat wukuf adalah...', 'radio', 'Jabal Rahmah', 'Masjid Namirah', 'Pintu Arafah', 'Semua benar', 'Semua benar', 10),
(47, 'Jika terlewat waktu wukuf...', 'radio', 'Haji tidak sah', 'Tetap melakukan wukuf', 'Membayar dam', 'Mengulang tahun depan', 'Haji tidak sah', 10),
(47, 'Keutamaan wukuf adalah...', 'radio', 'Puncak ibadah haji', 'Momen pengampunan dosa', 'Waktu mustajab berdoa', 'Semua benar', 'Semua benar', 10),
(47, 'Setelah wukuf, jamaah menuju...', 'radio', 'Muzdalifah', 'Mina', 'Masjidil Haram', 'Jeddah', 'Muzdalifah', 10);

-- Subbab 8: Larangan Saat Haji (10 soal)
INSERT INTO soal_kuis (id_subbab, soal, tipe_jawaban, pilihan_a, pilihan_b, pilihan_c, pilihan_d, jawaban_benar, poin) VALUES
(48, 'Berikut yang termasuk larangan ihram adalah...', 'radio', 'Memotong kuku', 'Memakai wangi-wangian', 'Berburu', 'Semua benar', 'Semua benar', 10),
(48, 'Larangan ihram bagi laki-laki adalah...', 'radio', 'Memakai pakaian berjahit', 'Menutup kepala', 'Memakai sepatu', 'Semua benar', 'Semua benar', 10),
(48, 'Larangan ihram bagi perempuan adalah...', 'radio', 'Menutup wajah', 'Memakai sarung tangan', 'Memakai cadar', 'Semua benar', 'Semua benar', 10),
(48, 'Melanggar larangan ihram harus membayar...', 'radio', 'Dam', 'Fidyah', 'Kaffarah', 'Zakat', 'Dam', 10),
(48, 'Bentuk dam untuk mencukur rambut sebelum tahalul adalah...', 'radio', 'Puasa 3 hari', 'Memberi makan 6 orang miskin', 'Menyembelih kambing', 'Semua benar', 'Semua benar', 10),
(48, 'Berhubungan suami istri saat ihram membatalkan...', 'radio', 'Haji', 'Umrah', 'Haji dan umrah', 'Tidak membatalkan', 'Haji dan umrah', 10),
(48, 'Menggunakan sabun saat ihram hukumnya...', 'radio', 'Boleh asal tidak wangi', 'Haram', 'Makruh', 'Membatalkan', 'Boleh asal tidak wangi', 10),
(48, 'Berbicara kotor saat ihram termasuk...', 'radio', 'Makruh', 'Haram', 'Membatalkan haji', 'Tidak masalah', 'Haram', 10),
(48, 'Membunuh serangga saat ihram...', 'radio', 'Boleh jika mengganggu', 'Tetap tidak boleh', 'Boleh dengan dam', 'Tidak masalah', 'Tetap tidak boleh', 10),
(48, 'Mengumpat atau bertengkar saat ihram...', 'radio', 'Membatalkan haji', 'Wajib dam', 'Haram', 'Tidak apa-apa', 'Haram', 10);

-- Subbab 9: Dam Haji (10 soal)
INSERT INTO soal_kuis (id_subbab, soal, tipe_jawaban, pilihan_a, pilihan_b, pilihan_c, pilihan_d, jawaban_benar, poin) VALUES
(49, 'Dam dalam haji berarti...', 'radio', 'Denda atas pelanggaran', 'Hewan sembelihan', 'Kurban wajib', 'Semua benar', 'Semua benar', 10),
(49, 'Jenis-jenis dam antara lain...', 'radio', 'Dam tadhir', 'Dam jazak', 'Dam is ah', 'Semua benar', 'Semua benar', 10),
(49, 'Dam karena meninggalkan wajib haji adalah...', 'radio', 'Menyembelih kambing', 'Berpuasa 10 hari', 'Memberi makan 60 orang miskin', 'Semua benar', 'Menyembelih kambing', 10),
(49, 'Dam karena berburu hewan darat adalah...', 'radio', 'Menyembelih hewan yang sepadan', 'Membayar dengan uang', 'Puasa 1 bulan', 'Semua benar', 'Menyembelih hewan yang sepadan', 10),
(49, 'Dam karena berhubungan suami istri sebelum tahalul pertama...', 'radio', 'Membatalkan haji', 'Wajib menyembelih unta', 'Wajib qadha', 'Semua benar', 'Membatalkan haji', 10),
(49, 'Dam karena mencukur rambut sebelum tahalul adalah...', 'radio', 'Puasa 3 hari', 'Memberi makan 6 orang miskin', 'Menyembelih kambing', 'Semua benar', 'Semua benar', 10),
(49, 'Dam karena terhalang menyelesaikan haji (haji tamattu) adalah...', 'radio', 'Menyembelih kambing', 'Berpuasa 10 hari', 'Semua benar', 'Tidak ada dam', 'Menyembelih kambing', 10),
(49, 'Tempat penyembelihan dam adalah...', 'radio', 'Makkah', 'Mina', 'Arafah', 'Semua benar', 'Makkah', 10),
(49, 'Jika tidak mampu membayar dam berupa hewan maka diganti dengan...', 'radio', 'Puasa', 'Uang', 'Zakat', 'Tidak bisa diganti', 'Puasa', 10),
(49, 'Dam disebut juga...', 'radio', 'Fidyah', 'Kaffarah', 'Hadyu', 'Semua benar', 'Hadyu', 10);

-- Subbab 10: Umrah (10 soal)
INSERT INTO soal_kuis (id_subbab, soal, tipe_jawaban, pilihan_a, pilihan_b, pilihan_c, pilihan_d, jawaban_benar, poin) VALUES
(50, 'Umrah menurut bahasa berarti...', 'radio', 'Kunjungan', 'Perjalanan', 'Ibadah', 'Ziarah', 'Ziarah', 10),
(50, 'Umrah menurut syara adalah berkunjung ke...', 'radio', 'Masjid Nabawi', 'Baitullah untuk ibadah', 'Arafah', 'Mina', 'Baitullah untuk ibadah', 10),
(50, 'Hukum umrah adalah...', 'radio', 'Wajib sekali seumur hidup', 'Sunah muakkad', 'Wajib setiap tahun', 'Mubah', 'Sunah muakkad', 10),
(50, 'Rukun umrah adalah...', 'radio', 'Ihram', 'Tawaf', 'Sai', 'Semua benar', 'Semua benar', 10),
(50, 'Perbedaan haji dan umrah adalah...', 'radio', 'Waktu pelaksanaan', 'Rukun wukuf', 'Tempat', 'Semua benar', 'Semua benar', 10),
(50, 'Waktu pelaksanaan umrah adalah...', 'radio', 'Kapan saja', 'Hanya bulan Ramadan', 'Hanya bulan haji', 'Tidak ada waktu khusus', 'Kapan saja', 10),
(50, 'Umrah yang digabung dengan haji disebut...', 'radio', 'Ifrad', 'Tamattu', 'Qiran', 'Mufrad', 'Tamattu', 10),
(50, 'Jenis umrah antara lain...', 'radio', 'Umrah mufradah', 'Umrah tamattu', 'Umrah sunah', 'Semua benar', 'Semua benar', 10),
(50, 'Umrah yang dilakukan sebelum haji disebut...', 'radio', 'Ifrad', 'Tamattu', 'Qiran', 'Mufrad', 'Tamattu', 10),
(50, 'Keutamaan umrah di bulan Ramadan adalah...', 'radio', 'Pahalanya sama de