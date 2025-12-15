CREATE DATABASE  IF NOT EXISTS `vet_clinic` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `vet_clinic`;
-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: vet_clinic
-- ------------------------------------------------------
-- Server version	8.0.33

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
-- Table structure for table `appointments`
--

DROP TABLE IF EXISTS `appointments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointments` (
  `appointments_id` int NOT NULL AUTO_INCREMENT,
  `customers_id` int NOT NULL,
  `pets_id` int NOT NULL,
  `date_of_appointment` datetime NOT NULL,
  `comments` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`appointments_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointments`
--

LOCK TABLES `appointments` WRITE;
/*!40000 ALTER TABLE `appointments` DISABLE KEYS */;
INSERT INTO `appointments` VALUES (1,14,1,'2025-10-25 00:00:00',NULL),(2,8,2,'2025-10-26 00:00:00',NULL),(3,3,3,'2025-10-27 00:00:00',NULL),(4,6,4,'2025-10-27 00:00:00','heavy'),(5,9,5,'2025-10-28 00:00:00',NULL),(6,10,6,'2025-10-28 00:00:00',NULL),(7,11,7,'2025-10-29 00:00:00',NULL),(8,13,8,'2025-10-30 00:00:00',NULL),(9,5,9,'2025-10-30 00:00:00',NULL),(10,15,10,'2025-10-31 00:00:00',NULL),(11,17,11,'2025-11-01 00:00:00',NULL),(12,16,12,'2025-11-01 00:00:00',NULL),(13,17,13,'2025-11-02 00:00:00',NULL),(14,7,14,'2025-11-02 00:00:00',NULL),(15,18,15,'2025-11-03 00:00:00',NULL),(16,4,16,'2025-11-03 00:00:00',NULL),(17,3,17,'2025-11-04 00:00:00',NULL),(18,12,18,'2025-11-05 00:00:00',NULL),(19,2,19,'2025-11-06 00:00:00',NULL),(20,1,20,'2025-11-06 00:00:00',NULL);
/*!40000 ALTER TABLE `appointments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `customers_id` int NOT NULL AUTO_INCREMENT,
  `last_name` varchar(45) NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `phone_number` bigint DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `street` varchar(45) DEFAULT NULL,
  `province` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`customers_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'samsom','zulek',9285473636,NULL,NULL,'palawan'),(2,'thinken','marta',9285473637,NULL,NULL,'cebu'),(3,'mendoza','erika',9285473638,NULL,NULL,NULL),(4,'lim','nathan',9285433638,'baguio',NULL,'legazpi'),(5,'cruz','kevin',NULL,NULL,NULL,NULL),(6,'arsi','luvna',9923253251,NULL,NULL,NULL),(7,'lachica','datu',9285323638,'pampanga',NULL,NULL),(8,'dela rosa','nicholo',NULL,NULL,'',NULL),(9,'vitug','jon richmond',NULL,NULL,'','metro manila'),(10,'mangubat','erl',NULL,NULL,NULL,NULL),(11,'montero','analise',9185423638,NULL,NULL,NULL),(12,'de castro','acarl',NULL,NULL,NULL,NULL),(13,'castro','vincent',NULL,'ppc','mayo','palawan'),(14,'aquino','angela',NULL,NULL,NULL,NULL),(15,'veluya','sheila',NULL,NULL,NULL,NULL),(16,'chuu','kim',NULL,NULL,NULL,'romblon'),(17,'malolos','marco',NULL,NULL,NULL,NULL),(18,'bantog','steven',NULL,NULL,NULL,NULL),(19,'salonoy','rhea',9295451039,'ppc','mayo','palawan'),(20,'cornel ','grace',NULL,'ppc','runway','palawan');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pets`
--

DROP TABLE IF EXISTS `pets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pets` (
  `idpets` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `breed` varchar(45) NOT NULL,
  `medical_condition` varchar(45) NOT NULL,
  `birthdate` datetime DEFAULT NULL,
  PRIMARY KEY (`idpets`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pets`
--

LOCK TABLES `pets` WRITE;
/*!40000 ALTER TABLE `pets` DISABLE KEYS */;
INSERT INTO `pets` VALUES (1,'Bella','Golden Retriever','Allergies',NULL),(2,'Max','Bulldog','Hip Dysplasia',NULL),(3,'Luna','Siamese Cat','Asthma',NULL),(4,'Charlie','Beagle','Heart Murmur',NULL),(5,'Lucy','Persian Cat','Kidney Disease',NULL),(6,'Rocky','Labrador Retriever','Obesity',NULL),(7,'Milo','Maine Coon','Dental Issues',NULL),(8,'Daisy','Poodle','Arthritis',NULL),(9,'Oscar','German Shepherd','Skin Infection',NULL),(10,'Coco','Ragdoll Cat','Diabetes',NULL),(11,'Buddy','Boxer','Ear Infection',NULL),(12,'Lola','Pomeranian','Collapsed Trachea',NULL),(13,'Simba','Bengal Cat','Allergies',NULL),(14,'Zoe','Chihuahua','Luxating Patella',NULL),(15,'Toby','Border Collie','Epilepsy',NULL),(16,'Molly','Shih Tzu','Eye Irritation',NULL),(17,'Bailey','Cocker Spaniel','Ear Mites',NULL),(18,'Leo','Sphynx Cat','Skin Sensitivity',NULL),(19,'Nala','Husky','Joint Pain',NULL),(20,'Jack','Dachshund','Back Problems',NULL);
/*!40000 ALTER TABLE `pets` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-23 14:21:50
