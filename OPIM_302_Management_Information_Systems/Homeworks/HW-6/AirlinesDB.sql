
drop schema airlines; 

create schema airlines; 
use airlines; 


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Availability`
--

DROP TABLE IF EXISTS `Availability`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Availability` (
  `FlightID` smallint(6) NOT NULL,
  `FlightDate` varchar(19) NOT NULL,
  `NoOfAvailableSeatsForEconomyClass` smallint(6) DEFAULT NULL,
  `NoOfAvailableSeatsForBusinessClass` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`FlightID`, `FlightDate`),
  FOREIGN KEY (`FlightID`) REFERENCES `Flight` (`FlightID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Availability`
--

LOCK TABLES `Availability` WRITE;
/*!40000 ALTER TABLE `Availability` DISABLE KEYS */;
INSERT INTO `Availability` VALUES (6000,'2019-12-01 00:00:00',20,12),(6000,'2019-12-02 00:00:00',60,12),(6000,'2019-12-03 00:00:00',60,12),(6000,'2019-12-04 00:00:00',60,12),(6000,'2019-12-05 00:00:00',60,12),(6000,'2019-12-06 00:00:00',30,12),(6000,'2019-12-07 00:00:00',60,12),(6000,'2019-12-08 00:00:00',45,11),(6000,'2019-12-09 00:00:00',60,12),(6000,'2019-12-10 00:00:00',60,12),(6000,'2019-12-11 00:00:00',55,12),(6000,'2019-12-12 00:00:00',60,12),(6000,'2019-12-13 00:00:00',22,12),(6000,'2019-12-14 00:00:00',60,12),(6000,'2019-12-15 00:00:00',60,12),(6000,'2019-12-16 00:00:00',60,12),(6000,'2019-12-17 00:00:00',60,12),(6000,'2019-12-18 00:00:00',60,12),(6000,'2019-12-19 00:00:00',60,12),(6000,'2019-12-20 00:00:00',23,12),(6000,'2019-12-21 00:00:00',60,12),(6000,'2019-12-22 00:00:00',60,12),(6000,'2019-12-23 00:00:00',60,12),(6000,'2019-12-24 00:00:00',60,12),(6000,'2019-12-25 00:00:00',4,3),(6000,'2019-12-26 00:00:00',60,12),(6000,'2019-12-27 00:00:00',60,12),(6000,'2019-12-28 00:00:00',60,12),(6000,'2019-12-29 00:00:00',60,12),(6000,'2019-12-30 00:00:00',60,12),(6001,'2019-12-01 00:00:00',78,12),(6001,'2019-12-02 00:00:00',78,12),(6001,'2019-12-03 00:00:00',78,12),(6001,'2019-12-04 00:00:00',4,12),(6001,'2019-12-05 00:00:00',70,12),(6001,'2019-12-06 00:00:00',78,12),(6001,'2019-12-07 00:00:00',22,12),(6001,'2019-12-08 00:00:00',78,12),(6001,'2019-12-09 00:00:00',44,12),(6001,'2019-12-10 00:00:00',78,12),(6001,'2019-12-11 00:00:00',78,12),(6001,'2019-12-12 00:00:00',78,12),(6001,'2019-12-13 00:00:00',33,12),(6001,'2019-12-14 00:00:00',78,12),(6001,'2019-12-15 00:00:00',78,12),(6001,'2019-12-16 00:00:00',6,12),(6001,'2019-12-17 00:00:00',78,12),(6001,'2019-12-18 00:00:00',78,12),(6001,'2019-12-19 00:00:00',78,12),(6001,'2019-12-20 00:00:00',77,12),(6001,'2019-12-21 00:00:00',66,12),(6001,'2019-12-22 00:00:00',22,12),(6001,'2019-12-23 00:00:00',78,12),(6001,'2019-12-24 00:00:00',77,12),(6001,'2019-12-25 00:00:00',12,12),(6001,'2019-12-26 00:00:00',43,12),(6001,'2019-12-27 00:00:00',78,12),(6001,'2019-12-28 00:00:00',22,12),(6001,'2019-12-29 00:00:00',78,12),(6001,'2019-12-30 00:00:00',78,12),(6002,'2019-12-01 00:00:00',78,12),(6002,'2019-12-02 00:00:00',44,12),(6002,'2019-12-03 00:00:00',78,12),(6002,'2019-12-04 00:00:00',33,12),(6002,'2019-12-05 00:00:00',78,12),(6002,'2019-12-06 00:00:00',78,12),(6002,'2019-12-07 00:00:00',78,12),(6002,'2019-12-08 00:00:00',22,12),(6002,'2019-12-09 00:00:00',78,12),(6002,'2019-12-10 00:00:00',78,12),(6002,'2019-12-11 00:00:00',56,12),(6002,'2019-12-12 00:00:00',78,12),(6002,'2019-12-13 00:00:00',78,12),(6002,'2019-12-14 00:00:00',34,12),(6002,'2019-12-15 00:00:00',78,12),(6002,'2019-12-16 00:00:00',78,12),(6002,'2019-12-17 00:00:00',78,12),(6002,'2019-12-18 00:00:00',78,12),(6002,'2019-12-19 00:00:00',77,12),(6002,'2019-12-20 00:00:00',78,12),(6002,'2019-12-21 00:00:00',77,12),(6002,'2019-12-22 00:00:00',78,12),(6002,'2019-12-23 00:00:00',78,12),(6002,'2019-12-24 00:00:00',78,12),(6002,'2019-12-25 00:00:00',78,12),(6002,'2019-12-26 00:00:00',78,12),(6002,'2019-12-27 00:00:00',78,12),(6002,'2019-12-28 00:00:00',78,12),(6002,'2019-12-29 00:00:00',78,12),(6002,'2019-12-30 00:00:00',70,24),(6003,'2019-12-01 00:00:00',120,24),(6003,'2019-12-02 00:00:00',120,24),(6003,'2019-12-03 00:00:00',100,24),(6003,'2019-12-04 00:00:00',120,24),(6003,'2019-12-05 00:00:00',120,24),(6003,'2019-12-06 00:00:00',78,24),(6003,'2019-12-07 00:00:00',120,24),(6003,'2019-12-08 00:00:00',120,24),(6003,'2019-12-09 00:00:00',120,24),(6003,'2019-12-10 00:00:00',120,24),(6003,'2019-12-11 00:00:00',120,24),(6003,'2019-12-12 00:00:00',120,24),(6003,'2019-12-13 00:00:00',120,24),(6003,'2019-12-14 00:00:00',120,24),(6003,'2019-12-15 00:00:00',120,24),(6003,'2019-12-16 00:00:00',120,24),(6003,'2019-12-17 00:00:00',120,24),(6003,'2019-12-18 00:00:00',120,24),(6003,'2019-12-19 00:00:00',45,24),(6003,'2019-12-20 00:00:00',120,23),(6003,'2019-12-21 00:00:00',120,24),(6003,'2019-12-22 00:00:00',120,24),(6003,'2019-12-23 00:00:00',120,24),(6003,'2019-12-24 00:00:00',120,24),(6003,'2019-12-25 00:00:00',2,1),(6003,'2019-12-26 00:00:00',120,24),(6003,'2019-12-27 00:00:00',120,24),(6003,'2019-12-28 00:00:00',120,24),(6003,'2019-12-29 00:00:00',120,24),(6003,'2019-12-30 00:00:00',33,24),(6004,'2019-12-01 00:00:00',120,24),(6004,'2019-12-02 00:00:00',120,24),(6004,'2019-12-03 00:00:00',120,24),(6004,'2019-12-04 00:00:00',120,24),(6004,'2019-12-05 00:00:00',120,24),(6004,'2019-12-06 00:00:00',120,24),(6004,'2019-12-07 00:00:00',120,24),(6004,'2019-12-08 00:00:00',120,24),(6004,'2019-12-09 00:00:00',120,24),(6004,'2019-12-10 00:00:00',120,24),(6004,'2019-12-11 00:00:00',22,24),(6004,'2019-12-12 00:00:00',120,24),(6004,'2019-12-13 00:00:00',120,24),(6004,'2019-12-14 00:00:00',120,24),(6004,'2019-12-15 00:00:00',120,24),(6004,'2019-12-16 00:00:00',120,24),(6004,'2019-12-17 00:00:00',120,23),(6004,'2019-12-18 00:00:00',120,24),(6004,'2019-12-19 00:00:00',120,24),(6004,'2019-12-20 00:00:00',120,24),(6004,'2019-12-21 00:00:00',120,24),(6004,'2019-12-22 00:00:00',35,24),(6004,'2019-12-23 00:00:00',120,24),(6004,'2019-12-24 00:00:00',120,24),(6004,'2019-12-25 00:00:00',120,24),(6004,'2019-12-26 00:00:00',120,24),(6004,'2019-12-27 00:00:00',120,24),(6004,'2019-12-28 00:00:00',21,24),(6004,'2019-12-29 00:00:00',120,24),(6004,'2019-12-30 00:00:00',120,24);
/*!40000 ALTER TABLE `Availability` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Flight`
--

DROP TABLE IF EXISTS `Flight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Flight` (
  `FlightID` smallint(6) NOT NULL AUTO_INCREMENT,
  `DepartureTime` varchar(19) DEFAULT NULL,
  `ArrivalTime` varchar(19) DEFAULT NULL,
  `Duration` varchar(7) DEFAULT NULL,
  `CapacityOfEconomyClass` smallint(6) DEFAULT NULL,
  `CapacityOfBusinessClass` tinyint(4) DEFAULT NULL,
  `DepartureAirport` varchar(8) DEFAULT NULL,
  `ArrivalAirport` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`FlightID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Flight`
--

LOCK TABLES `Flight` WRITE;
/*!40000 ALTER TABLE `Flight` DISABLE KEYS */;
INSERT INTO `Flight` VALUES (6000,'1899-12-30 13:00:00','1899-12-30 17:00:00','4 hours',60,12,'Istanbul','London'),(6001,'1899-12-30 11:30:00','1899-12-30 12:30:00','1 hour',78,12,'Istanbul','Ankara'),(6002,'1899-12-30 23:00:00','1899-12-30 12:00:00','1 hour',78,12,'Ankara','Izmir'),(6003,'1899-12-30 10:00:00','1899-12-30 14:00:00','4 hours',120,24,'Istanbul','London'),(6004,'1899-12-30 10:30:00','1899-12-30 18:30:00','8 hours',120,24,'Istanbul','Izmir');
/*!40000 ALTER TABLE `Flight` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FlightHistory`
--

DROP TABLE IF EXISTS `FlightHistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FlightHistory` (
  `Reservation_ID` smallint(6) NOT NULL AUTO_INCREMENT,
  `Reservation_Date` varchar(19) DEFAULT NULL,
  `IsRoundTrip` varchar(5) DEFAULT NULL,
  `FlightDate` varchar(19) DEFAULT NULL,
  `Class` varchar(8) DEFAULT NULL,
  `EstimatedPayment` smallint(6) DEFAULT NULL,
  `DiscountRate` varchar(2) DEFAULT NULL,
  `CancellationDate` varchar(19) DEFAULT NULL,
  `ExtraBaggage` varchar(5) DEFAULT NULL,
  `ChargeForExtraBaggage` varchar(3) DEFAULT NULL,
  `ExtraChargeForMeal` varchar(2) DEFAULT NULL,
  `FinalCharge` smallint(6) DEFAULT NULL,
  `PassengerID` tinyint(4) NOT NULL,
  `FlightID` smallint(6) NOT NULL,
  PRIMARY KEY (`Reservation_ID`),
  FOREIGN KEY (`PassengerID`) REFERENCES `Passenger` (`Passenger NO`) ON DELETE CASCADE,
  FOREIGN KEY (`FlightID`) REFERENCES `Flight` (`FlightID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FlightHistory`
--

LOCK TABLES `FlightHistory` WRITE;
/*!40000 ALTER TABLE `FlightHistory` DISABLE KEYS */;
INSERT INTO `FlightHistory` VALUES (201,'2019-11-01 00:00:00','True','2019-11-12 00:00:00','Business',300,'10','','True','50','',320,10,6003),(202,'2019-11-05 00:00:00','False','2019-11-15 00:00:00','Business',300,'10','','False','','',270,11,6004),(203,'2019-11-08 00:00:00','True','2019-11-13 00:00:00','Economy',100,'','','False','','',100,14,6001),(204,'2019-11-10 00:00:00','False','2019-11-12 00:00:00','Economy',100,'','','False','','',100,12,6002),(205,'2019-10-04 00:00:00','False','2019-10-16 00:00:00','Economy',100,'','','True','100','',200,11,6001),(206,'2019-09-07 00:00:00','True','2019-10-19 00:00:00','Economy',100,'','2019-11-09 00:00:00','False','','',100,13,6001),(207,'2019-11-03 00:00:00','False','2019-11-17 00:00:00','Economy',100,'','2019-11-09 00:00:00','False','','',100,13,6003),(208,'2019-09-01 00:00:00','True','2019-09-11 00:00:00','Economy',100,'','','True','','20',120,14,6003),(209,'2019-11-02 00:00:00','False','2019-11-07 00:00:00','Economy',100,'','','False','','',100,11,6001);
/*!40000 ALTER TABLE `FlightHistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Passenger`
--

DROP TABLE IF EXISTS `Passenger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Passenger` (
  `Passenger NO` tinyint(4) NOT NULL AUTO_INCREMENT,
  `FName` varchar(6) DEFAULT NULL,
  `MI` varchar(1) DEFAULT NULL,
  `Surname` varchar(7) DEFAULT NULL,
  `DateOfBirth` varchar(19) DEFAULT NULL,
  `Gender` varchar(1) DEFAULT NULL,
  `Age` tinyint(4) DEFAULT NULL,
  `Address` varchar(82) DEFAULT NULL,
  `Nationality` varchar(7) DEFAULT NULL,
  `CreditCardNo` bigint(20) DEFAULT NULL,
  `IsGoldMember` varchar(5) DEFAULT NULL,
  `PassportNo` int(11) DEFAULT NULL,
  `Email` varchar(23) DEFAULT NULL,
  PRIMARY KEY (`Passenger NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Passenger`
--

LOCK TABLES `Passenger` WRITE;
/*!40000 ALTER TABLE `Passenger` DISABLE KEYS */;
INSERT INTO `Passenger` VALUES (10,'Can','','Bilgin','1990-11-03 00:00:00','M',26,'Üniversite Mahallesi Komiser Sokak No:7 34320 Avcılar','Turkish',9438534075290184,'True',234234,'canb@hotmail.com'),(11,'Ali','E','Öztürk','1988-11-22 00:00:00','M',28,'Cerrahpaşa Cad. Sancaktar Müezzin Sok. No: 2 Aksaray','Turkish',4139432379341032,'False',431032,'emre@gmail.com'),(12,'Mert','','Özdemir','1976-08-27 00:00:00','M',40,'Süleyman Seba Cad. Refik Osman Top Sok. No: 2 Beşiktaş','Turkish',4130583205772091,'False',143023,'ozdemr@fbil.com'),(13,'Ozkan','','Ekinci','1985-01-31 00:00:00','M',31,'İstiklal Mah. 19 Mayıs Cad. Erkul Apt. No: 3/1-2 Ümraniye','Turkish',7238401385083271,'True',413320,'ek_nci@hotmail.com'),(14,'Selin','C','Inan','1979-01-21 00:00:00','F',37,'Talatpaşa Cd. No:9 Bahçelievler','Turkish',3581348094328018,'False',984321,'selinan@yahoo.com'),(15,'Duygu','','Kaya','1989-08-05 00:00:00','F',27,'Eğitim Mahallesi Kasap İsmet Sokak No:15 34722 Kadıköy','Turkish',3475123409572903,'True',753615,'dkaya@gmail.com'),(16,'Haluk','','Korkmaz','1990-09-18 00:00:00','M',26,'Atalar Mah. Beyaz Köşk Cad. Sebil Sok. No: 3 Kartal','Turkish',4134850314759931,'False',912773,'halukorkmaz@yahoo.com'),(17,'Leman','','Berk','1992-06-11 00:00:00','F',24,'Mecidiyeköy Mah. Selahattin Pınar Caddesi Darcan Sokak No:6/A 34387 Mecidiyeköy','Turkish',3415867230143859,'False',625145,'le_berk@gmail.com'),(18,'Dursun','','Burak','1982-05-13 00:00:00','M',34,'Mithatpaşa Cad. No: 520 Yalı Durağı Konak','Turkish',3415713488527934,'True',975134,'dur-bur@gmail.com'),(19,'Çağlar','','Tezcan','1995-11-12 00:00:00','M',21,'Mansuroğlu Mah. Dumlupınar Cad. 269/3-4 Sok. No: 5 Avrupa-2 Apt. Zemin Kat Bornova','Turkish',5772340134891348,'False',1423012,'caglar.tezcan@yahoo.com');
/*!40000 ALTER TABLE `Passenger` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Preference`
--

DROP TABLE IF EXISTS `Preference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Preference` (
  `PassengerID` tinyint(4) NOT NULL,
  `Preferences` varchar(13) DEFAULT NULL,
  PRIMARY KEY (`PassengerID`),
  FOREIGN KEY (`PassengerID`) REFERENCES `Passenger` (`Passenger NO`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Preference`
--

LOCK TABLES `Preference` WRITE;
/*!40000 ALTER TABLE `Preference` DISABLE KEYS */;
INSERT INTO `Preference` VALUES (10,'Business'),(11,'Extra Baggage'),(14,'Round Trip');
/*!40000 ALTER TABLE `Preference` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reservation`
--

DROP TABLE IF EXISTS `Reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Reservation` (
  `Reservation_Number` smallint(6) NOT NULL AUTO_INCREMENT,
  `Reservation Date` varchar(19) DEFAULT NULL,
  `IsRoundTrip` varchar(5) DEFAULT NULL,
  `FlightDate` varchar(19) DEFAULT NULL,
  `Class` varchar(8) DEFAULT NULL,
  `EstimatedPayment` smallint(6) DEFAULT NULL,
  `DiscountRate` varchar(2) DEFAULT NULL,
  `CancellationDate` varchar(0) DEFAULT NULL,
  `ExtraBaggage` varchar(5) DEFAULT NULL,
  `PassengerNumber` tinyint(4) NOT NULL,
  `FlightID` smallint(6) NOT NULL,
  PRIMARY KEY (`Reservation_Number`),
  FOREIGN KEY (`PassengerNumber`) REFERENCES `Passenger` (`Passenger NO`) ON DELETE CASCADE,
  FOREIGN KEY (`FlightID`) REFERENCES `Flight` (`FlightID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reservation`
--

LOCK TABLES `Reservation` WRITE;
/*!40000 ALTER TABLE `Reservation` DISABLE KEYS */;
INSERT INTO `Reservation` VALUES (101,'2019-10-01 00:00:00','True','2019-12-08 00:00:00','Business',200,'15','','False',18,6000),(102,'2019-11-05 00:00:00','False','2019-12-17 00:00:00','Business',200,'15','','False',19,6004),(103,'2019-09-04 00:00:00','False','2019-12-20 00:00:00','Economy',100,'','','False',13,6001),(104,'2019-11-02 00:00:00','False','2019-12-16 00:00:00','Economy',100,'','','False',16,6001),(105,'2019-11-09 00:00:00','True','2019-12-24 00:00:00','Economy',100,'','','True',11,6004),(106,'2019-11-06 00:00:00','False','2019-12-20 00:00:00','Business',200,'15','','False',13,6003),(107,'2019-11-02 00:00:00','True','2019-12-19 00:00:00','Economy',100,'','','False',14,6002),(108,'2019-10-02 00:00:00','False','2019-12-21 00:00:00','Economy',100,'','','True',15,6002),(109,'2019-11-06 00:00:00','False','2019-12-26 00:00:00','Economy',100,'','','False',12,6001),(110,'2019-11-07 00:00:00','False','2019-12-16 00:00:00','Economy',100,'','','False',17,6001),(111,'2019-11-07 00:00:00','True','2019-12-15 00:00:00','Economy',100,'','','False',14,6002),(112,'2019-09-09 00:00:00','False','2019-12-22 00:00:00','Business',200,'15','','False',15,6000),(113,'2019-09-02 00:00:00','False','2019-12-16 00:00:00','Economy',100,'','','False',18,6000),(114,'2019-11-04 00:00:00','True','2019-12-12 00:00:00','Business',150,'','','True',14,6002),(115,'2019-10-09 00:00:00','False','2019-12-18 00:00:00','Economy',100,'','','False',12,6001),(116,'2019-11-07 00:00:00','False','2019-12-16 00:00:00','Economy',100,'','','False',19,6002),(117,'2019-11-02 00:00:00','False','2019-12-22 00:00:00','Economy',100,'','','False',17,6003),(118,'2019-10-07 00:00:00','False','2019-12-27 00:00:00','Business',200,'15','','False',16,6000),(119,'2019-11-05 00:00:00','False','2019-12-18 00:00:00','Economy',100,'','','True',11,6001);
/*!40000 ALTER TABLE `Reservation` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-08-22 15:20:25


ALTER TABLE Flight MODIFY COLUMN DepartureTime DATETIME;

