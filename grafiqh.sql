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

-- Bab dan Subbab
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

-- Soal dan Jawaban
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

-- ChatGPT log
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
(3, 'Air zamzam termasuk air...', 'radio', 'Muqayyad', 'Najis', 'Mutlak', 'mustamal', 'Mutlak', 10),
(3, 'Air yang tercampur dengan minyak...', 'radio', 'Tetap suci mensucikan', 'Menjadi najis', 'Menjadi muqayyad', 'Tidak boleh dipakai', 'Menjadi muqayyad', 10),
(3, 'Minimal air yang dapat digunakan untuk wudhu adalah...', 'radio', 'Satu liter', 'Satu mud', 'Dua qullah', 'Tidak ada batas minimal', 'Satu mud', 10),
(3, 'Air yang berubah warna karena najis...', 'radio', 'Tetap suci', 'Menjadi najis', 'Menjadi muqayyad', 'Masih boleh dipakai', 'Menjadi najis', 10),
(3, 'Air sungai yang jernih termasuk...', 'radio', 'Air muqayyad', 'Air najis', 'Air mutlak', 'Air mustamal', 'Air mutlak', 10),
(3, 'Air yang dipakai untuk mencuci najis...', 'radio', 'Tetap suci', 'Menjadi najis', 'Menjadi muqayyad', 'Menjadi mustamal', 'Menjadi najis', 10),

-- Subbab 4: Air Musta'mal (10 soal)
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