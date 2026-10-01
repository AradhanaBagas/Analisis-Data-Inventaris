-- menambahkan bulan Januari 2025 ke tabel
INSERT INTO inventaris_penggunaanalat (Tanggal_Sewa, Jenis_Pemakaian, Jumlah, Durasi, Pemasukan_Total, Pemasukan_ke_Organisasi)
VALUES 
('2024-11-01', 'Internal', 0, 0, 0, 0),
('2025-01-01', 'Sewa', 0, 0, 0, 0),
('2025-01-01', 'Internal', 0, 0, 0, 0);

SELECT * FROM inventaris_penggunaanalat
ORDER BY Tanggal_Sewa;

-- mengelompokkan harga beli sesuai jenis alat
CREATE TABLE inventaris_dataalat_perjenis AS
SELECT jenis, sum(harga_beli) AS "nilai"
FROM inventaris_dataalat
GROUP BY jenis;

SELECT * FROM inventaris_dataalat_perjenis;

-- mengelompokkan biaya service masing-masing jenis alat
CREATE TABLE inventaris_maintenancealat_perjenis AS
SELECT alat_yg_diservice, sum(biaya) 
AS biaya_service
FROM inventaris_maintenancealat
WHERE alat_yg_diservice != ""
GROUP BY alat_yg_diservice;

SELECT * FROM inventaris_maintenancealat_perjenis;
    
-- mengelompokkan jumlah sewa dan pemasukan bersih masing-masing jenis alat
CREATE TABLE inventaris_sewaalat_perjenis AS
SELECT alat, sum(jumlah * durasi) AS jumlah_sewa, 
	sum(pemasukan_ke_organisasi) AS pemasukan
    FROM inventaris_penggunaanalat
    WHERE jenis_pemakaian = "sewa"
    GROUP BY alat;

-- mengelompokkan jumlah pemakaian internal masing-masing jenis alat
CREATE TABLE inventaris_internaluse_perjenis AS
SELECT alat AS alat_internal, sum(jumlah * durasi) AS jumlah_pemakaian
    FROM inventaris_penggunaanalat
    WHERE jenis_pemakaian = "internal"
    GROUP BY alat;

-- membuat view gabungan keempat kelompok data sebelumnya utk ditampilkan di Power BI
CREATE VIEW sektor_finansial AS
SELECT 
	jenis, nilai, coalesce(biaya_service,0) AS biaya_service, 
    coalesce(jumlah_sewa,0) AS jumlah_sewa, coalesce(pemasukan,0) AS pemasukan, 
    coalesce(jumlah_pemakaian,0) AS jumlah_pemakaian, 
    coalesce(pemasukan,0)/(nilai + coalesce(biaya_service,0)) AS ROI 
FROM inventaris_dataalat_perjenis
LEFT JOIN inventaris_maintenancealat_perjenis
	ON jenis = alat_yg_diservice
LEFT JOIN inventaris_sewaalat_perjenis
	ON jenis = alat
LEFT JOIN inventaris_internaluse_perjenis
	ON jenis = alat_internal;

-- membuat view penggunaan alat
CREATE VIEW penggunaan_alat AS
SELECT
	DATE_FORMAT(tanggal_sewa, '%Y-%m') AS Bulan,
    Alat, Jenis_Pemakaian,
    Jumlah*Durasi AS Volume,
    Pengguna, PJ_Inventaris, Pemasukan_ke_Organisasi
FROM inventaris_penggunaanalat;