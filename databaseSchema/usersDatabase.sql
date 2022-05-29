-- MySQL dump 10.19  Distrib 10.3.31-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: adise2021Quarto
-- ------------------------------------------------------
-- Server version	10.3.31-MariaDB-0+deb10u1-log

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
-- Table structure for table `board`
--

DROP TABLE IF EXISTS `board`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `board` (
  `posX` tinyint(4) NOT NULL,
  `posY` tinyint(4) NOT NULL,
  `piece` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`posX`,`posY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board`
--

LOCK TABLES `board` WRITE;
/*!40000 ALTER TABLE `board` DISABLE KEYS */;
INSERT INTO `board` VALUES (1,1,NULL),(1,2,NULL),(1,3,NULL),(1,4,NULL),(2,1,NULL),(2,2,NULL),(2,3,NULL),(2,4,NULL),(3,1,NULL),(3,2,NULL),(3,3,NULL),(3,4,NULL),(4,1,NULL),(4,2,NULL),(4,3,NULL),(4,4,NULL);
/*!40000 ALTER TABLE `board` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `board_empty`
--

DROP TABLE IF EXISTS `board_empty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `board_empty` (
  `posX` tinyint(4) NOT NULL,
  `posY` tinyint(4) NOT NULL,
  `piece` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`posX`,`posY`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board_empty`
--

LOCK TABLES `board_empty` WRITE;
/*!40000 ALTER TABLE `board_empty` DISABLE KEYS */;
INSERT INTO `board_empty` VALUES (1,1,NULL),(1,2,NULL),(1,3,NULL),(1,4,NULL),(2,1,NULL),(2,2,NULL),(2,3,NULL),(2,4,NULL),(3,1,NULL),(3,2,NULL),(3,3,NULL),(3,4,NULL),(4,1,NULL),(4,2,NULL),(4,3,NULL),(4,4,NULL);
/*!40000 ALTER TABLE `board_empty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_status`
--

DROP TABLE IF EXISTS `game_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_status` (
  `status` enum('not active','initialized','started','ended','aborted') NOT NULL DEFAULT 'not active',
  `result` enum('Player1','Player2','Draw') DEFAULT NULL,
  `player_turn` enum('Player1','Player2') DEFAULT 'Player1',
  `last_change` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_status`
--

LOCK TABLES `game_status` WRITE;
/*!40000 ALTER TABLE `game_status` DISABLE KEYS */;
INSERT INTO `game_status` VALUES ('not active',NULL,'Player1','2022-01-16 12:07:24');
/*!40000 ALTER TABLE `game_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pieces`
--

DROP TABLE IF EXISTS `pieces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pieces` (
  `piece_id` varchar(50) NOT NULL,
  `piece_color` enum('White','Brown') NOT NULL DEFAULT 'White',
  `piece_height` enum('Tall','Short') NOT NULL DEFAULT 'Tall',
  `piece_shape` enum('Square','Circle') NOT NULL DEFAULT 'Circle',
  `piece_depth` enum('Hollow','Flat','nothing') NOT NULL DEFAULT 'nothing',
  `played` enum('False','True') NOT NULL DEFAULT 'False',
  PRIMARY KEY (`piece_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pieces`
--

LOCK TABLES `pieces` WRITE;
/*!40000 ALTER TABLE `pieces` DISABLE KEYS */;
INSERT INTO `pieces` VALUES ('BSCF','Brown','Short','Circle','Flat','False'),('BSCH','Brown','Short','Circle','Hollow','False'),('BSSF','Brown','Short','Square','Flat','False'),('BSSH','Brown','Short','Square','Hollow','False'),('BTCF','Brown','Tall','Circle','Flat','False'),('BTCH','Brown','Tall','Circle','Hollow','False'),('BTSF','Brown','Tall','Square','Flat','False'),('BTSH','Brown','Tall','Square','Hollow','False'),('WSCF','White','Short','Circle','Flat','False'),('WSCH','White','Short','Circle','Hollow','False'),('WSSF','White','Short','Square','Flat','False'),('WSSH','White','Short','Square','Hollow','False'),('WTCF','White','Tall','Circle','Flat','False'),('WTCH','White','Tall','Circle','Hollow','False'),('WTSF','White','Tall','Square','Flat','False'),('WTSH','White','Tall','Square','Hollow','False');
/*!40000 ALTER TABLE `pieces` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pieces_reload`
--

DROP TABLE IF EXISTS `pieces_reload`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pieces_reload` (
  `piece_id` varchar(50) NOT NULL,
  `piece_color` enum('White','Brown') NOT NULL DEFAULT 'White',
  `piece_height` enum('Tall','Short') NOT NULL DEFAULT 'Tall',
  `piece_shape` enum('Square','Circle') NOT NULL DEFAULT 'Circle',
  `piece_depth` enum('Hollow','Flat','nothing') NOT NULL DEFAULT 'nothing',
  `played` enum('False','True') NOT NULL DEFAULT 'False',
  PRIMARY KEY (`piece_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pieces_reload`
--

LOCK TABLES `pieces_reload` WRITE;
/*!40000 ALTER TABLE `pieces_reload` DISABLE KEYS */;
INSERT INTO `pieces_reload` VALUES ('BSCF','Brown','Short','Circle','Flat','False'),('BSCH','Brown','Short','Circle','Hollow','False'),('BSSF','Brown','Short','Square','Flat','False'),('BSSH','Brown','Short','Square','Hollow','False'),('BTCF','Brown','Tall','Circle','Flat','False'),('BTCH','Brown','Tall','Circle','Hollow','False'),('BTSF','Brown','Tall','Square','Flat','False'),('BTSH','Brown','Tall','Square','Hollow','False'),('WSCF','White','Short','Circle','Flat','False'),('WSCH','White','Short','Circle','Hollow','False'),('WSSF','White','Short','Square','Flat','False'),('WSSH','White','Short','Square','Hollow','False'),('WTCF','White','Tall','Circle','Flat','False'),('WTCH','White','Tall','Circle','Hollow','False'),('WTSF','White','Tall','Square','Flat','False'),('WTSH','White','Tall','Square','Hollow','False');
/*!40000 ALTER TABLE `pieces_reload` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `players`
--

DROP TABLE IF EXISTS `players`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `players` (
  `username` varchar(50) DEFAULT NULL,
  `token` varchar(50) DEFAULT NULL,
  `last_action` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `player_id` enum('Player1','Player2') NOT NULL DEFAULT 'Player1',
  PRIMARY KEY (`player_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `players`
--

LOCK TABLES `players` WRITE;
/*!40000 ALTER TABLE `players` DISABLE KEYS */;
INSERT INTO `players` VALUES (NULL,NULL,'2022-01-16 12:07:04','Player1'),(NULL,NULL,'2022-01-16 12:07:15','Player2');
/*!40000 ALTER TABLE `players` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'adise2021Quarto'
--
/*!50003 DROP PROCEDURE IF EXISTS `clean_board` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `clean_board`()
BEGIN
	REPLACE INTO board SELECT * FROM board_empty;
	UPDATE players SET username=NULL;
	UPDATE game_status SET status='not active', player_turn=NULL, result=NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `reload_pieces` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `reload_pieces`()
BEGIN
	REPLACE INTO pieces SELECT * FROM pieces_reload;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-01-16 14:10:48
