-- ========================================================
-- SCRIPT ANTI-GAGAL: RUNNING DATA DUMMY RENTAL MOBIL
-- Dengan Bypass Pengecekan Foreign Key untuk Pembersihan Bersih
-- ========================================================

-- 1. Matikan pengecekan foreign key agar semua tabel lama bisa di-drop tanpa error 3730
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS Traking_GPS;
DROP TABLE IF EXISTS Tracking_GPS;
DROP TABLE IF EXISTS Pembayaran;
DROP TABLE IF EXISTS Denda;
DROP TABLE IF EXISTS Penyewaan;
DROP TABLE IF EXISTS Kendaraan;
DROP TABLE IF EXISTS Pegawai;
DROP TABLE IF EXISTS Cabang;
DROP TABLE IF EXISTS Pelanggan;

-- 2. Hidupkan kembali pengecekan foreign key agar struktur tabel baru tetap disiplin & aman
SET FOREIGN_KEY_CHECKS = 1;

-- ========================================================
-- STRUKTUR TABEL BARU (DDL)
-- ========================================================

CREATE TABLE Pelanggan (
    ID_Pelanggan VARCHAR(10) PRIMARY KEY,
    NIK VARCHAR(20) NOT NULL,
    Nama VARCHAR(100) NOT NULL,
    Tanggal_lahir DATE,
    Jenis_Kelamin VARCHAR(20),
    Alamat TEXT,
    No_Hp VARCHAR(20),
    Email VARCHAR(50),
    Status_Anggota VARCHAR(30),
    Total_Penyewaan INT DEFAULT 0
);

CREATE TABLE Cabang (
    ID_Cabang VARCHAR(10) PRIMARY KEY,
    Nama_Cabang VARCHAR(100) NOT NULL,
    Alamat TEXT,
    No_Hp VARCHAR(20),
    Jumlah_Pegawai INT DEFAULT 0,
    List_Kendaraan TEXT
);

CREATE TABLE Pegawai (
    ID_Pegawai VARCHAR(10) PRIMARY KEY,
    NIK VARCHAR(20) NOT NULL,
    Nama_Lengkap VARCHAR(100) NOT NULL,
    Alamat TEXT,
    No_Hp VARCHAR(20),
    Email VARCHAR(50),
    Tanggal_Lahir DATE,
    Jenis_Kelamin VARCHAR(20),
    Jabatan VARCHAR(50),
    ID_Cabang VARCHAR(10),
    FOREIGN KEY (ID_Cabang) REFERENCES Cabang(ID_Cabang) ON DELETE SET NULL
);

CREATE TABLE Kendaraan (
    ID_Kendaraan VARCHAR(10) PRIMARY KEY,
    Plat_Nomor VARCHAR(20) NOT NULL,
    Merek VARCHAR(50) NOT NULL,
    Model VARCHAR(50),
    Tipe_Varian VARCHAR(50),
    Tahun_Pembuatan INT,
    Warna VARCHAR(30),
    Kapasitas_Penumpang INT,
    Jenis_Kendaraan VARCHAR(30),
    Transmisi VARCHAR(20),
    Bahan_Bakar VARCHAR(25),
    Harga_Sewa INT NOT NULL,
    Status_Kendaraan VARCHAR(30) DEFAULT 'Tersedia',
    ID_Cabang VARCHAR(10),
    FOREIGN KEY (ID_Cabang) REFERENCES Cabang(ID_Cabang) ON DELETE SET NULL
);

CREATE TABLE Penyewaan (
    ID_Penyewaan VARCHAR(10) PRIMARY KEY,
    ID_Pelanggan VARCHAR(10),
    ID_Kendaraan VARCHAR(10),
    ID_Pegawai VARCHAR(10),
    Tanggal_Pesan DATE,
    Tanggal_Mulai_Sewa DATE NOT NULL,
    Tanggal_Akhir_Sewa DATE NOT NULL,
    Tanggal_Pengembalian DATE,
    Total_Biaya INT DEFAULT 0,
    Kondisi_Kendaraan_Sebelum VARCHAR(100),
    Kondisi_Kendaraan_Sesudah VARCHAR(100),
    Status_Pengembalian VARCHAR(30),
    FOREIGN KEY (ID_Pelanggan) REFERENCES Pelanggan(ID_Pelanggan) ON DELETE SET NULL,
    FOREIGN KEY (ID_Kendaraan) REFERENCES Kendaraan(ID_Kendaraan) ON DELETE SET NULL,
    FOREIGN KEY (ID_Pegawai) REFERENCES Pegawai(ID_Pegawai) ON DELETE SET NULL
);

CREATE TABLE Denda (
    ID_Denda VARCHAR(10) PRIMARY KEY,
    Jumlah_Denda INT NOT NULL,
    Alasan TEXT,
    Status_Denda VARCHAR(30),
    ID_Penyewaan VARCHAR(10),
    FOREIGN KEY (ID_Penyewaan) REFERENCES Penyewaan(ID_Penyewaan) ON DELETE CASCADE
);

CREATE TABLE Pembayaran (
    ID_Pembayaran VARCHAR(10) PRIMARY KEY,
    Tanggal_Bayar DATE NOT NULL,
    Metode_Bayar VARCHAR(50),
    Status_Bayar VARCHAR(30),
    ID_Penyewaan VARCHAR(10),
    FOREIGN KEY (ID_Penyewaan) REFERENCES Penyewaan(ID_Penyewaan) ON DELETE CASCADE
);

CREATE TABLE Tracking_GPS (
    ID_Tracking VARCHAR(10) PRIMARY KEY,
    Waktu DATETIME NOT NULL,
    Latitude DECIMAL(10, 6) NOT NULL,
    Longitude DECIMAL(10, 6) NOT NULL,
    ID_Kendaraan VARCHAR(10),
    FOREIGN KEY (ID_Kendaraan) REFERENCES Kendaraan(ID_Kendaraan) ON DELETE CASCADE
);

-- ========================================================
-- INJEKSI DATA DUMMY (Masing-masing 30 Baris Konten Konsisten)
-- ========================================================

-- A. DATA MASTER: PELANGGAN (30)
INSERT INTO Pelanggan (ID_Pelanggan, NIK, Nama, Tanggal_lahir, Jenis_Kelamin, Alamat, No_Hp, Email, Status_Anggota, Total_Penyewaan) VALUES
('PLG001', '3506110293049101', 'Satria Pratama', '1995-04-12', 'Laki-laki', 'Jl. Pemuda No. 12, Surabaya', '081267869695', 'satria@gmail.com', 'Aktif', 2),
('PLG002', '3506110293049102', 'Sri Lestari', '1998-08-22', 'Perempuan', 'Jl. Pemuda No. 15, Surabaya', '081273932840', 'sri@gmail.com', 'Aktif', 1),
('PLG003', '3506110293049103', 'Heri Wijaya', '1993-11-02', 'Laki-laki', 'Jl. Pemuda No. 18, Surabaya', '081232890479', 'heri@gmail.com', 'Aktif', 1),
('PLG004', '3506110293049104', 'Daffa Purnama', '2005-11-01', 'Laki-laki', 'Jl. Pemuda No. 22, Surabaya', '081215160893', 'daffa@gmail.com', 'Aktif', 1),
('PLG005', '3506110293049105', 'Hendra Kusuma', '1994-01-30', 'Laki-laki', 'Jl. Pemuda No. 34, Surabaya', '081295254199', 'hendra@gmail.com', 'Aktif', 1),
('PLG006', '3506110293049106', 'Clarissa Lestari', '1997-05-14', 'Perempuan', 'Jl. Pemuda No. 59, Surabaya', '081231671987', 'clarissa@gmail.com', 'Aktif', 1),
('PLG007', '3506110293049107', 'Utami Ramadhan', '1996-09-19', 'Perempuan', 'Jl. Pemuda No. 64, Surabaya', '081250692797', 'utami@gmail.com', 'Aktif', 1),
('PLG008', '3506110293049108', 'Diana Fitriani', '1999-02-25', 'Perempuan', 'Jl. Pemuda No. 80, Surabaya', '081247895085', 'diana@gmail.com', 'Aktif', 1),
('PLG009', '3506110293049109', 'Siti Wijaya', '1992-07-07', 'Perempuan', 'Jl. Pemuda No. 87, Surabaya', '081233932785', 'siti@gmail.com', 'Aktif', 1),
('PLG010', '3506110293049110', 'Fitri Wibowo', '1995-12-04', 'Perempuan', 'Jl. Pemuda No. 90, Surabaya', '081299891834', 'fitri@gmail.com', 'Aktif', 1),
('PLG011', '3506110293049111', 'Agus Ramadhan', '1993-03-15', 'Laki-laki', 'Jl. Pemuda No. 94, Surabaya', '081281283688', 'agus@gmail.com', 'Aktif', 1),
('PLG012', '3506110293049112', 'Mega Sutrisno', '1997-10-10', 'Perempuan', 'Jl. Pemuda No. 99, Surabaya', '081295563914', 'mega@gmail.com', 'Aktif', 1),
('PLG013', '3506110293049113', 'Dani Purnama', '1994-06-21', 'Laki-laki', 'Jl. Pemuda No. 101, Surabaya', '081293608240', 'dani@gmail.com', 'Aktif', 1),
('PLG014', '3506110293049114', 'Sri Gunawan', '1991-08-13', 'Perempuan', 'Jl. Pemuda No. 104, Surabaya', '081217579133', 'sri.g@gmail.com', 'Aktif', 1),
('PLG015', '3506110293049115', 'Yanto Siregar', '1990-04-26', 'Laki-laki', 'Jl. Pemuda No. 115, Surabaya', '081250692797', 'yanto@gmail.com', 'Aktif', 1),
('PLG016', '3506110293049116', 'Sari Nugroho', '1996-02-18', 'Perempuan', 'Jl. Pemuda No. 120, Surabaya', '081274249150', 'sari@gmail.com', 'Aktif', 3),
('PLG017', '3506110293049117', 'Eka Ramadhan', '1995-07-29', 'Laki-laki', 'Jl. Pemuda No. 122, Surabaya', '081294334335', 'eka@gmail.com', 'Aktif', 1),
('PLG018', '3506110293049118', 'Dimas Prasetyo', '1998-03-08', 'Laki-laki', 'Jl. Pemuda No. 125, Surabaya', '081220496152', 'dimas@gmail.com', 'Aktif', 2),
('PLG019', '3506110293049119', 'Putri Aulia', '1997-11-23', 'Perempuan', 'Jl. Pemuda No. 130, Surabaya', '081210065005', 'putri@gmail.com', 'Aktif', 1),
('PLG020', '3506110293049120', 'Dewi Prasetyo', '1994-09-12', 'Perempuan', 'Jl. Pemuda No. 134, Surabaya', '081262615682', 'dewi@gmail.com', 'Aktif', 1),
('PLG021', '3506110293049121', 'Intan Subagyo', '1996-05-05', 'Perempuan', 'Jl. Pemuda No. 140, Surabaya', '081255486950', 'intan@gmail.com', 'Aktif', 1),
('PLG022', '3506110293049122', 'Aditya Lestari', '1993-01-17', 'Laki-laki', 'Jl. Pemuda No. 144, Surabaya', '081294982613', 'aditya@gmail.com', 'Aktif', 2),
('PLG023', '3506110293049123', 'Fajar Wibowo', '1995-10-25', 'Laki-laki', 'Jl. Pemuda No. 147, Surabaya', '081247071980', 'fajar@gmail.com', 'Aktif', 3),
('PLG024', '3506110293049124', 'Rina Wibowo', '1997-03-14', 'Perempuan', 'Jl. Pemuda No. 150, Surabaya', '081228904797', 'rina@gmail.com', 'Aktif', 2),
('PLG025', '3506110293049125', 'Ayu Aulia', '1999-06-30', 'Perempuan', 'Jl. Pemuda No. 154, Surabaya', '081227110183', 'ayu@gmail.com', 'Aktif', 1),
('PLG026', '3506110293049126', 'Sri Hidayat', '1992-04-11', 'Perempuan', 'Jl. Pemuda No. 158, Surabaya', '081251119612', 'sri.h@gmail.com', 'Aktif', 1),
('PLG027', '3506110293049127', 'Yanti Saputra', '1994-08-08', 'Perempuan', 'Jl. Pemuda No. 160, Surabaya', '081252726322', 'yanti@gmail.com', 'Aktif', 1),
('PLG028', '3506110293049128', 'Amalia Sutrisno', '1996-12-12', 'Perempuan', 'Jl. Pemuda No. 166, Surabaya', '081213364998', 'amalia@gmail.com', 'Aktif', 1),
('PLG029', '3506110293049129', 'Hendra Wibowo', '1993-02-27', 'Laki-laki', 'Jl. Pemuda No. 170, Surabaya', '081251582236', 'hendra.w@gmail.com', 'Aktif', 1),
('PLG030', '3506110293049130', 'Rizky Gunawan', '1995-07-05', 'Laki-laki', 'Jl. Pemuda No. 177, Surabaya', '081213876735', 'rizky@gmail.com', 'Aktif', 1);

-- B. DATA MASTER: CABANG (30)
INSERT INTO Cabang (ID_Cabang, Nama_Cabang, Alamat, No_Hp, Jumlah_Pegawai, List_Kendaraan) VALUES
('CBG001', 'Rental Surabaya Pusat 1', 'Jl. Kertajaya No. 10, Surabaya', '031-555001', 2, 'KND014'),
('CBG002', 'Rental Surabaya Barat 1', 'Jl. HR Muhammad No. 45, Surabaya', '031-555002', 2, 'KND008'),
('CBG003', 'Rental Surabaya Timur 1', 'Jl. Mulyorejo No. 88, Surabaya', '031-555003', 0, 'Tidak Ada'),
('CBG004', 'Rental Surabaya Selatan 1', 'Jl. Ahmad Yani No. 120, Surabaya', '031-555004', 0, 'KND015, KND026'),
('CBG005', 'Rental Surabaya Utara 1', 'Jl. Perak Timur No. 34, Surabaya', '031-555005', 2, 'KND003, KND012'),
('CBG006', 'Rental Sidoarjo 1', 'Jl. Gajah Mada No. 5, Sidoarjo', '031-888001', 1, 'KND006, KND022'),
('CBG007', 'Rental Gresik 1', 'Jl. Veteran No. 12, Gresik', '031-333001', 0, 'Tidak Ada'),
('CBG008', 'Rental Malang 1', 'Jl. Borobudur No. 2, Malang', '0341-444001', 1, 'Tidak Ada'),
('CBG009', 'Rental Kediri 1', 'Jl. Hasanuddin No. 9, Kediri', '0354-666001', 3, 'Tidak Ada'),
('CBG010', 'Rental Madiun 1', 'Jl. Pahlawan No. 40, Madiun', '0351-777001', 1, 'KND019'),
('CBG011', 'Rental Mojokerto 1', 'Jl. Gajah Mada No. 15, Mojokerto', '0321-222001', 1, 'Tidak Ada'),
('CBG012', 'Rental Jember 1', 'Jl. Gajah Mada No. 100, Jember', '0331-333001', 2, 'KND013'),
('CBG013', 'Rental Pasuruan 1', 'Jl. Panglima Sudirman No. 8, Pasuruan', '0343-444001', 0, 'Tidak Ada'),
('CBG014', 'Rental Blitar 1', 'Jl. Merdeka No. 21, Blitar', '0342-555001', 1, 'KND025'),
('CBG015', 'Rental Batu 1', 'Jl. Diponegoro No. 50, Batu', '0341-595001', 1, 'Tidak Ada'),
('CBG016', 'Rental Surabaya Pusat 2', 'Jl. Basuki Rahmat No. 12, Surabaya', '031-555016', 3, 'KND023'),
('CBG017', 'Rental Surabaya Barat 2', 'Jl. Mayjen Jonosewojo No. 3, Surabaya', '031-555017', 0, 'KND009'),
('CBG018', 'Rental Surabaya Timur 2', 'Jl. Dharmahusada No. 60, Surabaya', '031-555018', 0, 'KND011, KND016'),
('CBG019', 'Rental Surabaya Selatan 2', 'Jl. Jemursari No. 14, Surabaya', '031-555019', 4, 'KND007, KND017, KND018, KND024'),
('CBG020', 'Rental Surabaya Utara 2', 'Jl. Rajawali No. 5, Surabaya', '031-555020', 1, 'KND029'),
('CBG021', 'Rental Sidoarjo 2', 'Jl. Jenggolo No. 11, Sidoarjo', '031-888021', 0, 'KND010'),
('CBG022', 'Rental Gresik 2', 'Jl. lndro No. 4, Gresik', '031-333022', 1, 'KND028'),
('CBG023', 'Rental Malang 2', 'Jl. Sutoyo No. 18, Malang', '0341-444023', 1, 'Tidak Ada'),
('CBG024', 'Rental Kediri 2', 'Jl. Brawijaya No. 14, Kediri', '0354-666024', 1, 'Tidak Ada'),
('CBG025', 'Rental Madiun 2', 'Jl. Sudirman No. 5, Madiun', '0351-777025', 1, 'KND004'),
('CBG026', 'Rental Mojokerto 2', 'Jl. Bhayangkara No. 2, Mojokerto', '0321-222026', 2, 'KND002, KND020'),
('CBG027', 'Rental Jember 2', 'Jl. Hayam Wuruk No. 12, Jember', '0331-333027', 2, 'KND001, KND030'),
('CBG028', 'Rental Pasuruan 2', 'Jl. Hayam Wuruk No. 80, Pasuruan', '0343-444028', 6, 'KND017'),
('CBG029', 'Rental Blitar 2', 'Jl. Sudirman No. 31, Blitar', '0342-555029', 2, 'KND005, KND027'),
('CBG030', 'Rental Batu 2', 'Jl. Sultan Agung No. 1, Batu', '0341-595030', 0, 'Tidak Ada');

-- C. DATA MASTER: PEGAWAI (30)
INSERT INTO Pegawai (ID_Pegawai, NIK, Nama_Lengkap, Alamat, No_Hp, Email, Tanggal_Lahir, Jenis_Kelamin, Jabatan, ID_Cabang) VALUES
('PGW001', '3506011204940001', 'Satria Purnama', 'Kediri', '085611223301', 'satria.p@rental.com', '1994-04-12', 'Laki-laki', 'Admin Cabang', 'CBG009'),
('PGW002', '3506011204940002', 'Dewi Prasetyo', 'Pasuruan', '085611223302', 'dewi.p@rental.com', '1996-05-15', 'Perempuan', 'Kasir', 'CBG028'),
('PGW003', '3506011204940003', 'Roni Nugroho', 'Surabaya', '085611223303', 'roni.n@rental.com', '1992-01-20', 'Laki-laki', 'Customer Service', 'CBG016'),
('PGW004', '3506011204940004', 'Putri Wijaya', 'Blitar', '085611223304', 'putri.w@rental.com', '1991-09-10', 'Perempuan', 'Manager Cabang', 'CBG014'),
('PGW005', '3506011204940005', 'Heri Aulia', 'Surabaya', '085611223305', 'heri.a@rental.com', '1993-07-25', 'Laki-laki', 'Staff Operasional', 'CBG019'),
('PGW006', '3506011204940006', 'Guntur Purnama', 'Kediri', '085611223306', 'guntur@rental.com', '1994-03-11', 'Laki-laki', 'Admin Cabang', 'CBG009'),
('PGW007', '3506011204940007', 'Fajar Lestari', 'Surabaya', '085611223307', 'fajar.l@rental.com', '1995-12-04', 'Laki-laki', 'Kasir', 'CBG016'),
('PGW008', '3506011204940008', 'Daffa Pratama', 'Malang', '085611223308', 'daffa.p@rental.com', '1997-08-08', 'Laki-laki', 'Customer Service', 'CBG008'),
('PGW009', '3506011204940009', 'Amalia Wijaya', 'Pasuruan', '085611223309', 'amalia@rental.com', '1994-02-15', 'Perempuan', 'Manager Cabang', 'CBG028'),
('PGW010', '3506011204940010', 'Budi Purnama', 'Surabaya', '085611223310', 'budi.p@rental.com', '1993-06-21', 'Laki-laki', 'Staff Operasional', 'CBG019'),
('PGW011', '3506011204940011', 'Taufik Saputra', 'Surabaya', '085611223311', 'taufik@rental.com', '1992-04-14', 'Laki-laki', 'Admin Cabang', 'CBG002'),
('PGW012', '3506011204940012', 'Aris Sutrisno', 'Pasuruan', '085611223312', 'aris@rental.com', '1991-08-13', 'Laki-laki', 'Kasir', 'CBG028'),
('PGW013', '3506011204940013', 'Siti Setiawan', 'Mojokerto', '085611223313', 'siti@rental.com', '1996-03-18', 'Perempuan', 'Customer Service', 'CBG011'),
('PGW014', '3506011204940014', 'Rizky Purnama', 'Surabaya', '085611223314', 'rizky@rental.com', '1995-07-29', 'Laki-laki', 'Manager Cabang', 'CBG019'),
('PGW015', '3506011204940015', 'Diana Wibowo', 'Kediri', '085611223315', 'diana@rental.com', '1994-11-23', 'Perempuan', 'Staff Operasional', 'CBG024'),
('PGW016', '3506011204940016', 'Andi Subagyo', 'Pasuruan', '085611223316', 'andi@rental.com', '1993-01-17', 'Laki-laki', 'Admin Cabang', 'CBG028'),
('PGW017', '3506011204940017', 'Dimas Lestari', 'Gresik', '085611223317', 'dimas.l@rental.com', '1995-10-25', 'Laki-laki', 'Kasir', 'CBG022'),
('PGW018', '3506011204940018', 'Agus Gunawan', 'Jember', '085611223318', 'agus.g@rental.com', '1992-04-11', 'Laki-laki', 'Customer Service', 'CBG012'),
('PGW019', '3506011204940019', 'Diana Setiawan', 'Madiun', '085611223319', 'diana.s@rental.com', '1994-08-08', 'Perempuan', 'Manager Cabang', 'CBG025'),
('PGW020', '3506011204940020', 'Fitri Gunawan', 'Surabaya', '085611223320', 'fitri@rental.com', '1996-12-12', 'Perempuan', 'Staff Operasional', 'CBG016'),
('PGW021', '3506011204940021', 'Anwar Wijaya', 'Kediri', '085611223321', 'anwar@rental.com', '1993-02-27', 'Laki-laki', 'Admin Cabang', 'CBG009'),
('PGW022', '3506011204940022', 'Clarissa Wibowo', 'Pasuruan', '085611223322', 'clarissa.w@rental.com', '1995-07-05', 'Perempuan', 'Kasir', 'CBG028'),
('PGW023', '3506011204940023', 'Eka Saputra', 'Surabaya', '085611223323', 'eka.s@rental.com', '1994-06-21', 'Laki-laki', 'Customer Service', 'CBG002'),
('PGW024', '3506011204940024', 'Rian Lestari', 'Surabaya', '085611223324', 'rian@rental.com', '1991-08-13', 'Perempuan', 'Manager Cabang', 'CBG020'),
('PGW025', '3506011204940025', 'Dimas Hidayat', 'Batu', '085611223325', 'dimas.h@rental.com', '1990-04-26', 'Laki-laki', 'Staff Operasional', 'CBG015'),
('PGW026', '3506011204940026', 'Yanti Setiawan', 'Jember', '085611223326', 'yanti@rental.com', '1996-02-18', 'Perempuan', 'Admin Cabang', 'CBG012'),
('PGW027', '3506011204940027', 'Budi Ramadhan', 'Pasuruan', '085611223327', 'budi.r@rental.com', '1995-07-29', 'Laki-laki', 'Kasir', 'CBG028'),
('PGW028', '3506011204940028', 'Dedi Wijaya', 'Malang', '085611223328', 'dedi@rental.com', '1998-03-08', 'Laki-laki', 'Customer Service', 'CBG023'),
('PGW029', '3506011204940029', 'Irfan Wibowo', 'Madiun', '085611223329', 'irfan@rental.com', '1997-11-23', 'Laki-laki', 'Manager Cabang', 'CBG010'),
('PGW030', '3506011204940030', 'Amalia Saputra', 'Sidoarjo', '085611223330', 'amalia.s@rental.com', '1994-09-12', 'Perempuan', 'Staff Operasional', 'CBG006');

-- D. DATA MASTER: KENDARAAN (30)
INSERT INTO Kendaraan (ID_Kendaraan, Plat_Nomor, Merek, Model, Tipe_Varian, Tahun_Pembuatan, Warna, Kapasitas_Penumpang, Jenis_Kendaraan, Transmisi, Bahan_Bakar, Harga_Sewa, Status_Kendaraan, ID_Cabang) VALUES
('KND001', 'AG 1460 CC', 'Toyota', 'Avanza', 'G 1.3', 2021, 'Hitam', 7, 'MPV', 'Manual', 'Bensin', 350000, 'Tersedia', 'CBG027'),
('KND002', 'AG 3524 LU', 'Toyota', 'Innova Zenix', 'V Hybrid', 2023, 'Silver', 7, 'MPV', 'Otomatis', 'Bensin/Listrik', 800000, 'Tersedia', 'CBG026'),
('KND003', 'L 9651 BB', 'Mitsubishi', 'Xpander', 'Ultimate', 2022, 'Putih', 7, 'MPV', 'Otomatis', 'Bensin', 450000, 'Tersedia', 'CBG005'),
('KND004', 'B 6878 CC', 'Mitsubishi', 'Pajero Sport', 'Dakar', 2021, 'Hitam', 7, 'SUV', 'Otomatis', 'Solar', 1200000, 'Tersedia', 'CBG025'),
('KND005', 'N 6445 NZ', 'Toyota', 'Fortuner', 'VRZ', 2021, 'Abu-abu', 7, 'SUV', 'Otomatis', 'Solar', 1200000, 'Perawatan', 'CBG029'),
('KND006', 'AG 4287 LU', 'Honda', 'Brio', 'Satya E', 2020, 'Merah', 5, 'City Car', 'Manual', 'Bensin', 300000, 'Disewa', 'CBG006'),
('KND007', 'AG 4181 LU', 'Honda', 'HR-V', 'SE', 2023, 'Putih', 5, 'SUV', 'Otomatis', 'Bensin', 500000, 'Perawatan', 'CBG019'),
('KND008', 'W 9652 NZ', 'Toyota', 'Agya', 'G', 2021, 'Silver', 5, 'City Car', 'Manual', 'Bensin', 300000, 'Perawatan', 'CBG002'),
('KND009', 'DK 4627 AA', 'Toyota', 'Alphard', 'G A/T', 2024, 'Hitam', 7, 'Luxury MPV', 'Otomatis', 'Bensin', 2500000, 'Tersedia', 'CBG017'),
('KND010', 'W 7430 BB', 'Honda', 'Civic', 'RS Turbo', 2022, 'Merah', 5, 'Sedan', 'Otomatis', 'Bensin', 1200000, 'Tersedia', 'CBG021'),
('KND011', 'B 1935 AA', 'Toyota', 'Avanza', 'Veloz 1.5', 2022, 'Hitam', 7, 'MPV', 'Otomatis', 'Bensin', 350000, 'Disewa', 'CBG018'),
('KND012', 'L 9906 XX', 'Toyota', 'Innova Zenix', 'G Petrol', 2021, 'Putih', 7, 'MPV', 'Otomatis', 'Bensin', 800000, 'Disewa', 'CBG005'),
('KND013', 'AG 4181 DS', 'Mitsubishi', 'Xpander', 'Exceed', 2020, 'Abu-abu', 7, 'MPV', 'Manual', 'Bensin', 450000, 'Disewa', 'CBG012'),
('KND014', 'B 3081 XX', 'Mitsubishi', 'Pajero Sport', 'Exceed', 2022, 'Hitam', 7, 'SUV', 'Otomatis', 'Solar', 1200000, 'Tersedia', 'CBG001'),
('KND015', 'DK 3110 AA', 'Toyota', 'Fortuner', 'SRZ', 2024, 'Silver', 7, 'SUV', 'Otomatis', 'Bensin', 1200000, 'Tersedia', 'CBG004'),
('KND016', 'AG 9706 DS', 'Honda', 'Brio', 'RS M/T', 2022, 'Putih', 5, 'City Car', 'Manual', 'Bensin', 300000, 'Tersedia', 'CBG018'),
('KND017', 'W 9349 AA', 'Honda', 'HR-V', 'E CVT', 2020, 'Hitam', 5, 'SUV', 'Otomatis', 'Bensin', 500000, 'Perawatan', 'CBG028'),
('KND018', 'B 3370 XX', 'Toyota', 'Agya', 'GR Sport', 2020, 'Merah', 5, 'City Car', 'Otomatis', 'Bensin', 300000, 'Tersedia', 'CBG019'),
('KND019', 'L 9906 CC', 'Toyota', 'Alphard', 'X', 2023, 'Putih', 7, 'Luxury MPV', 'Otomatis', 'Bensin', 2500000, 'Tersedia', 'CBG010'),
('KND020', 'DK 3816 DS', 'Honda', 'Civic', 'Turbo', 2024, 'Hitam', 5, 'Sedan', 'Otomatis', 'Bensin', 1200000, 'Disewa', 'CBG026'),
('KND021', 'N 1735 LU', 'Toyota', 'Avanza', 'E M/T', 2024, 'Silver', 7, 'MPV', 'Manual', 'Bensin', 350000, 'Tersedia', 'CBG028'),
('KND022', 'L 3266 BB', 'Toyota', 'Innova Zenix', 'V Petrol', 2024, 'Hitam', 7, 'MPV', 'Otomatis', 'Bensin', 800000, 'Tersedia', 'CBG006'),
('KND023', 'L 6003 XX', 'Mitsubishi', 'Xpander', 'GLS', 2024, 'Putih', 7, 'MPV', 'Manual', 'Bensin', 450000, 'Disewa', 'CBG016'),
('KND024', 'B 7949 LU', 'Mitsubishi', 'Pajero Sport', 'GLX 4x4', 2023, 'Abu-abu', 7, 'SUV', 'Manual', 'Solar', 1200000, 'Perawatan', 'CBG019'),
('KND025', 'DK 8251 BB', 'Toyota', 'Fortuner', 'G M/T', 2024, 'Hitam', 7, 'SUV', 'Manual', 'Solar', 1200000, 'Disewa', 'CBG014'),
('KND026', 'W 6226 LU', 'Honda', 'Brio', 'Satya S', 2025, 'Merah', 5, 'City Car', 'Manual', 'Bensin', 300000, 'Tersedia', 'CBG004'),
('KND027', 'AG 6702 XX', 'Honda', 'HR-V', 'Prestige', 2022, 'Silver', 5, 'SUV', 'Otomatis', 'Bensin', 500000, 'Disewa', 'CBG029'),
('KND028', 'N 1056 DS', 'Toyota', 'Agya', 'E M/T', 2021, 'Hitam', 5, 'City Car', 'Manual', 'Bensin', 300000, 'Tersedia', 'CBG022'),
('KND029', 'W 4180 CC', 'Toyota', 'Alphard', 'Transformer', 2025, 'Putih', 7, 'Luxury MPV', 'Otomatis', 'Bensin', 2500000, 'Tersedia', 'CBG020'),
('KND030', 'L 6463 CC', 'Honda', 'Civic', 'Hatchback', 2024, 'Hitam', 5, 'Hatchback', 'Otomatis', 'Bensin', 1200000, 'Tersedia', 'CBG027');

-- E. DATA TRANSAKSI: PENYEWAAN (30)
INSERT INTO Penyewaan (ID_Penyewaan, ID_Pelanggan, ID_Kendaraan, ID_Pegawai, Tanggal_Pesan, Tanggal_Mulai_Sewa, Tanggal_Akhir_Sewa, Tanggal_Pengembalian, Total_Biaya, Kondisi_Kendaraan_Sebelum, Kondisi_Kendaraan_Sesudah, Status_Pengembalian) VALUES
('SEW001', 'PLG024', 'KND001', 'PGW021', '2026-03-01', '2026-03-05', '2026-03-10', '2026-03-10', 1750000, 'Mulus, BBM Full', 'Mulus, BBM Full', 'Selesai'),
('SEW002', 'PLG001', 'KND002', 'PGW012', '2026-01-18', '2026-01-21', '2026-01-24', '2026-01-25', 2400000, 'Mulus, AC Dingin', 'Lecet bemper depan', 'Terlambat'),
('SEW003', 'PLG024', 'KND003', 'PGW022', '2026-02-28', '2026-03-02', '2026-03-03', '2026-03-03', 450000, 'Bersih', 'Bersih', 'Selesai'),
('SEW004', 'PLG001', 'KND004', 'PGW011', '2026-02-15', '2026-02-18', '2026-02-23', '2026-02-24', 6000000, 'Normal', 'Normal', 'Terlambat'),
('SEW005', 'PLG028', 'KND005', 'PGW019', '2026-03-10', '2026-03-12', '2026-03-16', '2026-03-18', 4800000, 'Mulus', 'Mulus', 'Terlambat'),
('SEW006', 'PLG016', 'KND006', 'PGW021', '2026-02-28', '2026-03-01', '2026-03-03', '2026-03-03', 600000, 'Mulus', 'Mulus', 'Selesai'),
('SEW007', 'PLG016', 'KND007', 'PGW028', '2026-02-24', '2026-02-26', '2026-03-02', '2026-03-04', 2000000, 'Normal', 'Kotor interior', 'Terlambat'),
('SEW008', 'PLG012', 'KND008', 'PGW014', '2026-03-29', '2026-03-31', '2026-04-01', '2026-04-01', 300000, 'Mulus', 'Mulus', 'Selesai'),
('SEW009', 'PLG020', 'KND009', 'PGW021', '2026-01-18', '2026-01-20', '2026-01-25', '2026-01-25', 12500000, 'Sangat Mulus', 'Sangat Mulus', 'Selesai'),
('SEW010', 'PLG019', 'KND010', 'PGW004', '2026-01-12', '2026-01-14', '2026-01-19', '2026-01-19', 6000000, 'Mulus', 'Mulus', 'Selesai'),
('SEW011', 'PLG022', 'KND011', 'PGW016', '2026-02-24', '2026-02-26', '2026-03-02', '2026-03-03', 1400000, 'Normal', 'Normal', 'Terlambat'),
('SEW012', 'PLG001', 'KND012', 'PGW016', '2026-01-18', '2026-01-20', '2026-01-21', '2026-01-21', 800000, 'Bersih', 'Bersih', 'Selesai'),
('SEW013', 'PLG022', 'KND013', 'PGW009', '2026-03-16', '2026-03-18', '2026-03-21', '2026-03-22', 1350000, 'Normal', 'Ban serep terpakai', 'Terlambat'),
('SEW014', 'PLG009', 'KND014', 'PGW011', '2026-01-19', '2026-01-21', '2026-01-23', '2026-01-23', 2400000, 'Mulus', 'Mulus', 'Selesai'),
('SEW015', 'PLG011', 'KND015', 'PGW014', '2026-02-11', '2026-02-13', '2026-02-18', '2026-02-18', 6000000, 'Mulus', 'Mulus', 'Selesai'),
('SEW016', 'PLG001', 'KND016', 'PGW013', '2026-02-12', '2026-02-14', '2026-02-18', '2026-02-19', 1200000, 'Normal', 'Normal', 'Terlambat'),
('SEW017', 'PLG023', 'KND017', 'PGW016', '2026-01-26', '2026-01-28', '2026-01-29', '2026-01-30', 500000, 'Bersih', 'Kaca depan retak tipis', 'Terlambat'),
('SEW018', 'PLG030', 'KND018', 'PGW011', '2026-03-01', '2026-03-02', '2026-03-04', '2026-03-06', 600000, 'Mulus', 'Mulus', 'Terlambat'),
('SEW019', 'PLG013', 'KND019', 'PGW016', '2026-01-19', '2026-01-20', '2026-01-22', '2026-01-22', 5000000, 'Sangat Bersih', 'Sangat Bersih', 'Selesai'),
('SEW020', 'PLG002', 'KND020', 'PGW013', '2026-01-07', '2026-01-09', '2026-01-14', '2026-01-14', 6000000, 'Mulus', 'Mulus', 'Selesai'),
('SEW021', 'PLG021', 'KND021', 'PGW009', '2026-01-15', '2026-01-17', '2026-01-19', '2026-01-21', 700000, 'Normal', 'Normal', 'Terlambat'),
('SEW022', 'PLG025', 'KND022', 'PGW016', '2026-03-03', '2026-03-05', '2026-03-10', '2026-03-10', 4000000, 'Mulus', 'Mulus', 'Selesai'),
('SEW023', 'PLG023', 'KND023', 'PGW028', '2026-01-13', '2026-01-15', '2026-01-17', '2026-01-18', 900000, 'Bersih', 'Bersih', 'Terlambat'),
('SEW024', 'PLG018', 'KND024', 'PGW009', '2026-02-17', '2026-02-19', '2026-02-23', '2026-02-23', 4800000, 'Normal', 'Normal', 'Selesai'),
('SEW025', 'PLG018', 'KND025', 'PGW011', '2026-01-27', '2026-01-29', '2026-01-30', '2026-01-30', 1200000, 'Mulus', 'Mulus', 'Selesai'),
('SEW026', 'PLG006', 'KND026', 'PGW016', '2026-03-01', '2026-03-03', '2026-03-05', '2026-03-07', 600000, 'Mulus', 'Baret halus pintu kiri', 'Terlambat'),
('SEW027', 'PLG023', 'KND027', 'PGW021', '2026-03-22', '2026-03-24', '2026-03-26', '2026-03-26', 1000000, 'Normal', 'Normal', 'Selesai'),
('SEW028', 'PLG029', 'KND028', 'PGW016', '2026-02-13', '2026-02-15', '2026-02-18', '2026-02-19', 900000, 'Bersih', 'Bersih', 'Terlambat'),
('SEW029', 'PLG026', 'KND029', 'PGW008', '2026-03-26', '2026-03-28', '2026-03-31', '2026-04-01', 7500000, 'Sangat Mulus', 'Sangat Mulus', 'Terlambat'),
('SEW030', 'PLG016', 'KND030', 'PGW012', '2026-01-03', '2026-01-05', '2026-01-08', '2026-01-08', 3600000, 'Mulus', 'Mulus', 'Selesai');

-- F. DATA TRANSAKSI: DENDA (30)
INSERT INTO Denda (ID_Denda, Jumlah_Denda, Alasan, Status_Denda, ID_Penyewaan) VALUES
('DND001', 0, 'Tidak ada denda', 'Lunas', 'SEW001'),
('DND002', 350000, 'Keterlambatan 1 hari & lecet bodi', 'Belum Lunas', 'SEW002'),
('DND003', 0, 'Tidak ada denda', 'Lunas', 'SEW003'),
('DND004', 600000, 'Keterlambatan 1 hari', 'Lunas', 'SEW004'),
('DND005', 1200000, 'Keterlambatan 2 hari', 'Lunas', 'SEW005'),
('DND006', 0, 'Tidak ada denda', 'Lunas', 'SEW006'),
('DND007', 500000, 'Keterlambatan 2 hari', 'Belum Lunas', 'SEW007'),
('DND008', 0, 'Tidak ada denda', 'Lunas', 'SEW008'),
('DND009', 0, 'Tidak ada denda', 'Lunas', 'SEW009'),
('DND010', 0, 'Tidak ada denda', 'Lunas', 'SEW010'),
('DND011', 350000, 'Keterlambatan 1 hari', 'Belum Lunas', 'SEW011'),
('DND012', 0, 'Tidak ada denda', 'Lunas', 'SEW012'),
('DND013', 250000, 'Keterlambatan 1 hari', 'Lunas', 'SEW013'),
('DND014', 0, 'Tidak ada denda', 'Lunas', 'SEW014'),
('DND015', 0, 'Tidak ada denda', 'Lunas', 'SEW015'),
('DND016', 300000, 'Keterlambatan 1 hari', 'Belum Lunas', 'SEW016'),
('DND017', 750000, 'Keterlambatan 1 hari & retak kaca', 'Lunas', 'SEW017'),
('DND018', 300000, 'Keterlambatan 2 hari', 'Lunas', 'SEW018'),
('DND019', 0, 'Tidak ada denda', 'Lunas', 'SEW019'),
('DND020', 0, 'Tidak ada denda', 'Lunas', 'SEW020'),
('DND021', 350000, 'Keterlambatan 2 hari', 'Lunas', 'SEW021'),
('DND022', 0, 'Tidak ada denda', 'Lunas', 'SEW022'),
('DND023', 450000, 'Keterlambatan 1 hari', 'Lunas', 'SEW023'),
('DND024', 0, 'Tidak ada denda', 'Lunas', 'SEW024'),
('DND025', 0, 'Tidak ada denda', 'Lunas', 'SEW025'),
('DND026', 500000, 'Keterlambatan 2 hari & baret bodi', 'Lunas', 'SEW026'),
('DND027', 0, 'Tidak ada denda', 'Lunas', 'SEW027'),
('DND028', 300000, 'Keterlambatan 1 hari', 'Lunas', 'SEW028'),
('DND029', 2500000, 'Keterlambatan 1 hari', 'Lunas', 'SEW029'),
('DND030', 0, 'Tidak ada denda', 'Lunas', 'SEW030');

-- G. DATA TRANSAKSI: PEMBAYARAN (30)
INSERT INTO Pembayaran (ID_Pembayaran, Tanggal_Bayar, Metode_Bayar, Status_Bayar, ID_Penyewaan) VALUES
('PBY001', '2026-03-05', 'Tunai', 'Lunas', 'SEW001'),
('PBY002', '2026-01-21', 'Kartu Kredit', 'Lunas', 'SEW002'),
('PBY003', '2026-03-02', 'Kartu Kredit', 'Lunas', 'SEW003'),
('PBY004', '2026-02-18', 'QRIS', 'Lunas', 'SEW004'),
('PBY005', '2026-03-12', 'Transfer Bank', 'Lunas', 'SEW005'),
('PBY006', '2026-03-01', 'QRIS', 'Lunas', 'SEW006'),
('PBY007', '2026-02-26', 'Transfer Bank', 'Lunas', 'SEW007'),
('PBY008', '2026-03-31', 'Kartu Kredit', 'Lunas', 'SEW008'),
('PBY009', '2026-01-20', 'QRIS', 'Lunas', 'SEW009'),
('PBY010', '2026-01-14', 'QRIS', 'Lunas', 'SEW010'),
('PBY011', '2026-02-26', 'QRIS', 'Lunas', 'SEW011'),
('PBY012', '2026-01-20', 'QRIS', 'Lunas', 'SEW012'),
('PBY013', '2026-03-18', 'QRIS', 'Lunas', 'SEW013'),
('PBY014', '2026-01-21', 'Tunai', 'Lunas', 'SEW014'),
('PBY015', '2026-02-13', 'Tunai', 'Lunas', 'SEW015'),
('PBY016', '2026-02-14', 'Transfer Bank', 'Lunas', 'SEW016'),
('PBY017', '2026-01-28', 'Kartu Kredit', 'Lunas', 'SEW017'),
('PBY018', '2026-03-02', 'QRIS', 'Lunas', 'SEW018'),
('PBY019', '2026-01-20', 'QRIS', 'Lunas', 'SEW019'),
('PBY020', '2026-01-09', 'Tunai', 'Lunas', 'SEW020'),
('PBY021', '2026-01-17', 'Transfer Bank', 'Lunas', 'SEW021'),
('PBY022', '2026-03-05', 'Transfer Bank', 'Lunas', 'SEW022'),
('PBY023', '2026-01-15', 'QRIS', 'Lunas', 'SEW023'),
('PBY024', '2026-02-19', 'Kartu Kredit', 'Lunas', 'SEW024'),
('PBY025', '2026-01-29', 'QRIS', 'Lunas', 'SEW025'),
('PBY026', '2026-03-03', 'Transfer Bank', 'Lunas', 'SEW026'),
('PBY027', '2026-03-24', 'Transfer Bank', 'Lunas', 'SEW027'),
('PBY028', '2026-02-15', 'Transfer Bank', 'Lunas', 'SEW028'),
('PBY029', '2026-03-28', 'Kartu Kredit', 'Lunas', 'SEW029'),
('PBY030', '2026-01-05', 'QRIS', 'Lunas', 'SEW030');

-- H. DATA TRANSAKSI: TRACKING GPS (30)
INSERT INTO Tracking_GPS (ID_Tracking, Waktu, Latitude, Longitude, ID_Kendaraan) VALUES
('GPS001', '2026-05-16 14:30:00', -7.215266, 112.721473, 'KND001'),
('GPS002', '2026-05-16 14:31:00', -7.348651, 112.695328, 'KND002'),
('GPS003', '2026-05-16 14:32:00', -7.319349, 112.709562, 'KND003'),
('GPS004', '2026-05-16 14:33:00', -7.224192, 112.768140, 'KND004'),
('GPS005', '2026-05-16 14:34:00', -7.283110, 112.711033, 'KND005'),
('GPS006', '2026-05-16 14:35:00', -7.206688, 112.668832, 'KND006'),
('GPS007', '2026-05-16 14:36:00', -7.213899, 112.791334, 'KND007'),
('GPS008', '2026-05-16 14:37:00', -7.297314, 112.745582, 'KND008'),
('GPS009', '2026-05-16 14:38:00', -7.250993, 112.722108, 'KND009'),
('GPS010', '2026-05-16 14:39:00', -7.347313, 112.779430, 'KND010'),
('GPS011', '2026-05-16 14:40:00', -7.263847, 112.726811, 'KND011'),
('GPS012', '2026-05-16 14:41:00', -7.291452, 112.791062, 'KND012'),
('GPS013', '2026-05-16 14:42:00', -7.216183, 112.704104, 'KND013'),
('GPS014', '2026-05-16 14:43:00', -7.238779, 112.713076, 'KND014'),
('GPS015', '2026-05-16 14:44:00', -7.320070, 112.738753, 'KND015'),
('GPS016', '2026-05-16 14:45:00', -7.262635, 112.719307, 'KND016'),
('GPS017', '2026-05-16 14:46:00', -7.237129, 112.754199, 'KND017'),
('GPS018', '2026-05-16 14:47:00', -7.231671, 112.775953, 'KND018'),
('GPS019', '2026-05-16 14:48:00', -7.234289, 112.711452, 'KND019'),
('GPS020', '2026-05-16 14:49:00', -7.243779, 112.709419, 'KND020'),
('GPS021', '2026-05-16 14:50:00', -7.284742, 112.767576, 'KND021'),
('GPS022', '2026-05-16 14:51:00', -7.280486, 112.776648, 'KND022'),
('GPS023', '2026-05-16 14:52:00', -7.225441, 112.758021, 'KND023'),
('GPS024', '2026-05-16 14:53:00', -7.242459, 112.758197, 'KND024'),
('GPS025', '2026-05-16 14:54:00', -7.279782, 112.727705, 'KND025'),
('GPS026', '2026-05-16 14:55:00', -7.221455, 112.713350, 'KND026'),
('GPS027', '2026-05-16 14:56:00', -7.241151, 112.708931, 'KND027'),
('GPS028', '2026-05-16 14:57:00', -7.264911, 112.721110, 'KND028'),
('GPS029', '2026-05-16 14:58:00', -7.297241, 112.754964, 'KND029'),
('GPS030', '2026-05-16 14:59:00', -7.223668, 112.732968, 'KND030');