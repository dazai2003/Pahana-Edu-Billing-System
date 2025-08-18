-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: pahana_edu
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `age` int DEFAULT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Vihanga Wimalaweera','Ganthiriyagama, Anuradhapura',22,'0771234567','vihangawimalaweera@gmail.com'),(2,'Thanuji Dissanayake','Gurudeniya,Kandy',20,'0719876543','thanujidissanayake2005@gmail.com'),(3,'Pamadi Wimalaweera','Ganthiriyagama,Anuradhapura',17,'0754567890','pamadiwimalaweera@gmail.com'),(4,'Dulith wanasekara','Katugasthota,Kandy',23,'0778765432','dulithmax@gmail.com'),(5,'Pamadani Karunarathne','Basawakkulama,Anuradhapura',53,'0761234567','pamadanikarunarathne@gmail.com'),(6,'Sakuni Thasunika','Mulgampola, Gampaha',13,'0702345678','sakunithasunika@gmail.com'),(7,'Mihisara Neeladenuwan','Basawakkulama,Anuradhapura',15,'0783456789','mihisaraneeladenuwan@gmail.com'),(8,'Nimal Bandara','12, Main Street, Colombo',35,'0711122334','nimal.bandara@gmail.com'),(9,'Ishara Fernando','45/A, Galle Road, Panadura',28,'0778899001','ishara.fernando@yahoo.com'),(10,'Kavindi Senanayake','88, Kandy Road, Peradeniya',42,'0787654321','kavindi.senanayake@gmail.com'),(11,'Amal Rajapaksa','10/B, Jaffna Road, Anuradhapura',55,'0714455667','amal.rajapaksa@yahoo.com'),(12,'Chamali Perera','22, School Lane, Negombo',19,'0755667788','chamali.perera@gmail.com'),(13,'Janani De Seram','Manawa, Anuradhapura',21,'+94 78 256 5456','jananide2004@gmail.com');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `items` (
  `item_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `description` text,
  `price` decimal(10,2) DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `item_type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES (1,'Grade 11 Math Workbook','Grade 11 Mathematic questions for each lesson',1200.00,20,'Workbooks'),(14,'Mathematics Grade 6','School textbook for Grade 6 Mathematics',950.00,79,'Textbooks'),(15,'Science Grade 8','School textbook covering Grade 8 science topics',1100.00,65,'Textbooks'),(16,'English Literature O/L','Prescribed literature text for O/L syllabus',1450.00,40,'Textbooks'),(17,'History Grade 9','Comprehensive history syllabus coverage',1050.00,54,'Textbooks'),(18,'Business Studies A/L','Advanced Level textbook for commerce stream',1650.00,34,'Textbooks'),(19,'Mathematics Practice Grade 6','Workbook with exercises for Grade 6 Mathematics',450.00,90,'Workbooks'),(20,'Science Practical Workbook','Workbook for science experiments and activities',550.00,68,'Workbooks'),(21,'English Grammar Workbook','Exercises for improving grammar and vocabulary',500.00,84,'Workbooks'),(22,'Sinhala Language Workbook','Grammar and comprehension practice in Sinhala',400.00,75,'Workbooks'),(23,'Accounting Practice Book','Workbook for accounting problems and solutions',650.00,50,'Workbooks'),(24,'Oxford English Dictionary','Comprehensive English language reference',3500.00,20,'Reference Books'),(25,'Advanced Physics Reference','Reference guide for physics topics',4200.00,15,'Reference Books'),(26,'Mathematics Formula Handbook','Collection of math formulas for quick reference',1500.00,30,'Reference Books'),(27,'Biology Illustrated Guide','Detailed biology reference with diagrams',3800.00,17,'Reference Books'),(28,'World History Encyclopedia','Comprehensive encyclopedia on global history',5000.00,12,'Reference Books'),(29,'Grade 10 Science eBook','Digital science textbook in PDF format',950.00,99,'Digital Content'),(30,'Mathematics Video Lessons','Set of video tutorials for mathematics',2000.00,80,'Digital Content'),(31,'English Literature Audio Book','Audio version of prescribed literature text',1500.00,90,'Digital Content'),(32,'Accounting Theory eBook','Digital version of accounting textbook',1200.00,70,'Digital Content'),(33,'History Interactive CD','CD with interactive history lessons',1800.00,60,'Digital Content'),(34,'Blue Ballpoint Pen (10 Pack)','Pack of 10 smooth-writing blue pens',250.00,250,'Stationery'),(35,'HB Pencil (12 Pack)','Set of 12 high-quality HB pencils',200.00,300,'Stationery'),(36,'A4 200-Page Exercise Book','Ruled exercise book for school use',150.00,350,'Stationery'),(37,'Mathematics Instrument Box','Geometry box with compass, ruler, and protractor',450.00,150,'Stationery'),(38,'Permanent Marker Set','Set of assorted color permanent markers',500.00,120,'Stationery'),(39,'Math Solver Pro','Software for solving and explaining math problems',3500.00,25,'Educational Software'),(40,'Typing Tutor Deluxe','Touch typing tutor with lessons and games',2800.00,30,'Educational Software'),(41,'Science Simulation Lab','Interactive science experiments simulator',4000.00,20,'Educational Software'),(42,'Language Learning Suite','Multi-language learning software',4500.00,15,'Educational Software'),(43,'Accounting Ledger Software','Practical accounting ledger training tool',5000.00,10,'Educational Software'),(44,'Grade 9 Past Papers','Collection of past papers with marking schemes',600.00,70,'Assessment Materials'),(45,'O/L Model Papers','Set of model papers for Ordinary Level exams',750.00,65,'Assessment Materials'),(46,'A/L Past Papers Pack','Complete past papers for Advanced Level',950.00,48,'Assessment Materials'),(47,'Grade 8 Revision Test Papers','Practice papers for Grade 8 students',550.00,80,'Assessment Materials'),(48,'Mock Exam Bundle','Full mock exams with answer keys',850.00,59,'Assessment Materials'),(49,'School Backpack','Durable backpack suitable for school use',2500.00,40,'Other'),(50,'Water Bottle 750ml','Reusable water bottle',800.00,50,'Other'),(51,'Lunch Box','Plastic lunch container with compartments',600.00,55,'Other'),(52,'Desk Lamp','Adjustable LED desk lamp',1500.00,30,'Other'),(53,'Raincoat','Lightweight waterproof raincoat',1800.00,25,'Other'),(54,'Harry Potter and the Sorcerer\'s Stone','Fantasy novel by J.K. Rowling',1800.00,34,'Novels'),(55,'The Hobbit','Classic fantasy novel by J.R.R. Tolkien',1600.00,25,'Novels'),(56,'Pride and Prejudice','Romantic novel by Jane Austen',1400.00,28,'Novels'),(57,'The Great Gatsby','Classic American novel by F. Scott Fitzgerald',1500.00,20,'Novels'),(58,'The Da Vinci Code','Thriller novel by Dan Brown',1700.00,21,'Novels'),(59,'Geography Grade 7','School textbook for Grade 7 geography',950.00,65,'Textbooks'),(60,'Chemistry A/L Theory','Advanced Level chemistry textbook',1750.00,38,'Textbooks'),(61,'ICT Grade 10','School ICT syllabus textbook',1200.00,50,'Textbooks'),(62,'Art & Design Grade 8','Art and design curriculum textbook',1100.00,55,'Textbooks'),(63,'Economics O/L','Ordinary Level economics syllabus textbook',1450.00,35,'Textbooks'),(64,'Sinhala Literature Workbook','Practice workbook for Sinhala literature',500.00,70,'Workbooks'),(65,'English Creative Writing Workbook','Workbook for improving creative writing skills',550.00,65,'Workbooks'),(66,'Science Revision Workbook Grade 9','Revision exercises for Grade 9 science',600.00,80,'Workbooks'),(67,'Math Past Paper Workbook','Workbook of past papers with answers',750.00,60,'Workbooks'),(68,'Spelling Practice Workbook','Exercises for spelling and vocabulary improvement',450.00,85,'Workbooks'),(69,'Cambridge Advanced Learner\'s Dictionary','English language dictionary',3200.00,18,'Reference Books'),(70,'Atlas of the World','Illustrated geographical atlas',4000.00,20,'Reference Books'),(71,'Complete Chemistry Reference','Comprehensive chemistry reference guide',3800.00,15,'Reference Books'),(72,'Engineering Mathematics Handbook','Reference for engineering mathematics',4500.00,12,'Reference Books'),(73,'Science Glossary','Glossary of scientific terms',2000.00,25,'Reference Books'),(74,'Biology Video Lessons','Video tutorials for biology topics',2200.00,75,'Digital Content'),(75,'Physics Simulation Software','Physics lab simulation software',3800.00,30,'Digital Content'),(76,'English Listening Skills Audio Pack','Audio lessons for listening practice',1500.00,85,'Digital Content'),(77,'Interactive Math Practice App','Digital math problem-solving app',2500.00,40,'Digital Content'),(78,'Geography Digital Atlas','Interactive digital atlas',3000.00,35,'Digital Content'),(79,'Gel Pen Set (Blue & Black)','Set of smooth gel pens',300.00,180,'Stationery'),(80,'Colored Pencils (12 Pack)','Box of 12 color pencils',250.00,220,'Stationery'),(81,'Whiteboard Markers (4 Pack)','Set of assorted color whiteboard markers',400.00,140,'Stationery'),(82,'Ruler 30cm','Plastic ruler with measurements',80.00,300,'Stationery'),(83,'Glue Stick','Non-toxic school glue stick',120.00,250,'Stationery'),(84,'Physics Formula Trainer','Interactive learning of physics formulas',3800.00,18,'Educational Software'),(85,'Grammar Correction Tool','AI-based grammar checking software',3200.00,25,'Educational Software'),(86,'Exam Prep App','Digital app for exam preparation',2800.00,22,'Educational Software'),(87,'Science 3D Models Viewer','3D educational models for science learning',5000.00,10,'Educational Software'),(88,'Geography Mapping Tool','Digital mapping and cartography software',4200.00,12,'Educational Software'),(89,'English O/L Revision Papers','Collection of revision papers',700.00,55,'Assessment Materials'),(90,'Grade 7 Mid-Year Papers','Practice papers for mid-year exams',600.00,65,'Assessment Materials'),(91,'Science MCQ Practice Pack','Multiple choice questions for science',550.00,75,'Assessment Materials'),(92,'Math Speed Test Papers','Timed math practice papers',500.00,80,'Assessment Materials'),(93,'ICT Practical Test Papers','ICT practical test paper set',850.00,60,'Assessment Materials'),(94,'File Folder Set','Set of 5 A4 file folders',400.00,100,'Other'),(95,'Calculator Scientific','Scientific calculator for school use',2500.00,45,'Other'),(96,'Book Cover Roll','Transparent book covering roll',300.00,90,'Other'),(97,'School ID Card Holder','Plastic ID card holder with lanyard',150.00,120,'Other'),(98,'Desk Organizer','Multi-compartment desk organizer',1200.00,25,'Other'),(99,'To Kill a Mockingbird','Novel by Harper Lee',1500.00,28,'Novels'),(100,'1984','Dystopian novel by George Orwell',1400.00,26,'Novels'),(101,'The Catcher in the Rye','Classic novel by J.D. Salinger',1350.00,24,'Novels'),(102,'The Alchemist','Inspirational novel by Paulo Coelho',1600.00,30,'Novels'),(103,'Little Women','Classic novel by Louisa May Alcott',1450.00,22,'Novels');
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `order_item_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `item_id` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `discount` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  PRIMARY KEY (`order_item_id`),
  KEY `order_id` (`order_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `items` (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (21,26,54,1,8,1656),(22,26,58,1,5,1615),(23,27,18,1,5,1567.5),(24,27,14,1,7,883.5),(25,28,1,1,6,1128),(26,28,29,1,3,921.5),(27,29,20,2,15,935),(28,29,46,2,12,1672),(29,29,60,2,20,2800),(30,30,17,1,10,945),(31,30,27,1,5,3610),(32,31,21,1,2,490),(33,31,48,1,3,824.5);
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `order_date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (26,1,3271.00,'2025-08-07 09:20:08'),(27,2,2451.00,'2025-08-07 09:20:56'),(28,4,2049.50,'2025-08-07 09:56:09'),(29,3,5407.00,'2025-08-07 09:58:00'),(30,5,4555.00,'2025-08-07 10:00:19'),(31,13,1314.50,'2025-08-07 10:03:04');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `staff_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `birth_date` date DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`staff_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `staff_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (1,2,'Sudheera Theekshana','2001-07-12','Ipologama, Anuradhapura','sudeeratheek@gmail.com','014256851'),(2,3,'Vihanga Wimalaweera','2003-10-09','Ganthiriyagama, Anuradhapura','vihangawimalaweera@gmail.com','0720707267');
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','staff') NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin1','admin123','admin'),(2,'cashier1','staff123','staff'),(3,'sysdev','pass123','admin');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-08-07 10:05:27
