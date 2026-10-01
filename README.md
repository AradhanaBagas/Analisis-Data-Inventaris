# Analisis Data Inventaris : Analisis Manajemen Aset Inventaris Unit Kegiatan Mahasiswa (UKM) Jazz untuk Meninjau Performa Aset

## Latar Belakang
Aset adalah segala sumber daya yang dimiliki atau dikendalikan individu, perusahaan, atau organisasi, dan memiliki manfaat ekonomi di masa depan. Berdasarkan wujudnya, aset dibagi menjadi 2 kelompok, yakni aset berwujud dan aset tidak berwujud. Contoh aset berwujud adalah peralatan, tanah, bangunan, dll. Contoh aset tidak berwujud adalah hak cipta, paten, merek dagang, dll.

Dalam konteks organisasi/unit kegiatan mahasiswa, khususnya dalam bidang musik, aset berwujud yang seringkali dimiliki organisasi tersebut adalah alat musik dan soundsystem. Selain digunakan untuk keperluan internal, tak jarang aset tersebut disewakan kepada pihak eksternal guna memberikan pemasukan langsung kepada organisasi. Meski dapat disewakan dan menghasilkan pemasukan, nilai aset dapat menurun akibat pemakaian seiring berjalannya waktu. Penurunan nilai aset akan semakin besar jika aset tersebut tidak dirawat dengan benar. Oleh karena itu, penting untuk melakukan perawatan berkala terhadap aset tersebut guna meminimalkan penurunan nilai dan memastikan aset tersebut tetap dapat digunakan dengan baik.

Proyek analisis data ini bertujuan untuk meninjau performa aset milik organisasi dari sudut pandang **Financial** (biaya perawatan, profitabilitas, dan *return of investment*) serta **Operasional** (tingkat utilisasi, ketersediaan alat, tren penyewaan) selama satu periode kepengurusan (2024-2025). Hasil dari analisis ini dapat digunakan untuk mengoptimalkan performa aset organisasi di periode-periode yang akan datang.

## Tools yang Digunakan
Dalam proyek ini, tools yang digunakan adalah sebagai berikut:
* **CSV:** Digunakan sebagai tempat menyimpan data mentah (master sheet data alat, data maintenance alat, dan data penggunaan alat) yang akan diolah menggunakan SQL.
* **SQL:** Digunakan untuk mengolah, menggabungkan, dan mengekstraksi data mentah menjadi data yang siap divisualisasikan di Power BI.
* **Power BI:** Digunakan untuk merancang dashboard visualisasi data yang sudah diolah sebelumnya.

## Struktur Repository
```text
├── Data Mentah/
│   ├── Inventaris_DataAlat/                           # Mastersheet data alat (CSV)
|   ├── Inventaris_MaintenanceAlat/                    # Data maintenance alat (CSV)
│   └── Inventaris_PenggunaanAlat/                     # Data penggunaan alat (CSV)
├── Script/
│   └── pengolahan_data_inventaris.sql                 # Query SQL untuk pengolahan, penggabungan, dan ekstraksi data
├── Dashboard/
│   ├── Dashboard Manajemen Inventaris.pbix            # File sumber Power BI
│   └── Screenshot Dashboard Manajemen Inventaris.png  # Screenshot tampilan hasil akhir dashboard
└── README.md
```

## Kesimpulan
Berdasarkan hasil analisis, didapatkan kesimpulan sebagai berikut.
1. **Performa Finansial:** Secara keseluruhan, portofolio aset menghasilkan **RoI sebesar 10.96%** dengan total pemasukan mencapai Rp8.93 Juta. 
2. **Profitabilitas Aset:** **Keyboard** merupakan aset dengan tingkat profitabilitas tertinggi, yakni 22.13%. Di sisi lain, **Drum** menyumbang nilai pemasukan terbesar, yakni Rp Rp3.3 Juta.
3. **Operasional:** Terdapat lonjakan ekstrem untuk penggunaan internal pada bulan **Maret 2025** yakni mencapai 65 penggunaan, kemungkinan akibat banyaknya kegiatan internal pada periode tersebut. Hal ini menuntut adanya perencanaan alokasi barang (*inventory planning*) yang ketat untuk menghindari bentrok dengan jadwal penyewaan eksternal.
4. **Peluang Bisnis:** "Unit Kegiatan Mahasiswa (UKM) Sunda" dan "Himpunan Mahasiswa (HM) Bisnis Manajemen" adalah penyumbang pendapatan sewa terbesar, masing-masing di angka Rp1.95 Juta dan Rp1.79 Juta. Keduanya juga merupakan penyumbang volume sewa terbesar, masing-masing sebesar 10 buah sewa. Hal ini dapat dipertahankan atau bahkan ditingkatkan dengan adanya strategi *customer retention* untuk kedua pihak tersebut, misalnya melalui diskon loyalitas, penjalinan kerjasama atau kolaborasi antar organisasi, dll.

## Evaluasi dan Saran
Dalam proses *Data Engineering* pada proyek ini, terdapat penanganan khusus untuk data deret waktu, tepatnya pada bagian penggunaan alat. Untuk memastikan bulan yang tidak memiliki transaksi atau penggunaan internal (November 2024 dan Januari 2025) tetap muncul di grafik Power BI dengan nilai `0`, dilakukan `INSERT INTO` data transaksi bernilai `0` ke dalam tabel utama menggunakan SQL. Metode tersebut berhasil dalam proyek ini. Namun, untuk proyek-proyek mendatang, terlebih untuk proyek bisnis berskala besar, menyuntikkan *dummy data* ke tabel operasional tidak disarankan. Pendekatan yang lebih ideal adalah menggunakan **Common Table Expressions (CTE)** di SQL untuk melakukan *LEFT JOIN* dengan tabel referensi bulan, atau menggunakan **DimDate (Calendar Table) mapping** secara langsung menggunakan DAX di Power BI.
