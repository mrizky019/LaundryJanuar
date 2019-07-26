/*
SQLyog Ultimate v11.33 (64 bit)
MySQL - 10.1.33-MariaDB : Database - laundry_januar
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`laundry_januar` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `laundry_januar`;

/*Table structure for table `aktivitas` */

DROP TABLE IF EXISTS `aktivitas`;

CREATE TABLE `aktivitas` (
  `id_aktivitas` char(5) NOT NULL,
  `nama` varchar(250) NOT NULL,
  `deskripsi` text,
  PRIMARY KEY (`id_aktivitas`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `aktivitas` */

insert  into `aktivitas`(`id_aktivitas`,`nama`,`deskripsi`) values ('A0001','Cuci','-'),('A0002','Setrika','-'),('A0003','Setrika Uap','-');

/*Table structure for table `aktivitas_laundry` */

DROP TABLE IF EXISTS `aktivitas_laundry`;

CREATE TABLE `aktivitas_laundry` (
  `id_aktivitas_laundry` char(30) NOT NULL,
  `id_detail_laundry` char(25) NOT NULL,
  `id_aktivitas` char(5) NOT NULL,
  `id_pegawai` char(5) DEFAULT NULL,
  `mulai_pengerjaan` datetime DEFAULT NULL,
  `selesai` datetime DEFAULT NULL,
  PRIMARY KEY (`id_aktivitas_laundry`,`id_detail_laundry`,`id_aktivitas`),
  KEY `fk_relationship_13` (`id_aktivitas`),
  KEY `fk_relationship_29` (`id_pegawai`),
  KEY `id_detail_laundry` (`id_detail_laundry`),
  CONSTRAINT `aktivitas_laundry_ibfk_1` FOREIGN KEY (`id_detail_laundry`) REFERENCES `detail_laundry` (`id_detail_laundry`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_relationship_13` FOREIGN KEY (`id_aktivitas`) REFERENCES `aktivitas` (`id_aktivitas`),
  CONSTRAINT `fk_relationship_29` FOREIGN KEY (`id_pegawai`) REFERENCES `pegawai` (`id_pegawai`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `aktivitas_laundry` */

insert  into `aktivitas_laundry`(`id_aktivitas_laundry`,`id_detail_laundry`,`id_aktivitas`,`id_pegawai`,`mulai_pengerjaan`,`selesai`) values ('ADTR20190723000000000100010001','DTR2019072300000000010001','A0001','P0019','2019-07-23 14:41:14','2019-07-23 14:43:27'),('ADTR20190723000000000100010002','DTR2019072300000000010001','A0002','P0002','2019-07-23 15:42:20','2019-07-23 17:26:16'),('ADTR20190723000000000200010001','DTR2019072300000000020001','A0001','P0001','2019-07-23 17:28:56','2019-07-23 17:29:10'),('ADTR20190723000000000200010002','DTR2019072300000000020001','A0002','P0005','2019-07-23 17:29:03','2019-07-23 17:29:11'),('ADTR20190723000000000300010001','DTR2019072300000000030001','A0003','P0006','2019-07-23 17:38:25','2019-07-23 17:38:29'),('ADTR20190724000000000100010001','DTR2019072400000000010001','A0003','P0008','2019-07-24 14:20:18','2019-07-24 14:20:20');

/*Table structure for table `aktivitas_menu` */

DROP TABLE IF EXISTS `aktivitas_menu`;

CREATE TABLE `aktivitas_menu` (
  `id_aktivitas` char(5) NOT NULL,
  `id_menu` char(8) NOT NULL,
  PRIMARY KEY (`id_aktivitas`,`id_menu`),
  KEY `fk_memiliki2` (`id_menu`),
  CONSTRAINT `fk_memiliki` FOREIGN KEY (`id_aktivitas`) REFERENCES `aktivitas` (`id_aktivitas`),
  CONSTRAINT `fk_memiliki2` FOREIGN KEY (`id_menu`) REFERENCES `menu` (`id_menu`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `aktivitas_menu` */

insert  into `aktivitas_menu`(`id_aktivitas`,`id_menu`) values ('A0001','00001'),('A0001','00002'),('A0002','00001'),('A0002','00002'),('A0003','00003');

/*Table structure for table `cabang` */

DROP TABLE IF EXISTS `cabang`;

CREATE TABLE `cabang` (
  `id_cabang` char(5) NOT NULL,
  `alamat` text NOT NULL,
  `no_tlp` varchar(20) NOT NULL,
  PRIMARY KEY (`id_cabang`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `cabang` */

insert  into `cabang`(`id_cabang`,`alamat`,`no_tlp`) values ('C0001','Jl Kapuk Muara 7 Kompl Duta Harapan Indah Bl D/12,Kapuk Muara, Penjaringan, Jakarta','02156958842'),('C0002','Jl Panataran 9,Pegangsaan, Menteng, Jakarta','0213161952'),('C0003','Jl. Rasuna Said No. 1 Cipete, Banten, Tangerang','02173691665'),('C0004','Jl Gajah Mada 16 J,Glodok, Taman Sari, Jakarta','0218671379'),('C0005','Tanjung Duren Utara 900, Grogol Petamburan, Jakarta barat 11460, Dki Jakarta','0217256815');

/*Table structure for table `cash_flow_cabang` */

DROP TABLE IF EXISTS `cash_flow_cabang`;

CREATE TABLE `cash_flow_cabang` (
  `id_cash_flow_cabang` char(20) NOT NULL,
  `id_cabang` char(5) NOT NULL,
  `id_cash_type` int(10) unsigned NOT NULL,
  `tanggal` datetime NOT NULL,
  `jumlah` decimal(18,2) NOT NULL,
  `catatan` text NOT NULL,
  PRIMARY KEY (`id_cash_flow_cabang`),
  KEY `id_cabang` (`id_cabang`),
  KEY `id_cash_type` (`id_cash_type`),
  CONSTRAINT `cash_flow_cabang_ibfk_1` FOREIGN KEY (`id_cabang`) REFERENCES `cabang` (`id_cabang`) ON UPDATE CASCADE,
  CONSTRAINT `cash_flow_cabang_ibfk_2` FOREIGN KEY (`id_cash_type`) REFERENCES `cash_type` (`id_cash_type`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `cash_flow_cabang` */

insert  into `cash_flow_cabang`(`id_cash_flow_cabang`,`id_cabang`,`id_cash_type`,`tanggal`,`jumlah`,`catatan`) values ('CB120181220000000001','C0001',1,'2018-12-20 11:53:50','500000.00','Sukses'),('CB120181220000000002','C0002',1,'2018-12-20 12:33:22','500000.00','Sukses'),('CB120181220000000003','C0001',1,'2018-12-20 13:01:03','500000.00','Sukses'),('CB120190102000000001','C0001',1,'2019-01-02 20:27:34','20000.00','OK'),('CB120190102000000002','C0002',1,'2019-01-02 20:28:53','520000.00','OK'),('CB120190102000000003','C0003',1,'2019-01-02 20:32:15','50000.00','OK'),('CB120190106000000001','C0005',1,'2019-01-06 16:26:26','12000.00','Transaksi Laundry : ID_TRANSAKSI = [TR201811010000000006]'),('CB120190724000000001','C0004',1,'2019-07-24 13:00:17','63000.00','Transaksi Laundry : ID_TRANSAKSI = [TR201907230000000003]'),('CB120190724000000002','C0004',1,'2019-07-24 13:00:36','36000.00','Transaksi Laundry : ID_TRANSAKSI = [TR201907230000000002]'),('CB120190724000000003','C0004',1,'2019-07-24 13:04:47','60000.00','Transaksi Laundry : ID_TRANSAKSI = [TR201907230000000001]'),('CB120190724000000004','C0004',1,'2019-07-24 14:20:06','105000.00','Transaksi Laundry : ID_TRANSAKSI = [TR201907240000000001]'),('CB220181220000000001','C0001',2,'2018-12-20 13:16:23','500000.00','Sukses'),('CB220190102000000001','C0001',2,'2019-01-02 20:28:10','1000.00','OK'),('CB220190102000000002','C0002',2,'2019-01-02 20:28:55','320000.00','OK'),('CB220190102000000003','C0003',2,'2019-01-02 20:29:42','30000.00','OK');

/*Table structure for table `cash_flow_hq` */

DROP TABLE IF EXISTS `cash_flow_hq`;

CREATE TABLE `cash_flow_hq` (
  `id_cash_flow_hq` char(20) NOT NULL,
  `id_hq` char(5) NOT NULL,
  `id_cash_type` int(10) unsigned NOT NULL,
  `tanggal` datetime NOT NULL,
  `jumlah` decimal(18,2) NOT NULL,
  `catatan` text NOT NULL,
  PRIMARY KEY (`id_cash_flow_hq`,`id_hq`),
  KEY `id_hq` (`id_hq`),
  KEY `id_cash_type` (`id_cash_type`),
  CONSTRAINT `cash_flow_hq_ibfk_1` FOREIGN KEY (`id_hq`) REFERENCES `hq` (`id_hq`) ON UPDATE CASCADE,
  CONSTRAINT `cash_flow_hq_ibfk_2` FOREIGN KEY (`id_cash_type`) REFERENCES `cash_type` (`id_cash_type`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `cash_flow_hq` */

insert  into `cash_flow_hq`(`id_cash_flow_hq`,`id_hq`,`id_cash_type`,`tanggal`,`jumlah`,`catatan`) values ('HQ120181101000000002','HQ001',1,'2018-11-01 20:29:05','350000.00','Sukses'),('HQ120181112000000001','HQ001',1,'2018-11-12 00:00:00','3500000.00','Sukses'),('HQ120181220000000001','HQ001',1,'2018-12-20 13:35:02','500000.00','Sukses'),('HQ120181227000000001','HQ001',1,'2018-12-27 12:10:53','50000.00','KAS'),('HQ120181227000000002','HQ001',1,'2018-12-27 20:37:09','3500000.00','Sukses'),('HQ220181220000000001','HQ001',2,'2018-11-20 13:36:55','500000.00','Sukses'),('HQ220181227000000001','HQ001',2,'2018-12-27 12:11:30','25000.00','GANTI RUGI'),('HQ220190106000000001','HQ001',2,'2019-01-06 17:44:35','4100000.00','Transaksi Pembelian : ID_PEMBELIAN = [P2018100100000000001]');

/*Table structure for table `cash_type` */

DROP TABLE IF EXISTS `cash_type`;

CREATE TABLE `cash_type` (
  `id_cash_type` int(10) unsigned NOT NULL,
  `nama` varchar(250) NOT NULL,
  `deskripsi` text NOT NULL,
  PRIMARY KEY (`id_cash_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `cash_type` */

insert  into `cash_type`(`id_cash_type`,`nama`,`deskripsi`) values (1,'IN','CASH IN'),(2,'OUT','CASH OUT');

/*Table structure for table `convert_item` */

DROP TABLE IF EXISTS `convert_item`;

CREATE TABLE `convert_item` (
  `id_convert_item` char(20) NOT NULL,
  `id_hq` char(5) NOT NULL,
  `id_item` char(10) NOT NULL,
  `id_reference` char(20) DEFAULT NULL,
  `id_convert_type` char(5) NOT NULL,
  `id_uom_converter` char(5) NOT NULL,
  `quantitiy` decimal(5,2) NOT NULL,
  `tanggal` datetime NOT NULL,
  PRIMARY KEY (`id_convert_item`),
  KEY `fk_relationship_31` (`id_item`),
  KEY `fk_relationship_33` (`id_hq`),
  KEY `fk_relationship_36` (`id_uom_converter`),
  KEY `id_convert_type` (`id_convert_type`),
  KEY `id_reference` (`id_reference`),
  CONSTRAINT `convert_item_ibfk_1` FOREIGN KEY (`id_convert_type`) REFERENCES `convert_type` (`id_convert_type`),
  CONSTRAINT `convert_item_ibfk_2` FOREIGN KEY (`id_reference`) REFERENCES `convert_item` (`id_convert_item`),
  CONSTRAINT `fk_relationship_31` FOREIGN KEY (`id_item`) REFERENCES `item` (`id_item`),
  CONSTRAINT `fk_relationship_33` FOREIGN KEY (`id_hq`) REFERENCES `hq` (`id_hq`),
  CONSTRAINT `fk_relationship_36` FOREIGN KEY (`id_uom_converter`) REFERENCES `uom_converter` (`id_uom_converter`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `convert_item` */

insert  into `convert_item`(`id_convert_item`,`id_hq`,`id_item`,`id_reference`,`id_convert_type`,`id_uom_converter`,`quantitiy`,`tanggal`) values ('CI201810300000000001','HQ001','I000000001','CI201810300000000004','CT001','C0003','3.00','2018-10-30 01:08:02'),('CI201810300000000002','HQ001','I000000001','CI201810300000000003','CT001','C0003','5.00','2018-10-30 01:08:02'),('CI201810300000000003','HQ001','I000000003','CI201810300000000002','CT002','C0003','100.00','2018-10-30 01:08:02'),('CI201810300000000004','HQ001','I000000003','CI201810300000000001','CT002','C0003','60.00','2018-10-30 01:08:02');

/*Table structure for table `convert_type` */

DROP TABLE IF EXISTS `convert_type`;

CREATE TABLE `convert_type` (
  `id_convert_type` char(5) NOT NULL,
  `nama` varchar(250) NOT NULL,
  PRIMARY KEY (`id_convert_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `convert_type` */

insert  into `convert_type`(`id_convert_type`,`nama`) values ('CT001','Menggunakan Barang'),('CT002','Menghasilkan barang');

/*Table structure for table `detail_laundry` */

DROP TABLE IF EXISTS `detail_laundry`;

CREATE TABLE `detail_laundry` (
  `id_detail_laundry` char(25) NOT NULL,
  `id_transaksi_laundry` char(20) NOT NULL,
  `id_menu` char(8) NOT NULL,
  `id_harga_menu` bigint(20) unsigned NOT NULL,
  `quantity` double NOT NULL,
  `real_quantity` double NOT NULL,
  `info` text,
  PRIMARY KEY (`id_detail_laundry`,`id_transaksi_laundry`,`id_menu`,`id_harga_menu`),
  KEY `fk_relationship_14` (`id_menu`),
  KEY `fk_relationship_11` (`id_transaksi_laundry`),
  KEY `id_harga_menu` (`id_harga_menu`),
  CONSTRAINT `detail_laundry_ibfk_1` FOREIGN KEY (`id_harga_menu`) REFERENCES `harga_menu` (`id_harga_menu`),
  CONSTRAINT `fk_relationship_11` FOREIGN KEY (`id_transaksi_laundry`) REFERENCES `transaksi_laundry` (`id_transaksi_laundry`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_relationship_14` FOREIGN KEY (`id_menu`) REFERENCES `menu` (`id_menu`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `detail_laundry` */

insert  into `detail_laundry`(`id_detail_laundry`,`id_transaksi_laundry`,`id_menu`,`id_harga_menu`,`quantity`,`real_quantity`,`info`) values ('DTR2019072300000000010001','TR201907230000000001','00002',2,5,5,'-'),('DTR2019072300000000020001','TR201907230000000002','00002',2,3,2,'iiii'),('DTR2019072300000000030001','TR201907230000000003','00003',4,3,3,'ok'),('DTR2019072400000000010001','TR201907240000000001','00003',4,5,5,'zzz');

/*Table structure for table `detail_pembelian` */

DROP TABLE IF EXISTS `detail_pembelian`;

CREATE TABLE `detail_pembelian` (
  `id_pembelian` char(20) NOT NULL,
  `id_item` char(10) NOT NULL,
  `id_harga_beli` bigint(20) unsigned NOT NULL,
  `quantity` decimal(18,2) NOT NULL,
  PRIMARY KEY (`id_pembelian`,`id_item`,`id_harga_beli`),
  KEY `id_item` (`id_item`),
  KEY `id_harga_beli` (`id_harga_beli`),
  CONSTRAINT `detail_pembelian_ibfk_2` FOREIGN KEY (`id_item`) REFERENCES `item` (`id_item`),
  CONSTRAINT `detail_pembelian_ibfk_3` FOREIGN KEY (`id_harga_beli`) REFERENCES `harga_beli` (`id_harga_beli`),
  CONSTRAINT `detail_pembelian_ibfk_4` FOREIGN KEY (`id_pembelian`) REFERENCES `pembelian` (`id_pembelian`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `detail_pembelian` */

insert  into `detail_pembelian`(`id_pembelian`,`id_item`,`id_harga_beli`,`quantity`) values ('P2018100100000000001','I000000001',1,'100.00'),('P2018100100000000001','I000000002',4,'100.00'),('P2018100100000000002','I000000004',2,'100.00'),('P2018100100000000002','I000000005',5,'100.00'),('P2018100200000000001','I000000005',5,'50.00'),('P2018103100000000001','I000000001',1,'50.00');

/*Table structure for table `harga_beli` */

DROP TABLE IF EXISTS `harga_beli`;

CREATE TABLE `harga_beli` (
  `id_harga_beli` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_item` char(10) NOT NULL,
  `harga` decimal(18,2) NOT NULL,
  `tanggal` datetime NOT NULL,
  PRIMARY KEY (`id_harga_beli`),
  KEY `fk_relationship_24` (`id_item`),
  CONSTRAINT `fk_relationship_24` FOREIGN KEY (`id_item`) REFERENCES `item` (`id_item`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

/*Data for the table `harga_beli` */

insert  into `harga_beli`(`id_harga_beli`,`id_item`,`harga`,`tanggal`) values (1,'I000000001','24000.00','2018-10-31 23:35:45'),(2,'I000000004','15000.00','2018-10-31 23:35:58'),(3,'I000000007','4000.00','2018-10-31 23:36:13'),(4,'I000000002','17000.00','2018-10-31 23:36:13'),(5,'I000000005','10000.00','2018-11-01 00:25:06'),(6,'I000000001','20000.00','2018-11-01 00:25:06'),(7,'I000000002','20000.00','2018-12-19 13:25:44');

/*Table structure for table `harga_menu` */

DROP TABLE IF EXISTS `harga_menu`;

CREATE TABLE `harga_menu` (
  `id_harga_menu` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_menu` char(8) NOT NULL,
  `harga` decimal(18,2) NOT NULL,
  `tanggal` datetime NOT NULL,
  PRIMARY KEY (`id_harga_menu`),
  KEY `fk_relationship_37` (`id_menu`),
  CONSTRAINT `fk_relationship_37` FOREIGN KEY (`id_menu`) REFERENCES `menu` (`id_menu`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `harga_menu` */

insert  into `harga_menu`(`id_harga_menu`,`id_menu`,`harga`,`tanggal`) values (1,'00001','8000.00','2018-10-31 19:13:11'),(2,'00002','12000.00','2018-10-31 19:13:24'),(3,'00003','20000.00','2018-10-31 19:13:35'),(4,'00003','21000.00','2018-12-06 18:32:59'),(5,'00001','9000.00','2018-12-19 14:10:05');

/*Table structure for table `hq` */

DROP TABLE IF EXISTS `hq`;

CREATE TABLE `hq` (
  `id_hq` char(5) NOT NULL,
  `nama` varchar(250) NOT NULL,
  `alamat` text NOT NULL,
  `no_telp` varchar(15) NOT NULL,
  PRIMARY KEY (`id_hq`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `hq` */

insert  into `hq`(`id_hq`,`nama`,`alamat`,`no_telp`) values ('HQ001','Pusat','Jl. Arjuna Utara No 9, Duri Kepa, Jakarta Barat','02112345678');

/*Table structure for table `item` */

DROP TABLE IF EXISTS `item`;

CREATE TABLE `item` (
  `id_item` char(10) NOT NULL,
  `id_uom` char(5) DEFAULT NULL,
  `nama` varchar(250) NOT NULL,
  `deskripsi` text NOT NULL,
  PRIMARY KEY (`id_item`),
  KEY `fk_relationship_30` (`id_uom`),
  CONSTRAINT `fk_relationship_30` FOREIGN KEY (`id_uom`) REFERENCES `uom` (`id_uom`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `item` */

insert  into `item`(`id_item`,`id_uom`,`nama`,`deskripsi`) values ('I000000001','U0001','Detergen 1kg','-'),('I000000002','U0004','Detergen 900g','-'),('I000000003','U0005','Detergen Laundry Januar 50g','-'),('I000000004','U0006','Pewangi 1lt','-'),('I000000005','U0007','Pewangi 500ml','-'),('I000000006','U0008','Pewangi Laundry Januar 20ml','-'),('I000000007','U0008','Cairan Uap 20ml','-'),('I000000008','U0006','Detergen Cair 1 lt','-');

/*Table structure for table `membutuhkan` */

DROP TABLE IF EXISTS `membutuhkan`;

CREATE TABLE `membutuhkan` (
  `id_aktivitas` char(5) DEFAULT NULL,
  `id_item` char(10) DEFAULT NULL,
  `jumlah_item` decimal(18,2) NOT NULL,
  KEY `fk_relationship_15` (`id_aktivitas`),
  KEY `fk_relationship_16` (`id_item`),
  CONSTRAINT `fk_relationship_15` FOREIGN KEY (`id_aktivitas`) REFERENCES `aktivitas` (`id_aktivitas`),
  CONSTRAINT `fk_relationship_16` FOREIGN KEY (`id_item`) REFERENCES `item` (`id_item`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `membutuhkan` */

insert  into `membutuhkan`(`id_aktivitas`,`id_item`,`jumlah_item`) values ('A0001','I000000003','1.00'),('A0002','I000000006','1.00'),('A0003','I000000007','1.00');

/*Table structure for table `menu` */

DROP TABLE IF EXISTS `menu`;

CREATE TABLE `menu` (
  `id_menu` char(8) NOT NULL,
  `id_uom` char(5) NOT NULL,
  `nama` varchar(250) NOT NULL,
  `deskripsi` text NOT NULL,
  `quantity_minimum` decimal(18,2) NOT NULL,
  `lama_pengerjaan` int(10) unsigned NOT NULL,
  `is_available` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_menu`),
  KEY `id_uom` (`id_uom`),
  CONSTRAINT `menu_ibfk_1` FOREIGN KEY (`id_uom`) REFERENCES `uom` (`id_uom`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `menu` */

insert  into `menu`(`id_menu`,`id_uom`,`nama`,`deskripsi`,`quantity_minimum`,`lama_pengerjaan`,`is_available`) values ('00001','U0009','Cuci Kiloan Reguler','-','3.00',5,1),('00002','U0009','Cuci Kiloan Express','-','3.00',3,1),('00003','U0003','Dry Clean','-','1.00',3,1),('00004','U0009','Cuci Kiloan Ultra Express','-','3.00',2,1);

/*Table structure for table `migrations` */

DROP TABLE IF EXISTS `migrations`;

CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `migrations` */

/*Table structure for table `pegawai` */

DROP TABLE IF EXISTS `pegawai`;

CREATE TABLE `pegawai` (
  `id_pegawai` char(5) NOT NULL,
  `id_cabang` char(5) DEFAULT NULL,
  `nama` varchar(250) NOT NULL,
  `alamat` text NOT NULL,
  `no_telp` varchar(15) NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id_pegawai`),
  KEY `fk_relationship_28` (`id_cabang`),
  CONSTRAINT `fk_relationship_28` FOREIGN KEY (`id_cabang`) REFERENCES `cabang` (`id_cabang`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pegawai` */

insert  into `pegawai`(`id_pegawai`,`id_cabang`,`nama`,`alamat`,`no_telp`,`is_active`) values ('P0001','C0004','Muljoto Méh-fùnh Gunawano','Jl. Lorem ipsum dolor sit amet, Unkown','08512391232',1),('P0002','C0001','Sudomo Sudirman Tanuwidjaja','Ampera 3 no 8 Daerah Khusus Ibukota Jakarta','08123123127',1),('P0003','C0001','Sinta Sari','Jl.Taman Sentosa Indah II blok A2 no.16, Jakarta','08512319213',1),('P0004','C0001','Cahya Citra Tan','Jl. Bimba AIUEO ','08123151603',1),('P0005','C0001','Eugeo','Rulid\r\n','08125982342',1),('P0006','C0002','Kirito','Aincrad Floor 22nd','08151232132',1),('P0007','C0002','Asuna','Aincrad Floor 22nd	','08512391232',1),('P0008','C0002','Shinta Ade Atmadja','Jl. ABCDEFGH1234	','08151231282',1),('P0009','C0002','Ivan Agus Tan','Jl Letjen MT Haryono Kav 29-30 Ged Menara Saidah Lt 21,Cikoko','08659291005',1),('P0010','C0002','Ade Herman Tahyadi','Jl Letjen S Parman Ruko Gateway Bl D/29','08962029102',1),('P0011','C0003','Ade Irwan Kusnadi','Jl Ngagel Jaya Utara 131','02112557559',1),('P0012','C0003','Yohanes Bima Lie','Komp. ALKemang IFI - Jatirasa, Jatiasih, Jawa Barat','02112557560',1),('P0013','C0003','Eka Yohanes Darmadi','Jl. Perhubungan IV/25','02112557561',1),('P0014','C0003','Tjandra Yanlin','Jl RA Kartini 26 Ventura Bldg Lt 8,Cilandak Barat','02112557562',1),('P0015','C0003','Sunardi Mingli','Pondok Labu - Cilandak, Jakarta Selatan, Dki Jakarta','02112557563',1),('P0016','C0004','Rodney Tahalea','Jl Pelajar Pejuang 45 80,Turangga','02112557564',1),('P0017','C0004','Asaph Daulay','Vestibulum est lacus, vestibulum non ultrices, No 1','02112557565',1),('P0018','C0004','Marcus Halihi','ellentesque bibendum aliquet metus, no 9','02112557566',1),('P0019','C0004','Jeremy Hutasoit','Vivamus mollis a elit sed volutpat, No 12','02112557567',1),('P0020','C0004','Dian','Nullam sit amet tempus augue, No 12','02112557568',1),('P0021','C0005','Suharto','Donec accumsan rutrum vestibulum, No 90','02112557569',1),('P0022','C0005','Hadi Djaja Makmur','Nulla facilisi. In porta nisi et massa vulputate, a no 12','02112557570',1),('P0023','C0005','Kusuma Suharto Halim','In sollicitudin quis augue eu cursus, No 123','02112557571',1),('P0024','C0005','Halim Guoliang','Morbi non velit efficitur, malesuada leo at, egestas quam, No 98','02112557572',1),('P0025','C0005','Kusumawijaya Junjie','Phasellus eget elementum ligula, no 893','02112557573',1),('P0026','C0005','Kxan','Kxangrahan II, Duri kepa, Jakarta barat','082158628461',1),('P0027','C0001','asdasdasda','asda','5323',1),('P0028','C0004','vgv','ftgc','5225',1),('P0029','C0004','vgv','ftgc','5225',1),('P0030','C0004','chh','vyhbh','968',1),('P0032','C0001','asdasdasda','asda','5323',1),('P0033','C0004','oke','hjki','67385',1);

/*Table structure for table `pelanggan` */

DROP TABLE IF EXISTS `pelanggan`;

CREATE TABLE `pelanggan` (
  `id_pelanggan` char(10) NOT NULL,
  `email` varchar(250) DEFAULT NULL,
  `nama` varchar(250) NOT NULL,
  `no_telepon` char(15) NOT NULL,
  `alamat` text NOT NULL,
  PRIMARY KEY (`id_pelanggan`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pelanggan` */

insert  into `pelanggan`(`id_pelanggan`,`email`,`nama`,`no_telepon`,`alamat`) values ('CUST000001','naufal@gmailx.com','Naufalz','0896','Puri Gading'),('CUST000002','choset@outlook.com','Rinaldy Satria','081259897642','102 Westport Drive '),('CUST000003','world@sbcglobal.net','Asyrafi Al-fathan','082175525624','Corpus Christi, TX 78418'),('CUST000004','mjewell@yahoo.com','Achmad Setyawati','087850516382','51 Campfire St. '),('CUST000005','trieuvan@sbcglobal.net','Andrilla Alika','081280923139','Superior, WI 54880'),('CUST000006','hstiles@me.com','Adam Aisi','081259024219','226 Brewery Ave. '),('CUST000007','maikelnai@hotmail.com','Rusdi Fauzi','085673548929','Springfield, PA 19064'),('CUST000008','treit@yahoo.com','Bob Hamada','085673548930','814 N. Country Club Rd. '),('CUST000009','zyghom@mac.com','Kevin Indriany','085673548931','Hudson, NH 03051'),('CUST000010','hllam@hotmail.com','Yosua Aswati','085673548932','565 Manhattan Street '),('CUST000011','combrobahlul@gg.com','KX','082115328141','Combro bios No 10'),('CUST000013','ok@gmailm.com','ok','089620595294','ok@gmailm.com'),('CUST000014','ok@gnail.com','ok','666','ok@gnail.com'),('CUST000015','hhhg@gmail.com','hbh','66648','hhhg@gmail.com'),('CUST000016','naufal.riasgremory2x@gmail.com','Naufal','0896','Puri Gading');

/*Table structure for table `pembelian` */

DROP TABLE IF EXISTS `pembelian`;

CREATE TABLE `pembelian` (
  `id_pembelian` char(20) NOT NULL,
  `id_supplier` char(5) NOT NULL,
  `id_hq` char(5) NOT NULL,
  `tanggal` datetime NOT NULL,
  `is_paid` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_canceled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_success` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_pembelian`),
  KEY `fk_relationship_21` (`id_hq`),
  KEY `id_supplier` (`id_supplier`),
  CONSTRAINT `fk_relationship_21` FOREIGN KEY (`id_hq`) REFERENCES `hq` (`id_hq`),
  CONSTRAINT `pembelian_ibfk_1` FOREIGN KEY (`id_supplier`) REFERENCES `supplier` (`id_supplier`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pembelian` */

insert  into `pembelian`(`id_pembelian`,`id_supplier`,`id_hq`,`tanggal`,`is_paid`,`is_canceled`,`is_success`) values ('P2018100100000000001','S0001','HQ001','2018-10-01 00:26:30',1,0,0),('P2018100100000000002','S0002','HQ001','2018-10-01 00:26:30',0,0,0),('P2018100200000000001','S0002','HQ001','2018-10-02 00:26:30',0,0,0),('P2018103100000000001','S0001','HQ001','2018-10-31 01:50:43',0,0,0),('P2018112200000000001','S0001','HQ001','2018-11-22 16:39:56',0,0,0),('P2018120800000000001','S0001','HQ001','2018-12-08 09:00:38',0,0,0);

/*Table structure for table `penerimaan_by_purchase` */

DROP TABLE IF EXISTS `penerimaan_by_purchase`;

CREATE TABLE `penerimaan_by_purchase` (
  `id_penerimaan_by_purchase` char(20) NOT NULL,
  `id_pembelian` char(20) DEFAULT NULL,
  `id_hq` char(5) DEFAULT NULL,
  `tanggal` datetime NOT NULL,
  `catatan` text NOT NULL,
  PRIMARY KEY (`id_penerimaan_by_purchase`),
  KEY `fk_relationship_35` (`id_hq`),
  KEY `id_pembelian` (`id_pembelian`),
  CONSTRAINT `fk_relationship_35` FOREIGN KEY (`id_hq`) REFERENCES `hq` (`id_hq`),
  CONSTRAINT `penerimaan_by_purchase_ibfk_1` FOREIGN KEY (`id_pembelian`) REFERENCES `pembelian` (`id_pembelian`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `penerimaan_by_purchase` */

insert  into `penerimaan_by_purchase`(`id_penerimaan_by_purchase`,`id_pembelian`,`id_hq`,`tanggal`,`catatan`) values ('D2018100200000000001','P2018100100000000001','HQ001','2018-10-02 00:45:54','-'),('D2018100200000000002','P2018100100000000002','HQ001','2018-10-02 00:45:56','-'),('D2018100300000000001','P2018100200000000001','HQ001','2018-10-03 00:00:00','-\r\n'),('D2018103100000000001','P2018103100000000001','HQ001','2018-10-31 01:51:11','-\r\n');

/*Table structure for table `penerimaan_by_request` */

DROP TABLE IF EXISTS `penerimaan_by_request`;

CREATE TABLE `penerimaan_by_request` (
  `id_penerimaan_by_request` char(20) NOT NULL,
  `id_pengiriman` char(20) DEFAULT NULL,
  `id_cabang` char(5) DEFAULT NULL,
  `tanggal` datetime NOT NULL,
  `catatan` text NOT NULL,
  PRIMARY KEY (`id_penerimaan_by_request`),
  KEY `fk_relationship_34` (`id_cabang`),
  KEY `fk_relationship_7` (`id_pengiriman`),
  CONSTRAINT `fk_relationship_34` FOREIGN KEY (`id_cabang`) REFERENCES `cabang` (`id_cabang`),
  CONSTRAINT `fk_relationship_7` FOREIGN KEY (`id_pengiriman`) REFERENCES `pengiriman` (`id_pengiriman`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `penerimaan_by_request` */

insert  into `penerimaan_by_request`(`id_penerimaan_by_request`,`id_pengiriman`,`id_cabang`,`tanggal`,`catatan`) values ('REC20181101000000001','DEL20181031000000001','C0001','2018-11-01 01:15:59','-'),('REC20181101000000002','DEL20181031000000002','C0002','2018-11-01 02:15:59','-'),('REC20181101000000003','DEL20181031000000003','C0003','2018-11-01 03:15:59','-'),('REC20181101000000004','DEL20181031000000004','C0004','2018-11-01 04:15:59','-'),('REC20181101000000005','DEL20181031000000005','C0005','2018-11-01 05:15:59','-');

/*Table structure for table `penerimaan_item_purchase` */

DROP TABLE IF EXISTS `penerimaan_item_purchase`;

CREATE TABLE `penerimaan_item_purchase` (
  `id_penerimaan_by_purchase` char(20) NOT NULL,
  `id_item` char(10) NOT NULL,
  `quantity` decimal(18,2) DEFAULT NULL,
  PRIMARY KEY (`id_item`,`id_penerimaan_by_purchase`),
  KEY `fk_relationship_27` (`id_penerimaan_by_purchase`),
  CONSTRAINT `fk_relationship_26` FOREIGN KEY (`id_item`) REFERENCES `item` (`id_item`),
  CONSTRAINT `fk_relationship_27` FOREIGN KEY (`id_penerimaan_by_purchase`) REFERENCES `penerimaan_by_purchase` (`id_penerimaan_by_purchase`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `penerimaan_item_purchase` */

insert  into `penerimaan_item_purchase`(`id_penerimaan_by_purchase`,`id_item`,`quantity`) values ('D2018100200000000001','I000000001','100.00'),('D2018103100000000001','I000000001','50.00'),('D2018100200000000001','I000000002','100.00'),('D2018100200000000002','I000000004','100.00'),('D2018100200000000002','I000000005','100.00'),('D2018100300000000001','I000000005','50.00');

/*Table structure for table `penerimaan_item_request` */

DROP TABLE IF EXISTS `penerimaan_item_request`;

CREATE TABLE `penerimaan_item_request` (
  `id_penerimaan_by_request` char(20) NOT NULL,
  `id_item` char(10) NOT NULL,
  `quantity` decimal(18,2) NOT NULL,
  PRIMARY KEY (`id_item`,`id_penerimaan_by_request`),
  KEY `fk_relationship_9` (`id_penerimaan_by_request`),
  CONSTRAINT `fk_relationship_8` FOREIGN KEY (`id_item`) REFERENCES `item` (`id_item`),
  CONSTRAINT `fk_relationship_9` FOREIGN KEY (`id_penerimaan_by_request`) REFERENCES `penerimaan_by_request` (`id_penerimaan_by_request`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `penerimaan_item_request` */

insert  into `penerimaan_item_request`(`id_penerimaan_by_request`,`id_item`,`quantity`) values ('REC20181101000000001','I000000003','25.00'),('REC20181101000000002','I000000003','25.00'),('REC20181101000000003','I000000003','25.00'),('REC20181101000000004','I000000003','25.00'),('REC20181101000000005','I000000003','25.00'),('REC20181101000000001','I000000006','25.00'),('REC20181101000000002','I000000006','25.00'),('REC20181101000000003','I000000006','25.00'),('REC20181101000000004','I000000006','25.00'),('REC20181101000000005','I000000006','25.00');

/*Table structure for table `penggunaan` */

DROP TABLE IF EXISTS `penggunaan`;

CREATE TABLE `penggunaan` (
  `id_aktivitas_laundry` char(30) NOT NULL,
  `id_item` char(10) NOT NULL,
  `quantity` decimal(18,2) NOT NULL,
  `tanggal` datetime NOT NULL,
  PRIMARY KEY (`id_aktivitas_laundry`,`id_item`),
  KEY `fk_relationship_17` (`id_item`),
  CONSTRAINT `fk_relationship_17` FOREIGN KEY (`id_item`) REFERENCES `item` (`id_item`),
  CONSTRAINT `fk_relationship_18` FOREIGN KEY (`id_aktivitas_laundry`) REFERENCES `aktivitas_laundry` (`id_aktivitas_laundry`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `penggunaan` */

insert  into `penggunaan`(`id_aktivitas_laundry`,`id_item`,`quantity`,`tanggal`) values ('ADTR20190723000000000100010001','I000000003','5.00','2019-07-23 14:41:14'),('ADTR20190723000000000100010002','I000000006','5.00','2019-07-23 15:42:20'),('ADTR20190723000000000200010001','I000000003','2.00','2019-07-23 17:28:56'),('ADTR20190723000000000200010002','I000000006','2.00','2019-07-23 17:29:03'),('ADTR20190723000000000300010001','I000000007','3.00','2019-07-23 17:38:25'),('ADTR20190724000000000100010001','I000000007','5.00','2019-07-24 14:20:18');

/*Table structure for table `pengiriman` */

DROP TABLE IF EXISTS `pengiriman`;

CREATE TABLE `pengiriman` (
  `id_pengiriman` char(20) NOT NULL,
  `id_permintaan` char(20) NOT NULL,
  `id_cabang` char(5) NOT NULL,
  `id_hq` char(5) NOT NULL,
  `tanggal` datetime NOT NULL,
  PRIMARY KEY (`id_pengiriman`,`id_permintaan`,`id_cabang`,`id_hq`),
  KEY `fk_relationship_19` (`id_hq`),
  KEY `fk_relationship_4` (`id_permintaan`),
  KEY `id_cabang` (`id_cabang`),
  CONSTRAINT `fk_relationship_19` FOREIGN KEY (`id_hq`) REFERENCES `hq` (`id_hq`),
  CONSTRAINT `fk_relationship_4` FOREIGN KEY (`id_permintaan`) REFERENCES `permintaan` (`id_permintaan`),
  CONSTRAINT `pengiriman_ibfk_1` FOREIGN KEY (`id_cabang`) REFERENCES `cabang` (`id_cabang`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pengiriman` */

insert  into `pengiriman`(`id_pengiriman`,`id_permintaan`,`id_cabang`,`id_hq`,`tanggal`) values ('DEL20181031000000001','REQ20181031000000001','C0001','HQ001','2018-10-31 04:32:52'),('DEL20181031000000002','REQ20181031000000002','C0002','HQ001','2018-10-31 04:33:52'),('DEL20181031000000003','REQ20181031000000003','C0003','HQ001','2018-10-31 04:34:52'),('DEL20181031000000004','REQ20181031000000004','C0004','HQ001','2018-10-31 04:35:52'),('DEL20181031000000005','REQ20181031000000005','C0005','HQ001','2018-10-31 04:36:52'),('DEL20181208000000001','REQ20181208000000001','C0001','HQ001','2018-12-08 09:29:44');

/*Table structure for table `pengiriman_item` */

DROP TABLE IF EXISTS `pengiriman_item`;

CREATE TABLE `pengiriman_item` (
  `id_pengiriman` char(20) NOT NULL,
  `id_item` char(10) NOT NULL,
  `quantity` decimal(18,2) NOT NULL,
  PRIMARY KEY (`id_item`,`id_pengiriman`),
  KEY `fk_relationship_6` (`id_pengiriman`),
  CONSTRAINT `fk_relationship_5` FOREIGN KEY (`id_item`) REFERENCES `item` (`id_item`),
  CONSTRAINT `fk_relationship_6` FOREIGN KEY (`id_pengiriman`) REFERENCES `pengiriman` (`id_pengiriman`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pengiriman_item` */

insert  into `pengiriman_item`(`id_pengiriman`,`id_item`,`quantity`) values ('DEL20181031000000001','I000000003','25.00'),('DEL20181031000000002','I000000003','25.00'),('DEL20181031000000003','I000000003','25.00'),('DEL20181031000000004','I000000003','25.00'),('DEL20181031000000005','I000000003','25.00'),('DEL20181031000000001','I000000006','25.00'),('DEL20181031000000002','I000000006','25.00'),('DEL20181031000000003','I000000006','25.00'),('DEL20181031000000004','I000000006','25.00'),('DEL20181031000000005','I000000006','25.00');

/*Table structure for table `permintaan` */

DROP TABLE IF EXISTS `permintaan`;

CREATE TABLE `permintaan` (
  `id_permintaan` char(20) NOT NULL,
  `id_cabang` char(5) NOT NULL,
  `deskripsi` text NOT NULL,
  `tanggal` datetime NOT NULL,
  `is_accepted` tinyint(4) NOT NULL,
  PRIMARY KEY (`id_permintaan`,`id_cabang`),
  KEY `fk_relationship_1` (`id_cabang`),
  CONSTRAINT `fk_relationship_1` FOREIGN KEY (`id_cabang`) REFERENCES `cabang` (`id_cabang`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `permintaan` */

insert  into `permintaan`(`id_permintaan`,`id_cabang`,`deskripsi`,`tanggal`,`is_accepted`) values ('REQ20181031000000001','C0001','-','2018-10-31 02:32:52',1),('REQ20181031000000002','C0002','-','2018-10-31 02:33:52',1),('REQ20181031000000003','C0003','-','2018-10-31 02:34:52',1),('REQ20181031000000004','C0004','-','2018-10-31 02:35:52',1),('REQ20181031000000005','C0005','-','2018-10-31 02:36:52',1),('REQ20181101000000001','C0005','-','2018-11-01 10:02:50',0),('REQ20181208000000001','C0001','-','2018-12-08 09:25:18',1);

/*Table structure for table `permintaan_item` */

DROP TABLE IF EXISTS `permintaan_item`;

CREATE TABLE `permintaan_item` (
  `id_permintaan` char(20) NOT NULL,
  `id_item` char(10) NOT NULL,
  `quantity` decimal(18,2) DEFAULT NULL,
  PRIMARY KEY (`id_item`,`id_permintaan`),
  KEY `id_permintaan` (`id_permintaan`),
  CONSTRAINT `fk_relationship_2` FOREIGN KEY (`id_item`) REFERENCES `item` (`id_item`),
  CONSTRAINT `permintaan_item_ibfk_1` FOREIGN KEY (`id_permintaan`) REFERENCES `permintaan` (`id_permintaan`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `permintaan_item` */

insert  into `permintaan_item`(`id_permintaan`,`id_item`,`quantity`) values ('REQ20181101000000001','I000000001','30.00'),('REQ20181031000000001','I000000003','25.00'),('REQ20181031000000002','I000000003','25.00'),('REQ20181031000000003','I000000003','25.00'),('REQ20181031000000004','I000000003','25.00'),('REQ20181031000000005','I000000003','25.00'),('REQ20181031000000001','I000000006','25.00'),('REQ20181031000000002','I000000006','25.00'),('REQ20181031000000003','I000000006','25.00'),('REQ20181031000000004','I000000006','25.00'),('REQ20181031000000005','I000000006','25.00');

/*Table structure for table `supplier` */

DROP TABLE IF EXISTS `supplier`;

CREATE TABLE `supplier` (
  `id_supplier` char(5) NOT NULL,
  `nama` varchar(250) NOT NULL,
  `alamat` text NOT NULL,
  `no_tlp` varchar(20) NOT NULL,
  PRIMARY KEY (`id_supplier`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `supplier` */

insert  into `supplier`(`id_supplier`,`nama`,`alamat`,`no_tlp`) values ('S0001','Toko Detergen Lengkap','Jl Jend Sudirman Kav 29-31 Wisma Metropolitan I Lt 3 12920','0215711850'),('S0002','Tokoe Pewangi Lengkap','Jl Kwitang Raya 8 Ged Senatama Lt 3,Kwitang, Senen, Jakarta','0212303641'),('S0003','Toko Serba Ada Lengkap','Jl Jend Sudirman Kav 10-11 Midplaza 2,Karet Tengsin, Tanah abang, jakarta','0215706281'),('S0004','Toko Serba Ada Kujang','Jl. Kompilasi 11 , No. 15, Alpokats, Jakarta','0215969725');

/*Table structure for table `transaksi_laundry` */

DROP TABLE IF EXISTS `transaksi_laundry`;

CREATE TABLE `transaksi_laundry` (
  `id_transaksi_laundry` char(20) NOT NULL,
  `id_cabang` char(5) DEFAULT NULL,
  `id_pelanggan` char(10) DEFAULT NULL,
  `tanggal` datetime NOT NULL,
  `is_paid` tinyint(1) NOT NULL,
  `is_taken` tinyint(1) NOT NULL,
  `waktu_pengambilan` datetime DEFAULT NULL,
  PRIMARY KEY (`id_transaksi_laundry`),
  KEY `fk_relationship_10` (`id_cabang`),
  KEY `fk_relationship_39` (`id_pelanggan`),
  CONSTRAINT `fk_relationship_10` FOREIGN KEY (`id_cabang`) REFERENCES `cabang` (`id_cabang`),
  CONSTRAINT `fk_relationship_39` FOREIGN KEY (`id_pelanggan`) REFERENCES `pelanggan` (`id_pelanggan`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `transaksi_laundry` */

insert  into `transaksi_laundry`(`id_transaksi_laundry`,`id_cabang`,`id_pelanggan`,`tanggal`,`is_paid`,`is_taken`,`waktu_pengambilan`) values ('TR201907230000000001','C0004','CUST000001','2019-07-23 13:16:11',1,1,'2019-07-24 13:13:17'),('TR201907230000000002','C0004','CUST000006','2019-07-23 17:28:42',1,1,'2019-07-24 13:15:37'),('TR201907230000000003','C0004','CUST000014','2019-07-23 17:38:08',1,1,'2019-07-24 13:15:52'),('TR201907240000000001','C0004','CUST000009','2019-07-24 13:50:43',1,1,'2019-07-24 14:20:24');

/*Table structure for table `uom` */

DROP TABLE IF EXISTS `uom`;

CREATE TABLE `uom` (
  `id_uom` char(5) NOT NULL,
  `nama` varchar(250) NOT NULL,
  `singkatan` varchar(25) NOT NULL,
  PRIMARY KEY (`id_uom`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `uom` */

insert  into `uom`(`id_uom`,`nama`,`singkatan`) values ('U0001','pcs(1 kilogram)','pcs(1kg)'),('U0002','pcs(100 gram)','pcs(100g)'),('U0003','pieces','pcs'),('U0004','pcs(900 gram)','pcs(900g)'),('U0005','pcs(50 gram)','pcs(50g)'),('U0006','pcs(liter)','pcs(l)'),('U0007','pcs(500 mililiter)','pcs(500ml)'),('U0008','pcs(20 mililiter)','pcs(20ml)'),('U0009','kilogram','kg');

/*Table structure for table `uom_converter` */

DROP TABLE IF EXISTS `uom_converter`;

CREATE TABLE `uom_converter` (
  `id_uom_converter` char(5) NOT NULL,
  `from_id_uom` char(5) NOT NULL,
  `to_id_uom` char(5) NOT NULL,
  `factor` double NOT NULL,
  PRIMARY KEY (`id_uom_converter`),
  KEY `fk_uom_from` (`to_id_uom`),
  KEY `fk_uom_to` (`from_id_uom`),
  CONSTRAINT `fk_uom_from` FOREIGN KEY (`to_id_uom`) REFERENCES `uom` (`id_uom`),
  CONSTRAINT `fk_uom_to` FOREIGN KEY (`from_id_uom`) REFERENCES `uom` (`id_uom`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `uom_converter` */

insert  into `uom_converter`(`id_uom_converter`,`from_id_uom`,`to_id_uom`,`factor`) values ('C0001','U0001','U0002',0.1),('C0002','U0004','U0005',0.05555555555555555),('C0003','U0001','U0005',0.05),('C0004','U0004','U0002',0.1111111111111111),('C0007','U0006','U0008',0.05),('C0008','U0007','U0008',0.04);

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(573) DEFAULT NULL,
  `email` varchar(573) DEFAULT NULL,
  `password` varchar(573) DEFAULT NULL,
  `id_hq` char(15) DEFAULT NULL,
  `id_cabang` char(15) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

/*Data for the table `users` */

insert  into `users`(`id`,`name`,`email`,`password`,`id_hq`,`id_cabang`,`created_at`,`updated_at`) values (1,'rizky','mrizky019@gmail.com','$2y$10$lq6h8Mo1X53Ra3UzxBhGOeAlTK/Xzsswy6ZaeCcgwdd8KU.C2A8r6',NULL,'C0001','2019-07-08 09:58:35','2019-07-08 09:58:35'),(2,'naufal','nauhalf@gmail.com','$2y$10$nhcwXWkZPbi9.xRmRO4zMuDcpekOieAVaZnw8OBxiAROXPE8IGTBW',NULL,'C0002','2019-07-08 10:06:29','2019-07-08 10:06:29'),(3,'Ocit','shinryuzaki@gmail.com','$2y$10$t1KrcSID1YcC7oLD9VmxRe/ic.cppk5RN7Fhz4XxkyQvRULGyNH76',NULL,'C0003','2019-07-08 10:06:47','2019-07-08 10:06:47'),(4,'ersa','ersa@gmail.com','$2y$10$yoBanrTl1shc1AU/GduqQ.VY3uZP3eoe.pJxlbMO1BCKeA6oRfVgm',NULL,'C0004','2019-07-18 17:46:05','2019-07-08 10:07:02'),(7,'kosun','mrizky019@outlook.com','$2y$10$0.Xvi2TznFCnv2.soQ/Z/etOl43YHKY7HsvTMH2yc5kyFWcbtKv8m',NULL,'C0004','2019-07-10 12:54:44','2019-07-10 12:54:44');

/* Trigger structure for table `aktivitas_laundry` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `trigger_after_update_aktivitas_laundry` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'naufal'@'localhost' */ /*!50003 TRIGGER `trigger_after_update_aktivitas_laundry` AFTER UPDATE ON `aktivitas_laundry` FOR EACH ROW BEGIN
	IF (old.mulai_pengerjaan IS NULL OR new.mulai_pengerjaan <> old.mulai_pengerjaan) THEN 
		call procedure_melakukan_pekerjaan(old.id_aktivitas_laundry, new.mulai_pengerjaan);
	END if;
	
    END */$$


DELIMITER ;

/* Trigger structure for table `detail_laundry` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `trigger_after_insert_detail_laundry` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `trigger_after_insert_detail_laundry` AFTER INSERT ON `detail_laundry` FOR EACH ROW BEGIN
	DECLARE V_ID_MENU CHAR(8);
	DECLARE V_ID_AKTIVITAS VARCHAR(5);
	DECLARE V_ID_DETAIL_LAUNDRY VARCHAR(25);
	DECLARE DoneAktivitas INTEGER DEFAULT FALSE;
	DECLARE CursorAktivitas CURSOR FOR
		SELECT
		dl.`id_menu`,
		am.`id_aktivitas`,
		dl.id_detail_laundry
		FROM detail_laundry dl
		JOIN aktivitas_menu am
		ON dl.`id_menu` = am.`id_menu`
		WHERE dl.`id_transaksi_laundry` = new.id_transaksi_laundry;
		
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET DoneAktivitas = 1; 
	
	OPEN CursorAktivitas;
	
	readloop: LOOP
		FETCH CursorAktivitas INTO V_ID_MENU, V_ID_AKTIVITAS, V_ID_DETAIL_LAUNDRY;
		
		IF DoneAktivitas THEN
			LEAVE readloop;
		END IF;
		call procedure_new_aktivitas_laundry(V_ID_DETAIL_LAUNDRY, V_ID_AKTIVITAS, @id_aktivitas_laundry);
				
	END LOOP;	
	CLOSE CursorAktivitas;
    END */$$


DELIMITER ;

/* Trigger structure for table `pembelian` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `trigger_after_update_pembelian` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'naufal'@'localhost' */ /*!50003 TRIGGER `trigger_after_update_pembelian` AFTER UPDATE ON `pembelian` FOR EACH ROW BEGIN
    
	if(old.is_paid = 0 && new.is_paid = 1) THEN
		call procedure_cash_out_pembelian(old.id_hq, now(), old.id_pembelian);
	end if;
    
    END */$$


DELIMITER ;

/* Trigger structure for table `pengiriman` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `trigger_after_insert_pengiriman` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `trigger_after_insert_pengiriman` AFTER INSERT ON `pengiriman` FOR EACH ROW BEGIN
    UPDATE permintaan SET permintaan.`is_accepted` = 1 where permintaan.`id_permintaan` = new.`id_permintaan`;
    END */$$


DELIMITER ;

/* Trigger structure for table `transaksi_laundry` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `trigger_after_update_transaction` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'naufal'@'localhost' */ /*!50003 TRIGGER `trigger_after_update_transaction` AFTER UPDATE ON `transaksi_laundry` FOR EACH ROW BEGIN
	if (old.is_paid = 0 AND new.is_paid = 1) THEN
		call procedure_cash_in_transaction_laundry(old.id_cabang, now(), old.id_transaksi_laundry);
	END IF;
    END */$$


DELIMITER ;

/* Function  structure for function  `first_day` */

/*!50003 DROP FUNCTION IF EXISTS `first_day` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `first_day`(dt DATETIME) RETURNS date
BEGIN
	RETURN DATE_ADD(DATE_ADD(LAST_DAY(dt),
                INTERVAL 1 DAY),
            INTERVAL - 1 MONTH);
    END */$$
DELIMITER ;

/* Function  structure for function  `get_cash_cabang` */

/*!50003 DROP FUNCTION IF EXISTS `get_cash_cabang` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `get_cash_cabang`(p_id_cabang CHAR(5)) RETURNS decimal(18,2)
BEGIN
    declare v_uang DECIMAL(18,2);
    set v_uang = (SELECT SUM(summary_cabang.jumlah) AS jumlah FROM
		(SELECT
		id_cabang,
		SUM(cin.`jumlah`) AS jumlah
		FROM view_cash_in_cabang cin
		WHERE id_cabang = p_id_cabang
		GROUP BY cin.`id_cabang`
		UNION ALL
		SELECT
		id_cabang,
		SUM(cout.`jumlah`)*-1 AS jumlah	FROM view_cash_out_cabang cout	WHERE id_cabang = p_id_cabang GROUP BY cout.id_cabang
		) AS summary_cabang GROUP BY summary_cabang.id_cabang);
		
	return v_uang;
    END */$$
DELIMITER ;

/* Function  structure for function  `get_cash_cabang_in_periode` */

/*!50003 DROP FUNCTION IF EXISTS `get_cash_cabang_in_periode` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `get_cash_cabang_in_periode`(p_id_cabang CHAR(5), p_date_from DATE, p_date_to DATE) RETURNS decimal(18,2)
BEGIN
	declare v_cash_in DECIMAL(18,2);
	
	set v_cash_in = (SELECT sum(`view_cash_in_cabang`.`jumlah`) AS `jumlah` FROM `view_cash_in_cabang` WHERE view_cash_in_cabang.`id_cabang` = p_id_cabang and view_cash_in_cabang.`tanggal` BETWEEN p_date_from AND p_date_to GROUP BY `view_cash_in_cabang`.`id_cabang`);
	
	return (v_cash_in);
	
    END */$$
DELIMITER ;

/* Function  structure for function  `get_cash_cabang_out_periode` */

/*!50003 DROP FUNCTION IF EXISTS `get_cash_cabang_out_periode` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `get_cash_cabang_out_periode`(p_id_cabang CHAR(5), p_date_from DATE, p_date_to DATE) RETURNS decimal(18,2)
BEGIN
	DECLARE v_cash_out DECIMAL(18,2);
	
	SET v_cash_out = (SELECT SUM(`view_cash_out_cabang`.`jumlah`) AS `jumlah` FROM `view_cash_out_cabang` WHERE view_cash_out_cabang.`id_cabang` = p_id_cabang AND view_cash_out_cabang.`tanggal` BETWEEN p_date_from AND p_date_to GROUP BY `view_cash_out_cabang`.`id_cabang`);
	return v_cash_out;
    END */$$
DELIMITER ;

/* Function  structure for function  `get_cash_hq_in_periode` */

/*!50003 DROP FUNCTION IF EXISTS `get_cash_hq_in_periode` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `get_cash_hq_in_periode`(p_id_hq CHAR(5), p_date_from DATE, p_date_to DATE) RETURNS decimal(18,2)
BEGIN
	DECLARE v_cash_in DECIMAL(18,2);
	
	SET v_cash_in = (SELECT SUM(`view_cash_in_hq`.`jumlah`) AS `jumlah` FROM `view_cash_in_hq` WHERE view_cash_in_hq.`id_hq` = p_id_hq AND view_cash_in_hq.`tanggal` BETWEEN p_date_from AND p_date_to GROUP BY `view_cash_in_hq`.`id_hq`);
	
	RETURN (v_cash_in);
    END */$$
DELIMITER ;

/* Function  structure for function  `get_cash_hq_out_periode` */

/*!50003 DROP FUNCTION IF EXISTS `get_cash_hq_out_periode` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `get_cash_hq_out_periode`(p_id_hq CHAR(5), p_date_from DATE, p_date_to DATE) RETURNS decimal(18,2)
BEGIN
	DECLARE v_cash_out DECIMAL(18,2);
	SET v_cash_out = (SELECT SUM(`view_cash_out_hq`.`jumlah`) AS `jumlah` FROM `view_cash_out_hq` WHERE view_cash_out_hq.`id_hq` = p_id_hq AND view_cash_out_hq.`tanggal` BETWEEN p_date_from AND p_date_to GROUP BY `view_cash_out_hq`.`id_hq`);
	return v_cash_out;
    END */$$
DELIMITER ;

/* Function  structure for function  `get_harga_pembelian` */

/*!50003 DROP FUNCTION IF EXISTS `get_harga_pembelian` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `get_harga_pembelian`(p_id_pembelian CHAR(20)) RETURNS decimal(18,2)
BEGIN
	declare harga decimal(18,2);
	set harga = (SELECT
	SUM(hb.`harga`*quantity) AS harga
	FROM detail_pembelian dp
	JOIN harga_beli hb
	ON dp.`id_harga_beli` = hb.`id_harga_beli`
	where dp.id_pembelian = p_id_pembelian
	GROUP BY dp.`id_pembelian`
	ORDER BY dp.`id_pembelian`);
	return harga;
    END */$$
DELIMITER ;

/* Function  structure for function  `get_harga_transaksi_laundry` */

/*!50003 DROP FUNCTION IF EXISTS `get_harga_transaksi_laundry` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `get_harga_transaksi_laundry`(p_id_transaksi_laundry CHAR(20)) RETURNS decimal(18,2)
BEGIN
    declare uang DECIMAL(18,2);
    set uang = (SELECT
SUM(hm.`harga`*quantity) AS harga
FROM detail_laundry dl
JOIN harga_menu hm
ON dl.`id_harga_menu` = hm.`id_harga_menu`
WHERE dl.`id_transaksi_laundry` = p_id_transaksi_laundry
GROUP BY dl.`id_transaksi_laundry`
ORDER BY dl.`id_transaksi_laundry`);
return uang;
    END */$$
DELIMITER ;

/* Function  structure for function  `get_increment_convert_item` */

/*!50003 DROP FUNCTION IF EXISTS `get_increment_convert_item` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `get_increment_convert_item`(p_tanggal DATETIME) RETURNS int(11)
BEGIN
	declare number int;
	set number = (SELECT IFNULL(MAX(CONVERT(RIGHT(id_convert_item, 11), INT)), 0) AS max_number FROM convert_item WHERE DATE(tanggal) = DATE(p_tanggal));
	return number+1;
    END */$$
DELIMITER ;

/* Function  structure for function  `get_increment_id_aktivitas` */

/*!50003 DROP FUNCTION IF EXISTS `get_increment_id_aktivitas` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `get_increment_id_aktivitas`() RETURNS int(11)
BEGIN
	declare number int;
	set number = (SELECT IFNULL(MAX(CONVERT(RIGHT(id_aktivitas, 4), INT)), 0) FROM aktivitas);
	return number+1;
    END */$$
DELIMITER ;

/* Function  structure for function  `get_increment_id_aktivitas_laundry` */

/*!50003 DROP FUNCTION IF EXISTS `get_increment_id_aktivitas_laundry` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `get_increment_id_aktivitas_laundry`(in_id_detail_laundry char(25)) RETURNS int(11)
BEGIN
	DECLARE number INT;
	SET number = (SELECT IFNULL(MAX(CONVERT(RIGHT(id_aktivitas_laundry, 4), INT)), 0) AS max_number FROM aktivitas_laundry WHERE id_detail_laundry = in_id_detail_laundry);
	RETURN number+1;
    END */$$
DELIMITER ;

/* Function  structure for function  `get_increment_id_cash_flow_cabang_in` */

/*!50003 DROP FUNCTION IF EXISTS `get_increment_id_cash_flow_cabang_in` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `get_increment_id_cash_flow_cabang_in`( in_tanggal datetime) RETURNS int(11)
BEGIN
	DECLARE number INT;
	SET number = (SELECT IFNULL(MAX(CONVERT(RIGHT(id_cash_flow_cabang, 9), INT)), 0) AS max_number FROM cash_flow_cabang WHERE DATE(tanggal) = DATE(in_tanggal) AND LEFT(id_cash_flow_cabang, 3) = 'CB1');
	RETURN number+1;
    END */$$
DELIMITER ;

/* Function  structure for function  `get_increment_id_cash_flow_cabang_out` */

/*!50003 DROP FUNCTION IF EXISTS `get_increment_id_cash_flow_cabang_out` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `get_increment_id_cash_flow_cabang_out`(in_tanggal datetime) RETURNS int(11)
BEGIN
	DECLARE number INT;
	SET number = (SELECT IFNULL(MAX(CONVERT(RIGHT(id_cash_flow_cabang, 9),INT)), 0) AS max_number FROM cash_flow_cabang WHERE DATE(tanggal) = DATE(in_tanggal) AND LEFT(id_cash_flow_cabang, 3) = 'CB2');
	RETURN number+1;
    END */$$
DELIMITER ;

/* Function  structure for function  `get_increment_id_cash_flow_hq_in` */

/*!50003 DROP FUNCTION IF EXISTS `get_increment_id_cash_flow_hq_in` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `get_increment_id_cash_flow_hq_in`(in_tanggal datetime) RETURNS int(11)
BEGIN
	DECLARE number INT;
	SET number = (SELECT IFNULL(MAX(CONVERT(RIGHT(id_cash_flow_hq, 9),INT)), 0) AS max_number FROM cash_flow_hq WHERE DATE(tanggal) = DATE(in_tanggal) AND LEFT(id_cash_flow_hq, 3) = 'HQ1');
	RETURN number+1;
    END */$$
DELIMITER ;

/* Function  structure for function  `get_increment_id_cash_flow_hq_out` */

/*!50003 DROP FUNCTION IF EXISTS `get_increment_id_cash_flow_hq_out` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `get_increment_id_cash_flow_hq_out`(in_tanggal datetime) RETURNS int(11)
BEGIN
	DECLARE number INT;
	SET number = (SELECT IFNULL(MAX(CONVERT(RIGHT(id_cash_flow_hq, 9),INT)), 0) AS max_number FROM cash_flow_hq WHERE DATE(tanggal) = DATE(in_tanggal) AND LEFT(id_cash_flow_hq, 3) = 'HQ2');
	RETURN number+1;
    END */$$
DELIMITER ;

/* Function  structure for function  `get_increment_id_detail_laundry` */

/*!50003 DROP FUNCTION IF EXISTS `get_increment_id_detail_laundry` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `get_increment_id_detail_laundry`(p_id_transaksi_laundry CHAR(20)) RETURNS int(11)
BEGIN
    declare number int;
    set number = (SELECT IFNULL(MAX(CONVERT(RIGHT(d.`id_detail_laundry`, 4), INT)), 0) AS max_number 
FROM detail_laundry d WHERE d.`id_transaksi_laundry` = p_id_transaksi_laundry);
return number+1;
    END */$$
DELIMITER ;

/* Function  structure for function  `get_increment_id_item` */

/*!50003 DROP FUNCTION IF EXISTS `get_increment_id_item` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `get_increment_id_item`() RETURNS int(11)
BEGIN
    declare number int;
    set number = (SELECT IFNULL(MAX(CONVERT(RIGHT(id_item, 9), INT)), 0) from item);
    return number+1;
    END */$$
DELIMITER ;

/* Function  structure for function  `get_increment_id_menu` */

/*!50003 DROP FUNCTION IF EXISTS `get_increment_id_menu` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `get_increment_id_menu`() RETURNS int(11)
BEGIN
	declare number int;
	set number = (SELECT IFNULL(MAX(CONVERT(RIGHT(id_menu, 5), INT)), 0) from menu);
	return number+1;
    END */$$
DELIMITER ;

/* Function  structure for function  `get_increment_id_pegawai` */

/*!50003 DROP FUNCTION IF EXISTS `get_increment_id_pegawai` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `get_increment_id_pegawai`() RETURNS int(11)
BEGIN
	declare number int;
	set number = (SELECT IFNULL(MAX(CONVERT(RIGHT(id_pegawai, 4), INT)), 0) from pegawai);
	return number+1;
    END */$$
DELIMITER ;

/* Function  structure for function  `get_increment_id_pelanggan` */

/*!50003 DROP FUNCTION IF EXISTS `get_increment_id_pelanggan` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `get_increment_id_pelanggan`() RETURNS int(11)
BEGIN
	declare number int;
	set number = (SELECT IFNULL(MAX(CONVERT(RIGHT(id_pelanggan, 6), INT)), 0) from pelanggan);
	return number+1;
    END */$$
DELIMITER ;

/* Function  structure for function  `get_increment_id_pembelian` */

/*!50003 DROP FUNCTION IF EXISTS `get_increment_id_pembelian` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `get_increment_id_pembelian`(in_tanggal DATETIME) RETURNS int(11)
BEGIN
	DECLARE number INT;
	SET number = (SELECT IFNULL(MAX(CONVERT(RIGHT(id_pembelian, 9), INT)), 0) AS max_number FROM pembelian WHERE DATE(tanggal) = DATE(in_tanggal));
	
	return number+1;
    END */$$
DELIMITER ;

/* Function  structure for function  `get_increment_id_penerimaan_by_purchase` */

/*!50003 DROP FUNCTION IF EXISTS `get_increment_id_penerimaan_by_purchase` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `get_increment_id_penerimaan_by_purchase`(p_tanggal DATETIME) RETURNS int(11)
BEGIN
    DECLARE number INT;
	SET number = (SELECT IFNULL(MAX(CONVERT(RIGHT(id_penerimaan_by_purchase, 11), INT)), 0) AS max_number FROM penerimaan_by_purchase WHERE DATE(tanggal) = DATE(p_tanggal));
	
	RETURN number+1;
    END */$$
DELIMITER ;

/* Function  structure for function  `get_increment_id_penerimaan_by_request` */

/*!50003 DROP FUNCTION IF EXISTS `get_increment_id_penerimaan_by_request` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `get_increment_id_penerimaan_by_request`(p_tanggal DATETIME) RETURNS int(11)
BEGIN
	DECLARE number INT;
	SET number = (SELECT IFNULL(MAX(CONVERT(RIGHT(id_penerimaan_by_request, 9), INT)), 0) AS max_number FROM penerimaan_by_request WHERE DATE(tanggal) = DATE(p_tanggal));
	
	RETURN number+1;
    END */$$
DELIMITER ;

/* Function  structure for function  `get_increment_id_pengiriman` */

/*!50003 DROP FUNCTION IF EXISTS `get_increment_id_pengiriman` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `get_increment_id_pengiriman`(in_tanggal DATETIME) RETURNS int(11)
BEGIN
    DECLARE number INT;
	SET number = (SELECT IFNULL(MAX(CONVERT(RIGHT(id_pengiriman, 9), INT)), 0) AS max_number FROM pengiriman WHERE DATE(tanggal) = DATE(in_tanggal));
	
	return number+1;
    END */$$
DELIMITER ;

/* Function  structure for function  `get_increment_id_permintaan` */

/*!50003 DROP FUNCTION IF EXISTS `get_increment_id_permintaan` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `get_increment_id_permintaan`(in_tanggal datetime) RETURNS int(11)
BEGIN
	DECLARE number INT;
	SET number = (SELECT IFNULL(MAX(CONVERT(RIGHT(id_permintaan, 9), INT)), 0) AS max_number FROM permintaan WHERE DATE(tanggal) = DATE(in_tanggal));
	
	RETURN number+1;
    END */$$
DELIMITER ;

/* Function  structure for function  `get_increment_id_supplier` */

/*!50003 DROP FUNCTION IF EXISTS `get_increment_id_supplier` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `get_increment_id_supplier`() RETURNS int(11)
BEGIN
	declare number int;
	set number = (SELECT IFNULL(MAX(CONVERT(RIGHT(id_supplier, 4), INT)), 0) from supplier);
	return number+1;
    END */$$
DELIMITER ;

/* Function  structure for function  `get_increment_id_transaksi_laundry` */

/*!50003 DROP FUNCTION IF EXISTS `get_increment_id_transaksi_laundry` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `get_increment_id_transaksi_laundry`( in_tanggal datetime) RETURNS int(11)
BEGIN
	DECLARE number INT;
	SET number = (SELECT IFNULL(MAX(CONVERT(RIGHT(id_transaksi_laundry, 10), INT)), 0) AS max_number FROM transaksi_laundry WHERE DATE(tanggal) = DATE(in_tanggal));
	
	RETURN number+1;
    END */$$
DELIMITER ;

/* Function  structure for function  `get_increment_id_uom` */

/*!50003 DROP FUNCTION IF EXISTS `get_increment_id_uom` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `get_increment_id_uom`() RETURNS int(11)
BEGIN
	declare number int;
	set number = (SELECT IFNULL(MAX(CONVERT(RIGHT(id_uom, 4), INT)), 0) from uom);
	return number+1;
    END */$$
DELIMITER ;

/* Function  structure for function  `get_increment_id_uom_converter` */

/*!50003 DROP FUNCTION IF EXISTS `get_increment_id_uom_converter` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `get_increment_id_uom_converter`() RETURNS int(11)
BEGIN
	declare number int;
	set number = (SELECT IFNULL(MAX(CONVERT(RIGHT(id_uom_converter, 4), INT)), 0) from uom_converter);
	return number+1;
    END */$$
DELIMITER ;

/* Function  structure for function  `get_is_finished_activity_laundry` */

/*!50003 DROP FUNCTION IF EXISTS `get_is_finished_activity_laundry` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `get_is_finished_activity_laundry`(p_id_detail_laundry VARCHAR(25)) RETURNS tinyint(1)
BEGIN
	DECLARE UNFINISHED INT;
	DECLARE V_START DATETIME;
	DECLARE V_END DATETIME;
	DECLARE DoneLoop INTEGER DEFAULT FALSE;
	DECLARE Cursorloop CURSOR FOR
		SELECT v.mulai_pengerjaan, v.selesai FROM `view_get_aktivitas_laundry` v
		WHERE v.id_detail_laundry = p_id_detail_laundry;
		
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET DoneLoop = 1;
	SET UNFINISHED = 0;
	OPEN CursorLoop;
	readLoop: LOOP
		fetch CursorLoop INTO V_START, V_END;
		
		IF DoneLoop THEN
			LEAVE readloop;
		END IF;
		
		if V_START is null OR V_END IS NULL THEN
			set UNFINISHED = UNFINISHED + 1;
		end if;
	END LOOP;
	CLOSE CursorLoop;
	
	return UNFINISHED = 0;
		
    END */$$
DELIMITER ;

/* Function  structure for function  `get_latest_harga_beli` */

/*!50003 DROP FUNCTION IF EXISTS `get_latest_harga_beli` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `get_latest_harga_beli`(p_id_item char(10)) RETURNS int(11)
BEGIN
    DECLARE id int;
    
    set id = (SELECT MAX(id_harga_beli) as id FROM harga_beli WHERE id_item = p_id_item GROUP BY id_item);
    return id;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_cash_in_transaction_laundry` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_cash_in_transaction_laundry` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_cash_in_transaction_laundry`(IN p_id_cabang VARCHAR(5), IN p_tanggal DATETIME, IN p_id_transaksi CHAR(20))
BEGIN
	call procedure_new_cash_flow_cabang_in(p_id_cabang, p_tanggal, get_harga_transaksi_laundry(p_id_transaksi), CONCAT("Transaksi Laundry : ID_TRANSAKSI = [", p_id_transaksi, "]"), @out_cash_transaction );
    END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_cash_out_pembelian` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_cash_out_pembelian` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_cash_out_pembelian`(in p_id_hq CHAR(5), in p_tanggal DATETIME, IN p_id_pembelian CHAR(20))
BEGIN
	call procedure_new_cash_flow_hq_out(p_id_hq, p_tanggal, get_harga_pembelian(p_id_pembelian), concat("Transaksi Pembelian : ID_PEMBELIAN = [", p_id_pembelian, "]"), @out_cash_out); 
    END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_get_cash_cabang_all` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_get_cash_cabang_all` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_get_cash_cabang_all`()
BEGIN
SELECT
summary_cabang.id_cabang,
summary_cabang.alamat,
SUM(summary_cabang.jumlah) AS jumlah
FROM
(
SELECT
cin.`id_cabang`,
cin.alamat,
SUM(cin.`jumlah`) AS jumlah
FROM view_cash_in_cabang cin
GROUP BY cin.`id_cabang`
UNION ALL
SELECT
cout.`id_cabang`,
cout.alamat,
SUM(cout.`jumlah`)*-1 AS jumlah
FROM view_cash_out_cabang  cout
GROUP BY cout.id_cabang
) AS summary_cabang
GROUP BY summary_cabang.id_cabang;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_get_cash_hq_all` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_get_cash_hq_all` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_get_cash_hq_all`()
BEGIN
    SELECT
summary_hq.id_hq,
SUM(summary_hq.jumlah) AS jumlah
FROM
(
SELECT
hin.`id_hq`,
SUM(hin.`jumlah`) AS jumlah
FROM view_cash_in_hq hin
GROUP BY hin.`id_hq`
UNION ALL
SELECT
hout.`id_hq`,
SUM(hout.`jumlah`)*-1 AS jumlah
FROM view_cash_out_hq hout
GROUP BY hout.id_hq
) AS summary_hq
GROUP BY summary_hq.id_hq;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_cancel_pembelian` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_cancel_pembelian` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_cancel_pembelian`(in p_id_pembelian char(20))
BEGIN
	
	DECLARE DonePembelian INTEGER DEFAULT FALSE;
	DECLARE V_IS_SUCCESS TINYINT(1);
	DECLARE V_IS_PAID TINYINT(1);	
	DECLARE V_ID_HQ CHAR(5);
	
	DECLARE CursorPembelian CURSOR FOR	
		SELECT is_success, is_paid, id_hq FROM pembelian WHERE id_pembelian = p_id_pembelian;
	
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET DonePembelian = 1; 
	
	OPEN CursorPembelian; 
	
	readLoop: LOOP
		FETCH CursorPembelian INTO V_IS_SUCCESS, V_IS_PAID, V_ID_HQ;
		
		IF DonePembelian THEN
			LEAVE readLoop;
		END IF;
	END LOOP;
	CLOSE CursorPembelian;
			
	IF V_IS_SUCCESS != 1 THEN 
		CALL procedure_set_cancel_pembelian(p_id_pembelian);
		IF(V_IS_SUCCESS = 1) THEN 
			CALL procedure_new_cash_flow_hq_in(V_ID_HQ, NOW(), `get_harga_pembelian`(p_id_pembelian), CONCAT("REFUND PEMBELIAN : ID_PEMBELIAN = [", p_id_pembelian, "]"), @out_id_cash_flow_hq);
		END IF;
	END IF;
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_get_laporan_transaksi_cabang` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_get_laporan_transaksi_cabang` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_get_laporan_transaksi_cabang`(in p_date_from DATE, IN p_date_to DATE)
BEGIN
		select *
		from view_laporan_transaksi_cabang c
		where c.tanggal between first_day(p_date_from) and last_day(p_date_to);
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_get_pegawai_cabang` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_get_pegawai_cabang` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_get_pegawai_cabang`(in v_id_cabang char(5) )
BEGIN
		select * from pegawai
		where id_cabang = v_id_cabang;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_get_stock_all_cabang` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_get_stock_all_cabang` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_get_stock_all_cabang`()
BEGIN
SELECT stock.id_cabang, stock.id_item, i.nama, SUM(stock.total) AS total FROM (
	SELECT 
	vprs.`id_cabang`, vprs.`id_item`, vprs.`total`
	FROM `view_penerimaan_by_request_sum` vprs
		
	UNION ALL
	
	SELECT
	vpis.id_cabang, vpis.id_item, vpis.total*-1
	FROM view_penggunaan_item_sum vpis
	
	) stock
	JOIN item i
	ON stock.id_item = i.`id_item`
	GROUP BY stock.id_cabang, stock.id_item;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_get_stock_cabang` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_get_stock_cabang` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_get_stock_cabang`(IN id_cabang char(5))
BEGIN
SELECT stock.id_cabang, stock.id_item, i.nama, SUM(stock.total) AS total FROM (
	SELECT 
	vprs.`id_cabang`, vprs.`id_item`, vprs.`total`
	FROM `view_penerimaan_by_request_sum` vprs
		
	UNION ALL
	
	SELECT
	vpis.id_cabang, vpis.id_item, vpis.total*-1
	FROM view_penggunaan_item_sum vpis
	
	) stock
	JOIN item i
	ON stock.id_item = i.`id_item`
	GROUP BY stock.id_cabang, stock.id_item
	HAVING stock.id_cabang= id_cabang;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_get_stock_hq` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_get_stock_hq` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_get_stock_hq`(IN id_hq CHAR(5))
BEGIN
SELECT stock.id_hq, stock.id_item, i.nama, SUM(stock.total) AS total FROM (
	SELECT 
	vpps.`id_hq`, vpps.`id_item`, vpps.`total`
	FROM `view_penerimaan_by_purchase_sum` vpps
	UNION ALL
	SELECT 
	`vcimin`.`id_hq`, `vcimin`.`id_item`, vcimin.`total`*-1
	FROM`view_convert_item_pengurangan` vcimin
	UNION ALL
	
	SELECT
	vciplus.id_hq, vciplus.id_item, vciplus.total
	FROM view_convert_item_penambahan vciplus
	
	UNION ALL 
	
	select
	`vpis`.`id_hq`, `vpis`.`id_item`, vpis.`total`*-1
	from view_pengiriman_item_sum vpis	
	
	) stock
JOIN item i
ON stock.id_item = i.`id_item`
GROUP BY id_hq, id_item
HAVING stock.id_hq = id_hq;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_melakukan_pekerjaan` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_melakukan_pekerjaan` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_melakukan_pekerjaan`(in p_old_id_aktivitas_laundry VARCHAR(30), IN p_tanggal DATETIME)
BEGIN
	DECLARE V_ID_AKTIVITAS_LAUNDRY VARCHAR(30);
	DECLARE V_ID_AKTIVITAS VARCHAR(5);
	DECLARE V_ID_ITEM VARCHAR(10);
	DECLARE V_JUMLAH_ITEM DECIMAL(18,2);
	DECLARE V_REAL_QUANTITY DECIMAL(18,2);
	DECLARE DoneMembutuhkan INTEGER DEFAULT FALSE;
    	DECLARE CursorMembutuhkan CURSOR FOR
				
		SELECT
		al.`id_aktivitas_laundry`,
		al.`id_aktivitas`,
		m.`id_item`,
		m.`jumlah_item`,
		dl.`real_quantity`
		FROM aktivitas_laundry al
		JOIN membutuhkan m
		ON al.`id_aktivitas` = m.`id_aktivitas`
		JOIN detail_laundry dl
		ON al.`id_detail_laundry` = dl.`id_detail_laundry`
		WHERE al.`id_aktivitas_laundry` = p_old_id_aktivitas_laundry;
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET DoneMembutuhkan = 1; 
		OPEN CursorMembutuhkan;
		
		readloop: LOOP
			FETCH CursorMembutuhkan INTO V_ID_AKTIVITAS_LAUNDRY, V_ID_AKTIVITAS, V_ID_ITEM, V_JUMLAH_ITEM, V_REAL_QUANTITY;
			
			IF DoneMembutuhkan THEN
				LEAVE readloop;
			END IF;
			
			CALL procedure_new_penggunaan(V_ID_AKTIVITAS_LAUNDRY, V_ID_ITEM, (V_JUMLAH_ITEM * CEIL(V_REAL_QUANTITY)), p_tanggal);
			
		END LOOP;	
		CLOSE CursorMembutuhkan;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_mengerjakan_aktivitas_laundry` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_mengerjakan_aktivitas_laundry` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_mengerjakan_aktivitas_laundry`(in p_id_aktivitas_laundry char(30), in p_id_pegawai char(5))
BEGIN
		update aktivitas_laundry set id_pegawai = p_id_pegawai, mulai_pengerjaan =  now()
		where  id_aktivitas_laundry = p_id_aktivitas_laundry;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_mengerjakan_aktivitas_laundry_date` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_mengerjakan_aktivitas_laundry_date` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_mengerjakan_aktivitas_laundry_date`(IN p_id_aktivitas_laundry CHAR(30), IN p_id_pegawai CHAR(5), IN p_date DATETIME)
BEGIN
		UPDATE aktivitas_laundry SET id_pegawai = p_id_pegawai, mulai_pengerjaan =  p_date
		WHERE  id_aktivitas_laundry = p_id_aktivitas_laundry;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_menyelesaikan_aktivitas_laundry` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_menyelesaikan_aktivitas_laundry` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_menyelesaikan_aktivitas_laundry`(in p_id_aktivitas_laundry char(30))
BEGIN
		UPDATE aktivitas_laundry SET selesai =  NOW()
		WHERE  id_aktivitas_laundry = p_id_aktivitas_laundry;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_menyelesaikan_aktivitas_laundry_date` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_menyelesaikan_aktivitas_laundry_date` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_menyelesaikan_aktivitas_laundry_date`(IN p_id_aktivitas_laundry CHAR(30), IN p_date DATETIME)
BEGIN
		UPDATE aktivitas_laundry SET selesai =  p_date
		WHERE  id_aktivitas_laundry = p_id_aktivitas_laundry;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_new_aktivitas` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_new_aktivitas` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_new_aktivitas`(IN p_nama VARCHAR(250), IN p_deskripsi TEXT, OUT o_id_aktivitas CHAR(5))
BEGIN
	declare v_id_aktivitas  char(5);
	SET v_id_aktivitas = CONCAT('A', LPAD(get_increment_id_aktivitas(), 4, '0'));
	insert into aktivitas (id_aktivitas, nama, deskripsi)
	values (v_id_aktivitas, p_nama, p_deskripsi);
	set o_id_aktivitas = v_id_aktivitas;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_new_aktivitas_laundry` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_new_aktivitas_laundry` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_new_aktivitas_laundry`(in id_detail_laundry char(25), in id_aktivitas char(5), out o_id_aktivitas_laundry char(30))
BEGIN
		declare v_id_aktivitas_laundry char(30);
		set v_id_aktivitas_laundry = CONCAT('A', id_detail_laundry, LPAD(get_increment_id_aktivitas_laundry(id_detail_laundry), 4, '0'));
		insert into aktivitas_laundry (id_aktivitas_laundry, id_detail_laundry, id_aktivitas)
		values (v_id_aktivitas_laundry, id_detail_laundry, id_aktivitas);
		set o_id_aktivitas_laundry = v_id_aktivitas_laundry;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_new_aktivitas_menu` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_new_aktivitas_menu` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_new_aktivitas_menu`(IN p_id_aktivitas CHAR(5), IN p_id_menu CHAR(5))
BEGIN
insert into aktivitas_menu (id_aktivitas, id_menu)
		values (p_id_aktivitas, p_id_menu);
    END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_new_cash_flow_cabang_in` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_new_cash_flow_cabang_in` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_new_cash_flow_cabang_in`(in id_cabang char(5), in tanggal datetime, in jumlah decimal (18.2), in catatan text, out o_id_cash_flow_cabang char(20))
BEGIN
		declare v_id_cash_flow_cabang char(20);
		set v_id_cash_flow_cabang = CONCAT('CB1', YEAR(NOW()),  LPAD(MONTH(NOW()), 2, '0'), LPAD(DAY(NOW()), 2, '0'), LPAD(get_increment_id_cash_flow_cabang_in(tanggal), 9, '0'));
		insert into cash_flow_cabang (id_cash_flow_cabang, id_cabang, id_cash_type, tanggal, jumlah, catatan)
		values (v_id_cash_flow_cabang, id_cabang, '1', tanggal, jumlah, catatan);
		set o_id_cash_flow_cabang = v_id_cash_flow_cabang;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_new_cash_flow_cabang_out` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_new_cash_flow_cabang_out` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_new_cash_flow_cabang_out`(IN id_cabang CHAR(5), IN tanggal DATETIME, IN jumlah DECIMAL (18.2), IN catatan TEXT, OUT o_id_cash_flow_cabang CHAR(20))
BEGIN
		DECLARE v_id_cash_flow_cabang CHAR(20);
		SET v_id_cash_flow_cabang = CONCAT('CB2', YEAR(tanggal),  LPAD(MONTH(tanggal), 2, '0'), LPAD(DAY(tanggal), 2, '0'), LPAD(get_increment_id_cash_flow_cabang_out(tanggal), 9, '0'));
		INSERT INTO cash_flow_cabang (id_cash_flow_cabang, id_cabang, id_cash_type, tanggal, jumlah, catatan)
		VALUES (v_id_cash_flow_cabang, id_cabang, '2', tanggal, jumlah, catatan);
		SET o_id_cash_flow_cabang = v_id_cash_flow_cabang;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_new_cash_flow_hq_in` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_new_cash_flow_hq_in` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_new_cash_flow_hq_in`(IN id_hq CHAR(5), IN tanggal DATETIME, IN jumlah DECIMAL (18.2), IN catatan TEXT, OUT o_id_cash_flow_hq CHAR(20))
BEGIN
		DECLARE v_id_cash_flow_hq CHAR(20);
		SET v_id_cash_flow_hq = CONCAT('HQ1', YEAR(tanggal),  LPAD(MONTH(tanggal), 2, '0'), LPAD(DAY(tanggal), 2, '0'), LPAD(get_increment_id_cash_flow_hq_in(tanggal), 9, '0'));
		INSERT INTO cash_flow_hq (id_cash_flow_hq, id_hq, id_cash_type, tanggal, jumlah, catatan)
		VALUES (v_id_cash_flow_hq, id_hq, '1', tanggal, jumlah, catatan);
		SET o_id_cash_flow_hq = v_id_cash_flow_hq;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_new_cash_flow_hq_out` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_new_cash_flow_hq_out` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_new_cash_flow_hq_out`(IN id_hq CHAR(5), IN tanggal DATETIME, IN jumlah DECIMAL (18.2), IN catatan TEXT, OUT o_id_cash_flow_hq CHAR(20))
BEGIN
		DECLARE v_id_cash_flow_hq CHAR(20);
		SET v_id_cash_flow_hq = CONCAT('HQ2', YEAR(tanggal),  LPAD(MONTH(tanggal), 2, '0'), LPAD(DAY(tanggal), 2, '0'), LPAD(get_increment_id_cash_flow_hq_out(tanggal), 9, '0'));
		INSERT INTO cash_flow_hq (id_cash_flow_hq, id_hq, id_cash_type, tanggal, jumlah, catatan)
		VALUES (v_id_cash_flow_hq, id_hq, '2', tanggal, jumlah, catatan);
		SET o_id_cash_flow_hq = v_id_cash_flow_hq;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_new_convert_item` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_new_convert_item` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_new_convert_item`(IN p_id_hq CHAR(5), IN p_id_item_from CHAR(10), IN p_id_item_to CHAR(10), IN p_id_uom_converter CHAR(5), IN p_quantity DECIMAL(18,2))
BEGIN
    
    DECLARE v_id_convert_item1 CHAR(20);
	DECLARE v_id_convert_item2 CHAR(20);
	DECLARE v_quantity_result DECIMAL(18,2);
	
	/* insert menggunakan */
	SET v_id_convert_item1 = CONCAT('CI',  YEAR(NOW()), LPAD(MONTH(NOW()), 2, '0'), LPAD(DAY(NOW()), 2, '0'), LPAD(`get_increment_convert_item`(NOW()), 10, '0'));	
	INSERT INTO convert_item(id_convert_item, id_hq, id_item, id_reference, id_convert_type, id_uom_converter, quantity, tanggal) VALUES(v_id_convert_item1, p_id_hq, p_id_item_from, NULL, 'CT001', p_id_uom_converter, p_quantity, NOW());	
	/* innsert menghasilkan */
	SET v_quantity_result = (SELECT (p_quantity/uc.`factor`) FROM uom_converter uc WHERE uc.id_uom_converter = p_id_uom_converter);
	SET v_id_convert_item2 = CONCAT('CI',  YEAR(NOW()), LPAD(MONTH(NOW()), 2, '0'), LPAD(DAY(NOW()), 2, '0'), LPAD(`get_increment_convert_item`(NOW()), 10, '0'));	
	INSERT INTO convert_item(id_convert_item, id_hq, id_item, id_reference, id_convert_type, id_uom_converter, quantity, tanggal) VALUES(v_id_convert_item2, p_id_hq, p_id_item_to, v_id_convert_item1, 'CT002', p_id_uom_converter, v_quantity_result, NOW());
	
	update convert_item set id_reference = v_id_convert_item2 where id_convert_item  = v_id_convert_item1;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_new_detail_laundry` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_new_detail_laundry` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_new_detail_laundry`(IN p_id_transaksi_laundry CHAR(20), IN p_id_menu CHAR(8), IN p_real_quantity DOUBLE, IN p_info text)
BEGIN
	DECLARE v_id_detail_laundry CHAR(25);
	DECLARE v_quantity DOUBLE;
	DECLARE v_id_harga_menu BIGINT;
	
	SET v_id_detail_laundry = (SELECT CONCAT('D', p_id_transaksi_laundry, LPAD(get_increment_id_detail_laundry(p_id_transaksi_laundry), 4, '0')));
	SET v_quantity = (SELECT quantity_minimum FROM menu WHERE menu.`id_menu` = p_id_menu);
	SET v_id_harga_menu = (SELECT MAX(h.id_harga_menu) FROM harga_menu h WHERE h.id_menu = p_id_menu GROUP BY h.id_menu);
	
	IF(p_real_quantity >= v_quantity) THEN
		SET v_quantity = (SELECT CEIL(p_real_quantity));
	END IF;
	
	INSERT INTO detail_laundry(`id_detail_laundry`, `id_transaksi_laundry`, `id_menu`, `id_harga_menu`, `quantity`, `real_quantity`, `info`)
	VALUES(v_id_detail_laundry, p_id_transaksi_laundry, p_id_menu, v_id_harga_menu, v_quantity, p_real_quantity, p_info);
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_new_detail_pembelian` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_new_detail_pembelian` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_new_detail_pembelian`(IN p_id_pembelian CHAR(20), IN p_id_item CHAR(10), IN p_id_harga_beli INT, IN p_quantitiy DECIMAL(18,2))
BEGIN
    
    INSERT INTO detail_pembelian(`id_pembelian`, id_item, id_harga_beli, quantity) values(p_id_pembelian, p_id_item, p_id_harga_beli, p_quantitiy);
    
    END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_new_harga_beli` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_new_harga_beli` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_new_harga_beli`(in id_item char(10), in harga decimal(18.2))
BEGIN
		insert into harga_beli (id_harga_beli, id_item, harga, tanggal)
		VALUES (null, id_item, harga, now());
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_new_harga_menu` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_new_harga_menu` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_new_harga_menu`(in id_menu char(8), in harga decimal (18.2))
BEGIN
		insert into harga_menu (id_harga_menu, id_menu, harga, tanggal)
		VALUES (null, id_menu, harga, now());
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_new_item` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_new_item` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_new_item`(IN p_id_uom char(5), IN p_nama varchar(250), IN p_deskripsi text, out o_id_item char(10))
BEGIN
    DECLARE v_id_item CHAR(10);
    DECLARE counter VARCHAR(18);
    SET counter =(SELECT CONCAT('000000000', `get_increment_id_item`()));
    SET v_id_item = (SELECT CONCAT('I', SUBSTRING(counter, LENGTH(counter)-8, 9)));
    
    INSERT INTO item(`id_item`, `id_uom`, `nama`, `deskripsi`)
    VALUES(v_id_item, `p_id_uom`, `p_nama`, p_deskripsi);
    
    SET o_id_item = v_id_item;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_new_menu` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_new_menu` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_new_menu`(in id_uom char(5), in nama varchar(250), in deskripsi text , in quantity_minimum decimal(18,2), in lama_pengerjaan int(10), in is_available tinyint(1), out o_id_menu char(5))
BEGIN
		DECLARE v_id_menu CHAR(5);
		DECLARE counter VARCHAR(14);
		SET counter =(SELECT CONCAT('0000', `get_increment_id_menu`()));
		SET v_id_menu = (counter);
		INSERT INTO menu (id_menu, id_uom, nama, deskripsi, quantity_minimum, lama_pengerjaan, is_available)
		VALUES(v_id_menu, id_uom, nama, deskripsi, quantity_minimum, lama_pengerjaan, is_available);
		SET o_id_menu = v_id_menu;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_new_pegawai` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_new_pegawai` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_new_pegawai`(in id_cabang char(5), in nama varchar(250), in alamat text, In no_telp varchar(15), in is_active tinyint(1), out o_id_pegawai char(5))
BEGIN
		DECLARE v_id_pegawai CHAR(10);
		DECLARE counter VARCHAR(14);
		SET counter =(SELECT CONCAT('0000', `get_increment_id_pegawai`()));
		SET v_id_pegawai = (SELECT CONCAT('P', SUBSTRING(counter, LENGTH(counter)-3, 4)));
		INSERT INTO pegawai(id_pegawai, id_cabang, nama, alamat, no_telp, is_active)
		VALUES(v_id_pegawai, id_cabang, nama, alamat, no_telp, is_active);
		SET o_id_pegawai = v_id_pegawai;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_new_pelanggan` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_new_pelanggan` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_new_pelanggan`(in email varchar(250), in nama varchar(250), in no_telepon char(15), in alamat text, out o_id_pelanggan char(10))
BEGIN
		DECLARE v_id_pelanggan CHAR(10);
		DECLARE counter VARCHAR(14);
		SET counter =(SELECT CONCAT('000000', `get_increment_id_pelanggan`()));
		SET v_id_pelanggan = (SELECT CONCAT('CUST', SUBSTRING(counter, LENGTH(counter)-5, 6)));
		INSERT INTO pelanggan (id_pelanggan, email, nama, no_telepon, alamat)
		VALUES(v_id_pelanggan, email, nama, no_telepon, alamat);
		SET o_id_pelanggan = v_id_pelanggan;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_new_pembelian` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_new_pembelian` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_new_pembelian`(
	IN id_supplier CHAR(5),
	in id_hq CHAR(5),
	OUT o_id_pembelian varchar(20)
    )
BEGIN
    DECLARE v_id_pembelian CHAR(20);
    DECLARE counter VARCHAR(22);
    SET counter =( SELECT CONCAT('00000000000', get_increment_id_pembelian(NOW())) );
    SET v_id_pembelian = (SELECT CONCAT('P', YEAR(NOW()), LPAD(MONTH(NOW()), 2, '0'), LPAD(DAY(NOW()), 2, '0'), SUBSTRING(counter, LENGTH(counter)-10, 11)));				
    INSERT INTO pembelian(`id_pembelian`, `id_supplier`, `id_hq`, `tanggal`, `is_canceled`)
    VALUES(v_id_pembelian, `id_supplier`, `id_hq`, NOW(), 0);
    
    set o_id_pembelian = v_id_pembelian;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_new_penerimaan_by_purchase` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_new_penerimaan_by_purchase` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_new_penerimaan_by_purchase`(IN p_id_pembelian CHAR(20), IN p_id_hq CHAR(5), IN p_catatan TEXT, OUT o_id_penerimaan_purchase CHAR(20))
BEGIN
	DECLARE v_id_penerimaan_by_purchase CHAR(20);
	SET v_id_penerimaan_by_purchase = CONCAT('D',  YEAR(NOW()), LPAD(MONTH(NOW()), 2, '0'), LPAD(DAY(NOW()), 2, '0'), LPAD(`get_increment_id_penerimaan_by_purchase`(NOW()), 11, '0'));	
	INSERT INTO penerimaan_by_purchase (id_penerimaan_by_purchase, id_pembelian, id_hq, tanggal, catatan)
	VALUES (v_id_penerimaan_by_purchase, p_id_pembelian, p_id_hq, NOW(), p_catatan);
	set o_id_penerimaan_purchase = v_id_penerimaan_by_purchase;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_new_penerimaan_by_request` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_new_penerimaan_by_request` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_new_penerimaan_by_request`(IN p_id_pengiriman CHAR(20), IN p_id_cabang CHAR(5), IN p_catatan TEXT, OUT o_id_penerimaan_request CHAR(20))
BEGIN
	DECLARE v_id_penerimaan_by_request CHAR(20);
	SET v_id_penerimaan_by_request = CONCAT('REC',  YEAR(NOW()), LPAD(MONTH(NOW()), 2, '0'), LPAD(DAY(NOW()), 2, '0'), LPAD(`get_increment_id_penerimaan_by_request`(NOW()), 9, '0'));	
	INSERT INTO penerimaan_by_request (id_penerimaan_by_request, id_pengiriman, id_cabang, tanggal, catatan)
	VALUES (v_id_penerimaan_by_request, p_id_pengiriman, p_id_cabang, NOW(), p_catatan);
	set o_id_penerimaan_request = v_id_penerimaan_by_request;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_new_penerimaan_item_purchase` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_new_penerimaan_item_purchase` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_new_penerimaan_item_purchase`(IN p_id_penerimaan_by_purchase CHAR(20), In p_id_item CHAR(10), IN p_quantity DECIMAL(18,2))
BEGIN
	INSERT INTO penerimaan_item_purchase(id_penerimaan_by_purchase, id_item, quantity)
	VALUES(p_id_penerimaan_by_purchase, p_id_item, p_quantity);
    END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_new_penerimaan_item_request` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_new_penerimaan_item_request` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_new_penerimaan_item_request`(IN p_id_penerimaan_by_request CHAR(20), In p_id_item CHAR(10), IN p_quantity DECIMAL(18,2))
BEGIN
	INSERT INTO penerimaan_item_request(id_penerimaan_by_request, id_item, quantity)
	VALUES(p_id_penerimaan_by_request, p_id_item, p_quantity);
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_new_penggunaan` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_new_penggunaan` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_new_penggunaan`(in p_id_aktivitas_laundry char(30), in p_id_item char(10), in p_quantitiy decimal(18,2), IN p_tanggal DATETIME)
BEGIN
		insert into penggunaan (id_aktivitas_laundry, id_item, quantity, tanggal)
		values (p_id_aktivitas_laundry, p_id_item, p_quantitiy, p_tanggal);
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_new_pengiriman` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_new_pengiriman` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_new_pengiriman`(in p_id_permintaan char(20), IN p_id_hq CHAR(5), out o_id_pengiriman char(20))
BEGIN
		DECLARE v_id_pengiriman CHAR(20);
		declare v_id_cabang char(5);
		
		DECLARE counter VARCHAR(22);
		SET counter =( SELECT CONCAT('000000000', get_increment_id_pengiriman(NOW())) );
		SET v_id_pengiriman = (SELECT CONCAT('DEL', YEAR(NOW()), LPAD(MONTH(NOW()), 2, '0'), LPAD(DAY(NOW()), 2, '0'), SUBSTRING(counter, LENGTH(counter)-8, 9)));
		
		set v_id_cabang = (select id_cabang from permintaan where id_permintaan = p_id_permintaan);
						
		INSERT INTO pengiriman (id_pengiriman, id_permintaan, id_cabang, id_hq, tanggal)
		VALUES(v_id_pengiriman, p_id_permintaan, v_id_cabang, p_id_hq, NOW());
		
		set o_id_pengiriman = v_id_pengiriman;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_new_pengiriman_item` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_new_pengiriman_item` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_new_pengiriman_item`(in p_id_pengiriman char(20), in p_id_item char(10), in p_quantity decimal(18,2))
BEGIN
		INSERT INTO pengiriman_item(id_pengiriman, id_item, quantity) values(p_id_pengiriman, p_id_item, p_quantity);
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_new_permintaan` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_new_permintaan` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_new_permintaan`(in id_cabang char(5), in deskripsi text, out o_id_permintaan varchar(20))
BEGIN
		declare v_id_permintaan char(20);
		declare counter varchar (22);
		set counter = (SELECT CONCAT('000000000', get_increment_id_permintaan(NOW())));
		set v_id_permintaan = (SELECT CONCAT('REQ', YEAR(NOW()),  LPAD(MONTH(NOW()), 2, '0'), LPAD(DAY(NOW()), 2, '0'), SUBSTRING(counter, LENGTH(counter)-8, 9)));
		insert into permintaan (`id_permintaan`, `id_cabang`, `deskripsi`, `tanggal`, `is_accepted`)
		VALUES ( `v_id_permintaan`, `id_cabang`, `deskripsi`, now(), 0);
		
		set o_id_permintaan = v_id_permintaan;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_new_permintaan_item` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_new_permintaan_item` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_new_permintaan_item`(in p_id_permintaan char(20), in p_id_item char(10), in p_quantity decimal(18,2))
BEGIN
		INSERT INTO permintaan_item(id_permintaan, id_item, quantity) values(p_id_permintaan, p_id_item, p_quantity);
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_new_supplier` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_new_supplier` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_new_supplier`(IN p_nama VARCHAR(250), IN p_alamat TEXT, IN p_no_tlp VARCHAR(20), OUT o_id_supplier CHAR(10))
BEGIN
		DECLARE v_id_supplier CHAR(10);
		DECLARE counter VARCHAR(14);
		SET counter =(SELECT CONCAT('0000', `get_increment_id_supplier`()));
		SET v_id_supplier = (SELECT CONCAT('S', SUBSTRING(counter, LENGTH(counter)-3, 4)));
		INSERT INTO supplier(`id_supplier`, `nama`, `alamat`, `no_tlp`)
		VALUES(v_id_supplier, `p_nama`, `p_alamat`, `p_no_tlp`);
		SET o_id_supplier = v_id_supplier;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_new_transaksi_laundry` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_new_transaksi_laundry` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_new_transaksi_laundry`(in id_cabang char(5), in id_pelanggan char(10), out o_id_transaksi_laundry char(20))
BEGIN
		declare v_id_transaksi_laundry char(20);
		declare counter varchar (22);
		set counter = (SELECT CONCAT('000000000', get_increment_id_transaksi_laundry(NOW())));
		set v_id_transaksi_laundry = (SELECT CONCAT('TR', YEAR(NOW()),  LPAD(MONTH(NOW()), 2, '0'), LPAD(DAY(NOW()), 2, '0'), SUBSTRING(counter, LENGTH(counter)-9, 10)));
		insert into transaksi_laundry (id_transaksi_laundry, id_cabang, id_pelanggan, tanggal)
		VALUES (v_id_transaksi_laundry, id_cabang, id_pelanggan, now());
		
		set o_id_transaksi_laundry = v_id_transaksi_laundry;
		
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_new_transaksi_laundry_date` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_new_transaksi_laundry_date` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_new_transaksi_laundry_date`(IN id_cabang CHAR(5), IN id_pelanggan CHAR(10), IN p_date DATETIME, OUT o_id_transaksi_laundry CHAR(20))
BEGIN
		DECLARE v_id_transaksi_laundry CHAR(20);
		DECLARE counter VARCHAR (22);
		SET counter = (SELECT CONCAT('000000000', get_increment_id_transaksi_laundry(p_date)));
		SET v_id_transaksi_laundry = (SELECT CONCAT('TR', YEAR(p_date),  LPAD(MONTH(p_date), 2, '0'), LPAD(DAY(p_date), 2, '0'), SUBSTRING(counter, LENGTH(counter)-9, 10)));
		INSERT INTO transaksi_laundry (id_transaksi_laundry, id_cabang, id_pelanggan, tanggal)
		VALUES (v_id_transaksi_laundry, id_cabang, id_pelanggan, p_date);
		
		SET o_id_transaksi_laundry = v_id_transaksi_laundry;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_new_uom` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_new_uom` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_new_uom`(in nama varchar(250), in singkatan varchar(25), out o_id_uom char(5))
BEGIN
		DECLARE v_id_uom CHAR (5);
		SET v_id_uom = CONCAT('U', LPAD(get_increment_id(), 4, '0'));
		INSERT INTO uom (id_uom, nama, singkatan)
		values (v_id_uom, nama, singkatan);
		
		set o_id_uom = v_id_uom;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_new_uom_converter` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_new_uom_converter` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_new_uom_converter`(in id_uom char(5), in uom_id_uom CHAR(5), in factor double, out o_id_uom_converter char(5))
BEGIN
	declare v_id_uom_converter char(5);
	set v_id_uom_converter = CONCAT('C', LPAD(get_increment_id_uom_converter(), 4, '0'));
	insert into uom_converter (id_uom_converter, id_uom, uom_id_uom, factor)
	values (v_id_uom_converter, id_uom, uom_id_uom, factor);
	set o_id_uom_converter = v_id_uom_converter;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_paid_laundry` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_paid_laundry` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_paid_laundry`(IN p_id_transaksi_laundry CHAR(20))
BEGIN
    
	UPDATE transaksi_laundry SET is_paid = 1 WHERE id_transaksi_laundry = p_id_transaksi_laundry;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_paid_pembelian` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_paid_pembelian` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_paid_pembelian`(in p_id_pembelian char(20))
BEGIN
	UPDATE pembelian SET is_paid = 1 WHERE id_pembelian = p_id_pembelian;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_penerimaan_item_purchase` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_penerimaan_item_purchase` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_penerimaan_item_purchase`(IN p_id_penerimaan_by_purchase CHAR(20))
BEGIN
	DECLARE V_ID_ITEM VARCHAR(10);
	DECLARE V_JUMLAH_ITEM DECIMAL(18,2);
	
	DECLARE DonePenerimaanPurchase INTEGER DEFAULT FALSE;
    	DECLARE CursorPenerimaanPurchase CURSOR FOR	
		SELECT
		dp.`id_item`,
		dp.`quantity`
		FROM detail_pembelian dp
		JOIN penerimaan_by_purchase p 
		ON dp.`id_pembelian` = p.`id_pembelian`
		WHERE p.`id_penerimaan_by_purchase` = p_id_penerimaan_by_purchase;
		
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET DonePenerimaanPurchase = 1; 
		OPEN CursorPenerimaanPurchase;
		
		readloop: LOOP
			FETCH CursorPenerimaanPurchase INTO V_ID_ITEM, V_JUMLAH_ITEM;
			
			IF DonePenerimaanPurchase THEN
				LEAVE readloop;
			END IF;
			
			call procedure_new_penerimaan_by_purchase(p_id_penerimaan_by_purchase, V_ID_ITEM, V_JUMLAH_ITEM);
		END LOOP;	
		CLOSE CursorPenerimaanPurchase;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_penerimaan_item_request` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_penerimaan_item_request` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_penerimaan_item_request`(IN p_id_penerimaan_by_request CHAR(20))
BEGIN
	DECLARE V_ID_ITEM VARCHAR(10);
	DECLARE V_JUMLAH_ITEM DECIMAL(18,2);
	
	DECLARE DonePenerimaanRequest INTEGER DEFAULT FALSE;
    	DECLARE CursorPenerimaanRequest CURSOR FOR	
		SELECT
		pi.`id_item`,
		pi.`quantity`
		FROM pengiriman_item `pi`
		JOIN penerimaan_by_request pr 
		ON pi.`id_pengiriman` = pr.`id_pengiriman`
		WHERE pr.`id_penerimaan_by_request` = p_id_penerimaan_by_request;		
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET DonePenerimaanRequest = 1; 
		OPEN CursorPenerimaanRequest;
		
		readloop: LOOP
			FETCH CursorPenerimaanRequest INTO V_ID_ITEM, V_JUMLAH_ITEM;
			
			IF DonePenerimaanRequest THEN
				LEAVE readloop;
			END IF;
			
			call procedure_new_penerimaan_by_purchase(p_id_penerimaan_by_purchase, V_ID_ITEM, V_JUMLAH_ITEM);
		END LOOP;	
		CLOSE CursorPenerimaanRequest;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_pengambilan_laundry` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_pengambilan_laundry` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_pengambilan_laundry`(IN p_id_transaksi CHAR(20))
BEGIN
		update transaksi_laundry set waktu_pengambilan = NOW(), is_taken = 1 where id_transaksi_laundry = p_id_transaksi;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_pengiriman_uang_ke_cabang_nominal` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_pengiriman_uang_ke_cabang_nominal` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_pengiriman_uang_ke_cabang_nominal`(IN p_id_hq CHAR(5), IN p_id_cabang CHAR(5), IN p_nominal DECIMAL(18,2))
BEGIN
		DECLARE EXIT HANDLER FOR SQLEXCEPTION
		  BEGIN
		    
		  ROLLBACK;
		END;
		DECLARE EXIT HANDLER FOR SQLWARNING
		 BEGIN
		    -- WARNING
		 ROLLBACK;
		END;
		START TRANSACTION;
			CALL `procedure_new_cash_flow_cabang_in`(p_id_cabang, NOW(), p_nominal, CONCAT('DANA MASUK DARI HQ[', p_id_hq, ']'), @in_cash_cabang);
			CALL `procedure_new_cash_flow_hq_out`(p_id_hq, NOW(), p_nominal, CONCAT('PENGIRIMAN DANA KE CABANG [', p_id_cabang, ']'), @out_cash_hq);
		COMMIT;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_pengiriman_uang_ke_hq` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_pengiriman_uang_ke_hq` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_pengiriman_uang_ke_hq`(IN p_id_cabang CHAR(5), IN p_id_hq CHAR(5))
BEGIN
		DECLARE exit handler for sqlexception
		  BEGIN
		    
		  ROLLBACK;
		END;
		DECLARE exit handler for sqlwarning
		 BEGIN
		    -- WARNING
		 ROLLBACK;
		END;
		START TRANSACTION;
			CALL `procedure_new_cash_flow_hq_in`(p_id_hq, NOW(), get_cash_cabang(p_id_cabang), CONCAT('DANA MASUK DARI CABANG [', p_id_cabang, ']'), @in_cash_hq);
			CALL `procedure_new_cash_flow_cabang_out`(p_id_cabang, NOW(), get_cash_cabang(p_id_cabang), CONCAT('PENGIRIMAN DANA KE HQ [', p_id_hq, ']'), @out_cash_cabang);
		COMMIT;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_pengiriman_uang_ke_hq_nominal` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_pengiriman_uang_ke_hq_nominal` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_pengiriman_uang_ke_hq_nominal`(IN p_id_cabang CHAR(5), IN p_id_hq CHAR(5), IN p_nominal DECIMAL(18,2))
BEGIN
		DECLARE EXIT HANDLER FOR SQLEXCEPTION
		  BEGIN
		    
		  ROLLBACK;
		END;
		DECLARE EXIT HANDLER FOR SQLWARNING
		 BEGIN
		    -- WARNING
		 ROLLBACK;
		END;
		START TRANSACTION;
			CALL `procedure_new_cash_flow_hq_in`(p_id_hq, NOW(), p_nominal, CONCAT('DANA MASUK DARI CABANG [', p_id_cabang, ']'), @in_cash_hq);
			CALL `procedure_new_cash_flow_cabang_out`(p_id_cabang, NOW(), p_nominal, CONCAT('PENGIRIMAN DANA KE HQ [', p_id_hq, ']'), @out_cash_hq);
		COMMIT;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_pengiriman_item` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_pengiriman_item` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_pengiriman_item`(IN p_id_pengiriman CHAR(20))
BEGIN
	DECLARE V_ID_ITEM VARCHAR(10);
	DECLARE V_JUMLAH_ITEM DECIMAL(18,2);
	DECLARE DoneMengirim INTEGER DEFAULT FALSE;
    	DECLARE CursorMengirim CURSOR FOR		
		SELECT
		pi.`id_item`,
		pi.`quantity`
		FROM permintaan_item `pi`
		join pengiriman `p`
		on `pi`.id_permintaan = p.id_permintaan
		WHERE p.`id_pengiriman` = p_id_pengiriman;
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET DoneMengirim = 1; 
		OPEN CursorMengirim;
		
		readloop: LOOP
			FETCH CursorMengirim INTO V_ID_ITEM, V_JUMLAH_ITEM;
			
			IF DoneMengirim THEN
				LEAVE readloop;
			END IF;
			
			call procedure_new_pengiriman_item(p_id_pengiriman, V_ID_ITEM, V_JUMLAH_ITEM);
		END LOOP;	
		CLOSE CursorMengirim;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure_set_cancel_pembelian` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure_set_cancel_pembelian` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_set_cancel_pembelian`(IN p_id_pembelian CHAR(20))
BEGIN
	update pembelian set is_canceled = 1 where id_pembelian = p_id_pembelian;
    END */$$
DELIMITER ;

/*Table structure for table `view_cash_in_cabang` */

DROP TABLE IF EXISTS `view_cash_in_cabang`;

/*!50001 DROP VIEW IF EXISTS `view_cash_in_cabang` */;
/*!50001 DROP TABLE IF EXISTS `view_cash_in_cabang` */;

/*!50001 CREATE TABLE  `view_cash_in_cabang`(
 `id_cash_flow_cabang` char(20) ,
 `id_cash_type` int(10) unsigned ,
 `id_cabang` char(5) ,
 `jumlah` decimal(18,2) ,
 `tanggal` datetime 
)*/;

/*Table structure for table `view_cash_in_cabang_monthly` */

DROP TABLE IF EXISTS `view_cash_in_cabang_monthly`;

/*!50001 DROP VIEW IF EXISTS `view_cash_in_cabang_monthly` */;
/*!50001 DROP TABLE IF EXISTS `view_cash_in_cabang_monthly` */;

/*!50001 CREATE TABLE  `view_cash_in_cabang_monthly`(
 `id_cabang` char(5) ,
 `jumlah` decimal(40,2) ,
 `tahun` int(4) ,
 `bulan` int(2) 
)*/;

/*Table structure for table `view_cash_in_hq` */

DROP TABLE IF EXISTS `view_cash_in_hq`;

/*!50001 DROP VIEW IF EXISTS `view_cash_in_hq` */;
/*!50001 DROP TABLE IF EXISTS `view_cash_in_hq` */;

/*!50001 CREATE TABLE  `view_cash_in_hq`(
 `id_cash_flow_hq` char(20) ,
 `id_cash_type` int(10) unsigned ,
 `id_hq` char(5) ,
 `jumlah` decimal(18,2) ,
 `tanggal` datetime 
)*/;

/*Table structure for table `view_cash_in_hq_monthly` */

DROP TABLE IF EXISTS `view_cash_in_hq_monthly`;

/*!50001 DROP VIEW IF EXISTS `view_cash_in_hq_monthly` */;
/*!50001 DROP TABLE IF EXISTS `view_cash_in_hq_monthly` */;

/*!50001 CREATE TABLE  `view_cash_in_hq_monthly`(
 `id_hq` char(5) ,
 `jumlah` decimal(40,2) ,
 `tahun` int(4) ,
 `bulan` int(2) 
)*/;

/*Table structure for table `view_cash_out_cabang` */

DROP TABLE IF EXISTS `view_cash_out_cabang`;

/*!50001 DROP VIEW IF EXISTS `view_cash_out_cabang` */;
/*!50001 DROP TABLE IF EXISTS `view_cash_out_cabang` */;

/*!50001 CREATE TABLE  `view_cash_out_cabang`(
 `id_cash_flow_cabang` char(20) ,
 `id_cash_type` int(10) unsigned ,
 `id_cabang` char(5) ,
 `jumlah` decimal(18,2) ,
 `tanggal` datetime 
)*/;

/*Table structure for table `view_cash_out_cabang_monthly` */

DROP TABLE IF EXISTS `view_cash_out_cabang_monthly`;

/*!50001 DROP VIEW IF EXISTS `view_cash_out_cabang_monthly` */;
/*!50001 DROP TABLE IF EXISTS `view_cash_out_cabang_monthly` */;

/*!50001 CREATE TABLE  `view_cash_out_cabang_monthly`(
 `id_cabang` char(5) ,
 `jumlah` decimal(40,2) ,
 `tahun` int(4) ,
 `bulan` int(2) 
)*/;

/*Table structure for table `view_cash_out_hq` */

DROP TABLE IF EXISTS `view_cash_out_hq`;

/*!50001 DROP VIEW IF EXISTS `view_cash_out_hq` */;
/*!50001 DROP TABLE IF EXISTS `view_cash_out_hq` */;

/*!50001 CREATE TABLE  `view_cash_out_hq`(
 `id_cash_flow_hq` char(20) ,
 `id_cash_type` int(10) unsigned ,
 `id_hq` char(5) ,
 `jumlah` decimal(18,2) ,
 `tanggal` datetime 
)*/;

/*Table structure for table `view_cash_out_hq_monthly` */

DROP TABLE IF EXISTS `view_cash_out_hq_monthly`;

/*!50001 DROP VIEW IF EXISTS `view_cash_out_hq_monthly` */;
/*!50001 DROP TABLE IF EXISTS `view_cash_out_hq_monthly` */;

/*!50001 CREATE TABLE  `view_cash_out_hq_monthly`(
 `id_hq` char(5) ,
 `jumlah` decimal(40,2) ,
 `tahun` int(4) ,
 `bulan` int(2) 
)*/;

/*Table structure for table `view_convert_item_penambahan` */

DROP TABLE IF EXISTS `view_convert_item_penambahan`;

/*!50001 DROP VIEW IF EXISTS `view_convert_item_penambahan` */;
/*!50001 DROP TABLE IF EXISTS `view_convert_item_penambahan` */;

/*!50001 CREATE TABLE  `view_convert_item_penambahan`(
 `id_item` char(10) ,
 `id_convert_type` char(5) ,
 `id_hq` char(5) ,
 `total` decimal(27,2) 
)*/;

/*Table structure for table `view_convert_item_pengurangan` */

DROP TABLE IF EXISTS `view_convert_item_pengurangan`;

/*!50001 DROP VIEW IF EXISTS `view_convert_item_pengurangan` */;
/*!50001 DROP TABLE IF EXISTS `view_convert_item_pengurangan` */;

/*!50001 CREATE TABLE  `view_convert_item_pengurangan`(
 `id_item` char(10) ,
 `id_convert_type` char(5) ,
 `id_hq` char(5) ,
 `total` decimal(27,2) 
)*/;

/*Table structure for table `view_get_aktivitas_laundry` */

DROP TABLE IF EXISTS `view_get_aktivitas_laundry`;

/*!50001 DROP VIEW IF EXISTS `view_get_aktivitas_laundry` */;
/*!50001 DROP TABLE IF EXISTS `view_get_aktivitas_laundry` */;

/*!50001 CREATE TABLE  `view_get_aktivitas_laundry`(
 `id_aktivitas_laundry` char(30) ,
 `id_detail_laundry` char(25) ,
 `id_transaksi_laundry` char(20) ,
 `id_pegawai` char(5) ,
 `nama_pegawai` varchar(250) ,
 `id_aktivitas` char(5) ,
 `nama_aktivitas` varchar(250) ,
 `mulai_pengerjaan` datetime ,
 `selesai` datetime 
)*/;

/*Table structure for table `view_get_menu` */

DROP TABLE IF EXISTS `view_get_menu`;

/*!50001 DROP VIEW IF EXISTS `view_get_menu` */;
/*!50001 DROP TABLE IF EXISTS `view_get_menu` */;

/*!50001 CREATE TABLE  `view_get_menu`(
 `id_menu` char(8) ,
 `nama` varchar(250) ,
 `deskripsi` text ,
 `minimum` varchar(46) ,
 `harga_menu` decimal(18,2) 
)*/;

/*Table structure for table `view_get_transaksi_laundry` */

DROP TABLE IF EXISTS `view_get_transaksi_laundry`;

/*!50001 DROP VIEW IF EXISTS `view_get_transaksi_laundry` */;
/*!50001 DROP TABLE IF EXISTS `view_get_transaksi_laundry` */;

/*!50001 CREATE TABLE  `view_get_transaksi_laundry`(
 `id_transaksi_laundry` char(20) ,
 `id_cabang` char(5) ,
 `id_pelanggan` char(10) ,
 `is_paid` tinyint(1) ,
 `is_taken` tinyint(1) ,
 `tanggal` datetime ,
 `waktu_pengambilan` datetime ,
 `id_detail_laundry` char(25) ,
 `quantity` double ,
 `real_quantity` double ,
 `id_menu` char(8) ,
 `harga_menu` decimal(18,2) ,
 `nama` varchar(250) ,
 `biaya` double 
)*/;

/*Table structure for table `view_laporan_penerimaan_by_purchase` */

DROP TABLE IF EXISTS `view_laporan_penerimaan_by_purchase`;

/*!50001 DROP VIEW IF EXISTS `view_laporan_penerimaan_by_purchase` */;
/*!50001 DROP TABLE IF EXISTS `view_laporan_penerimaan_by_purchase` */;

/*!50001 CREATE TABLE  `view_laporan_penerimaan_by_purchase`(
 `tanggal` datetime ,
 `id_hq` char(5) ,
 `id_penerimaan_by_purchase` char(20) ,
 `id_pembelian` char(20) ,
 `id_item` char(10) ,
 `nama` varchar(250) ,
 `satuan` varchar(25) ,
 `quantity` decimal(18,2) 
)*/;

/*Table structure for table `view_laporan_penerimaan_by_request` */

DROP TABLE IF EXISTS `view_laporan_penerimaan_by_request`;

/*!50001 DROP VIEW IF EXISTS `view_laporan_penerimaan_by_request` */;
/*!50001 DROP TABLE IF EXISTS `view_laporan_penerimaan_by_request` */;

/*!50001 CREATE TABLE  `view_laporan_penerimaan_by_request`(
 `tanggal` datetime ,
 `id_cabang` char(5) ,
 `id_penerimaan_by_request` char(20) ,
 `id_item` char(10) ,
 `nama` varchar(250) ,
 `satuan` varchar(25) ,
 `quantity` decimal(18,2) 
)*/;

/*Table structure for table `view_laporan_pengiriman_item` */

DROP TABLE IF EXISTS `view_laporan_pengiriman_item`;

/*!50001 DROP VIEW IF EXISTS `view_laporan_pengiriman_item` */;
/*!50001 DROP TABLE IF EXISTS `view_laporan_pengiriman_item` */;

/*!50001 CREATE TABLE  `view_laporan_pengiriman_item`(
 `tanggal` datetime ,
 `id_hq` char(5) ,
 `id_cabang` char(5) ,
 `id_permintaan` char(20) ,
 `id_pengiriman` char(20) ,
 `id_item` char(10) ,
 `nama` varchar(250) ,
 `satuan` varchar(25) ,
 `quantity` decimal(18,2) 
)*/;

/*Table structure for table `view_laporan_permintaan_item_cabang` */

DROP TABLE IF EXISTS `view_laporan_permintaan_item_cabang`;

/*!50001 DROP VIEW IF EXISTS `view_laporan_permintaan_item_cabang` */;
/*!50001 DROP TABLE IF EXISTS `view_laporan_permintaan_item_cabang` */;

/*!50001 CREATE TABLE  `view_laporan_permintaan_item_cabang`(
 `tanggal` datetime ,
 `id_cabang` char(5) ,
 `id_permintaan` char(20) ,
 `id_item` char(10) ,
 `nama` varchar(250) ,
 `satuan` varchar(25) ,
 `quantity` decimal(18,2) ,
 `status_permintaan` varchar(15) 
)*/;

/*Table structure for table `view_laporan_transaksi_cabang` */

DROP TABLE IF EXISTS `view_laporan_transaksi_cabang`;

/*!50001 DROP VIEW IF EXISTS `view_laporan_transaksi_cabang` */;
/*!50001 DROP TABLE IF EXISTS `view_laporan_transaksi_cabang` */;

/*!50001 CREATE TABLE  `view_laporan_transaksi_cabang`(
 `tanggal` datetime ,
 `id_cabang` char(5) ,
 `id_transaksi_laundry` char(20) ,
 `id_detail_laundry` char(25) ,
 `id_menu` char(8) ,
 `id_pelanggan` char(10) ,
 `nama_pelanggan` varchar(250) ,
 `no_telepon_pelanggan` char(15) ,
 `nama` varchar(250) ,
 `quantity` double ,
 `satuan` varchar(25) ,
 `total_harga` double ,
 `is_paid` tinyint(1) ,
 `is_taken` tinyint(1) ,
 `waktu_pengambilan` datetime ,
 `info` text ,
 `selesai_dikerjakan` tinyint(1) 
)*/;

/*Table structure for table `view_laporan_transaksi_cabang_detail` */

DROP TABLE IF EXISTS `view_laporan_transaksi_cabang_detail`;

/*!50001 DROP VIEW IF EXISTS `view_laporan_transaksi_cabang_detail` */;
/*!50001 DROP TABLE IF EXISTS `view_laporan_transaksi_cabang_detail` */;

/*!50001 CREATE TABLE  `view_laporan_transaksi_cabang_detail`(
 `tanggal` datetime ,
 `id_cabang` char(5) ,
 `id_transaksi_laundry` char(20) ,
 `id_detail_laundry` char(25) ,
 `id_menu` char(8) ,
 `nama` varchar(250) ,
 `quantity` double ,
 `satuan` varchar(25) ,
 `total_harga` double ,
 `status_pembayaran` varchar(13) ,
 `status_pengambilan` varchar(13) 
)*/;

/*Table structure for table `view_penerimaan_by_purchase_sum` */

DROP TABLE IF EXISTS `view_penerimaan_by_purchase_sum`;

/*!50001 DROP VIEW IF EXISTS `view_penerimaan_by_purchase_sum` */;
/*!50001 DROP TABLE IF EXISTS `view_penerimaan_by_purchase_sum` */;

/*!50001 CREATE TABLE  `view_penerimaan_by_purchase_sum`(
 `id_hq` char(5) ,
 `id_item` char(10) ,
 `total` decimal(40,2) 
)*/;

/*Table structure for table `view_penerimaan_by_request_sum` */

DROP TABLE IF EXISTS `view_penerimaan_by_request_sum`;

/*!50001 DROP VIEW IF EXISTS `view_penerimaan_by_request_sum` */;
/*!50001 DROP TABLE IF EXISTS `view_penerimaan_by_request_sum` */;

/*!50001 CREATE TABLE  `view_penerimaan_by_request_sum`(
 `id_cabang` char(5) ,
 `id_item` char(10) ,
 `total` decimal(40,2) 
)*/;

/*Table structure for table `view_penggunaan_item_sum` */

DROP TABLE IF EXISTS `view_penggunaan_item_sum`;

/*!50001 DROP VIEW IF EXISTS `view_penggunaan_item_sum` */;
/*!50001 DROP TABLE IF EXISTS `view_penggunaan_item_sum` */;

/*!50001 CREATE TABLE  `view_penggunaan_item_sum`(
 `id_cabang` char(5) ,
 `id_item` char(10) ,
 `total` decimal(40,2) 
)*/;

/*Table structure for table `view_penggunaan_item_with_cabang` */

DROP TABLE IF EXISTS `view_penggunaan_item_with_cabang`;

/*!50001 DROP VIEW IF EXISTS `view_penggunaan_item_with_cabang` */;
/*!50001 DROP TABLE IF EXISTS `view_penggunaan_item_with_cabang` */;

/*!50001 CREATE TABLE  `view_penggunaan_item_with_cabang`(
 `id_cabang` char(5) ,
 `id_transaksi_laundry` char(20) ,
 `id_detail_laundry` char(25) ,
 `id_aktivitas_laundry` char(30) ,
 `id_aktivitas` char(5) ,
 `selesai` datetime ,
 `id_item` char(10) ,
 `nama` varchar(250) ,
 `satuan` varchar(25) ,
 `quantity` decimal(18,2) 
)*/;

/*Table structure for table `view_pengiriman_item_sum` */

DROP TABLE IF EXISTS `view_pengiriman_item_sum`;

/*!50001 DROP VIEW IF EXISTS `view_pengiriman_item_sum` */;
/*!50001 DROP TABLE IF EXISTS `view_pengiriman_item_sum` */;

/*!50001 CREATE TABLE  `view_pengiriman_item_sum`(
 `id_hq` char(5) ,
 `id_item` char(10) ,
 `total` decimal(40,2) 
)*/;

/*View structure for view view_cash_in_cabang */

/*!50001 DROP TABLE IF EXISTS `view_cash_in_cabang` */;
/*!50001 DROP VIEW IF EXISTS `view_cash_in_cabang` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_cash_in_cabang` AS select `c`.`id_cash_flow_cabang` AS `id_cash_flow_cabang`,`c`.`id_cash_type` AS `id_cash_type`,`c`.`id_cabang` AS `id_cabang`,`c`.`jumlah` AS `jumlah`,`c`.`tanggal` AS `tanggal` from `cash_flow_cabang` `c` where (`c`.`id_cash_type` = 1) */;

/*View structure for view view_cash_in_cabang_monthly */

/*!50001 DROP TABLE IF EXISTS `view_cash_in_cabang_monthly` */;
/*!50001 DROP VIEW IF EXISTS `view_cash_in_cabang_monthly` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_cash_in_cabang_monthly` AS select `view_cash_in_cabang`.`id_cabang` AS `id_cabang`,sum(`view_cash_in_cabang`.`jumlah`) AS `jumlah`,year(`view_cash_in_cabang`.`tanggal`) AS `tahun`,month(`view_cash_in_cabang`.`tanggal`) AS `bulan` from `view_cash_in_cabang` group by `view_cash_in_cabang`.`id_cabang`,year(`view_cash_in_cabang`.`tanggal`),month(`view_cash_in_cabang`.`tanggal`) */;

/*View structure for view view_cash_in_hq */

/*!50001 DROP TABLE IF EXISTS `view_cash_in_hq` */;
/*!50001 DROP VIEW IF EXISTS `view_cash_in_hq` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_cash_in_hq` AS (select `c`.`id_cash_flow_hq` AS `id_cash_flow_hq`,`c`.`id_cash_type` AS `id_cash_type`,`c`.`id_hq` AS `id_hq`,`c`.`jumlah` AS `jumlah`,`c`.`tanggal` AS `tanggal` from `cash_flow_hq` `c` where (`c`.`id_cash_type` = 1)) */;

/*View structure for view view_cash_in_hq_monthly */

/*!50001 DROP TABLE IF EXISTS `view_cash_in_hq_monthly` */;
/*!50001 DROP VIEW IF EXISTS `view_cash_in_hq_monthly` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_cash_in_hq_monthly` AS (select `view_cash_in_hq`.`id_hq` AS `id_hq`,sum(`view_cash_in_hq`.`jumlah`) AS `jumlah`,year(`view_cash_in_hq`.`tanggal`) AS `tahun`,month(`view_cash_in_hq`.`tanggal`) AS `bulan` from `view_cash_in_hq` group by `view_cash_in_hq`.`id_hq`,year(`view_cash_in_hq`.`tanggal`),month(`view_cash_in_hq`.`tanggal`)) */;

/*View structure for view view_cash_out_cabang */

/*!50001 DROP TABLE IF EXISTS `view_cash_out_cabang` */;
/*!50001 DROP VIEW IF EXISTS `view_cash_out_cabang` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_cash_out_cabang` AS select `c`.`id_cash_flow_cabang` AS `id_cash_flow_cabang`,`c`.`id_cash_type` AS `id_cash_type`,`c`.`id_cabang` AS `id_cabang`,`c`.`jumlah` AS `jumlah`,`c`.`tanggal` AS `tanggal` from `cash_flow_cabang` `c` where (`c`.`id_cash_type` = 2) */;

/*View structure for view view_cash_out_cabang_monthly */

/*!50001 DROP TABLE IF EXISTS `view_cash_out_cabang_monthly` */;
/*!50001 DROP VIEW IF EXISTS `view_cash_out_cabang_monthly` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_cash_out_cabang_monthly` AS select `view_cash_out_cabang`.`id_cabang` AS `id_cabang`,sum(`view_cash_out_cabang`.`jumlah`) AS `jumlah`,year(`view_cash_out_cabang`.`tanggal`) AS `tahun`,month(`view_cash_out_cabang`.`tanggal`) AS `bulan` from `view_cash_out_cabang` group by `view_cash_out_cabang`.`id_cabang`,year(`view_cash_out_cabang`.`tanggal`),month(`view_cash_out_cabang`.`tanggal`) */;

/*View structure for view view_cash_out_hq */

/*!50001 DROP TABLE IF EXISTS `view_cash_out_hq` */;
/*!50001 DROP VIEW IF EXISTS `view_cash_out_hq` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_cash_out_hq` AS (select `c`.`id_cash_flow_hq` AS `id_cash_flow_hq`,`c`.`id_cash_type` AS `id_cash_type`,`c`.`id_hq` AS `id_hq`,`c`.`jumlah` AS `jumlah`,`c`.`tanggal` AS `tanggal` from `cash_flow_hq` `c` where (`c`.`id_cash_type` = 2)) */;

/*View structure for view view_cash_out_hq_monthly */

/*!50001 DROP TABLE IF EXISTS `view_cash_out_hq_monthly` */;
/*!50001 DROP VIEW IF EXISTS `view_cash_out_hq_monthly` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_cash_out_hq_monthly` AS (select `view_cash_out_hq`.`id_hq` AS `id_hq`,sum(`view_cash_out_hq`.`jumlah`) AS `jumlah`,year(`view_cash_out_hq`.`tanggal`) AS `tahun`,month(`view_cash_out_hq`.`tanggal`) AS `bulan` from `view_cash_out_hq` group by year(`view_cash_out_hq`.`tanggal`),month(`view_cash_out_hq`.`tanggal`)) */;

/*View structure for view view_convert_item_penambahan */

/*!50001 DROP TABLE IF EXISTS `view_convert_item_penambahan` */;
/*!50001 DROP VIEW IF EXISTS `view_convert_item_penambahan` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_convert_item_penambahan` AS (select `ci`.`id_item` AS `id_item`,`ci`.`id_convert_type` AS `id_convert_type`,`ci`.`id_hq` AS `id_hq`,sum(`ci`.`quantitiy`) AS `total` from `convert_item` `ci` group by `ci`.`id_hq`,`ci`.`id_convert_type`,`ci`.`id_item` having (`ci`.`id_convert_type` = 'CT002')) */;

/*View structure for view view_convert_item_pengurangan */

/*!50001 DROP TABLE IF EXISTS `view_convert_item_pengurangan` */;
/*!50001 DROP VIEW IF EXISTS `view_convert_item_pengurangan` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_convert_item_pengurangan` AS (select `ci`.`id_item` AS `id_item`,`ci`.`id_convert_type` AS `id_convert_type`,`ci`.`id_hq` AS `id_hq`,sum(`ci`.`quantitiy`) AS `total` from `convert_item` `ci` group by `ci`.`id_hq`,`ci`.`id_convert_type`,`ci`.`id_item` having (`ci`.`id_convert_type` = 'CT001')) */;

/*View structure for view view_get_aktivitas_laundry */

/*!50001 DROP TABLE IF EXISTS `view_get_aktivitas_laundry` */;
/*!50001 DROP VIEW IF EXISTS `view_get_aktivitas_laundry` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_get_aktivitas_laundry` AS (select `al`.`id_aktivitas_laundry` AS `id_aktivitas_laundry`,`al`.`id_detail_laundry` AS `id_detail_laundry`,`dl`.`id_transaksi_laundry` AS `id_transaksi_laundry`,`al`.`id_pegawai` AS `id_pegawai`,`p`.`nama` AS `nama_pegawai`,`al`.`id_aktivitas` AS `id_aktivitas`,`a`.`nama` AS `nama_aktivitas`,`al`.`mulai_pengerjaan` AS `mulai_pengerjaan`,`al`.`selesai` AS `selesai` from (((`aktivitas_laundry` `al` join `aktivitas` `a` on((`al`.`id_aktivitas` = `a`.`id_aktivitas`))) join `detail_laundry` `dl` on((`dl`.`id_detail_laundry` = `al`.`id_detail_laundry`))) left join `pegawai` `p` on((`p`.`id_pegawai` = `al`.`id_pegawai`)))) */;

/*View structure for view view_get_menu */

/*!50001 DROP TABLE IF EXISTS `view_get_menu` */;
/*!50001 DROP VIEW IF EXISTS `view_get_menu` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_get_menu` AS (select `m`.`id_menu` AS `id_menu`,`m`.`nama` AS `nama`,`m`.`deskripsi` AS `deskripsi`,concat(`m`.`quantity_minimum`,' ',`u`.`singkatan`) AS `minimum`,(select `harga_menu`.`harga` from `harga_menu` where (`harga_menu`.`id_menu` = `m`.`id_menu`) group by `harga_menu`.`id_menu` order by `harga_menu`.`id_harga_menu` desc) AS `harga_menu` from (`menu` `m` join `uom` `u` on((`m`.`id_uom` = `u`.`id_uom`)))) */;

/*View structure for view view_get_transaksi_laundry */

/*!50001 DROP TABLE IF EXISTS `view_get_transaksi_laundry` */;
/*!50001 DROP VIEW IF EXISTS `view_get_transaksi_laundry` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_get_transaksi_laundry` AS (select `tl`.`id_transaksi_laundry` AS `id_transaksi_laundry`,`tl`.`id_cabang` AS `id_cabang`,`tl`.`id_pelanggan` AS `id_pelanggan`,`tl`.`is_paid` AS `is_paid`,`tl`.`is_taken` AS `is_taken`,`tl`.`tanggal` AS `tanggal`,`tl`.`waktu_pengambilan` AS `waktu_pengambilan`,`dl`.`id_detail_laundry` AS `id_detail_laundry`,`dl`.`quantity` AS `quantity`,`dl`.`real_quantity` AS `real_quantity`,`m`.`id_menu` AS `id_menu`,`m`.`harga_menu` AS `harga_menu`,`m`.`nama` AS `nama`,(`m`.`harga_menu` * `dl`.`quantity`) AS `biaya` from ((`transaksi_laundry` `tl` join `detail_laundry` `dl` on((`tl`.`id_transaksi_laundry` = `dl`.`id_transaksi_laundry`))) join `view_get_menu` `m` on((`dl`.`id_menu` = `m`.`id_menu`)))) */;

/*View structure for view view_laporan_penerimaan_by_purchase */

/*!50001 DROP TABLE IF EXISTS `view_laporan_penerimaan_by_purchase` */;
/*!50001 DROP VIEW IF EXISTS `view_laporan_penerimaan_by_purchase` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_laporan_penerimaan_by_purchase` AS (select `pp`.`tanggal` AS `tanggal`,`pp`.`id_hq` AS `id_hq`,`pp`.`id_penerimaan_by_purchase` AS `id_penerimaan_by_purchase`,`pp`.`id_pembelian` AS `id_pembelian`,`pip`.`id_item` AS `id_item`,`i`.`nama` AS `nama`,`u`.`singkatan` AS `satuan`,`pip`.`quantity` AS `quantity` from ((((`penerimaan_by_purchase` `pp` join `pembelian` `p` on((`pp`.`id_pembelian` = `p`.`id_pembelian`))) join `penerimaan_item_purchase` `pip` on((`pp`.`id_penerimaan_by_purchase` = `pip`.`id_penerimaan_by_purchase`))) join `item` `i` on((`pip`.`id_item` = `i`.`id_item`))) join `uom` `u` on((`i`.`id_uom` = `u`.`id_uom`))) order by cast(`pp`.`tanggal` as date) desc,`pp`.`id_hq`,`pp`.`id_penerimaan_by_purchase`) */;

/*View structure for view view_laporan_penerimaan_by_request */

/*!50001 DROP TABLE IF EXISTS `view_laporan_penerimaan_by_request` */;
/*!50001 DROP VIEW IF EXISTS `view_laporan_penerimaan_by_request` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_laporan_penerimaan_by_request` AS (select `pq`.`tanggal` AS `tanggal`,`pq`.`id_cabang` AS `id_cabang`,`pq`.`id_penerimaan_by_request` AS `id_penerimaan_by_request`,`piq`.`id_item` AS `id_item`,`i`.`nama` AS `nama`,`u`.`singkatan` AS `satuan`,`piq`.`quantity` AS `quantity` from (((`penerimaan_item_request` `piq` join `penerimaan_by_request` `pq` on((`piq`.`id_penerimaan_by_request` = `pq`.`id_penerimaan_by_request`))) join `item` `i` on((`piq`.`id_item` = `i`.`id_item`))) join `uom` `u` on((`i`.`id_uom` = `u`.`id_uom`))) order by cast(`pq`.`tanggal` as date) desc,`pq`.`id_cabang`,`pq`.`id_penerimaan_by_request`) */;

/*View structure for view view_laporan_pengiriman_item */

/*!50001 DROP TABLE IF EXISTS `view_laporan_pengiriman_item` */;
/*!50001 DROP VIEW IF EXISTS `view_laporan_pengiriman_item` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_laporan_pengiriman_item` AS (select `p`.`tanggal` AS `tanggal`,`p`.`id_hq` AS `id_hq`,`p`.`id_cabang` AS `id_cabang`,`p`.`id_permintaan` AS `id_permintaan`,`p`.`id_pengiriman` AS `id_pengiriman`,`pi`.`id_item` AS `id_item`,`i`.`nama` AS `nama`,`u`.`singkatan` AS `satuan`,`pi`.`quantity` AS `quantity` from (((`pengiriman` `p` join `pengiriman_item` `pi` on((`p`.`id_pengiriman` = `pi`.`id_pengiriman`))) join `item` `i` on((`pi`.`id_item` = `i`.`id_item`))) join `uom` `u` on((`i`.`id_uom` = `u`.`id_uom`))) order by cast(`p`.`tanggal` as date) desc,`p`.`id_pengiriman`) */;

/*View structure for view view_laporan_permintaan_item_cabang */

/*!50001 DROP TABLE IF EXISTS `view_laporan_permintaan_item_cabang` */;
/*!50001 DROP VIEW IF EXISTS `view_laporan_permintaan_item_cabang` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_laporan_permintaan_item_cabang` AS (select `p`.`tanggal` AS `tanggal`,`p`.`id_cabang` AS `id_cabang`,`p`.`id_permintaan` AS `id_permintaan`,`pi`.`id_item` AS `id_item`,`i`.`nama` AS `nama`,`u`.`singkatan` AS `satuan`,`pi`.`quantity` AS `quantity`,(case `p`.`is_accepted` when 1 then 'disetujui' when 0 then 'belum disetujui' end) AS `status_permintaan` from ((((`permintaan` `p` join `permintaan_item` `pi` on((`p`.`id_permintaan` = `pi`.`id_permintaan`))) left join `pengiriman` `pg` on((`pi`.`id_permintaan` = `pg`.`id_permintaan`))) join `item` `i` on((`pi`.`id_item` = `i`.`id_item`))) join `uom` `u` on((`i`.`id_uom` = `u`.`id_uom`))) order by cast(`p`.`tanggal` as date) desc,`p`.`id_cabang`,`p`.`id_permintaan`) */;

/*View structure for view view_laporan_transaksi_cabang */

/*!50001 DROP TABLE IF EXISTS `view_laporan_transaksi_cabang` */;
/*!50001 DROP VIEW IF EXISTS `view_laporan_transaksi_cabang` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_laporan_transaksi_cabang` AS (select `tl`.`tanggal` AS `tanggal`,`tl`.`id_cabang` AS `id_cabang`,`tl`.`id_transaksi_laundry` AS `id_transaksi_laundry`,`dl`.`id_detail_laundry` AS `id_detail_laundry`,`dl`.`id_menu` AS `id_menu`,`p`.`id_pelanggan` AS `id_pelanggan`,`p`.`nama` AS `nama_pelanggan`,`p`.`no_telepon` AS `no_telepon_pelanggan`,`m`.`nama` AS `nama`,`dl`.`quantity` AS `quantity`,`u`.`singkatan` AS `satuan`,(`hm`.`harga` * `dl`.`quantity`) AS `total_harga`,`tl`.`is_paid` AS `is_paid`,`tl`.`is_taken` AS `is_taken`,`tl`.`waktu_pengambilan` AS `waktu_pengambilan`,`dl`.`info` AS `info`,`get_is_finished_activity_laundry`(`dl`.`id_detail_laundry`) AS `selesai_dikerjakan` from (((((`transaksi_laundry` `tl` join `detail_laundry` `dl` on((`tl`.`id_transaksi_laundry` = `dl`.`id_transaksi_laundry`))) join `pelanggan` `p` on((`tl`.`id_pelanggan` = `p`.`id_pelanggan`))) join `harga_menu` `hm` on((`dl`.`id_harga_menu` = `hm`.`id_harga_menu`))) join `menu` `m` on((`dl`.`id_menu` = `m`.`id_menu`))) join `uom` `u` on((`m`.`id_uom` = `u`.`id_uom`))) order by cast(`tl`.`tanggal` as date) desc,`tl`.`id_cabang`) */;

/*View structure for view view_laporan_transaksi_cabang_detail */

/*!50001 DROP TABLE IF EXISTS `view_laporan_transaksi_cabang_detail` */;
/*!50001 DROP VIEW IF EXISTS `view_laporan_transaksi_cabang_detail` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_laporan_transaksi_cabang_detail` AS (select `tl`.`tanggal` AS `tanggal`,`tl`.`id_cabang` AS `id_cabang`,`tl`.`id_transaksi_laundry` AS `id_transaksi_laundry`,`dl`.`id_detail_laundry` AS `id_detail_laundry`,`dl`.`id_menu` AS `id_menu`,`m`.`nama` AS `nama`,`dl`.`quantity` AS `quantity`,`u`.`singkatan` AS `satuan`,(`hm`.`harga` * `dl`.`quantity`) AS `total_harga`,(case `tl`.`is_paid` when 1 then 'Sudah dibayar' when 0 then 'Belum dibayar' end) AS `status_pembayaran`,if(isnull(`tl`.`waktu_pengambilan`),'Belum diambil','Sudah diambil') AS `status_pengambilan` from (((((`transaksi_laundry` `tl` join `detail_laundry` `dl` on((`tl`.`id_transaksi_laundry` = `dl`.`id_transaksi_laundry`))) join `pelanggan` `p` on((`tl`.`id_pelanggan` = `p`.`id_pelanggan`))) join `harga_menu` `hm` on((`dl`.`id_harga_menu` = `hm`.`id_harga_menu`))) join `menu` `m` on((`dl`.`id_menu` = `m`.`id_menu`))) join `uom` `u` on((`m`.`id_uom` = `u`.`id_uom`))) order by cast(`tl`.`tanggal` as date) desc,`tl`.`id_cabang`,`tl`.`id_transaksi_laundry`,`dl`.`id_detail_laundry`) */;

/*View structure for view view_penerimaan_by_purchase_sum */

/*!50001 DROP TABLE IF EXISTS `view_penerimaan_by_purchase_sum` */;
/*!50001 DROP VIEW IF EXISTS `view_penerimaan_by_purchase_sum` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_penerimaan_by_purchase_sum` AS (select `vpp`.`id_hq` AS `id_hq`,`vpp`.`id_item` AS `id_item`,sum(`vpp`.`quantity`) AS `total` from `view_laporan_penerimaan_by_purchase` `vpp` group by `vpp`.`id_hq`,`vpp`.`id_item`) */;

/*View structure for view view_penerimaan_by_request_sum */

/*!50001 DROP TABLE IF EXISTS `view_penerimaan_by_request_sum` */;
/*!50001 DROP VIEW IF EXISTS `view_penerimaan_by_request_sum` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_penerimaan_by_request_sum` AS (select `vpr`.`id_cabang` AS `id_cabang`,`vpr`.`id_item` AS `id_item`,sum(`vpr`.`quantity`) AS `total` from `view_laporan_penerimaan_by_request` `vpr` group by `vpr`.`id_cabang`,`vpr`.`id_item`) */;

/*View structure for view view_penggunaan_item_sum */

/*!50001 DROP TABLE IF EXISTS `view_penggunaan_item_sum` */;
/*!50001 DROP VIEW IF EXISTS `view_penggunaan_item_sum` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_penggunaan_item_sum` AS (select `vpic`.`id_cabang` AS `id_cabang`,`vpic`.`id_item` AS `id_item`,sum(`vpic`.`quantity`) AS `total` from `view_penggunaan_item_with_cabang` `vpic` group by `vpic`.`id_cabang`,`vpic`.`id_item`) */;

/*View structure for view view_penggunaan_item_with_cabang */

/*!50001 DROP TABLE IF EXISTS `view_penggunaan_item_with_cabang` */;
/*!50001 DROP VIEW IF EXISTS `view_penggunaan_item_with_cabang` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_penggunaan_item_with_cabang` AS (select `tl`.`id_cabang` AS `id_cabang`,`tl`.`id_transaksi_laundry` AS `id_transaksi_laundry`,`dl`.`id_detail_laundry` AS `id_detail_laundry`,`al`.`id_aktivitas_laundry` AS `id_aktivitas_laundry`,`al`.`id_aktivitas` AS `id_aktivitas`,`al`.`selesai` AS `selesai`,`p`.`id_item` AS `id_item`,`i`.`nama` AS `nama`,`u`.`singkatan` AS `satuan`,`p`.`quantity` AS `quantity` from (((((`transaksi_laundry` `tl` join `detail_laundry` `dl` on((`tl`.`id_transaksi_laundry` = `dl`.`id_transaksi_laundry`))) join `aktivitas_laundry` `al` on((`dl`.`id_detail_laundry` = `al`.`id_detail_laundry`))) join `penggunaan` `p` on((`al`.`id_aktivitas_laundry` = `p`.`id_aktivitas_laundry`))) join `item` `i` on((`p`.`id_item` = `i`.`id_item`))) join `uom` `u` on((`i`.`id_uom` = `u`.`id_uom`)))) */;

/*View structure for view view_pengiriman_item_sum */

/*!50001 DROP TABLE IF EXISTS `view_pengiriman_item_sum` */;
/*!50001 DROP VIEW IF EXISTS `view_pengiriman_item_sum` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_pengiriman_item_sum` AS (select `vpi`.`id_hq` AS `id_hq`,`vpi`.`id_item` AS `id_item`,sum(`vpi`.`quantity`) AS `total` from `view_laporan_pengiriman_item` `vpi` group by `vpi`.`id_hq`,`vpi`.`id_item`) */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
