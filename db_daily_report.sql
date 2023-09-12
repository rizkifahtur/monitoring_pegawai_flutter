-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 30, 2022 at 09:56 AM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 7.3.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_daily_report`
--

-- --------------------------------------------------------

--
-- Table structure for table `tb_income`
--

CREATE TABLE `tb_income` (
  `id_income` int(11) NOT NULL,
  `pendapatan` int(25) NOT NULL,
  `date` date NOT NULL,
  `keterangan` text NOT NULL,
  `id_user` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tb_income`
--

INSERT INTO `tb_income` (`id_income`, `pendapatan`, `date`, `keterangan`, `id_user`) VALUES
(1, 2000000, '2022-10-11', 'Pendapatan Jam 10', 8),
(4, 3000000, '2022-10-12', 'Pendapatan Jam 2', 8),
(5, 650000, '2022-10-12', 'Pendapatan Jam 8', 8),
(6, 500000, '2022-11-25', 'Pendapatan jam 12', 8),
(7, 800000, '2022-12-13', 'jam 2', 8);

-- --------------------------------------------------------

--
-- Table structure for table `tb_job`
--

CREATE TABLE `tb_job` (
  `id_job` varchar(10) NOT NULL,
  `job_name` varchar(50) NOT NULL,
  `salary` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tb_job`
--

INSERT INTO `tb_job` (`id_job`, `job_name`, `salary`) VALUES
('ad', 'Admin', 0),
('csr', 'Cashier', 3400000),
('inv', 'Inventory', 3200000),
('op', 'Operator', 4000000),
('st', 'Sales Team', 3100000);

-- --------------------------------------------------------

--
-- Table structure for table `tb_notif`
--

CREATE TABLE `tb_notif` (
  `id_notif` int(11) NOT NULL,
  `task_name` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `id_user` int(11) NOT NULL,
  `progress` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tb_notif`
--

INSERT INTO `tb_notif` (`id_notif`, `task_name`, `description`, `id_user`, `progress`) VALUES
(1, '6', '6', 4, 50),
(2, 'Rapikan Pajangan', 'Merapikan Pajangan Insight', 4, 50),
(3, 'Rapikan Pajangan', 'Merapikan Pajangan Insight', 4, 100),
(4, 'Merubah Visual Display', 'Merubah Visual Display Brand DC', 4, 50),
(5, 'Merubah Visual Display', 'Merubah Visual Display Brand DC', 4, 100),
(6, 'Cleaning Cashier', 'bersihkan area kasir', 8, 100);

-- --------------------------------------------------------

--
-- Table structure for table `tb_resi`
--

CREATE TABLE `tb_resi` (
  `id_resi` int(11) NOT NULL,
  `kd_resi` varchar(50) NOT NULL,
  `keterangan` text NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tb_resi`
--

INSERT INTO `tb_resi` (`id_resi`, `kd_resi`, `keterangan`, `date`) VALUES
(5, '200222', 'Barang Masuk Spider Bilt - XPS Link', '2022-10-07'),
(6, '11828', 'Barang Keluar Return Insight - JNE', '2022-10-07'),
(7, '78999', 'Barang Masuk Brand Spyderbilt', '2022-11-25'),
(8, '8930477', 'Barang Masuk Brand Insight', '2022-11-25'),
(9, '29292', 'barang keluar', '2022-11-29'),
(10, '237784012', 'barang masuk', '2022-11-29'),
(11, '283810239', 'barang masuk', '2022-11-29'),
(12, '2738912', 'barang masuk', '2022-11-29'),
(13, '123891238', 'barang keluar', '2022-12-13'),
(14, '29377499', 'Barang Keluar Brand Insight', '2022-12-19'),
(15, '23799488', 'Barang Keluar brand Insight', '2022-12-19');

-- --------------------------------------------------------

--
-- Table structure for table `tb_respon`
--

CREATE TABLE `tb_respon` (
  `kd_respon` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `score` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tb_respon`
--

INSERT INTO `tb_respon` (`kd_respon`, `id_user`, `name`, `score`) VALUES
(1, 4, 'Maulana Iskandar', 600),
(2, 8, 'Sri Marfuah', 12100),
(3, 11, 'Tantri Wulandari', 0),
(4, 14, 'Rizal', 0),
(6, 16, 'Rizki', 0),
(8, 18, 'juan', 0);

-- --------------------------------------------------------

--
-- Table structure for table `tb_task`
--

CREATE TABLE `tb_task` (
  `id_task` int(11) NOT NULL,
  `task_name` text NOT NULL,
  `description` text NOT NULL,
  `progress` double NOT NULL,
  `id_user` int(11) NOT NULL,
  `image` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tb_task`
--

INSERT INTO `tb_task` (`id_task`, `task_name`, `description`, `progress`, `id_user`, `image`) VALUES
(29, 'Grooming Baju', 'Baju Kaos Quick Silver', 100, 16, '321853a1-bfca-4dbc-a48f-53cc3c99d42b'),
(30, 'Grooming Display Celana', 'Di Brand Quick Silver', 100, 16, 'f01f4f9c-0119-4e5e-9975-0d9fe7c47e57'),
(32, '2', '2', 100, 4, '76fa8259-f1f7-4b8b-905a-3876ec9f1023'),
(33, '1', '1', 100, 4, '41adf6b0-fb04-451c-8cc4-44bf90f35f5d'),
(34, '4', '4', 100, 4, 'b4c8e105-71a3-4969-824d-b99ba6b02a4d'),
(35, '5', '5', 100, 4, '43a3ae05-fbe9-439f-a609-b08aed498f3a'),
(38, 'Merubah Visual Display', 'Merubah Visual Display Brand DC', 100, 4, '5ea3dc0b-6df9-4d4a-983a-69d840b63aea'),
(39, 'Cleaning Cashier', 'bersihkan area kasir', 100, 8, 'a8ed13f7-cf14-468a-932a-459eb8fd2579');

--
-- Triggers `tb_task`
--
DELIMITER $$
CREATE TRIGGER `user_notif` AFTER UPDATE ON `tb_task` FOR EACH ROW INSERT INTO tb_notif SET task_name=new.task_name, description=new.description, id_user=new.id_user, progress=new.progress
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tb_user`
--

CREATE TABLE `tb_user` (
  `id_user` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `nohp` varchar(20) NOT NULL,
  `pass` varchar(50) NOT NULL,
  `role` varchar(20) NOT NULL,
  `address` text NOT NULL,
  `id_job` varchar(10) NOT NULL,
  `reward` text NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tb_user`
--

INSERT INTO `tb_user` (`id_user`, `name`, `nohp`, `pass`, `role`, `address`, `id_job`, `reward`, `description`) VALUES
(1, 'Admin', '0891', '202cb962ac59075b964b07152d234b70', 'Admin', 'Jl. Admin', 'ad', '', ''),
(3, 'Ari Hamzah', '0892', '202cb962ac59075b964b07152d234b70', 'Operator', 'Jl. Kayu Manis No.35', 'op', '', ''),
(4, 'Maulana Iskandar', '0893', '202cb962ac59075b964b07152d234b70', 'Pegawai', 'Jl. Tiung Ujung No.122', 'inv', 'Reward', 'uang tunai 100.000'),
(8, 'Sri Marfuah', '0894', '202cb962ac59075b964b07152d234b70', 'Pegawai', 'Jl. Pepaya Ujung No.20a', 'csr', '', ''),
(11, 'Tantri Wulandari', '0895', '202cb962ac59075b964b07152d234b70', 'Pegawai', 'Jl. Harapan Raya No.145', 'st', '', ''),
(14, 'Rizal', '0897', '202cb962ac59075b964b07152d234b70', 'Pegawai', 'Jl. Pelajar', 'st', '', '');

--
-- Triggers `tb_user`
--
DELIMITER $$
CREATE TRIGGER `user_respon` AFTER INSERT ON `tb_user` FOR EACH ROW INSERT INTO tb_respon SET id_user=new.id_user, name=new.name
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tb_income`
--
ALTER TABLE `tb_income`
  ADD PRIMARY KEY (`id_income`);

--
-- Indexes for table `tb_job`
--
ALTER TABLE `tb_job`
  ADD PRIMARY KEY (`id_job`);

--
-- Indexes for table `tb_notif`
--
ALTER TABLE `tb_notif`
  ADD PRIMARY KEY (`id_notif`);

--
-- Indexes for table `tb_resi`
--
ALTER TABLE `tb_resi`
  ADD PRIMARY KEY (`id_resi`);

--
-- Indexes for table `tb_respon`
--
ALTER TABLE `tb_respon`
  ADD PRIMARY KEY (`kd_respon`);

--
-- Indexes for table `tb_task`
--
ALTER TABLE `tb_task`
  ADD PRIMARY KEY (`id_task`);

--
-- Indexes for table `tb_user`
--
ALTER TABLE `tb_user`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tb_income`
--
ALTER TABLE `tb_income`
  MODIFY `id_income` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `tb_notif`
--
ALTER TABLE `tb_notif`
  MODIFY `id_notif` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tb_resi`
--
ALTER TABLE `tb_resi`
  MODIFY `id_resi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `tb_respon`
--
ALTER TABLE `tb_respon`
  MODIFY `kd_respon` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `tb_task`
--
ALTER TABLE `tb_task`
  MODIFY `id_task` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `tb_user`
--
ALTER TABLE `tb_user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
