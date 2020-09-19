-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Aug 09, 2020 at 05:56 PM
-- Server version: 5.7.31
-- PHP Version: 7.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `k4154725_pdp_wisataku`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_kategori`
--

CREATE TABLE `tbl_kategori` (
  `id` int(11) NOT NULL,
  `nama_kategori` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_kategori`
--

INSERT INTO `tbl_kategori` (`id`, `nama_kategori`) VALUES
(1, 'Minuman'),
(2, 'Makanan khas'),
(3, 'Cepat saji'),
(4, 'Kue');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_komentar`
--

CREATE TABLE `tbl_komentar` (
  `id` int(11) NOT NULL,
  `komentar` text,
  `idMenu` int(11) DEFAULT NULL,
  `idUser` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_komentar`
--

INSERT INTO `tbl_komentar` (`id`, `komentar`, `idMenu`, `idUser`) VALUES
(1, 'Wah saya sangat suka makanan ini', 3, 12),
(2, 'Wah saya sangat suka makanan ini, keren dan bagus', 4, 10);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_menu`
--

CREATE TABLE `tbl_menu` (
  `id` int(11) NOT NULL,
  `namaMenu` text,
  `deskripsi` text,
  `harga` text,
  `tanggalinput` datetime DEFAULT NULL,
  `img` text NOT NULL,
  `idUser` int(11) DEFAULT NULL,
  `idKuliner` int(11) NOT NULL,
  `idKategoriMenu` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_menu`
--

INSERT INTO `tbl_menu` (`id`, `namaMenu`, `deskripsi`, `harga`, `tanggalinput`, `img`, `idUser`, `idKuliner`, `idKategoriMenu`) VALUES
(3, 'Ayam Krispi', 'Ayam krispi adalah emu andalan di resto kami', '50000', '2020-08-07 12:57:03', 'https://article.images.consumerreports.org/f_auto/prod/content/dam/CRO-Images-2020/Magazine/05May/CR-Health-Inlinehero-HealthyFastFood-3-20-v2', 10, 1, 2),
(4, 'Nasi Goreng', 'Ayam krispi adalah emu andalan di resto kami', '12000', '2020-08-07 12:57:45', 'https://media.timeout.com/images/105370171/750/422/image.jpg', 12, 2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_rating`
--

CREATE TABLE `tbl_rating` (
  `id` int(11) NOT NULL,
  `rating` text,
  `idUser` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_tempat_kuliner`
--

CREATE TABLE `tbl_tempat_kuliner` (
  `id` int(11) NOT NULL,
  `namaTempat` text,
  `alamat` text,
  `telepon` text,
  `latitude` text,
  `longitude` text,
  `jamBuka` text,
  `jamTutup` text,
  `img` text,
  `idWialayah` int(11) DEFAULT NULL,
  `idUser` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_tempat_kuliner`
--

INSERT INTO `tbl_tempat_kuliner` (`id`, `namaTempat`, `alamat`, `telepon`, `latitude`, `longitude`, `jamBuka`, `jamTutup`, `img`, `idWialayah`, `idUser`) VALUES
(1, 'Bakso Banteng', 'Jalan Banteng', '089693652230', '0', '0', '08-00', '20.00', 'www.google.com', 1, 11),
(2, 'Sate Rembige', 'Jalan Sudirman', '089693652230', '0', '0', '08-00', '20.00', 'www.google.com', 2, 11);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_wilayah`
--

CREATE TABLE `tbl_wilayah` (
  `id` int(11) NOT NULL,
  `namaWilayah` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_wilayah`
--

INSERT INTO `tbl_wilayah` (`id`, `namaWilayah`) VALUES
(1, 'Mataram'),
(2, 'Rembige');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` text,
  `password` text,
  `level` int(11) DEFAULT NULL,
  `nama` text,
  `status` int(11) DEFAULT NULL,
  `createdDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `level`, `nama`, `status`, `createdDate`) VALUES
(10, 'ahmad.subki1992@gmail.com', '123456', 1, 'Ahmad Subki	', 1, '2020-08-06 09:39:30'),
(11, 'aksestryout@gmail.com', '123456', 1, 'Irfandi', 1, '2020-08-06 15:01:04'),
(12, 'abdullah@gmail.com', '123456', 1, 'Abdullah', 1, '2020-08-07 07:37:40');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_kategori`
--
ALTER TABLE `tbl_kategori`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_komentar`
--
ALTER TABLE `tbl_komentar`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idMenu` (`idMenu`);

--
-- Indexes for table `tbl_menu`
--
ALTER TABLE `tbl_menu`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idUser` (`idUser`),
  ADD KEY `idKuliner` (`idKuliner`,`idKategoriMenu`);

--
-- Indexes for table `tbl_rating`
--
ALTER TABLE `tbl_rating`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idUser` (`idUser`);

--
-- Indexes for table `tbl_tempat_kuliner`
--
ALTER TABLE `tbl_tempat_kuliner`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idUser` (`idUser`),
  ADD KEY `idKecamatan` (`idWialayah`);

--
-- Indexes for table `tbl_wilayah`
--
ALTER TABLE `tbl_wilayah`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_kategori`
--
ALTER TABLE `tbl_kategori`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tbl_komentar`
--
ALTER TABLE `tbl_komentar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tbl_menu`
--
ALTER TABLE `tbl_menu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tbl_rating`
--
ALTER TABLE `tbl_rating`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_tempat_kuliner`
--
ALTER TABLE `tbl_tempat_kuliner`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tbl_wilayah`
--
ALTER TABLE `tbl_wilayah`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tbl_komentar`
--
ALTER TABLE `tbl_komentar`
  ADD CONSTRAINT `tbl_komentar_ibfk_1` FOREIGN KEY (`idMenu`) REFERENCES `tbl_menu` (`id`);

--
-- Constraints for table `tbl_menu`
--
ALTER TABLE `tbl_menu`
  ADD CONSTRAINT `tbl_menu_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `users` (`id`);

--
-- Constraints for table `tbl_rating`
--
ALTER TABLE `tbl_rating`
  ADD CONSTRAINT `tbl_rating_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `users` (`id`);

--
-- Constraints for table `tbl_tempat_kuliner`
--
ALTER TABLE `tbl_tempat_kuliner`
  ADD CONSTRAINT `tbl_tempat_kuliner_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
