-- MySQL dump 10.13  Distrib 8.0.22, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: payroll_service
-- ------------------------------------------------------
-- Server version	5.7.32-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department` (
  `DepartmentId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `DepartmentName` varchar(20) NOT NULL,
  PRIMARY KEY (`DepartmentId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1,'Sales'),(2,'Marketing');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee_department`
--

DROP TABLE IF EXISTS `employee_department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee_department` (
  `EmployeeId` int(10) unsigned NOT NULL,
  `DepartmentId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`EmployeeId`,`DepartmentId`),
  KEY `DepartmentId` (`DepartmentId`),
  CONSTRAINT `employee_department_ibfk_1` FOREIGN KEY (`EmployeeId`) REFERENCES `employee_payroll` (`EmployeeId`) ON DELETE CASCADE,
  CONSTRAINT `employee_department_ibfk_2` FOREIGN KEY (`DepartmentId`) REFERENCES `department` (`DepartmentId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee_department`
--

LOCK TABLES `employee_department` WRITE;
/*!40000 ALTER TABLE `employee_department` DISABLE KEYS */;
INSERT INTO `employee_department` VALUES (1,1),(2,1),(3,1),(2,2),(4,2);
/*!40000 ALTER TABLE `employee_department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee_payroll`
--

DROP TABLE IF EXISTS `employee_payroll`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee_payroll` (
  `EmployeeId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `EmployeeName` varchar(150) NOT NULL,
  `PhoneNumber` varchar(15) DEFAULT NULL,
  `Address` varchar(255) DEFAULT 'Mumbai',
  `Gender` char(1) DEFAULT NULL,
  `StartDate` date NOT NULL,
  PRIMARY KEY (`EmployeeId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee_payroll`
--

LOCK TABLES `employee_payroll` WRITE;
/*!40000 ALTER TABLE `employee_payroll` DISABLE KEYS */;
INSERT INTO `employee_payroll` VALUES (1,'Bill',NULL,'Mumbai','M','2018-01-03'),(2,'Terrisa','9876543210','Mumbai','F','2019-11-13'),(3,'Charlie',NULL,'Mumbai','M','2020-05-21'),(4,'Gunjan',NULL,'Mumbai','F','2019-07-10');
/*!40000 ALTER TABLE `employee_payroll` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payroll_details`
--

DROP TABLE IF EXISTS `payroll_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payroll_details` (
  `EmployeeId` int(10) unsigned NOT NULL,
  `BasicPay` double NOT NULL,
  `Deductions` double NOT NULL,
  `TaxablePay` double NOT NULL,
  `IncomeTax` double NOT NULL,
  `NetPay` double NOT NULL,
  KEY `EmployeeId` (`EmployeeId`),
  CONSTRAINT `payroll_details_ibfk_1` FOREIGN KEY (`EmployeeId`) REFERENCES `employee_payroll` (`EmployeeId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payroll_details`
--

LOCK TABLES `payroll_details` WRITE;
/*!40000 ALTER TABLE `payroll_details` DISABLE KEYS */;
INSERT INTO `payroll_details` VALUES (1,1000000,0,0,0,0),(2,2000000,1000000,1000000,500000,500000),(3,3000000,0,0,0,0),(4,4000000,0,0,0,0);
/*!40000 ALTER TABLE `payroll_details` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-11-21 22:38:28
