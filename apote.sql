/*
SQLyog Ultimate v13.1.1 (64 bit)
MySQL - 5.5.24-log : Database - db_apotek
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`db_apotek` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `db_apotek`;

/*Table structure for table `obat` */

DROP TABLE IF EXISTS `obat`;

CREATE TABLE `obat` (
  `idobat` int(11) NOT NULL AUTO_INCREMENT,
  `kode_obat` varchar(20) DEFAULT NULL,
  `namaobat` varchar(30) DEFAULT NULL,
  `hargabeli` double DEFAULT NULL,
  `stok` int(30) DEFAULT NULL,
  `satuan` varchar(30) DEFAULT NULL,
  `hargajual` double DEFAULT NULL,
  PRIMARY KEY (`idobat`) USING BTREE,
  KEY `id_obat` (`namaobat`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

/*Data for the table `obat` */

insert  into `obat`(`idobat`,`kode_obat`,`namaobat`,`hargabeli`,`stok`,`satuan`,`hargajual`) values 
(5,'OB01','PARAMEX',300000,88,'BOTOL',250000),
(6,'OB02','OBH',25000,51,'KAPSUL',20000),
(7,'OB03','PANADOL',100000,19,'DOS',50000),
(8,'OB04','BODREX',400000,54,'LEMBAR',350000),
(9,'OB05','PARAMEX',400000,4,'KAPSUL',350000),
(10,'OB06','OBH',400000,5,'BOTOL',250000),
(11,'OB07','PANADOL',50000,5,'GELAS',35000);

/*Table structure for table `pelanggan` */

DROP TABLE IF EXISTS `pelanggan`;

CREATE TABLE `pelanggan` (
  `idpelanggan` int(11) NOT NULL AUTO_INCREMENT,
  `kodepelanggan` varchar(30) DEFAULT NULL,
  `nohp` varchar(30) DEFAULT NULL,
  `alamat` varchar(30) DEFAULT NULL,
  `namapelanggan` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`idpelanggan`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `pelanggan` */

insert  into `pelanggan`(`idpelanggan`,`kodepelanggan`,`nohp`,`alamat`,`namapelanggan`) values 
(1,'P001','08223531','JLNMUARO','AFDAL');

/*Table structure for table `supplier` */

DROP TABLE IF EXISTS `supplier`;

CREATE TABLE `supplier` (
  `idsupplier` int(11) NOT NULL AUTO_INCREMENT,
  `namasupplier` varchar(64) DEFAULT NULL,
  `nohp` varchar(30) DEFAULT NULL,
  `alamat` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`idsupplier`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `supplier` */

insert  into `supplier`(`idsupplier`,`namasupplier`,`nohp`,`alamat`) values 
(1,'CV Cininta','0248313757','Jl Lampersari 57 Semarang'),
(2,'PT. Kalbe Farmasi','082286062083','Jl. Garuda Sakti Km. 1, Kel. Simpang Baru'),
(3,'CV.TAMBUN','0842422147','jln.muaro penjalinan');

/*Table structure for table `transaksipembelian` */

DROP TABLE IF EXISTS `transaksipembelian`;

CREATE TABLE `transaksipembelian` (
  `idpembelian` int(11) NOT NULL AUTO_INCREMENT,
  `kode_pembelian` varchar(40) DEFAULT NULL,
  `id_supplier` int(11) DEFAULT NULL,
  `id_obat` int(11) DEFAULT NULL,
  `jumlah` double DEFAULT NULL,
  `tanggal` date DEFAULT NULL,
  PRIMARY KEY (`idpembelian`) USING BTREE,
  KEY `id_supplier` (`id_supplier`),
  KEY `id_obat` (`id_obat`),
  CONSTRAINT `transaksipembelian_ibfk_2` FOREIGN KEY (`id_supplier`) REFERENCES `supplier` (`idsupplier`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `transaksipembelian_ibfk_5` FOREIGN KEY (`id_obat`) REFERENCES `obat` (`idobat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

/*Data for the table `transaksipembelian` */

insert  into `transaksipembelian`(`idpembelian`,`kode_pembelian`,`id_supplier`,`id_obat`,`jumlah`,`tanggal`) values 
(7,'TR01',2,5,6,'2024-01-06'),
(8,'TR02',1,6,7,'2024-01-06'),
(9,'TR03',2,5,23,'2024-01-11'),
(10,'TR04',3,7,16,'2024-01-12'),
(11,'TR05',2,8,50,'2024-01-12'),
(12,'TR06',1,5,50,'2024-01-13'),
(13,'TR07',1,6,50,'2024-01-03');

/*Table structure for table `transaksipenjualan` */

DROP TABLE IF EXISTS `transaksipenjualan`;

CREATE TABLE `transaksipenjualan` (
  `idpenjualan` int(11) NOT NULL AUTO_INCREMENT,
  `kode_penjualan` varchar(30) DEFAULT NULL,
  `id_pelanggan` int(11) DEFAULT NULL,
  `id_ob` int(11) DEFAULT NULL,
  `jumlahpenjualan` double DEFAULT NULL,
  `tanggal` date DEFAULT NULL,
  PRIMARY KEY (`idpenjualan`),
  KEY `id_ob` (`id_ob`),
  KEY `id_pelanggan` (`id_pelanggan`),
  CONSTRAINT `transaksipenjualan_ibfk_1` FOREIGN KEY (`id_ob`) REFERENCES `obat` (`idobat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `transaksipenjualan_ibfk_2` FOREIGN KEY (`id_pelanggan`) REFERENCES `pelanggan` (`idpelanggan`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `transaksipenjualan` */

insert  into `transaksipenjualan`(`idpenjualan`,`kode_penjualan`,`id_pelanggan`,`id_ob`,`jumlahpenjualan`,`tanggal`) values 
(1,'TR01',1,6,9,'2024-01-04');

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `iduser` int(11) NOT NULL,
  `namauser` varchar(64) DEFAULT NULL,
  `email` varchar(64) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  `level` int(20) DEFAULT NULL,
  PRIMARY KEY (`iduser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `user` */

insert  into `user`(`iduser`,`namauser`,`email`,`password`,`level`) values 
(1,'RAYHAN','mhdrayhan1405@gmail.com','$2y$10$/cTkfPEN3vPvVqQZC1z09egCeu2WV5.O2SJiCkBDIx.lCQFk7qBaO',1);

/* Trigger structure for table `transaksipembelian` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `t_stok` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `t_stok` AFTER INSERT ON `transaksipembelian` FOR EACH ROW BEGIN
UPDATE obat SET stok = stok + new.jumlah WHERE idobat=new.id_obat;
END */$$


DELIMITER ;

/* Trigger structure for table `transaksipenjualan` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `jual_stok` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `jual_stok` AFTER INSERT ON `transaksipenjualan` FOR EACH ROW BEGIN
UPDATE obat SET stok = stok - new.jumlahpenjualan WHERE idobat=new.id_ob;
END */$$


DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
