-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: letsplay
-- ------------------------------------------------------
-- Server version	8.0.19

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ParentCategoryID` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `IX_Categories_Name` (`Name`),
  KEY `IX_Categories_ParentCategoryID` (`ParentCategoryID`),
  CONSTRAINT `FK_Categories_Categories_ParentCategoryID` FOREIGN KEY (`ParentCategoryID`) REFERENCES `categories` (`ID`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Root',-1),(2,'Sports',1),(3,'Video Games',1),(4,'Music',1),
(5,'Football',2),(6,'Volleyball',2),(7,'Basketball',2),(8,'Tenis',2),(9,'League of Legends',3),
(10,'Dota 2',3),(11,'Fortnite',3),(12,'PUBG',3),(13,'World of Warcraft',3);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cities`
--

DROP TABLE IF EXISTS `cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cities` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Name` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cities`
--

LOCK TABLES `cities` WRITE;
/*!40000 ALTER TABLE `cities` DISABLE KEYS */;
INSERT INTO `cities` VALUES (7,'Айтос'), (8,'Аксаково'), (9,'Алфатар'), (10,'Антоново'), (11,'Априлци'), (12,'Ардино'), (13,'Асеновград'), (14,'Ахелой'), (15,'Ахтопол'), (16,'Балчик'), (17,'Банкя'), (18,'Банско'), (19,'Баня'), (20,'Батак'), (21,'Батановци'), (22,'Белене'), (23,'Белица'), (24,'Белово'), (25,'Белоградчик'), (26,'Белослав'), (27,'Берковица'), (28,'Благоевград'), (29,'Бобов дол'), (30,'Бобошево'), (31,'Божурище'), (32,'Бойчиновци'), (33,'Болярово'), (34,'Борово'), (35,'Ботевград'), (36,'Брацигово'), (37,'Брегово'), (38,'Брезник'), (39,'Брезово'), (40,'Брусарци'), (41,'Бургас'), (42,'Бухово'), (43,'Българово'), (44,'Бяла'), (45,'Бяла'), (46,'Бяла Слатина'), (47,'Бяла Черква'), (48,'Варна'), (49,'Велики Преслав'), (50,'Велико Търново'), (51,'Велинград'), (52,'Ветово'), (53,'Ветрен'), (54,'Видин'), (55,'Враца'), (56,'Вълчедръм'), (57,'Вълчи дол'), (58,'Върбица'), (59,'Вършец'), (60,'Габрово'), (61,'Генерал Тошево'), (62,'Главиница'), (63,'Глоджево'), (64,'Годеч'), (65,'Горна Оряховица'), (66,'Гоце Делчев'), (67,'Грамада'), (68,'Гулянци'), (69,'Гурково'), (70,'Гълъбово'), (71,'Две могили'), (72,'Дебелец'), (73,'Девин'), (74,'Девня'), (75,'Джебел'), (76,'Димитровград'), (77,'Димово'), (78,'Добринище'), (79,'Добрич'), (80,'Долна баня'), (81,'Долна Митрополия'), (82,'Долна Оряховица'), (83,'Долни Дъбник'), (84,'Долни чифлик'), (85,'Доспат'), (86,'Драгоман'), (87,'Дряново'), (88,'Дулово'), (89,'Дунавци'), (90,'Дупница'), (91,'Дългопол'), (92,'Елена'), (93,'Елин Пелин'), (94,'Елхово'), (95,'Етрополе'), (96,'Завет'), (97,'Земен'), (98,'Златарица'), (99,'Златица'), (100,'Златоград'), (101,'Ивайловград'), (102,'Игнатиево'), (103,'Искър'), (104,'Исперих'), (105,'Ихтиман'), (106,'Каблешково'), (107,'Каварна'), (108,'Казанлък'), (109,'Калофер'), (110,'Камено'), (111,'Каолиново'), (112,'Карлово'), (113,'Карнобат'), (114,'Каспичан'), (115,'Кермен'), (116,'Килифарево'), (117,'Китен'), (118,'Клисура'), (119,'Кнежа'), (120,'Козлодуй'), (121,'Койнаре'), (122,'Копривщица'), (123,'Костандово'), (124,'Костенец'), (125,'Костинброд'), (126,'Котел'), (127,'Кочериново'), (128,'Кресна'), (129,'Криводол'), (130,'Кричим'), (131,'Крумовград'), (132,'Крън'), (133,'Кубрат'), (134,'Куклен'), (135,'Кула'), (136,'Кърджали'), (137,'Кюстендил'), (138,'Левски'), (139,'Летница'), (140,'Ловеч'), (141,'Лозница'), (142,'Лом'), (143,'Луковит'), (144,'Лъки'), (145,'Любимец'), (146,'Лясковец'), (147,'Мадан'), (148,'Маджарово'), (149,'Малко Търново'), (150,'Мартен'), (151,'Мездра'), (152,'Мелник'), (153,'Меричлери'), (154,'Мизия'), (155,'Момин проход'), (156,'Момчилград'), (157,'Монтана'), (158,'Мъглиж'), (159,'Неделино'), (160,'Несебър'), (161,'Николаево'), (162,'Никопол'), (163,'Нова Загора'), (164,'Нови Искър'), (165,'Нови пазар'), (166,'Обзор'), (167,'Омуртаг'), (168,'Опака'), (169,'Оряхово'), (170,'Павел баня'), (171,'Павликени'), (172,'Пазарджик'), (173,'Панагюрище'), (174,'Перник'), (175,'Перущица'), (176,'Петрич'), (177,'Пещера'), (178,'Пирдоп'), (179,'Плачковци'), (180,'Плевен'), (181,'Плиска'), (182,'Пловдив'), (183,'Полски Тръмбеш'), (184,'Поморие'), (185,'Попово'), (186,'Пордим'), (187,'Правец', (188,'Приморско'), (189,'Провадия'), (190,'Първомай'), (191,'Раднево'), (192,'Радомир'), (193,'Разград'), (194,'Разлог'), (195,'Ракитово'), (196,'Раковски'), (197,'Рила'), (198,'Роман'), (199,'Рудозем'), (200,'Русе'), (201,'Садово'), (202,'Самоков'), (203,'Сандански'), (204,'Сапарева баня'), (205,'Свети Влас'), (206,'Свиленград'), (207,'Свищов'), (208,'Своге'), (209,'Севлиево'), (210,'Сеново'), (211,'Септември'), (212,'Силистра'), (213,'Симеоновград'), (214,'Симитли'), (215,'Славяново'), (216,'Сливен'), (217,'Сливница'), (218,'Сливо поле'), (219,'Смолян'), (220,'Смядово'), (221,'Созопол'), (222,'Сопот'), (223,'София'), (224,'Средец'), (225,'Стамболийски'), (226,'Стара Загора'), (227,'Стражица'), (228,'Стралджа'), (229,'Стрелча'), (230,'Суворово'), (231,'Сунгурларе'), (232,'Сухиндол'), (233,'Съединение'), (234,'Сърница'), (235,'Твърдица'), (236,'Тервел'), (237,'Тетевен'), (238,'Тополовград'), (239,'Троян'), (240,'Трън'), (241,'Тръстеник'), (242,'Трявна'), (243,'Тутракан'), (244,'Търговище'), (245,'Угърчин'), (246,'Хаджидимово'), (247,'Харманли'), (248,'Хасково'), (249,'Хисаря'), (250,'Цар Калоян'), (251,'Царево'), (252,'Чепеларе'), (253,'Червен бряг'), (254,'Черноморец'), (255,'Чипровци'), (256,'Чирпан'), (257,'Шабла'), (258,'Шивачево'), (259,'Шипка'), (260,'Шумен'), (261,'Ябланица'), (262,'Якоруда'), (263,'Ямбол');
/*!40000 ALTER TABLE `cities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Message` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `EventID` int DEFAULT NULL,
  `UserId` int DEFAULT NULL,
  `PostedOn` datetime(6) NOT NULL,
  `UpdatedOn` datetime(6) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `IX_Comments_EventID` (`EventID`),
  KEY `IX_Comments_UserId` (`UserId`),
  CONSTRAINT `FK_Comments_Events_EventID` FOREIGN KEY (`EventID`) REFERENCES `events` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `FK_Comments_Users_UserId` FOREIGN KEY (`UserId`) REFERENCES `users` (`Id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (1,'Texas or Omaha?',1,2,'2020-03-06 11:27:15.000000','2020-03-06 11:27:15.000000'),(2,'Panikata hvana me',2,3,'2020-03-06 11:27:15.000000','2020-03-06 11:27:15.000000'),(3,'Pozvoleno li e da si vzimam kalevri?',3,1,'2020-03-06 11:27:15.000000','2020-03-06 11:27:15.000000'),(4,'Savata shte bude li tam?',4,5,'2020-03-06 11:27:15.000000','2020-03-06 11:27:15.000000'),(5,'Plat 3 supp sum. Nickname:JclownX',5,4,'2020-03-06 11:27:15.000000','2020-03-06 11:27:15.000000');
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `events` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `EventStartDate` datetime(6) NOT NULL,
  `CreatedOn` datetime(6) NOT NULL,
  `UpdatedOn` datetime(6) NOT NULL,
  `EventStatus` int NOT NULL,
  `Recurring` int DEFAULT NULL,
  `Description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `PeopleNeeded` int NOT NULL,
  `Title` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `UserCreatedByID` int NOT NULL,
  `CategoryID` int NOT NULL,
  `CityID` int NOT NULL,
  `Address` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `IX_Events_CategoryID` (`CategoryID`),
  KEY `IX_Events_CityID` (`CityID`),
  KEY `IX_Events_UserCreatedByID` (`UserCreatedByID`),
  KEY `IX_Events_EventStartDate` (`EventStartDate`,`Recurring`),
  CONSTRAINT `FK_Events_Categories_CategoryID` FOREIGN KEY (`CategoryID`) REFERENCES `categories` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `FK_Events_Cities_CityID` FOREIGN KEY (`CityID`) REFERENCES `cities` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `FK_Events_Users_UserCreatedByID` FOREIGN KEY (`UserCreatedByID`) REFERENCES `users` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` VALUES (1,'2020-07-06 11:17:21.000000','2020-03-06 11:27:15.000000','2020-03-06 11:27:15.000000',1,2,'of nqma',3,'Poker:Kichuka',1,2,6,'ul.\"Vasil Chekelarov\",2'),
(2,'2020-07-06 11:17:21.000000','2020-03-06 11:27:15.000000','2020-03-06 11:27:15.000000',1,3,'Chalga-party-international',6,'Galena',2,5,6,'Club Bushido'),
(3,'2020-07-06 11:17:21.000000','2020-03-06 11:27:15.000000','2020-03-06 11:27:15.000000',1,2,'Need 2 people today at Optium Plovdiv to play football.',1,'Football-Optium',3,5,6,'Optium Plovdiv'),
(4,'2020-07-06 11:17:21.000000','2020-03-06 11:27:15.000000','2020-03-06 11:27:15.000000',1,3,'Dress code black.',14,'Dope-Zoo',4,13,6,'Club Void'),
(5,'2020-07-06 11:17:21.000000','2020-03-06 11:27:15.000000','2020-03-06 11:27:15.000000',1,1,'Need 3 people for clash tournament.',2,'Clash:LOL',5,8,6,''),
(6,'2020-07-06 11:17:21.000000','2020-03-06 11:27:15.000000','2020-03-06 11:27:15.000000',1,1,'aaa',3,'Balona',2,5,6,'ne'),
(7,'2020-07-06 11:17:21.000000','2020-03-06 11:27:15.000000','2020-03-06 11:27:15.000000',1,1,'bb',4,'Machle',1,5,6,'da'),
(8,'2020-07-06 11:17:21.000000','2020-03-06 11:27:15.000000','2020-03-06 11:27:15.000000',1,1,'cc',5,'Grebnata',3,5,6,'we'),
(9,'2020-07-06 11:17:21.000000','2020-03-06 11:27:15.000000','2020-03-06 11:27:15.000000',1,1,'ddd',6,'Skobata',4,5,6,'ka'),
(10,'2020-07-06 11:17:21.000000','2020-03-06 11:27:15.000000','2020-03-06 11:27:15.000000',1,1,'eee',7,'VSi',5,2,6,'de'),
(11,'2020-07-06 11:17:21.000000','2020-03-06 11:27:15.000000','2020-03-06 11:27:15.000000',1,1,'fff',8,'giganta',1,2,6,'das'),
(12,'2020-07-06 11:17:21.000000','2020-03-06 11:27:15.000000','2020-03-06 11:27:15.000000',1,1,'ggg',9,'levski ',1,5,5,'ich'),
(13,'2020-08-06 11:17:21.000000','2020-03-06 11:27:15.000000','2020-03-06 11:27:15.000000',1,1,'jjj',10,'cska',1,5,5,'bin'),
(14,'2020-08-06 11:17:21.000000','2020-03-06 11:27:15.000000','2020-03-06 11:27:15.000000',1,1,'ppp',10,'loko',1,5,5,'kehgdssdggf'),
(15,'2020-08-06 11:17:21.000000','2020-03-06 11:27:15.000000','2020-03-06 11:27:15.000000',1,1,'ooo',10,'botev',1,5,5,'daddaadda');
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Name` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'User'),(2,'Admin');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userevents`
--

DROP TABLE IF EXISTS `userevents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userevents` (
  `UserID` int NOT NULL,
  `EventID` int NOT NULL,
  PRIMARY KEY (`UserID`,`EventID`),
  KEY `IX_UserEvents_EventID` (`EventID`),
  CONSTRAINT `FK_UserEvents_Events_EventID` FOREIGN KEY (`EventID`) REFERENCES `events` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `FK_UserEvents_Users_UserID` FOREIGN KEY (`UserID`) REFERENCES `users` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userevents`
--

LOCK TABLES `userevents` WRITE;
/*!40000 ALTER TABLE `userevents` DISABLE KEYS */;
INSERT INTO `userevents` VALUES (2,1),(3,2),(1,3),(5,4),(4,5);
/*!40000 ALTER TABLE `userevents` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `updatePeopleNeeded` AFTER INSERT ON `userevents` FOR EACH ROW begin

       DECLARE id_exists Boolean;

       -- Check BookingRequest table

       SELECT 1

       INTO @id_exists

       FROM events

       WHERE events.ID = NEW.EventID;


       IF @id_exists = 1

       THEN

           UPDATE events

           SET peopleneeded = peopleneeded - 1

           WHERE ID = NEW.EventID;

        END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `USERROLES`
--

DROP TABLE IF EXISTS `USERROLES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USERROLES` (
  `UserId` int NOT NULL,
  `RoleId` int NOT NULL,
  PRIMARY KEY (`UserId`,`RoleId`),
  KEY `IX_USERROLES_RoleId` (`RoleId`),
  CONSTRAINT `FK_USERROLES_Roles_RoleId` FOREIGN KEY (`RoleId`) REFERENCES `roles` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_USERROLES_Users_UserId` FOREIGN KEY (`UserId`) REFERENCES `users` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USERROLES`
--

LOCK TABLES `USERROLES` WRITE;
/*!40000 ALTER TABLE `USERROLES` DISABLE KEYS */;
INSERT INTO `USERROLES` VALUES (1,1),(2,1),(3,1),(4,1),(5,1),(6,1);
/*!40000 ALTER TABLE `USERROLES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Username` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `Password` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `Email` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `CreatedAt` datetime(6) NOT NULL,
  `UpdatedAt` datetime(6) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Yovcho','password','ivelinjilov16@gmail.com','2020-03-06 11:14:52.000000','2020-03-06 11:14:52.000000'),(2,'Leppop','password','leppop@abv.bg','2020-03-06 11:17:21.000000','2020-03-06 11:17:21.000000'),(3,'Angel','password','angel.k@yahoo.com','2020-03-06 11:17:21.000000','2020-03-06 11:17:21.000000'),(4,'lilVayne','vaynegod32','vayne.god@mail.bg','2020-03-06 11:17:21.000000','2020-03-06 11:17:21.000000'),(5,'PeteApple','kudeebirata55','pesho.ywna@gmail.com','2020-03-06 11:17:21.000000','2020-03-06 11:17:21.000000'),(6,'Allah','allah','allah@gmail.com','2020-03-06 11:17:21.000000','2020-03-06 11:17:21.000000');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `UPDATEPEOPLEROLE` AFTER INSERT ON `users` FOR EACH ROW BEGIN

	INSERT INTO USERROLES

    VALUES(NEW.ID,1);

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping events for database 'letsplay'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `EVENTHAPPENINGNOWSTATUSUPDATE` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `EVENTHAPPENINGNOWSTATUSUPDATE` ON SCHEDULE EVERY 1 MINUTE STARTS '2020-03-26 16:41:04' ENDS '2030-03-26 16:41:04' ON COMPLETION PRESERVE ENABLE DO UPDATE letsplay.events
 		SET 
 			EVENTSTATUS = IF(EVENTSTATUS <> 3,2,EVENTSTATUS)
 		WHERE  EVENTSTARTDATE < CURRENT_TIMESTAMP */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `EVENTUPDATEAFTERTWELVEHOURS` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `EVENTUPDATEAFTERTWELVEHOURS` ON SCHEDULE EVERY 1 MINUTE STARTS '2020-03-27 16:41:04' ENDS '2030-03-26 16:41:04' ON COMPLETION PRESERVE ENABLE DO UPDATE letsplay.events
​
 		SET 
 			EVENTSTATUS = IF(RECURRING IS NOT NULL AND EVENTSTATUS <> 3,1,EVENTSTATUS),
 			EVENTSTATUS = IF(isnull(RECURRING),3,EVENTSTATUS),
             EVENTSTARTDATE = IF(RECURRING = 1 AND EVENTSTATUS <> 3,adddate(EVENTSTARTDATE,INTERVAL 1 DAY),EVENTSTARTDATE),
             EVENTSTARTDATE = IF(RECURRING = 2  AND EVENTSTATUS <> 3,adddate(EVENTSTARTDATE,INTERVAL 7 DAY),EVENTSTARTDATE),
             EVENTSTARTDATE = IF(RECURRING = 3  AND EVENTSTATUS <> 3,adddate(EVENTSTARTDATE,INTERVAL 1 MONTH),EVENTSTARTDATE)
 		WHERE  ADDDATE(EVENTSTARTDATE,INTERVAL 12 HOUR) < CURRENT_TIMESTAMP */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-03-24 17:33:13
