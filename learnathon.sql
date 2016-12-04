-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.7.15-log - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             9.3.0.5119
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for learnathon
CREATE DATABASE IF NOT EXISTS `learnathon` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `learnathon`;

-- Dumping structure for table learnathon.batch_info
CREATE TABLE IF NOT EXISTS `batch_info` (
  `Batch_Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Party_Id` bigint(20) NOT NULL,
  `Card_Id` bigint(20) NOT NULL,
  `Notification_Status` varchar(50) NOT NULL,
  `Create_TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Update_TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Batch_Id`),
  KEY `FK_batch_info_member_info` (`Party_Id`),
  KEY `FK_batch_info_card_info` (`Card_Id`),
  CONSTRAINT `FK_batch_info_card_info` FOREIGN KEY (`Card_Id`) REFERENCES `card_info` (`Card_Id`),
  CONSTRAINT `FK_batch_info_member_info` FOREIGN KEY (`Party_Id`) REFERENCES `member_info` (`Party_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Dumping data for table learnathon.batch_info: ~1 rows (approximately)
/*!40000 ALTER TABLE `batch_info` DISABLE KEYS */;
INSERT INTO `batch_info` (`Batch_Id`, `Party_Id`, `Card_Id`, `Notification_Status`, `Create_TS`, `Update_TS`) VALUES
	(1, 1, 1, 'Not Sent', '2016-11-22 23:17:48', '2016-11-22 23:17:48');
/*!40000 ALTER TABLE `batch_info` ENABLE KEYS */;

-- Dumping structure for table learnathon.card_info
CREATE TABLE IF NOT EXISTS `card_info` (
  `Card_Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Party_Id` bigint(20) NOT NULL,
  `Card_No` bigint(20) NOT NULL,
  `Card_Name` varchar(50) DEFAULT NULL,
  `Card_Type` varchar(50) DEFAULT NULL,
  `Card_Activation_Status` varchar(50) NOT NULL,
  `Card_Dispatch_Status` varchar(50) NOT NULL,
  `CVV` smallint(6) DEFAULT NULL,
  `Expiry_Date` varchar(50) DEFAULT NULL,
  `Create_TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Update_TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Card_Image` longtext,
  PRIMARY KEY (`Card_Id`),
  KEY `FK_card_info_member_info` (`Party_Id`),
  CONSTRAINT `FK_card_info_member_info` FOREIGN KEY (`Party_Id`) REFERENCES `member_info` (`Party_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Dumping data for table learnathon.card_info: ~0 rows (approximately)
/*!40000 ALTER TABLE `card_info` DISABLE KEYS */;
INSERT INTO `card_info` (`Card_Id`, `Party_Id`, `Card_No`, `Card_Name`, `Card_Type`, `Card_Activation_Status`, `Card_Dispatch_Status`, `CVV`, `Expiry_Date`, `Create_TS`, `Update_TS`, `Card_Image`) VALUES
	(1, 1, 5451648600248454, NULL, NULL, 'Active', 'Dispatched', NULL, NULL, '2016-11-22 23:05:48', '2016-12-05 02:44:20', 'https://usaa.i.lithium.com/t5/image/serverpage/image-id/1340iDED819FC83F3AD7F?v=v2');
/*!40000 ALTER TABLE `card_info` ENABLE KEYS */;

-- Dumping structure for table learnathon.device_info
CREATE TABLE IF NOT EXISTS `device_info` (
  `Device_Id` bigint(20) NOT NULL,
  `Party_Id` bigint(20) NOT NULL,
  `Device_Name` varchar(50) NOT NULL,
  `Version` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Create_TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Update_TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Device_Id`),
  KEY `FK_device_info_member_info` (`Party_Id`),
  CONSTRAINT `FK_device_info_member_info` FOREIGN KEY (`Party_Id`) REFERENCES `member_info` (`Party_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table learnathon.device_info: ~1 rows (approximately)
/*!40000 ALTER TABLE `device_info` DISABLE KEYS */;
INSERT INTO `device_info` (`Device_Id`, `Party_Id`, `Device_Name`, `Version`, `Create_TS`, `Update_TS`) VALUES
	(358187072480596, 1, 'Moto G4 Plus', 0, '2016-11-22 23:16:29', '2016-11-22 23:16:29');
/*!40000 ALTER TABLE `device_info` ENABLE KEYS */;

-- Dumping structure for table learnathon.member_info
CREATE TABLE IF NOT EXISTS `member_info` (
  `Party_Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL,
  `Birth_Date` date NOT NULL,
  `Mobile_No` bigint(20) NOT NULL,
  `Email_Id` varchar(50) NOT NULL,
  `Photo` blob,
  `Create_TS` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Update_TS` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Party_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Dumping data for table learnathon.member_info: ~1 rows (approximately)
/*!40000 ALTER TABLE `member_info` DISABLE KEYS */;
INSERT INTO `member_info` (`Party_Id`, `Name`, `Birth_Date`, `Mobile_No`, `Email_Id`, `Photo`, `Create_TS`, `Update_TS`) VALUES
	(1, 'Nickie', '1956-11-06', 2104567899, 'Nickie@www.com', NULL, '2016-11-22 23:00:54', '2016-11-22 23:00:54');
/*!40000 ALTER TABLE `member_info` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
