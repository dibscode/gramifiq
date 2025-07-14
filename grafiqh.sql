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
