-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Sep 30, 2020 at 01:54 PM
-- Server version: 5.7.26
-- PHP Version: 7.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `healthcare_api`
--

-- --------------------------------------------------------

--
-- Table structure for table `abcstats`
--

DROP TABLE IF EXISTS `abcstats`;
CREATE TABLE IF NOT EXISTS `abcstats` (
  `statid` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(100) DEFAULT NULL,
  `value` int(11) DEFAULT NULL,
  `stdid` bigint(11) NOT NULL,
  PRIMARY KEY (`statid`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `abcstats`
--

INSERT INTO `abcstats` (`statid`, `code`, `value`, `stdid`) VALUES
(1, 'A', 20, 0);

-- --------------------------------------------------------

--
-- Table structure for table `agent_locations`
--

DROP TABLE IF EXISTS `agent_locations`;
CREATE TABLE IF NOT EXISTS `agent_locations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(100) NOT NULL,
  `lat` float(10,6) NOT NULL,
  `long` float(10,6) NOT NULL,
  `created_time` timestamp NOT NULL,
  `updated_time` timestamp NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `area`
--

DROP TABLE IF EXISTS `area`;
CREATE TABLE IF NOT EXISTS `area` (
  `aid` int(11) NOT NULL AUTO_INCREMENT,
  `areaname` varchar(200) DEFAULT NULL,
  `hid` int(11) DEFAULT NULL,
  `is_delete` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`aid`),
  KEY `hid` (`hid`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `area`
--

INSERT INTO `area` (`aid`, `areaname`, `hid`, `is_delete`) VALUES
(2, 'Karve Road', 1, 0),
(5, 'Aundh', 1, 0),
(6, 'Ganpati Matha', 5, 1),
(7, 'Khadakwasla', 6, 0),
(13, 'Chandan Nagar', 5, 1),
(14, 'Sangamner', 7, 0),
(15, 'Katraj', 6, 0),
(16, 'Chinchwad', 8, 0),
(17, 'Navi Mumbai', 9, 0),
(18, 'Jalgaon', 10, 0),
(19, 'Jalgaon 1', 11, 1),
(20, 'Aurangabad', 12, 0),
(21, 'Pachora', 13, 0),
(22, 'Parner', 14, 0),
(23, 'Shirpur', 15, 0),
(24, 'Bhadgaon', 13, 0),
(25, 'Bhusawal', 13, 0),
(26, 'Karad', 16, 0),
(27, 'Chandgad', 18, 0),
(28, 'Karmala', 19, 0),
(29, 'West Nagpur', 20, 0),
(30, 'Rajpath', 22, 0),
(31, 'Nagar Road', 23, 0),
(32, 'Dapoli', 24, 0),
(33, 'Kokan', 24, 0);

-- --------------------------------------------------------

--
-- Table structure for table `asigneddoctor`
--

DROP TABLE IF EXISTS `asigneddoctor`;
CREATE TABLE IF NOT EXISTS `asigneddoctor` (
  `adid` int(11) NOT NULL AUTO_INCREMENT,
  `dsid` int(11) DEFAULT NULL,
  `doctor` varchar(100) DEFAULT NULL,
  `adate` date DEFAULT NULL,
  `atime` time DEFAULT NULL,
  `doctorid` bigint(20) NOT NULL,
  `eid` bigint(20) NOT NULL,
  `cerated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`adid`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `asigneddoctor`
--

INSERT INTO `asigneddoctor` (`adid`, `dsid`, `doctor`, `adate`, `atime`, `doctorid`, `eid`, `cerated_at`, `updated_at`) VALUES
(1, NULL, NULL, NULL, NULL, 2, 56, '2020-09-22 05:10:17', '2020-09-22 05:10:17'),
(2, NULL, NULL, NULL, NULL, 26, 56, '2020-09-22 05:10:17', '2020-09-22 05:10:17'),
(3, NULL, NULL, NULL, NULL, 46, 56, '2020-09-22 05:10:17', '2020-09-22 05:10:17'),
(4, NULL, NULL, NULL, NULL, 28, 64, '2020-09-26 04:57:49', '2020-09-26 04:57:49'),
(5, NULL, NULL, NULL, NULL, 44, 68, '2020-09-26 04:58:29', '2020-09-26 04:58:29');

-- --------------------------------------------------------

--
-- Table structure for table `campaign`
--

DROP TABLE IF EXISTS `campaign`;
CREATE TABLE IF NOT EXISTS `campaign` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `cname` varchar(200) DEFAULT NULL,
  `startdate` date DEFAULT NULL,
  `enddate` date DEFAULT NULL,
  `campaignvalue` varchar(200) DEFAULT NULL,
  `gift` varchar(255) NOT NULL,
  `status` varchar(200) DEFAULT NULL,
  `color` varchar(200) DEFAULT NULL,
  `is_delete` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `campaign`
--

INSERT INTO `campaign` (`cid`, `cname`, `startdate`, `enddate`, `campaignvalue`, `gift`, `status`, `color`, `is_delete`) VALUES
(28, 'New camp 1', '2020-03-01', '2020-03-31', '34625', '', 'Pending', '#ad003e', 0),
(29, 'ASDFnew', '2018-06-12', '2018-06-30', '2134', 'XYZabc', 'freeze', '#b05858', 0),
(30, 'ASDF', '2018-06-12', '2018-06-30', '213', 'XYZ', 'null', '#b05858', 0),
(31, 'New Camp', '2020-03-01', '2020-03-31', '245', 'XYZ', 'Pending', '#6b2b2b', 0),
(32, 'March fest', '2020-03-02', '2020-03-28', '200000', 'No gifts', 'Pending', '#b00027', 0),
(36, 'New Camp', '2020-03-09', '2020-03-24', '2343546', 'XYZabc', 'active', '#a87676', 0),
(37, 'New Year Camp 2020', '2020-03-01', '2020-03-31', '79875', 'XYZabcasd', 'active', '#691c1c', 0),
(38, 'March Camp', '2020-03-01', '2020-03-15', '500000', 'No gifts', 'Pending', '#d91e1e', 0),
(39, 'August Camp', '2020-08-01', '2020-08-03', '10000', 'Honda Shine', 'Rejected', '#8f6d84', 0),
(40, 'Septeber camp', '2020-09-01', '2020-09-09', '100000', 'Honda Unicorn', 'freeze', '#b05858', 0),
(41, 'October camp', '2020-10-01', '2020-10-09', '20', 'Bajaj Discover', 'active', '#b05858', 0),
(42, 'November camp', '2020-11-01', '2020-11-09', '52', 'Bajaj Discover', 'active', '#b05856', 0);

-- --------------------------------------------------------

--
-- Table structure for table `campmap`
--

DROP TABLE IF EXISTS `campmap`;
CREATE TABLE IF NOT EXISTS `campmap` (
  `mapid` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) DEFAULT NULL,
  `doctorid` int(11) DEFAULT NULL,
  PRIMARY KEY (`mapid`),
  KEY `cid` (`cid`),
  KEY `doctorid` (`doctorid`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `campmap`
--

INSERT INTO `campmap` (`mapid`, `cid`, `doctorid`) VALUES
(2, 40, 3),
(9, 39, 5),
(6, 41, 64),
(8, 42, 3);

-- --------------------------------------------------------

--
-- Table structure for table `chemists`
--

DROP TABLE IF EXISTS `chemists`;
CREATE TABLE IF NOT EXISTS `chemists` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(255) DEFAULT NULL,
  `druglicense` varchar(255) DEFAULT NULL,
  `druglicensevalidity` date DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `firmconstitution` varchar(255) DEFAULT NULL,
  `foodlicense` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `gst` float NOT NULL,
  `headquarter` varchar(255) DEFAULT NULL,
  `is_delete` int(11) NOT NULL DEFAULT '0',
  `mobile` varchar(100) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `residentialadd` varchar(255) DEFAULT NULL,
  `residentialnum` varchar(100) DEFAULT NULL,
  `shopactlicense` varchar(255) DEFAULT NULL,
  `shoptelephone` varchar(100) NOT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `chemists`
--

INSERT INTO `chemists` (`cid`, `address`, `druglicense`, `druglicensevalidity`, `email`, `firmconstitution`, `foodlicense`, `gender`, `gst`, `headquarter`, `is_delete`, `mobile`, `name`, `residentialadd`, `residentialnum`, `shopactlicense`, `shoptelephone`) VALUES
(1, 'Kothrud', '420GFHG', '2020-10-01', 'hello458@gmail.com', 'Partnership', 'HHFYU5456', 'Male', 144634, 'Pune', 0, '9847236548', 'Bill Gates', 'Khadaki', '9784581236', 'HU565GH', '020-298475'),
(2, 'Pune', 'HJD54', '2022-09-15', 'sadgfh@gmail.com', 'Medical', 'DGHS454', 'Male', 54422, 'Kothrud', 0, '7894563698', 'Ravindra', 'Jalgaon', '1564466466', 'JASBJG54542', '0257-25981235'),
(3, 'Pune', '9789', '2020-12-18', 'ravi@gmail.com', 'Proprietor', '5675', NULL, 4522, '6', 0, '9625647895', 'Ravindra Patil', NULL, NULL, '1235', '989898989'),
(4, 'ZCBVCZ', '9796664', '2020-12-12', 'ravi@gmail.com', '	\r\nPartnership', '56724', NULL, 4522, '4', 0, '9632145875', 'Ravindra nbmb', NULL, NULL, '123', '7456981235'),
(5, 'Red Fort', '9796664', '2030-12-18', 'mark@zuke420gmail.com', 'Proprietor', '567', NULL, 452, '22', 0, '7777888855', 'Mark Zukerburg', NULL, NULL, '12324', '7456981235');

-- --------------------------------------------------------

--
-- Table structure for table `chemistscontact`
--

DROP TABLE IF EXISTS `chemistscontact`;
CREATE TABLE IF NOT EXISTS `chemistscontact` (
  `cpid` int(11) NOT NULL AUTO_INCREMENT,
  `cpname1` varchar(200) DEFAULT NULL,
  `cpphone1` double DEFAULT NULL,
  `cpname2` varchar(200) DEFAULT NULL,
  `cpphone2` double DEFAULT NULL,
  `cid` int(11) DEFAULT NULL,
  `is_delete` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`cpid`),
  KEY `cid` (`cid`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `chemistscontact`
--

INSERT INTO `chemistscontact` (`cpid`, `cpname1`, `cpphone1`, `cpname2`, `cpphone2`, `cid`, `is_delete`) VALUES
(1, 'ABCSO', 8794563215, 'XYZSKO', 8596321478, 3, 0),
(2, 'ABCS', 9898985252, 'XYZSKO', 2074859632, 4, 0),
(3, 'ABCS', 9898985252, 'XYZSKOE', 989899898, 5, 0);

-- --------------------------------------------------------

--
-- Table structure for table `dailyreport`
--

DROP TABLE IF EXISTS `dailyreport`;
CREATE TABLE IF NOT EXISTS `dailyreport` (
  `dailyid` int(100) NOT NULL AUTO_INCREMENT,
  `eid` int(11) DEFAULT NULL,
  `chemistvisited` int(11) DEFAULT NULL,
  `empid` int(11) DEFAULT NULL,
  `date` varchar(200) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`dailyid`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dailyreport`
--

INSERT INTO `dailyreport` (`dailyid`, `eid`, `chemistvisited`, `empid`, `date`, `created_at`) VALUES
(1, 16, 32, NULL, NULL, '2018-11-20 06:13:01'),
(2, 16, 32, NULL, NULL, '2018-11-20 06:16:49'),
(3, 16, 32, NULL, NULL, '2018-11-20 06:18:16'),
(4, 16, 23, NULL, NULL, '2018-11-20 06:18:54'),
(5, 16, 23, NULL, NULL, '2018-11-20 06:20:26'),
(6, 16, 23, NULL, NULL, '2018-11-20 06:23:54'),
(7, 19, 43, NULL, NULL, '2018-11-20 07:40:10'),
(8, 19, 54, NULL, NULL, '2018-11-20 09:00:13'),
(9, 19, 54, NULL, NULL, '2018-11-20 09:04:33'),
(10, 16, 770, NULL, NULL, '2018-11-20 09:05:47'),
(11, 16, 43, 14, NULL, '2018-11-20 11:00:19'),
(12, 16, 34, 14, NULL, '2018-11-20 12:47:57'),
(13, 16, 34, 14, NULL, '2018-11-20 12:49:02'),
(14, 19, 343, 14, '2018-11-21', '2018-11-22 11:43:45'),
(15, 19, 343, 14, '2018-11-22', '2018-11-22 11:50:52'),
(16, 19, 97, 14, '2018-11-22', '2018-11-22 11:54:08'),
(17, 16, 23, 14, '01/03/2019', '2019-01-03 07:29:17'),
(18, 41, 343, 14, '01/03/2019', '2019-01-03 07:31:39'),
(19, NULL, 3, 63, '05/05/2020', '2020-05-07 03:45:33'),
(20, NULL, 3, 63, '05/05/2020', '2020-05-07 05:16:32'),
(21, 86, 98, 96, '06/05/2019', '2020-01-03 07:32:39'),
(22, 1, 12, 1111, '16/05/2020', '2020-04-09 07:32:39'),
(23, 96, 65, 91, '08/07/2020', '2020-07-10 07:32:39');

-- --------------------------------------------------------

--
-- Table structure for table `dailystockiestvisited`
--

DROP TABLE IF EXISTS `dailystockiestvisited`;
CREATE TABLE IF NOT EXISTS `dailystockiestvisited` (
  `id` int(100) NOT NULL AUTO_INCREMENT,
  `sid` int(11) DEFAULT NULL,
  `dailyid` int(100) DEFAULT NULL,
  `empid` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dailystockiestvisited`
--

INSERT INTO `dailystockiestvisited` (`id`, `sid`, `dailyid`, `empid`, `updated_at`) VALUES
(1, 2, 9, NULL, NULL),
(2, 8, 9, NULL, NULL),
(3, 5, 9, NULL, NULL),
(4, 2, 10, NULL, NULL),
(5, 1, 10, NULL, NULL),
(6, 4, 10, NULL, NULL),
(7, 9, 10, NULL, NULL),
(8, 1, 11, 14, '2018-11-20 11:00:19'),
(9, 4, 11, 14, '2018-11-20 11:00:19'),
(10, 1, 12, 14, '2018-11-20 12:47:57'),
(11, 3, 13, 14, '2018-11-20 12:49:02'),
(12, 5, 14, 14, '2018-11-22 11:43:45'),
(13, 1, 14, 14, '2018-11-22 11:43:45'),
(14, 5, 15, 14, '2018-11-22 11:50:52'),
(15, 8, 15, 14, '2018-11-22 11:50:52'),
(16, 5, 16, 14, '2018-11-22 11:54:08'),
(17, 9, 16, 14, '2018-11-22 11:54:08'),
(18, 1, 17, 14, '2019-01-03 07:29:17'),
(19, 2, 17, 14, '2019-01-03 07:29:17'),
(20, 3, 17, 14, '2019-01-03 07:29:17'),
(21, 4, 18, 14, '2019-01-03 07:31:39'),
(22, 5, 18, 14, '2019-01-03 07:31:39'),
(23, 8, 18, 14, '2019-01-03 07:31:39'),
(24, 1, 19, 63, '2020-05-07 03:45:33'),
(25, 2, 19, 63, '2020-05-07 03:45:33'),
(26, 4, 19, 63, '2020-05-07 03:45:33'),
(27, 5, 19, 63, '2020-05-07 03:45:33'),
(28, 1, 20, 63, '2020-05-07 05:16:32'),
(29, 2, 20, 63, '2020-05-07 05:16:32'),
(30, 4, 20, 63, '2020-05-07 05:16:32'),
(31, 5, 20, 63, '2020-05-07 05:16:32');

-- --------------------------------------------------------

--
-- Table structure for table `doctors`
--

DROP TABLE IF EXISTS `doctors`;
CREATE TABLE IF NOT EXISTS `doctors` (
  `doctorid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  `gender` varchar(20) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `doa` date DEFAULT NULL,
  `aid` int(11) DEFAULT NULL,
  `hid` int(11) DEFAULT NULL,
  `address` varchar(2000) DEFAULT NULL,
  `clinicphone` varchar(40) DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `degree` varchar(20) DEFAULT NULL,
  `speciality` varchar(200) DEFAULT NULL,
  `mortimefrom` varchar(100) DEFAULT NULL,
  `mortimeto` varchar(100) DEFAULT NULL,
  `evetimefrom` varchar(100) DEFAULT NULL,
  `evetimeto` varchar(100) DEFAULT NULL,
  `grade` varchar(20) DEFAULT NULL,
  `attendingperson` varchar(200) DEFAULT NULL,
  `campaign` varchar(200) DEFAULT NULL,
  `activepassive` varchar(200) DEFAULT NULL,
  `statid` int(11) DEFAULT NULL,
  `is_delete` int(11) NOT NULL DEFAULT '0',
  `clinic_lat` float(10,6) DEFAULT NULL,
  `clinic_long` float(10,6) DEFAULT NULL,
  PRIMARY KEY (`doctorid`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `doctors`
--

INSERT INTO `doctors` (`doctorid`, `name`, `gender`, `dob`, `doa`, `aid`, `hid`, `address`, `clinicphone`, `mobile`, `degree`, `speciality`, `mortimefrom`, `mortimeto`, `evetimefrom`, `evetimeto`, `grade`, `attendingperson`, `campaign`, `activepassive`, `statid`, `is_delete`, `clinic_lat`, `clinic_long`) VALUES
(1, 'Ravindra', 'male', '1293-04-23', '7664-04-03', 0, 0, 'Shivajinagar', '2209723', '8985236547', 'MBBS', 'MD', '00:09:02.000000', '01:30:23.000000', '22:22:00.000000', '22:22:00.000000', 'A', 'me', 'xyz', 'Active', 0, 0, 18.531401, 73.844597),
(2, 'Damini', 'female', '1293-04-23', '7664-04-03', 2, 0, 'old sangvi', '2209723', '8390770941', 'mbbs', 'MD', '00:09:02.000000', '01:30:23.000000', '22:22:00.000000', '22:22:00.000000', 'A', 'me', 'xyz', 'Active', 0, 0, 18.572901, 73.818398),
(3, 'Manoj Matlane', 'male', '1992-02-14', '2018-05-05', 5, 0, 'karve  nagar', '874372', '143432', 'DHMS', 'Animal', '00:09:02.000000', '08:30:23.000000', '00:00:00.000000', '00:00:00.000000', 'E', 'annirudha ', 'Null', 'Active', 0, 0, 18.491501, 73.821701),
(4, 'ABC', 'male', '1293-04-23', '7664-04-03', 0, 0, 'Pune', '2209723', '8985236547', 'MBA', 'MD', '00:09:02.000000', '01:30:23.000000', '22:22:00.000000', '22:22:00.000000', 'A', 'me', 'xyz', 'Active', 0, 0, 18.520399, 73.856697),
(5, 'XYZ', 'male', '1293-04-23', '7664-04-03', 0, 0, 'Pune', '2209723', '8985236547', 'MBA', 'MD', '00:09:02.000000', '01:30:23.000000', '22:22:00.000000', '22:22:00.000000', 'A', 'me', 'xyz', 'Active', 0, 0, 18.520399, 73.856697),
(8, 'Ravi S Patil', 'male', '1293-04-23', '7664-04-03', 1, 2, 'Shivajinagar', '2209723', '8985236547', 'MBBS', 'MD', '00:09:02.000000', '01:30:23.000000', '22:22:00.000000', '22:22:00.000000', 'A+', 'me', 'RSP', 'Active', 8, 2, 18.531401, 73.844597),
(22, 'Manoj', 'male', '1998-01-02', '2017-01-30', 16, 0, 'jhkjkl', '9876543212', '9689968868', 'MBBS', 'Ear', '08:07:00.000000', '01:02:00.000000', '07:20:00.000000', '07:20:00.000000', 'null', 'null', 'null', 'Active', 8, 0, 18.520399, 73.856697),
(24, 'Steve Jobs', 'male', '1986-05-06', '2019-01-31', 2, 0, 'Nashik Road, Pune', '1020304050', '9876546783', 'mbbs', 'MD', '09:30:00.000000', '14:00:00.000000', '00:00:00.000000', '00:00:00.000000', 'A', 'null', 'null', 'Active', 0, 0, 19.972900, 73.822998),
(25, 'Tim Lee', 'male', '2002-01-28', '2010-01-24', 13, 0, 'hhxh, pune', '9876543206', '8798748569', 'MBBS', 'MD', '08:01:00', '07:12:00', '00:00:00', '00:00:00', 'null', 'null', 'null', 'Active', 2, 0, 18.520399, 73.856697),
(26, 'Shirlee Eldridge', 'female', '0007-11-09', '0007-02-09', 2, 0, 'fhsod', '52313847', '2437126', 'MD', 'California', '07:45:00.000000', '07:45:00.000000', '07:45:00.000000', '07:45:00.000000', '2', 'null', 'null', 'Active', 3, 0, 18.520399, 73.856697),
(28, 'Alycia Schiff', 'female', '2019-01-09', '2019-01-09', 5, 6, 'efafgg', '132343', '12234', 'MD', 'California', '10:45:00.000000', '10:45:00.000000', '10:45:00.000000', '10:45:00.000000', '2', 'null', 'null', 'Active', 2, 0, 18.520399, 73.856697),
(44, 'Robby Shontz', 'male', '2014-01-24', '2020-01-02', 6, 1, 'anywhere', '9911223344', '9911223344', 'MS', 'Consultant', '00:30:00.000000', '00:30:00.000000', '00:30:00.000000', '00:30:00.000000', '4', 'null', 'null', 'Active', 3, 0, 18.520399, 73.856697),
(45, 'Venita Chavarin', 'female', '1988-12-26', '2020-03-31', 2, 0, 'Pune', '1020304050', '09911223344', 'MS', 'MBBS', '08:00:00.000000', '10:00:00.000000', '16:00:00.000000', '18:00:00.000000', '4', 'null', 'null', 'Active', 2, 0, 18.520399, 73.856697),
(46, 'Ravindra P', 'male', '1996-01-06', '2010-01-26', 2, 1, 'Shivajinagar', '8574857479', '7896541235', 'MS', 'Surgon', '00:09:00', '00:01:00', '00:09:00', '00:09:00', '2', 'null', 'null', 'Active', 0, 0, NULL, NULL),
(47, 'Ravindra PA', 'male', '1954-01-09', '2020-01-15', 6, 6, '', '9856478598', '7485963214', 'MS', 'Surgon', '00:09:00', '00:01:00', '00:04:00', '00:09:00', '3', 'null', 'null', 'Active', 0, 0, NULL, NULL),
(48, 'Donald Trump', 'male', '1951-01-15', '2009-01-20', 22, 12, 'Parner', '202255887', '7458547896', 'MS', 'Ortho', '00:09:00', '00:01:00', '00:04:00', '00:09:00', '3', 'null', 'null', 'Active', 0, 0, NULL, NULL),
(49, 'Jyoti Gajare', 'female', '1966-01-19', '2020-01-09', 18, 13, 'Sadium Complex', '257420512', '9856478596', 'MD', 'Gunacologist', '00:08:00', '00:12:00', '00:06:00', '00:10:00', '1', 'null', 'null', 'Inactive', 0, 0, NULL, NULL),
(50, 'Shital Oswal', 'female', '1986-01-19', '2020-01-09', 18, 13, 'Sadium Complex', '257420512', '9856478596', 'MD', 'Gynacologist', '00:08:00', '00:12:00', '00:06:00', '00:10:00', '1', 'null', 'null', 'Inactive', 0, 0, NULL, NULL),
(57, 'AMAN', 'female', '1980-01-12', '2015-01-23', 7, 1, 'LOK', '9988774455', '7777888899', 'MS', 'Gynacologist', '00:09:00', '00:01:00', '00:09:00', '00:10:00', '3', 'null', 'null', 'Inactive', 0, 0, NULL, NULL),
(64, 'Dr Donald Trump', 'male', '1918-01-06', '2020-01-15', 7, 6, 'USA', '9696965874', '98745632140', 'BHMS', '', '00:09:00', '00:01:00', '00:06:00', '00:09:00', '2', 'null', 'null', 'Active', 0, 0, NULL, NULL),
(65, 'Mark Zukerburg', 'male', '1975-01-09', '2020-01-09', 32, 24, 'Kokan', '7412589630', '7412589630', 'BDS', 'Gynacologist', '00:09:00', '00:01:00', '00:06:00', '00:09:00', '2', 'null', 'null', 'Active', 0, 0, NULL, NULL),
(66, 'Ravindra Pa420', 'male', '1996-01-23', '2010-01-26', 5, 6, 'Pune', '7412589620', '7412589632', 'MBBS', 'Surgon', '14:45:00', '14:45:00', '14:45:00', '14:45:00', '3', 'null', 'null', 'Active', 1, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
CREATE TABLE IF NOT EXISTS `employee` (
  `eid` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `assignedauth` int(11) DEFAULT NULL,
  `profile_photo` varchar(200) DEFAULT NULL,
  `usertype` varchar(200) DEFAULT NULL,
  `gender` varchar(20) DEFAULT NULL,
  `presentaddress` varchar(2000) DEFAULT NULL,
  `permanentaddress` varchar(2000) DEFAULT NULL,
  `mobile` bigint(20) DEFAULT NULL,
  `emergencycontact` bigint(20) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `bankdetails` varchar(2000) DEFAULT NULL,
  `pan` varchar(2000) DEFAULT NULL,
  `aadhar` varchar(20) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `doj` date DEFAULT NULL,
  `aid` int(11) DEFAULT NULL,
  `designation` varchar(200) DEFAULT NULL,
  `education` varchar(200) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `licenseno` varchar(20) DEFAULT NULL,
  `insurancecovered` varchar(200) DEFAULT NULL,
  `emptype` varchar(20) DEFAULT NULL,
  `isactive` varchar(20) DEFAULT NULL,
  `is_delete` tinyint(4) NOT NULL DEFAULT '0',
  `adhar` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`eid`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`eid`, `name`, `username`, `password`, `assignedauth`, `profile_photo`, `usertype`, `gender`, `presentaddress`, `permanentaddress`, `mobile`, `emergencycontact`, `email`, `bankdetails`, `pan`, `aadhar`, `dob`, `doj`, `aid`, `designation`, `education`, `age`, `licenseno`, `insurancecovered`, `emptype`, `isactive`, `is_delete`, `adhar`) VALUES
(13, 'Sushant', 'admin_sushant@123', 'TSRU9zH2+RA=c3VzaGFudDEyMw==', 1, NULL, 'admin', 'male', 'Karve Nagr, Pune', 'Karve Nagr, Pune', 9876543212, 7328787098, 'sushanttayade1234@gmail.com', 'kjsajkdsk123 s', 'as1234fgtaxin', '3873982', '2018-07-04', '2018-07-06', 2, 'manager', 'b.pharm', 25, 'huhius73629', '3WESFSFHDG', 'permanent', 'Active', 0, NULL),
(14, 'Paurnima', 'tm_rani@123', 'gxw3L6QHF3s=cGF1cm5pbWExMjM=', 16, NULL, 'TM', 'female', 'Warje, Pune', 'Warje, Pune', 9876546783, 332445754, 'paurnimasavkare@gmail.com', 'kjdalkjd', 'ASKLKJKJKJSDKJSDJ', '482331201102', '2018-07-13', '2018-07-11', 2, 'TM', 'm,pharm', 25, '398323', 'gf37982', 'Temporary', 'Inactive', 0, NULL),
(15, 'Hannah Baker', 'rbm_baker@123', '6e8fwtRUYEk=YmFrZXIxMjM=', 42, NULL, 'RBM', 'female', 'Karve Nagar, Pune', 'Karve Nagar, Pune', 9876543212, 7328787098, 'hannnah@mail.com', 'BOI, Pune', '1234567890-=', '987654321', '2018-07-19', '2018-07-21', 2, 'RBM', 'b.pharm', 25, '123456765432', '3WESFSFHDG', 'Temporary', 'Active', 0, NULL),
(16, 'Clay Jensen', 'abm_jensen@123', 'VSFJDjL5MRQ=amVuc2VuMTIz', 15, NULL, 'ABM', 'null', 'Kothrud depo, Pune', 'Kothrud depo, Pune', 8390770941, 332445754, 'clayjensen@mail.com', 'SBI, Pune', '88731898g1x89', '1.234234534563421e15', '2018-07-14', '2018-07-27', 13, 'ABM', 'm,pharm', 25, '123sdr456765', 'option1', 'Temporary', 'Active', 0, NULL),
(18, 'Jessica Davis', 'tm_jess@123', 'JhCtUQtStMY=', 41, NULL, 'TM', 'female', 'Kothrud, Pune', 'Kothrud, Pune', 9876546783, 2, 'jess@mail.com', 'asasdasck', NULL, NULL, '2018-07-20', '2018-07-15', 13, 'TM', 'eds', 25, '123456765', '9iiokdmw291e11', 'Temporary', 'Active', 0, NULL),
(25, 'Ravindra', 'ravindra@123', '$2a$10$0FecQXNFOLafJ/u6DzmL5e8.tjetNjUUb1m.fnhzFU2cUnh.DMZ9.', 2, NULL, 'admin', 'male', 'Shivaji Nagar, Pune', 'Shivaji Nagr, Pune', 8698947, 86989, 'ravipatil6596@gmail.com', 'asdf126564s', '9879asdasdwuHFHFH', NULL, '1996-06-05', '2018-07-06', 12, 'manager', 'MCA', 25, 'mca73629', '3WESFSFHDG', 'permanent', 'Active', 0, '420512'),
(52, 'Ravindra', 'tm_ravindra@456', 'TTU6J/a5wjs=cmF2aTEyMw==', 16, NULL, 'TM', 'male', 'pune', 'jalgaon', 34543454354, 45675367, 'fdghdfg@gmail.com', 'ewrrt', 'fhgyyhj45', '123456789123', '2018-06-01', '2020-03-04', 2, 'mca', 'MBBS', 45, 'dfjsi2', 'Yes', 'Permanent', 'Active', 0, NULL),
(53, 'Ravi', 'tm_ravi@123', '6jNPHxyvD9s=cmF2aTEyMw==', 16, NULL, 'TM', 'male', 'anywhere', '', 9911223344, 9911223344, '\r\nravindrapatil.alceatechnologies@gmail.com', 'ghdjg', 'werwer', '123456789123', '2019-02-06', '2020-03-17', 7, 'mca', 'ms', 32, 'sdf45463', 'Yes', 'Temporary', 'Inactive', 0, NULL),
(54, 'Dada Patil', 'abm_patil@123', 'RgJn73kf8YI=cGF0aWwxMjM=', 15, NULL, 'ABM', 'male', 'anywhere', 'dffgdsf', 9911223344, 9911223344, 'testing@teste2r.com', 'fgdhb', 'werwer', '123456789123', '2019-02-06', '2020-03-11', 13, 'MBa', 'MBBS', 45, 'sdf45463', 'No', 'Temporary', 'Active', 0, NULL),
(56, 'Smith Doe', 'bu_smith@123', 'magLew3luKg=c21pdGgxMjM=', 0, NULL, 'BU', 'null', '2, Amarnath Apartment, Lane number 2, Adarsh Nagar', '', 9665909190, 0, 'smith@gmail.com', 'Test bank details', '2346234', '12362345', '1992-01-11', '2009-01-27', 2, 'Business Head', 'BA', 28, '123975', 'option1', 'null', 'Inactive', 0, NULL),
(61, 'Blake', 'rbm_blake@123', 'EjEWCDLkZV0=Ymxha2UxMjM=', 0, NULL, 'RBM', 'male', 'Pune', 'Pune', 9911223344, 9911223344, 'sushanttayade12@gmail.com', 'Test Bank Details', '2346234', '12362345', '1998-12-28', '2019-11-20', 6, 'Regional Assistant Manager', 'BA', 21, '123975', 'Yes', 'Permanent', 'Active', 0, NULL),
(62, 'Aimee Ertl', 'abm_aimee@123', 'wBRUSjh212A=YWJtX2FpbWVl', 61, NULL, 'ABM', 'female', 'Pune', '', 9911223344, 9911223344, 'abm_aimee@gmail.com', '  ', '2346234', '12362345', '1989-01-13', '2019-01-17', 2, 'Assistant Business Manager - 1', 'BA', 30, '', 'Yes', 'Permanent', 'Active', 0, NULL),
(63, 'Jose Simmers', 'tm_jose@123', 'w38e+LCoqgs=am9zZTEyMw==', 62, NULL, 'TM', 'male', 'Pune', '', 9911223344, 9911223344, 'sushanttayade123@gmail.com', 'Testing Bank AC', '2346234', '12362345', '1989-01-01', '2020-06-02', 2, 'Territory Manager - 1', 'BA, B-com', 31, '123975', 'No', 'Temporary', 'Active', 0, NULL),
(64, 'Ravindra Suresh Patil', 'ravi@1231', '4jOEv2XAXYM=cmF2aTY3OA==', 0, NULL, 'ABM', 'null', 'Pune', 'Jalgaon', 7458961452, 9988774455, 'ram45@gmail.com', 'AFDG@123', 'SDDS352', '6598123654', '2020-01-15', '2009-01-17', 5, 'MS', 'Physician', 24, 'DDFF!@123', 'option1', 'Temporary', 'option1', 0, NULL),
(68, 'Mark Zukerburg', 'ravindra@12312', '/c781l1tcDw=cmF2aW5kcmFAMTIzMTI=', 15, NULL, 'ABM', 'male', 'USA', 'Newyork', 8741259652, 9632587410, 'mark@zuke420gmail.com', '65SHGASH4', 'SDDS352ASWE', '9632258741236', '1986-08-19', '2020-09-08', 6, 'MS', 'Physician', 34, 'DDFF!@123AAS', 'No', 'Temporary', 'Active', 0, NULL),
(70, 'Ronaldo', 'ravi@123', 'bJqQFNl0jOw=cmF2aTEyMw==', 64, NULL, 'TM', 'male', 'Brazil', 'London', 741258963, 1478523698, 'ronaldo7@gmail.com', 'SDDSA#', 'SDDS35', '6598123654', '1996-05-07', '2020-09-17', 13, 'MD', 'Physician', 24, '456', 'Yes', 'Temporary', 'Inactive', 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `emp_docs`
--

DROP TABLE IF EXISTS `emp_docs`;
CREATE TABLE IF NOT EXISTS `emp_docs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `profile_photo` blob NOT NULL,
  `pan` blob NOT NULL,
  `aadhar` blob NOT NULL,
  `eid` int(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `emp_docs`
--

INSERT INTO `emp_docs` (`id`, `profile_photo`, `pan`, `aadhar`, `eid`) VALUES
(1, '', '', '', 64),
(2, '', '', '', 65),
(3, '', '', '', 67),
(4, '', '', '', 68),
(5, '', '', '', 69),
(6, '', '', '', 70);

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

DROP TABLE IF EXISTS `expenses`;
CREATE TABLE IF NOT EXISTS `expenses` (
  `exid` int(11) NOT NULL AUTO_INCREMENT,
  `aid` int(11) NOT NULL,
  `hq` float NOT NULL,
  `exhq` float NOT NULL,
  `tour` float NOT NULL,
  `hid` int(20) DEFAULT NULL,
  `is_delete` int(11) NOT NULL DEFAULT '0',
  `name` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`exid`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `expenses`
--

INSERT INTO `expenses` (`exid`, `aid`, `hq`, `exhq`, `tour`, `hid`, `is_delete`, `name`) VALUES
(1, 28, 10, 0, 10, 0, 0, NULL),
(2, 30, 10, 0, 20, NULL, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `fixed_expenses`
--

DROP TABLE IF EXISTS `fixed_expenses`;
CREATE TABLE IF NOT EXISTS `fixed_expenses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fixed_category` varchar(200) DEFAULT NULL,
  `value` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `fixed_expenses`
--

INSERT INTO `fixed_expenses` (`id`, `fixed_category`, `value`) VALUES
(1, 'Telephone', 300),
(2, 'Travelling', 500);

-- --------------------------------------------------------

--
-- Table structure for table `focusedproduct1`
--

DROP TABLE IF EXISTS `focusedproduct1`;
CREATE TABLE IF NOT EXISTS `focusedproduct1` (
  `fpid` int(11) NOT NULL AUTO_INCREMENT,
  `doctorid` int(11) DEFAULT NULL,
  `pid` bigint(20) DEFAULT NULL,
  `fid` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`fpid`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `focusedproduct1`
--

INSERT INTO `focusedproduct1` (`fpid`, `doctorid`, `pid`, `fid`) VALUES
(9, 66, 3, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `headquarter`
--

DROP TABLE IF EXISTS `headquarter`;
CREATE TABLE IF NOT EXISTS `headquarter` (
  `hid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  `is_delete` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`hid`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `headquarter`
--

INSERT INTO `headquarter` (`hid`, `name`, `is_delete`) VALUES
(1, 'Pune', 0),
(4, 'Bhosari', 0),
(5, 'Warje', 1),
(6, 'Wagholi', 0),
(7, 'Nasik', 0),
(8, 'Pimpri', 0),
(9, 'Mumbai', 0),
(10, 'Khandesh', 0),
(11, 'Khandesh 1', 1),
(12, 'Marathwada', 0),
(13, 'Jalgaon', 0),
(14, 'Nagar', 0),
(15, 'Dhule', 0),
(16, 'Satara', 0),
(17, 'Sangali Road', 0),
(18, 'Kolhapur', 0),
(19, 'Solapur', 0),
(20, 'Nagpur', 0),
(21, 'Bhusawal', 0),
(22, 'Delhi', 0),
(23, 'Sangali', 0),
(24, 'Ratnagiri', 0);

-- --------------------------------------------------------

--
-- Table structure for table `hibernate_sequence`
--

DROP TABLE IF EXISTS `hibernate_sequence`;
CREATE TABLE IF NOT EXISTS `hibernate_sequence` (
  `next_val` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `hibernate_sequence`
--

INSERT INTO `hibernate_sequence` (`next_val`) VALUES
(49),
(49),
(49),
(49);

-- --------------------------------------------------------

--
-- Table structure for table `holidays`
--

DROP TABLE IF EXISTS `holidays`;
CREATE TABLE IF NOT EXISTS `holidays` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `title` varchar(100) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `holidays`
--

INSERT INTO `holidays` (`id`, `date`, `created_at`, `title`) VALUES
(1, '2020-08-15', '2020-09-02 09:29:18', 'Independence Day'),
(2, '2020-08-22', '2020-09-02 09:29:18', 'Ganesh Chaturthi'),
(3, '2020-09-01', '2020-09-02 09:30:39', 'Anant Chaturdashi'),
(4, '2020-09-23', '2020-09-07 12:08:21', 'TP');

-- --------------------------------------------------------

--
-- Table structure for table `individualtarget`
--

DROP TABLE IF EXISTS `individualtarget`;
CREATE TABLE IF NOT EXISTS `individualtarget` (
  `individualid` int(100) NOT NULL AUTO_INCREMENT,
  `eid` int(100) DEFAULT NULL,
  `datefrom` varchar(100) DEFAULT NULL,
  `dateto` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`individualid`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `individualtarget`
--

INSERT INTO `individualtarget` (`individualid`, `eid`, `datefrom`, `dateto`, `created_at`) VALUES
(1, 0, '2020-05', '2018-09-07', NULL),
(2, 0, '2020-05', '2018-08-23', NULL),
(3, 0, '2020-05', '2018-09-21', NULL),
(4, 14, '2020-01', '2018-12-29', NULL),
(5, 14, '2020-02', '2017-12-31', NULL),
(6, 17, '2020-05', '2018-11-29', '2018-12-01 10:40:32'),
(7, 18, '2020-05', '2018-12-02', '2018-11-23 10:42:14'),
(8, 14, '2020-03', NULL, '2020-03-14 14:59:41'),
(9, 18, '2020-05', NULL, '2020-03-14 15:01:19'),
(10, 48, '2020-05', NULL, '2020-03-14 16:24:40'),
(11, 48, '2020-05', NULL, '2020-03-14 16:45:43'),
(12, 51, '2020-05', NULL, '2020-03-25 04:10:10'),
(13, 14, '2020-04', NULL, '2020-04-08 12:20:35'),
(14, 14, '2020-05', NULL, '2020-04-08 12:27:06'),
(15, 63, '2020-05', NULL, '2020-05-03 11:39:51'),
(16, 52, '', NULL, '2020-09-19 08:22:58'),
(17, 53, '', NULL, '2020-09-19 08:28:32'),
(18, 18, '', NULL, '2020-09-22 11:12:25'),
(19, 63, '2020-11-10', NULL, '2020-09-24 05:19:45'),
(20, 53, '2020-11-10', NULL, '2020-09-24 12:11:14');

-- --------------------------------------------------------

--
-- Table structure for table `leavemgm`
--

DROP TABLE IF EXISTS `leavemgm`;
CREATE TABLE IF NOT EXISTS `leavemgm` (
  `leaveid` int(11) NOT NULL AUTO_INCREMENT,
  `eid` int(11) DEFAULT NULL,
  `leavetype` varchar(20) DEFAULT NULL,
  `fromdate` date DEFAULT NULL,
  `todate` date DEFAULT NULL,
  `comment` varchar(200) DEFAULT NULL,
  `status` varchar(200) DEFAULT 'Pending',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`leaveid`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `leavemgm`
--

INSERT INTO `leavemgm` (`leaveid`, `eid`, `leavetype`, `fromdate`, `todate`, `comment`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
(4, 14, 'PL', '2018-08-12', '2018-08-15', 'asach', 'Rejected', '2020-05-05 16:26:25', '2020-05-05 16:26:25', '0000-00-00 00:00:00'),
(5, 14, 'PL', '2018-07-26', '2018-07-31', 'asach', 'Rejected', '2020-05-05 16:26:25', '2020-05-05 16:26:25', '0000-00-00 00:00:00'),
(6, 16, 'SL', '2018-07-30', '2018-07-31', 'xyz reason', 'Rejected', '2020-05-05 16:26:25', '2020-09-22 05:42:39', '0000-00-00 00:00:00'),
(8, 14, 'PL', '2019-02-07', '2019-02-11', 'efrfer', 'Rejected', '2020-05-05 16:26:25', '2020-05-05 16:26:25', '0000-00-00 00:00:00'),
(10, 63, 'CL', '2020-05-11', '2020-05-13', 'Casually', 'Rejected', '2020-05-05 16:26:25', '2020-05-06 14:18:59', '0000-00-00 00:00:00'),
(11, 63, 'PL', '2020-06-10', '2020-06-15', 'Testing PL', 'Approved', '2020-05-05 16:26:25', '2020-09-30 13:22:18', '0000-00-00 00:00:00'),
(12, 63, 'SL', '2020-05-04', '2020-05-08', 'Sick Leave Testing', 'Rejected', '2020-05-05 16:30:17', '2020-09-30 13:30:02', '0000-00-00 00:00:00'),
(13, 63, 'SL', '2020-05-12', '2020-05-20', 'testing', 'Pending', '2020-05-06 03:01:13', '2020-09-14 10:41:31', '0000-00-00 00:00:00'),
(14, 63, 'SL', '2020-05-12', '2020-05-20', 'testing', 'Pending', '2020-05-06 03:04:00', '2020-05-06 03:04:00', '0000-00-00 00:00:00'),
(15, 63, 'SL', '2020-05-12', '2020-05-20', 'testing', 'Pending', '2020-05-06 03:05:59', '2020-05-06 03:05:59', '0000-00-00 00:00:00'),
(16, 63, 'SL', '2020-05-12', '2020-05-20', 'testing', 'Pending', '2020-05-06 03:06:25', '2020-05-06 03:06:25', '0000-00-00 00:00:00'),
(17, 63, 'SL', '2020-05-12', '2020-05-20', 'testing', 'Pending', '2020-05-06 03:06:38', '2020-05-06 03:06:38', '0000-00-00 00:00:00'),
(18, 63, 'SL', '2020-05-10', '2020-05-15', 'testing sl', 'Pending', '2020-05-06 09:59:58', '2020-05-06 09:59:58', '0000-00-00 00:00:00'),
(19, 63, 'SL', '2020-05-10', '2020-05-15', 'testing sl', 'Pending', '2020-05-06 10:17:47', '2020-05-06 10:17:47', '0000-00-00 00:00:00'),
(20, 63, 'SL', '2020-05-10', '2020-05-15', 'testing sl', 'Pending', '2020-05-06 10:18:38', '2020-05-06 10:18:38', '0000-00-00 00:00:00'),
(21, 63, 'SL', '2020-05-20', '2020-05-25', 'testing SLLL', 'Pending', '2020-05-06 10:19:50', '2020-05-06 10:19:50', '0000-00-00 00:00:00'),
(22, 63, 'SL', '2020-05-20', '2020-05-25', 'testing SLLL', 'Pending', '2020-05-06 10:31:41', '2020-05-06 10:31:41', '0000-00-00 00:00:00'),
(23, 63, 'SL', '2020-05-20', '2020-05-25', 'testing SLLL', 'Rejected', '2020-05-06 11:04:44', '2020-09-30 09:55:17', '0000-00-00 00:00:00'),
(24, 63, 'SL', '2020-05-10', '2020-05-14', 'testing SLL', 'Pending', '2020-05-06 11:18:58', '2020-05-06 11:18:58', '0000-00-00 00:00:00'),
(25, 63, 'SL', '2020-05-10', '2020-05-14', 'testing SLL', 'Pending', '2020-05-06 11:19:45', '2020-05-06 11:19:45', '0000-00-00 00:00:00'),
(26, 63, 'SL', '2020-05-10', '2020-05-14', 'testing SLL', 'Pending', '2020-05-06 11:36:25', '2020-05-06 11:36:25', '0000-00-00 00:00:00'),
(27, 63, 'SL', '2020-05-27', '2020-05-30', 'sl testing', 'Pending', '2020-05-06 11:38:23', '2020-05-06 11:38:23', '0000-00-00 00:00:00'),
(28, 63, 'SL', '2020-05-27', '2020-05-30', 'sl testing', 'Pending', '2020-05-06 11:39:09', '2020-05-06 11:39:09', '0000-00-00 00:00:00'),
(29, 63, 'SL', '2020-05-27', '2020-05-30', 'sl testing', 'Pending', '2020-05-06 11:54:29', '2020-05-06 11:54:29', '0000-00-00 00:00:00'),
(30, 63, 'SL', '2020-05-27', '2020-05-30', 'sl testing', 'Pending', '2020-05-06 11:55:08', '2020-05-06 11:55:08', '0000-00-00 00:00:00'),
(31, 63, 'SL', '2020-05-27', '2020-05-30', 'sl testing', 'Pending', '2020-05-06 12:03:32', '2020-05-06 12:03:32', '0000-00-00 00:00:00'),
(32, 63, 'SL', '2020-05-27', '2020-05-30', 'sl testing', 'Pending', '2020-05-06 12:05:12', '2020-05-06 12:05:12', '0000-00-00 00:00:00'),
(33, 63, 'SL', '2020-05-19', '2020-05-27', 'te', 'Pending', '2020-05-06 12:17:20', '2020-05-06 12:17:20', '0000-00-00 00:00:00'),
(34, 63, 'SL', '2020-05-01', '2020-05-04', 'slll', 'Rejected', '2020-05-06 12:20:18', '2020-09-30 13:31:34', '0000-00-00 00:00:00'),
(36, 23, 'PL', '2020-08-23', '2020-08-25', 'Picnic', 'Rejected', '2020-05-04 16:26:25', '2020-05-05 16:26:25', '0000-00-00 00:00:00'),
(37, 12, 'PL', '2020-08-12', '2020-08-16', 'Picnic', 'Rejected', '2020-05-04 16:26:25', '2020-05-05 16:26:25', '0000-00-00 00:00:00'),
(38, 38, 'PL', '2020-09-23', '2020-09-25', 'Timepass', 'Pending', '2020-05-04 16:26:25', '2020-05-05 16:26:25', '0000-00-00 00:00:00'),
(39, 12, 'PL', '2020-08-12', '2020-08-16', 'Picnic', 'Rejected', '2020-05-04 16:26:25', '2020-05-05 16:26:25', '0000-00-00 00:00:00'),
(44, 25, 'Urgent Work', '2020-09-08', '2020-09-16', 'Picnic', 'Approved', '2020-09-16 05:11:35', '2020-09-16 07:19:14', '2020-09-16 05:11:34'),
(45, 25, 'Personal', '2020-09-13', '2020-09-16', 'Picnic Leave', 'Approved', '2020-09-16 05:15:40', '2020-09-21 08:14:32', '2020-09-16 05:15:39'),
(47, 25, 'Personal', '2020-09-01', '2020-09-16', 'Time Pass', 'Approved', '2020-09-16 07:16:05', '2020-09-16 07:21:05', '2020-09-16 07:16:04'),
(48, 14, 'PL', '2020-10-22', '2020-10-27', 'Go to Home', 'Approved', '2020-09-22 04:37:51', '2020-09-30 09:56:48', '2020-09-22 04:37:51'),
(49, 64, 'CL', '2020-09-24', '2020-09-30', 'XYZ\r\n', 'Rejected', '2020-09-24 10:16:49', '2020-09-30 13:32:13', '2020-09-24 10:16:49');

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

DROP TABLE IF EXISTS `login`;
CREATE TABLE IF NOT EXISTS `login` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `password` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`id`, `password`, `username`) VALUES
(1, '$2a$10$Rd/yxgqXlbx7xf2ttLH7COYtW4r9kGbNuu98rnHQw0aRejYDy4.9q', 'ravindra');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
CREATE TABLE IF NOT EXISTS `notifications` (
  `nid` int(100) NOT NULL AUTO_INCREMENT,
  `eid` int(11) DEFAULT NULL,
  `message` varchar(2000) DEFAULT NULL,
  `status` tinytext,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`nid`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`nid`, `eid`, `message`, `status`, `created_at`, `updated_at`) VALUES
(1, 14, 'New report has been updated by Paurnima', 'read', '2018-11-21 09:57:11', '2018-11-21 09:57:11'),
(2, 14, 'New report has been updated by Paurnima', 'read', '2018-11-21 07:26:11', '2018-11-21 07:26:11'),
(3, 14, 'New report has been updated by Paurnima', 'read', '2018-11-22 11:55:21', '2018-11-22 11:55:21'),
(4, 14, 'New report has been updated by Paurnima', 'read', '2018-11-22 11:55:35', '2018-11-22 11:55:35'),
(5, 14, 'New report has been updated by Paurnima', 'read', '2018-11-22 11:55:41', '2018-11-22 11:55:41'),
(6, 14, 'New report has been updated by Paurnima', 'unread', '2018-11-22 11:50:52', '0000-00-00 00:00:00'),
(7, 14, 'New report has been updated by Paurnima', 'unread', '2018-11-22 11:54:08', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
CREATE TABLE IF NOT EXISTS `orders` (
  `orderid` bigint(11) NOT NULL AUTO_INCREMENT,
  `cid` bigint(20) NOT NULL,
  `campaign` varchar(200) DEFAULT NULL,
  `eid` int(11) NOT NULL,
  `orderdate` date NOT NULL,
  `totalAmt` float NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `total_amt` float NOT NULL,
  `id` bigint(20) NOT NULL,
  `amount` float NOT NULL,
  `details` varchar(255) DEFAULT NULL,
  `mail_status` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`orderid`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`orderid`, `cid`, `campaign`, `eid`, `orderdate`, `totalAmt`, `created_at`, `total_amt`, `id`, `amount`, `details`, `mail_status`, `updated_at`) VALUES
(10, 2, 'March camp', 63, '2020-03-01', 4370, '2020-05-03 12:58:30', 0, 0, 0, NULL, NULL, NULL),
(11, 2, NULL, 63, '2020-05-01', 0, '2020-05-03 12:59:14', 0, 0, 0, NULL, NULL, NULL),
(12, 2, NULL, 63, '2020-04-01', 1000, '2020-05-03 12:59:28', 0, 0, 0, NULL, NULL, NULL),
(13, 2, NULL, 63, '2020-05-01', 0, '2020-05-03 12:59:31', 0, 0, 0, NULL, NULL, NULL),
(14, 2, NULL, 63, '2020-05-01', 2000, '2020-05-03 12:59:40', 0, 0, 0, NULL, NULL, NULL),
(15, 2, NULL, 63, '2020-05-02', 286, '2020-05-04 06:02:57', 0, 0, 0, NULL, NULL, NULL),
(16, 24, NULL, 63, '2020-05-03', 350, '2020-05-04 06:02:59', 0, 0, 0, NULL, NULL, NULL),
(17, 2, NULL, 63, '2020-05-02', 286, '2020-05-04 06:04:25', 0, 0, 0, NULL, NULL, NULL),
(18, 24, NULL, 63, '2020-05-03', 880, '2020-05-04 06:04:25', 0, 0, 0, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `other_expenses`
--

DROP TABLE IF EXISTS `other_expenses`;
CREATE TABLE IF NOT EXISTS `other_expenses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `amount` float NOT NULL,
  `details` varchar(2000) NOT NULL,
  `mail_status` varchar(200) NOT NULL,
  `eid` int(11) NOT NULL,
  `approval` varchar(100) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `other_expenses`
--

INSERT INTO `other_expenses` (`id`, `amount`, `details`, `mail_status`, `eid`, `approval`, `updated_at`) VALUES
(1, 50000, 'Check It', 'yes', 13, 'APPROVED', '2020-09-22 04:29:46'),
(2, 65000, 'Send It ', 'no', 25, 'APPROVED', '2020-09-22 04:29:46'),
(3, 235640, 'Amount Sent tonight', 'Sent', 14, 'REJECTED', '2020-09-22 04:38:50'),
(4, 43000, 'Amount', 'No', 52, 'pending', '2020-09-30 12:10:05');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE IF NOT EXISTS `password_resets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `token` varchar(25) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `orid` bigint(20) NOT NULL,
  `orderid` bigint(20) NOT NULL,
  `pid` bigint(20) NOT NULL,
  `quantity` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `password_resets`
--

INSERT INTO `password_resets` (`id`, `email`, `token`, `created_at`, `orid`, `orderid`, `pid`, `quantity`) VALUES
(1, 'maharjanbimal@hotmail.com', '62F7SXP9B00BCKU2FPO0', '2020-03-18 19:17:59', 0, 0, 0, 0),
(2, 'testing@tester.com', 'GLQ1UX8NDVIYMAZ14VPR', '2020-03-18 19:14:46', 0, 0, 0, 0),
(3, 'nikhil.nehete5101@gmail.com', 'YFO5IDU5OA4PYUYE1KN2', '2020-03-18 19:11:15', 0, 0, 0, 0),
(4, 'ravindrapatil.alceatechnologies@gmail.com', 'ULE74YPKONR1WC6EC7WF', '2020-03-20 04:48:13', 0, 0, 0, 0),
(5, 'null', '2JEOFCR0DSCXZ8SQFB3X', '2020-04-04 07:08:42', 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `placeorder`
--

DROP TABLE IF EXISTS `placeorder`;
CREATE TABLE IF NOT EXISTS `placeorder` (
  `orid` bigint(20) NOT NULL AUTO_INCREMENT,
  `orderid` bigint(11) NOT NULL,
  `pid` bigint(20) NOT NULL,
  `quantity` int(11) NOT NULL,
  PRIMARY KEY (`orid`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `placeorder`
--

INSERT INTO `placeorder` (`orid`, `orderid`, `pid`, `quantity`) VALUES
(12, 10, 1, 5),
(13, 11, 5, 5),
(14, 12, 5, 5),
(15, 13, 5, 5),
(16, 14, 5, 5),
(17, 15, 5, 5),
(18, 15, 8, 2),
(19, 15, 3, 10),
(20, 15, 7, 3),
(21, 16, 5, 2),
(22, 16, 8, 5),
(23, 16, 9, 2),
(24, 16, 7, 5),
(25, 17, 5, 10),
(26, 17, 8, 2),
(27, 17, 9, 5),
(28, 17, 7, 3),
(29, 18, 5, 5),
(30, 18, 8, 5),
(31, 18, 9, 2),
(32, 18, 7, 5),
(33, 18, 10, 10);

-- --------------------------------------------------------

--
-- Table structure for table `primary_sale`
--

DROP TABLE IF EXISTS `primary_sale`;
CREATE TABLE IF NOT EXISTS `primary_sale` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eid` bigint(11) NOT NULL,
  `amount` double(10,2) NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `primary_sale`
--

INSERT INTO `primary_sale` (`id`, `eid`, `amount`, `date`) VALUES
(1, 53, 50000.00, '2020-09-24'),
(2, 52, 65000.00, '2020-09-23'),
(4, 18, 70000.00, '2020-10-14');

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
CREATE TABLE IF NOT EXISTS `product` (
  `pid` int(11) NOT NULL AUTO_INCREMENT,
  `composition` varchar(255) DEFAULT NULL,
  `detailingstory` varchar(255) DEFAULT NULL,
  `gst` float NOT NULL,
  `is_delete` int(11) NOT NULL DEFAULT '0',
  `mrp` float NOT NULL,
  `packaging` varchar(255) DEFAULT NULL,
  `pgroup` varchar(255) DEFAULT NULL,
  `pname` varchar(255) DEFAULT NULL,
  `ptr` float NOT NULL,
  `pts` float NOT NULL,
  `ptype` varchar(255) DEFAULT NULL,
  `scheme` varchar(255) DEFAULT NULL,
  `specification` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`pid`, `composition`, `detailingstory`, `gst`, `is_delete`, `mrp`, `packaging`, `pgroup`, `pname`, `ptr`, `pts`, `ptype`, `scheme`, `specification`) VALUES
(1, 'Pain', 'Dual Combination', 107854, 0, 54, 'ML', 'Multiple', 'Karace', 2, 5, 'Pain Killer', 'Any', 'Osteoarthritis, Rheumatoid Arthritis, Ankylosing Spondylitis'),
(3, 'Cold', 'Single', 8745, 0, 65, '10', 'Single', 'Kaltcure Plus', 48, 89, 'Cold & Fever', 'Double', 'Nasal and synus congestion, Allergic symptoms of the nose or throat, upper respiratory tract allergies, Sinusitis, Tonsillitis, Otitis Media'),
(4, 'Shivajinagar', 'Shivajinagar', 4520, 0, 63, 'Good', 'Calcium', 'Kaltcure DS', 20, 50, 'Platinum', NULL, 'Nasal & sinus congestion, sinus pain and headache, upper respiratory tract allergies, adjunct with antibacterial s in sinusitis, tonsillitis and otitis media.'),
(5, 'Shiv Colony', 'Jalgaon', 32464600, 0, 128, 'Strip', 'Calcium', 'Karminta Syrup', 65, 29, 'Platinum', NULL, 'Vitamin & miniral deficiency, Zinc deficiency, immune booster, loss of appetite, aiding growth in children, fatigue and general debility, anemia');

-- --------------------------------------------------------

--
-- Table structure for table `samples`
--

DROP TABLE IF EXISTS `samples`;
CREATE TABLE IF NOT EXISTS `samples` (
  `sampleid` bigint(11) NOT NULL AUTO_INCREMENT,
  `eid` bigint(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`sampleid`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `samples`
--

INSERT INTO `samples` (`sampleid`, `eid`, `created_at`, `updated_at`) VALUES
(1, 52, '2020-09-19 08:34:46', '2020-09-19 08:34:46'),
(2, 52, '2020-09-19 08:44:12', '2020-09-19 08:44:12'),
(3, 52, '2020-09-19 09:02:58', '2020-09-19 09:02:58'),
(4, 52, '2020-09-21 09:44:45', '2020-09-21 09:44:45'),
(5, 53, '2020-09-24 05:50:49', '2020-09-24 05:50:49'),
(6, 18, '2020-09-24 09:24:56', '2020-09-24 09:24:56'),
(7, 70, '2020-09-30 08:07:02', '2020-09-30 08:07:02');

-- --------------------------------------------------------

--
-- Table structure for table `sample_given`
--

DROP TABLE IF EXISTS `sample_given`;
CREATE TABLE IF NOT EXISTS `sample_given` (
  `sgid` bigint(11) NOT NULL AUTO_INCREMENT,
  `sample_proid` bigint(11) NOT NULL,
  `quantity_given` bigint(11) NOT NULL,
  `tourid` bigint(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`sgid`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sample_given`
--

INSERT INTO `sample_given` (`sgid`, `sample_proid`, `quantity_given`, `tourid`, `created_at`) VALUES
(1, 5, 3, 149, '2020-09-19 09:08:14');

-- --------------------------------------------------------

--
-- Table structure for table `sample_products`
--

DROP TABLE IF EXISTS `sample_products`;
CREATE TABLE IF NOT EXISTS `sample_products` (
  `sample_proid` bigint(11) NOT NULL AUTO_INCREMENT,
  `sampleid` bigint(11) NOT NULL,
  `pid` bigint(11) NOT NULL,
  `sample_quantity` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`sample_proid`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sample_products`
--

INSERT INTO `sample_products` (`sample_proid`, `sampleid`, `pid`, `sample_quantity`, `created_at`, `updated_at`) VALUES
(1, 2, 3, 10, '2020-09-19 08:44:12', '2020-09-19 08:44:12'),
(2, 3, 1, 10, '2020-09-19 09:02:58', '2020-09-19 09:02:58'),
(3, 4, 3, 12, '2020-09-21 09:44:46', '2020-09-21 09:44:46'),
(4, 5, 5, 10, '2020-09-24 05:50:49', '2020-09-24 05:50:49'),
(5, 6, 4, 20, '2020-09-24 09:24:56', '2020-09-24 09:24:56'),
(6, 6, 1, 10, '2020-09-24 09:24:56', '2020-09-24 09:24:56'),
(7, 7, 5, 10, '2020-09-30 08:07:03', '2020-09-30 08:07:03'),
(8, 7, 3, 20, '2020-09-30 08:07:03', '2020-09-30 08:07:03');

-- --------------------------------------------------------

--
-- Table structure for table `schedule`
--

DROP TABLE IF EXISTS `schedule`;
CREATE TABLE IF NOT EXISTS `schedule` (
  `scheduleid` int(11) NOT NULL AUTO_INCREMENT,
  `callweek` varchar(200) DEFAULT NULL,
  `callday` varchar(200) DEFAULT NULL,
  `cmortimefrom` time DEFAULT NULL,
  `cmortimeto` time DEFAULT NULL,
  `cevetimefrom` time DEFAULT NULL,
  `cevetimeto` time DEFAULT NULL,
  `doctorid` int(11) DEFAULT NULL,
  `sid` bigint(20) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `druglicense` varchar(255) DEFAULT NULL,
  `druglicensevalidity` date DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `firmconstitution` varchar(255) DEFAULT NULL,
  `foodlicense` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `gst` float DEFAULT NULL,
  `headquarter` varchar(255) DEFAULT NULL,
  `is_delete` int(11) NOT NULL DEFAULT '0',
  `mobile` double DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `residentialadd` varchar(255) DEFAULT NULL,
  `residentialnum` double DEFAULT NULL,
  `shopactlicense` varchar(255) DEFAULT NULL,
  `shoptelephone` double DEFAULT NULL,
  PRIMARY KEY (`scheduleid`),
  KEY `doctorid` (`doctorid`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `schedule`
--

INSERT INTO `schedule` (`scheduleid`, `callweek`, `callday`, `cmortimefrom`, `cmortimeto`, `cevetimefrom`, `cevetimeto`, `doctorid`, `sid`, `address`, `druglicense`, `druglicensevalidity`, `email`, `firmconstitution`, `foodlicense`, `gender`, `gst`, `headquarter`, `is_delete`, `mobile`, `name`, `residentialadd`, `residentialnum`, `shopactlicense`, `shoptelephone`) VALUES
(2, '1', '6', '11:11:00', '22:22:00', '01:56:00', '06:55:00', 3, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL, 0, NULL, 0),
(4, 'every week', '6', '11:11:00', '22:22:00', '21:57:00', '03:57:00', 2, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL, 0, NULL, 0),
(13, 'null', 'null', '08:07:00', '01:02:00', '03:03:00', '02:04:00', 22, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL, 0, NULL, 0),
(14, '1st Week', 'Monday', '09:30:00', '14:00:00', '16:00:00', '18:30:00', 24, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL, 0, NULL, 0),
(15, 'null', 'null', '08:01:00', '07:12:00', '20:21:00', '18:11:00', 25, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL, 0, NULL, 0),
(18, 'null', 'null', '10:45:00', '10:45:00', '10:45:00', '10:45:00', 28, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL, 0, NULL, 0),
(23, '1', '1', '00:30:00', '00:30:00', '00:30:00', '00:30:00', 44, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL, 0, NULL, 0),
(24, '3', '3', '00:30:00', '00:30:00', '00:30:00', '00:30:00', 44, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL, 0, NULL, 0),
(41, '1', '3', '22:15:00', '23:15:00', '23:15:00', '23:15:00', 45, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL, 0, NULL, 0),
(42, '4', '2', '22:15:00', '23:15:00', '23:15:00', '23:15:00', 45, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL, 0, NULL, 0),
(47, '1', '1', '07:45:00', '23:30:00', '23:30:00', '23:30:00', 26, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL, 0, NULL, 0),
(48, '1', '1', '00:09:00', '00:09:00', '00:04:00', '00:09:00', 57, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(55, '4', '4', '00:06:00', '00:10:00', '00:04:00', '00:09:00', 64, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(56, '1', '1', '00:06:00', '00:09:00', '00:09:00', '00:09:00', 65, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(57, '2', '3', '14:45:00', '14:45:00', '14:45:00', '14:45:00', 66, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `scheme`
--

DROP TABLE IF EXISTS `scheme`;
CREATE TABLE IF NOT EXISTS `scheme` (
  `scheme_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sid` bigint(20) NOT NULL,
  `doctorid` bigint(20) NOT NULL,
  `chemist_name` varchar(200) NOT NULL,
  `STATUS` varchar(20) NOT NULL DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`scheme_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `scheme`
--

INSERT INTO `scheme` (`scheme_id`, `sid`, `doctorid`, `chemist_name`, `STATUS`, `created_at`, `updated_at`) VALUES
(1, 14, 3, 'Ravindra', 'pending', '2020-09-19 12:59:51', '2020-09-19 12:59:51');

-- --------------------------------------------------------

--
-- Table structure for table `scheme_product`
--

DROP TABLE IF EXISTS `scheme_product`;
CREATE TABLE IF NOT EXISTS `scheme_product` (
  `spid` bigint(20) NOT NULL,
  `pid` bigint(20) NOT NULL,
  `scheme_id` bigint(20) NOT NULL,
  `scheme_given` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `stockiest`
--

DROP TABLE IF EXISTS `stockiest`;
CREATE TABLE IF NOT EXISTS `stockiest` (
  `sid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  `gender` varchar(200) DEFAULT NULL,
  `address` varchar(2000) DEFAULT NULL,
  `shoptelephone` varchar(100) NOT NULL,
  `mobile` varchar(100) NOT NULL,
  `email` varchar(200) DEFAULT NULL,
  `residentialnum` varchar(100) DEFAULT NULL,
  `residentialadd` varchar(2000) DEFAULT NULL,
  `shopactlicense` varchar(200) DEFAULT NULL,
  `druglicense` varchar(200) DEFAULT NULL,
  `druglicensevalidity` date DEFAULT NULL,
  `gst` float DEFAULT NULL,
  `headquarter` varchar(200) DEFAULT NULL,
  `firmconstitution` varchar(200) DEFAULT NULL,
  `foodlicense` varchar(200) DEFAULT NULL,
  `is_delete` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`sid`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `stockiest`
--

INSERT INTO `stockiest` (`sid`, `name`, `gender`, `address`, `shoptelephone`, `mobile`, `email`, `residentialnum`, `residentialadd`, `shopactlicense`, `druglicense`, `druglicensevalidity`, `gst`, `headquarter`, `firmconstitution`, `foodlicense`, `is_delete`) VALUES
(1, 'Damini Narkhede', 'female', 'new sangvi', '3243556', '83432929', 'dda@gmail.com', '323434', 'ffrgrtg', '3434df', 'ads342', '2018-03-07', 5.4, '4', 'Proprietor', 'dysh372', 0),
(2, 'Manoj Matlane', 'male', 'karve  nagar', '24345', '23421', 'manojmatlane14@gmail.com', '65745', 'sdasks', 'er34231', '34rewf', '2034-01-01', 18.9, '12', 'null', 'wei2323', 0),
(4, 'Ravindra nbmb', 'female', 'ZCBVCZ', '7456981235', '9632145875', 'ravi@gmail.com', '323434', 'ffrgrtg', '123', 'null', '2020-01-12', 4522, '1', 'Partnership', '56724', 0),
(5, 'Marya Goetsch', 'female', 'new york', '45321', '455645', 'gig@yahoo.com', '23820930', 'hewesklsd', 'wjeio343', 'iioe88090', '2017-04-03', 98, '12', 'null', 'wdew738', 1),
(13, 'Tiffanie Fitzhenry', 'female', 'bjdh', '317237', '23192320', 'dshf@hd.wj', '4932482', 'geshdf', '23234', 'ok', '0169-03-15', 23, '4', 'Partnership', '2423423', 0),
(14, 'Ricardo Robare', 'male', 'Test Shop Pune', '0', '8806112424', 'nikhil.nehete5101@gmail.com', '1564466466', 't', '12323', '2342356', '2020-03-04', 144634, '1', 'Proprietor', '1235', 0),
(17, 'Ravi', 'male', 'anywhere', '9911223344', '9911223344', 'testing@tester.com', '5', 'n', '12323', '2342356', '2020-01-23', 10, '4', 'Proprietor', '1235', 0),
(18, 'Ravindra', 'male', 'anywhere', '9911223344', '9911223344', 'testing@tester.com', '4', 'nk', '12323', '2342356', '2020-03-11', 144634, '4', 'Proprietor', '1235', 0),
(19, 'Johnathan Parra', 'male', 'Pune', '9911223344', '9911223344', 'testing@tester.com', '5', 'n', '232356', '456434', '2020-09-23', 324236000, '12', 'Proprietor', '2346723', 0),
(20, 'Bill Gates', NULL, 'Tapodham', '7585858585', '8585858585', 'ravi@gmail.com', NULL, NULL, '1231', 'null', '2020-01-12', 4521, '1', 'Proprietor', '5671', 0),
(21, 'Ravindra P', NULL, 'Pune', '8596744578', '9784589657', 'ravi@gmail.com', NULL, NULL, '12324', 'null', '2027-01-18', 4524, '1', 'Proprietor', '56724', 0),
(23, 'Donald Trump', NULL, 'Red Fort', '7456981235', '7412589632', 'donald@gmail.com', NULL, NULL, '12352', '97966623', '2030-12-18', 452442, '22', 'Proprietor', '5671444', 0);

-- --------------------------------------------------------

--
-- Table structure for table `stokiestcontact`
--

DROP TABLE IF EXISTS `stokiestcontact`;
CREATE TABLE IF NOT EXISTS `stokiestcontact` (
  `cpid` int(11) NOT NULL AUTO_INCREMENT,
  `cpname1` varchar(200) DEFAULT NULL,
  `cpphone1` double DEFAULT NULL,
  `cpname2` varchar(200) DEFAULT NULL,
  `cpphone2` double DEFAULT NULL,
  `sid` int(11) DEFAULT NULL,
  `is_delete` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`cpid`),
  KEY `sid` (`sid`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `stokiestcontact`
--

INSERT INTO `stokiestcontact` (`cpid`, `cpname1`, `cpphone1`, `cpname2`, `cpphone2`, `sid`, `is_delete`) VALUES
(12, '2fdgd', 2132443, 'gdfg', 24234, 13, 0),
(13, 'asdght', 123767458, '', 0, 14, 0),
(16, 'asdght', 9911223344, 'cxvxc', 9911223344, 17, 0),
(17, 'ravi', 123456789, 'patil', 87978984, 18, 0),
(18, 'Nedra Clampitt', 9911223344, 'Russel Patch', 123123563, 19, 0),
(19, 'ABCq', 9898985252, 'XYZq', 9112233445, 20, 0),
(20, 'ABCS', 9898985252, 'XYZSKO', 989899898, 21, 0),
(22, 'ABCSW', 9898985252, 'XYZSKOE', 989899891, 23, 0);

-- --------------------------------------------------------

--
-- Table structure for table `subarea`
--

DROP TABLE IF EXISTS `subarea`;
CREATE TABLE IF NOT EXISTS `subarea` (
  `said` int(11) NOT NULL AUTO_INCREMENT,
  `subareaname` varchar(200) DEFAULT NULL,
  `aid` int(11) DEFAULT NULL,
  `is_delete` tinyint(4) NOT NULL DEFAULT '0',
  `id` bigint(20) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `date` date DEFAULT NULL,
  `sid` bigint(20) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`said`),
  KEY `aid` (`aid`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `subarea`
--

INSERT INTO `subarea` (`said`, `subareaname`, `aid`, `is_delete`, `id`, `created_at`, `date`, `sid`, `updated_at`) VALUES
(3, 'Dhore Nagar', 5, 0, 0, NULL, NULL, 0, NULL),
(5, 'FC road', 2, 0, 0, NULL, NULL, 0, NULL),
(6, 'Akurdi', 5, 0, 0, NULL, NULL, 0, NULL),
(7, 'Nagar', 2, 0, 0, NULL, NULL, 0, NULL),
(8, 'Talegaon', 6, 1, 0, NULL, NULL, 0, NULL),
(9, 'NDA road', 7, 0, 0, NULL, NULL, 0, NULL),
(12, 'Kharadi', 13, 1, 0, NULL, NULL, 0, NULL),
(13, 'Kharadi gaon', 13, 1, 0, NULL, NULL, 0, NULL),
(14, 'Sangamner Road', 14, 1, 0, NULL, NULL, 0, NULL),
(16, 'Wagholi', 16, 0, 0, NULL, NULL, 0, NULL),
(20, 'RC patel', 23, 0, 0, NULL, NULL, 0, NULL),
(21, 'MJ College', 18, 1, 0, NULL, NULL, 0, NULL),
(22, 'Jilha Peth', 18, 0, 0, NULL, NULL, 0, NULL),
(23, 'MIDC', 18, 0, 0, NULL, NULL, 0, NULL),
(24, 'Kannad', 24, 0, 0, NULL, NULL, 0, NULL),
(25, 'Near Satara Road', 31, 0, NULL, NULL, NULL, NULL, NULL),
(26, 'Near Solapur Road', 32, 0, NULL, NULL, NULL, NULL, NULL),
(27, 'PMC ', 33, 0, NULL, NULL, NULL, NULL, NULL),
(28, 'DeepBangala', 33, 0, NULL, NULL, NULL, NULL, NULL),
(30, 'Near Pune Road', 32, 0, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `suspense_compilation`
--

DROP TABLE IF EXISTS `suspense_compilation`;
CREATE TABLE IF NOT EXISTS `suspense_compilation` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `sid` bigint(11) NOT NULL,
  `date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `suspense_compilation`
--

INSERT INTO `suspense_compilation` (`id`, `sid`, `date`, `created_at`, `updated_at`) VALUES
(1, 18, '2020-09-19', '2020-09-19 09:19:34', '2020-09-19 09:19:34'),
(2, 2, '2020-09-19', '2020-09-19 13:04:32', '2020-09-19 13:04:32'),
(3, 19, '2020-08-19', '2020-09-19 13:18:09', '2020-09-19 13:18:09'),
(4, 1, '2020-09-19', '2020-09-21 04:56:23', '2020-09-21 04:56:23'),
(5, 1, '2020-09-21', '2020-09-21 05:01:28', '2020-09-21 05:01:28'),
(6, 2, '2020-09-21', '2020-09-21 09:45:27', '2020-09-21 09:45:27'),
(7, 4, '2020-09-24', '2020-09-24 09:22:46', '2020-09-24 09:22:46');

-- --------------------------------------------------------

--
-- Table structure for table `suspense_compilation_products`
--

DROP TABLE IF EXISTS `suspense_compilation_products`;
CREATE TABLE IF NOT EXISTS `suspense_compilation_products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `sus_compilation_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `suspense_compilation_products`
--

INSERT INTO `suspense_compilation_products` (`id`, `pid`, `quantity`, `sus_compilation_id`) VALUES
(1, 3, 10, 1),
(2, 4, 10, 2),
(3, 3, 15, 2),
(4, 3, 10, 3),
(5, 1, 7, 4),
(6, 3, 30, 5),
(7, 3, 13, 6),
(8, 3, 20, 7);

-- --------------------------------------------------------

--
-- Table structure for table `target`
--

DROP TABLE IF EXISTS `target`;
CREATE TABLE IF NOT EXISTS `target` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `eid` bigint(11) NOT NULL,
  `month` date NOT NULL,
  `amount` double(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `target`
--

INSERT INTO `target` (`id`, `eid`, `month`, `amount`, `created_at`, `updated_at`) VALUES
(1, 53, '2020-09-12', 50000.00, '2020-09-15 18:30:00', '2020-09-15 18:30:00'),
(2, 52, '2020-08-15', 100000.00, '2020-09-15 00:46:16', '2020-09-15 04:43:18'),
(4, 18, '2020-10-10', 43000.00, '2020-09-25 08:25:20', '2020-09-25 08:25:20'),
(5, 14, '2020-10-15', 23000.00, '2020-09-29 11:34:38', '2020-09-29 11:34:38');

-- --------------------------------------------------------

--
-- Table structure for table `targetproducts`
--

DROP TABLE IF EXISTS `targetproducts`;
CREATE TABLE IF NOT EXISTS `targetproducts` (
  `tpid` int(100) NOT NULL AUTO_INCREMENT,
  `individualid` int(100) DEFAULT NULL,
  `pid` int(100) DEFAULT NULL,
  `target` double DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`tpid`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `targetproducts`
--

INSERT INTO `targetproducts` (`tpid`, `individualid`, `pid`, `target`, `created_at`) VALUES
(1, NULL, 4, 2, NULL),
(2, NULL, 6, 23, NULL),
(3, 6, 4, 809, '2018-11-23 10:40:32'),
(4, 6, 6, 392, '2018-11-23 10:40:32'),
(5, 7, 4, 23, '2018-11-23 10:42:14'),
(6, 7, 5, 423, '2018-11-23 10:42:14'),
(12, 9, 7, 12, '2020-03-14 15:01:19'),
(13, 10, 6, 25, '2020-03-14 16:24:40'),
(14, 11, 5, 10, '2020-03-14 16:45:43'),
(15, 11, 7, 20, '2020-03-14 16:45:43'),
(16, 12, 5, 20, '2020-03-25 04:10:10'),
(17, 12, 6, 15, '2020-03-25 04:10:10'),
(22, 14, 6, 10, NULL),
(23, 14, 7, 5, NULL),
(28, 13, 4, 10, NULL),
(29, 13, 5, 15, NULL),
(30, 8, 4, 23, NULL),
(31, 8, 5, 423, NULL),
(32, 8, 6, 45346, NULL),
(33, 8, 7, 3554, NULL),
(34, 8, 5, 10, NULL),
(38, 5, 10, 20, NULL),
(39, 5, 7, 5, NULL),
(40, 4, 5, 20, NULL),
(41, 15, 4, 20, '2020-05-03 11:39:51'),
(42, 15, 5, 10, '2020-05-03 11:39:51'),
(43, 15, 6, 5, '2020-05-03 11:39:51'),
(44, 15, 7, 20, '2020-05-03 11:39:51'),
(45, 15, 10, 5, '2020-05-03 11:39:51'),
(46, 16, 3, 10, '2020-09-19 08:22:58'),
(47, 17, 1, 10, '2020-09-19 08:28:32'),
(48, 18, 4, 20, '2020-09-22 11:12:25'),
(49, 19, 5, 15, '2020-09-24 05:19:45'),
(50, 20, 3, 50, '2020-09-24 12:11:14');

-- --------------------------------------------------------

--
-- Table structure for table `teamtarget`
--

DROP TABLE IF EXISTS `teamtarget`;
CREATE TABLE IF NOT EXISTS `teamtarget` (
  `teamid` int(100) NOT NULL AUTO_INCREMENT,
  `campaignid` int(11) DEFAULT NULL,
  `targetvalue` double DEFAULT NULL,
  `datefrom` date DEFAULT NULL,
  `dateto` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`teamid`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `teamtarget`
--

INSERT INTO `teamtarget` (`teamid`, `campaignid`, `targetvalue`, `datefrom`, `dateto`, `created_at`) VALUES
(1, 0, 0, '0000-00-00', '2018-07-13', NULL),
(2, 0, 0, '0000-00-00', '2018-07-13', NULL),
(3, 0, 0, '0000-00-00', '2018-07-13', NULL),
(4, 0, 0, '0000-00-00', '2018-07-20', NULL),
(5, 0, 0, '0000-00-00', '2018-07-18', NULL),
(6, 13, 345678, '2018-12-01', '2019-01-05', '2018-12-04 09:29:16'),
(7, 19, 2456, '2018-12-20', '2019-01-24', '2018-12-04 09:31:18'),
(8, 15, 424, '2018-12-13', '2019-01-08', '2018-12-04 09:35:43'),
(9, 19, 4245, '2018-12-28', '2019-01-15', '2018-12-04 09:39:22');

-- --------------------------------------------------------

--
-- Table structure for table `tourplan`
--

DROP TABLE IF EXISTS `tourplan`;
CREATE TABLE IF NOT EXISTS `tourplan` (
  `tourid` int(11) NOT NULL AUTO_INCREMENT,
  `doctorid` int(11) NOT NULL,
  `date` date NOT NULL,
  `time` varchar(100) NOT NULL,
  `eid` int(11) NOT NULL,
  `aid` int(11) NOT NULL,
  `status` varchar(200) NOT NULL DEFAULT 'pending',
  `feedback` varchar(100) DEFAULT NULL,
  `id` bigint(20) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `month` date DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`tourid`)
) ENGINE=InnoDB AUTO_INCREMENT=230 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tourplan`
--

INSERT INTO `tourplan` (`tourid`, `doctorid`, `date`, `time`, `eid`, `aid`, `status`, `feedback`, `id`, `created_at`, `month`, `updated_at`) VALUES
(38, 1, '2020-09-15', '01:30:00', 25, 2, 'visited', 'Dr visited', 0, NULL, NULL, NULL),
(39, 1, '2020-09-15', '01:30:00', 25, 2, 'visited', 'Dr visited', 0, NULL, NULL, NULL),
(149, 2, '2020-08-09', '11:11:00', 14, 2, 'pending', 'Good', 0, NULL, NULL, NULL),
(150, 26, '2020-08-10', '07:45:00', 14, 2, 'pending', 'Better', 0, NULL, NULL, NULL),
(151, 45, '2020-05-22', '22:15:00', 14, 2, 'pending', 'Best', 0, NULL, NULL, NULL),
(152, 45, '2020-05-06', '22:15:00', 14, 2, 'pending', '', 0, NULL, NULL, NULL),
(153, 2, '2020-05-09', '11:11:00', 14, 2, 'pending', '', 0, NULL, NULL, NULL),
(154, 26, '2020-05-11', '07:45:00', 14, 2, 'pending', '', 0, NULL, NULL, NULL),
(155, 45, '2020-05-12', '22:15:00', 14, 2, 'pending', '', 0, NULL, NULL, NULL),
(156, 45, '2020-05-13', '22:15:00', 14, 2, 'pending', '', 0, NULL, NULL, NULL),
(157, 2, '2020-05-16', '11:11:00', 14, 2, 'pending', '', 0, NULL, NULL, NULL),
(158, 26, '2020-05-18', '07:45:00', 14, 2, 'pending', '', 0, NULL, NULL, NULL),
(159, 45, '2020-05-19', '22:15:00', 14, 2, 'pending', '', 0, NULL, NULL, NULL),
(160, 45, '2020-05-20', '22:15:00', 14, 2, 'pending', '', 0, NULL, NULL, NULL),
(161, 2, '2020-05-23', '11:11:00', 14, 2, 'pending', '', 0, NULL, NULL, NULL),
(162, 26, '2020-05-25', '07:45:00', 14, 2, 'pending', '', 0, NULL, NULL, NULL),
(163, 45, '2020-05-26', '22:15:00', 14, 2, 'pending', '', 0, NULL, NULL, NULL),
(164, 45, '2020-05-27', '22:15:00', 14, 2, 'pending', '', 0, NULL, NULL, NULL),
(165, 2, '2020-05-30', '11:11:00', 14, 2, 'pending', '', 0, NULL, NULL, NULL),
(166, 2, '2020-05-02', '11:11:00', 18, 13, 'pending', '', 0, NULL, NULL, NULL),
(167, 2, '2020-05-09', '11:11:00', 18, 13, 'pending', '', 0, NULL, NULL, NULL),
(168, 2, '2020-05-16', '11:11:00', 18, 13, 'pending', '', 0, NULL, NULL, NULL),
(169, 2, '2020-05-23', '11:11:00', 18, 13, 'pending', '', 0, NULL, NULL, NULL),
(170, 2, '2020-05-30', '11:11:00', 18, 13, 'pending', '', 0, NULL, NULL, NULL),
(171, 2, '2020-05-02', '11:11:00', 51, 5, 'pending', '', 0, NULL, NULL, NULL),
(172, 3, '2020-05-02', '11:11:00', 51, 5, 'pending', '', 0, NULL, NULL, NULL),
(173, 2, '2020-05-09', '11:11:00', 51, 5, 'pending', '', 0, NULL, NULL, NULL),
(174, 3, '2020-05-09', '11:11:00', 51, 5, 'pending', '', 0, NULL, NULL, NULL),
(175, 2, '2020-05-16', '11:11:00', 51, 5, 'pending', '', 0, NULL, NULL, NULL),
(176, 3, '2020-05-16', '11:11:00', 51, 5, 'pending', '', 0, NULL, NULL, NULL),
(177, 2, '2020-05-23', '11:11:00', 51, 5, 'pending', '', 0, NULL, NULL, NULL),
(178, 3, '2020-05-23', '11:11:00', 51, 5, 'pending', '', 0, NULL, NULL, NULL),
(179, 2, '2020-05-30', '11:11:00', 51, 5, 'pending', '', 0, NULL, NULL, NULL),
(180, 3, '2020-05-30', '11:11:00', 51, 5, 'pending', '', 0, NULL, NULL, NULL),
(181, 2, '2020-05-02', '11:11:00', 52, 2, 'pending', '', 0, NULL, NULL, NULL),
(182, 26, '2020-05-04', '07:45:00', 52, 2, 'pending', '', 0, NULL, NULL, NULL),
(183, 45, '2020-05-05', '22:15:00', 52, 2, 'pending', '', 0, NULL, NULL, NULL),
(184, 45, '2020-05-06', '22:15:00', 52, 2, 'pending', '', 0, NULL, NULL, NULL),
(185, 2, '2020-05-09', '11:11:00', 52, 2, 'pending', '', 0, NULL, NULL, NULL),
(186, 26, '2020-05-11', '07:45:00', 52, 2, 'pending', '', 0, NULL, NULL, NULL),
(187, 45, '2020-05-12', '22:15:00', 52, 2, 'pending', '', 0, NULL, NULL, NULL),
(188, 45, '2020-05-13', '22:15:00', 52, 2, 'pending', '', 0, NULL, NULL, NULL),
(189, 2, '2020-05-16', '11:11:00', 52, 2, 'pending', '', 0, NULL, NULL, NULL),
(190, 26, '2020-05-18', '07:45:00', 52, 2, 'pending', '', 0, NULL, NULL, NULL),
(191, 45, '2020-05-19', '22:15:00', 52, 2, 'pending', '', 0, NULL, NULL, NULL),
(192, 45, '2020-05-20', '22:15:00', 52, 2, 'pending', '', 0, NULL, NULL, NULL),
(193, 2, '2020-05-23', '11:11:00', 52, 2, 'pending', '', 0, NULL, NULL, NULL),
(194, 26, '2020-05-25', '07:45:00', 52, 2, 'pending', '', 0, NULL, NULL, NULL),
(195, 45, '2020-05-26', '22:15:00', 52, 2, 'pending', '', 0, NULL, NULL, NULL),
(196, 45, '2020-05-27', '22:15:00', 52, 2, 'pending', '', 0, NULL, NULL, NULL),
(197, 2, '2020-05-30', '11:11:00', 52, 2, 'pending', '', 0, NULL, NULL, NULL),
(198, 2, '2020-05-02', '11:11:00', 53, 7, 'pending', '', 0, NULL, NULL, NULL),
(199, 2, '2020-05-09', '11:11:00', 53, 7, 'pending', '', 0, NULL, NULL, NULL),
(200, 2, '2020-05-16', '11:11:00', 53, 7, 'pending', '', 0, NULL, NULL, NULL),
(201, 2, '2020-05-23', '11:11:00', 53, 7, 'pending', '', 0, NULL, NULL, NULL),
(202, 2, '2020-05-30', '11:11:00', 53, 7, 'pending', '', 0, NULL, NULL, NULL),
(203, 2, '2020-05-02', '11:11:00', 63, 2, 'visited', 'Metting Successful', 0, NULL, NULL, NULL),
(204, 26, '2020-05-04', '07:45:00', 63, 2, 'pending', '', 0, NULL, NULL, NULL),
(205, 45, '2020-05-05', '22:15:00', 63, 2, 'pending', '', 0, NULL, NULL, NULL),
(206, 45, '2020-05-06', '22:15:00', 63, 2, 'pending', '', 0, NULL, NULL, NULL),
(207, 2, '2020-05-09', '11:11:00', 63, 2, 'pending', '', 0, NULL, NULL, NULL),
(208, 26, '2020-05-11', '07:45:00', 63, 2, 'pending', '', 0, NULL, NULL, NULL),
(209, 45, '2020-05-12', '22:15:00', 63, 2, 'pending', '', 0, NULL, NULL, NULL),
(210, 45, '2020-05-13', '22:15:00', 63, 2, 'pending', '', 0, NULL, NULL, NULL),
(211, 2, '2020-05-16', '11:11:00', 63, 2, 'pending', '', 0, NULL, NULL, NULL),
(212, 26, '2020-05-18', '07:45:00', 63, 2, 'pending', '', 0, NULL, NULL, NULL),
(213, 45, '2020-05-19', '22:15:00', 63, 2, 'pending', '', 0, NULL, NULL, NULL),
(214, 45, '2020-05-20', '22:15:00', 63, 2, 'pending', '', 0, NULL, NULL, NULL),
(215, 2, '2020-05-23', '11:11:00', 63, 2, 'pending', '', 0, NULL, NULL, NULL),
(216, 26, '2020-05-25', '07:45:00', 63, 2, 'pending', '', 0, NULL, NULL, NULL),
(217, 45, '2020-05-26', '22:15:00', 63, 2, 'pending', '', 0, NULL, NULL, NULL),
(218, 45, '2020-05-27', '22:15:00', 63, 2, 'pending', '', 0, NULL, NULL, NULL),
(219, 2, '2020-05-30', '11:11:00', 63, 2, 'pending', '', 0, NULL, NULL, NULL),
(220, 2, '2020-05-02', '11:11:00', 15, 2, 'pending', '', 0, NULL, NULL, NULL),
(221, 2, '2020-05-09', '11:11:00', 15, 2, 'pending', '', 0, NULL, NULL, NULL),
(222, 2, '2020-05-16', '11:11:00', 15, 2, 'pending', '', 0, NULL, NULL, NULL),
(223, 2, '2020-05-23', '11:11:00', 15, 2, 'pending', '', 0, NULL, NULL, NULL),
(224, 2, '2020-05-30', '11:11:00', 15, 2, 'pending', '', 0, NULL, NULL, NULL),
(225, 5, '2020-08-10', '14:08:15', 12, 12, 'pending', 'Dr Not Present', 0, NULL, NULL, NULL),
(226, 3, '2020-09-02', '14:08:15', 12, 2, 'pending', 'Dr Not Responced', 0, NULL, NULL, NULL),
(227, 1, '2020-09-10', '20:08:15', 12, 2, 'pending', 'Best', 0, NULL, NULL, NULL),
(228, 1, '2020-09-25', '07:45:00', 18, 2, 'pending', 'Success', 0, NULL, NULL, NULL),
(229, 1, '2020-01-30', '15:15:00', 13, 2, 'pending', NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `password` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `password`, `username`) VALUES
(1, '$2a$10$9vzYLM2BukP6UjhPWx7SEeKphedlKVN191n45rW5/cGeivZ8Ki0ii', 'ravindra');

-- --------------------------------------------------------

--
-- Table structure for table `user_activity`
--

DROP TABLE IF EXISTS `user_activity`;
CREATE TABLE IF NOT EXISTS `user_activity` (
  `aid` bigint(11) NOT NULL AUTO_INCREMENT,
  `eid` int(11) NOT NULL,
  `latitude` double(10,6) NOT NULL,
  `longitude` double(10,6) NOT NULL,
  `place_type` varchar(100) NOT NULL,
  `place_id` int(20) NOT NULL,
  `feedback` varchar(2000) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`aid`)
) ENGINE=MyISAM AUTO_INCREMENT=49 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_activity`
--

INSERT INTO `user_activity` (`aid`, `eid`, `latitude`, `longitude`, `place_type`, `place_id`, `feedback`, `created_at`) VALUES
(2, 13, 18.531401, 73.844597, 'Doctor', 1, 'Good', '2020-09-07 12:09:36'),
(3, 25, 18.572901, 73.883980, 'Chemist', 45, 'Visited', '2020-09-07 12:09:00'),
(4, 63, 18.531401, 73.844597, 'Stockiest', 12, 'Better', '2020-09-07 12:10:13'),
(5, 54, 18.245780, 65.257890, 'Doctor', 21, 'Best', '2020-09-08 04:31:35'),
(6, 10, 15.365940, 85.326940, 'Doctor', 10, 'Visited', '2020-09-08 18:30:00'),
(7, 40, 50.123550, 15.986564, 'Stockiest', 2, 'Good', '2020-09-08 18:30:00'),
(8, 0, 0.000000, 0.000000, 'Stockiest', 45, 'Not Visited', '2020-09-07 18:30:00'),
(9, 80, 10.000000, 20.000000, 'Chemist', 8, 'Visited Dr Not Available', '2020-09-10 00:45:18'),
(10, 54, 18.245780, 65.257890, 'Doctor', 21, 'Best', '2020-09-08 04:31:00'),
(11, 7, 78.778720, 62.547800, 'Chemist', 1, 'Bad', '2020-09-10 02:30:00'),
(21, 25, 73.844600, 18.531400, 'Doctor', 5, 'Visit', '2020-09-12 11:37:31'),
(22, 25, 73.844600, 18.531400, 'Doctor', 1, 'Dr Visit', '2020-09-12 11:41:46'),
(34, 25, 73.844600, 18.531400, 'Doctor', 1, 'rufjgjvjffj', '2020-09-14 14:17:12'),
(48, 25, 73.844600, 18.531400, 'Doctor', 1, 'Dr appointment at 11 am', '2020-09-16 07:27:52');

-- --------------------------------------------------------

--
-- Table structure for table `web_token`
--

DROP TABLE IF EXISTS `web_token`;
CREATE TABLE IF NOT EXISTS `web_token` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 NOT NULL,
  `token` varchar(2000) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `web_token`
--

INSERT INTO `web_token` (`id`, `username`, `token`) VALUES
(1, 'ravindra@123', 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJyYXZpbmRyYUAxMjMiLCJleHAiOjE2MDExNTExNTEsImlhdCI6MTYwMTEzMzE1MX0.ciFi-MqoiPA94C6vf2WTOlTs3L8cERJEaOuBiblzw3fwH6B9K-_NDGh-25VmT_oGDdBjeYRozvWLnqKLmVKOyQ'),
(2, 'ravindra@123', 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJyYXZpbmRyYUAxMjMiLCJleHAiOjE2MDEyODYyNzUsImlhdCI6MTYwMTI2ODI3NX0.fzTHewV1gc9IVuCirZSqNsKfzMCuBHTjlpA0M2DQnGpeOv4p8JLgwjXIae-BU1_Dr5Low2z6RpI559DOF0AkhQ'),
(3, 'ravindra@123', 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJyYXZpbmRyYUAxMjMiLCJleHAiOjE2MDEyODc5MDMsImlhdCI6MTYwMTI2OTkwM30.jxadSj6jdM8U1RqwMUAZqXHYkds3wduvq--itTalPHi0ue3sk2uLUmvowH0XpKMMnFqj1NiB67CHnl-dcrZAQw'),
(4, 'ravindra@123', 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJyYXZpbmRyYUAxMjMiLCJleHAiOjE2MDEyODg2NDcsImlhdCI6MTYwMTI3MDY0N30.CEV1l6sgNgA12QywqmZxPXJ1VbtaiWW5xff5GhmkY0nr7P1aDU97SiHE94EyY_0RDh-ix7DlLV00U0fcse87zQ'),
(5, 'ravindra@123', 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJyYXZpbmRyYUAxMjMiLCJleHAiOjE2MDEyODk2NzIsImlhdCI6MTYwMTI3MTY3Mn0.xWhZs7B8cZzroKh1BEZrcpl2iPqHIHkWeEXEiXFES37SBtmM0la6lN7q1J-li2JTUPvL4Oh0n_EXRlGqeIwgBw'),
(6, 'ravindra@123', 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJyYXZpbmRyYUAxMjMiLCJleHAiOjE2MDEyOTUxNDgsImlhdCI6MTYwMTI3NzE0OH0.vI_osTRmj-vfhhfb6cyeb_q_-H8SXZkQtqnF70WU8GVsWwfrtWvjPnWdtW22Qk3M9tvbMGb3UAnH5aAcAWWxJA'),
(7, 'ravindra@123', 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJyYXZpbmRyYUAxMjMiLCJleHAiOjE2MDEyOTUyNTEsImlhdCI6MTYwMTI3NzI1MX0.4NF0GJIe1domNfYcM3Gt_8b8lnV649dwNMjCUJzgh4dho6KWVaVawiE9wixSlH7wyU-5f2bm86d0zrfAEUynJg'),
(8, 'ravindra@123', 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJyYXZpbmRyYUAxMjMiLCJleHAiOjE2MDEyOTU2MjgsImlhdCI6MTYwMTI3NzYyOH0.t4Ztv22puzVD9OVX4JY8jWgXk8Zt1ggd5R6uH4GWT_9Gbn1SnKDsErWUYf__Y3u66WIvwXQeEph37hBiB9hqGw'),
(9, 'ravindra@123', 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJyYXZpbmRyYUAxMjMiLCJleHAiOjE2MDEyOTYxMjYsImlhdCI6MTYwMTI3ODEyNn0.5Qh3_7KCvmeBOheISMp9n6hhcRrFwT7D0oCHS5wjT3GJqELxCkAQiht0edXGh8tDIgIBOv6AdLNMpVY-mmyPEA'),
(10, 'ravindra@123', 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJyYXZpbmRyYUAxMjMiLCJleHAiOjE2MDEzODc5NjQsImlhdCI6MTYwMTM2OTk2NH0.dqiBLvlnAKEOgFayKL6PbYTzfAfZLvxC-ol5rsuCfdwj7OsTCKeOs5VnTkJMpZBQxjHpRvcj_egO84j_S_vfsQ'),
(11, 'ravindra@123', 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJyYXZpbmRyYUAxMjMiLCJleHAiOjE2MDEzODk2NjUsImlhdCI6MTYwMTM3MTY2NX0.XtmxrdISNZsJ0LkKh5JXR2zEpkCD5Qxlp8m9o5EL-8PUxJunwrfQ8_a8wxGWg55NQSMsKbFjiWIWg6nOgbuX0w'),
(12, 'ravindra@123', 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJyYXZpbmRyYUAxMjMiLCJleHAiOjE2MDEzOTQxMjMsImlhdCI6MTYwMTM3NjEyM30._ZSlIiX-HctHiLf7siL1KgquPt1sWhfmEEangp7G2ll_RNXq_qeKtXh0dhrwp64nV6_tor6HZ1aPSdUSqzwTnQ'),
(13, 'ravindra@123', 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJyYXZpbmRyYUAxMjMiLCJleHAiOjE2MDEzOTc3MTcsImlhdCI6MTYwMTM3OTcxN30.wWkyVJTSbBMKD2_DFNZdrkWE6ErFHz2S4eR7_xh7w8em1fGbnZxnEm3os7Vi5Zj9xq_c9B03DaPxSr96_7VAiQ'),
(14, 'ravindra@123', 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJyYXZpbmRyYUAxMjMiLCJleHAiOjE2MDEzOTkyMzYsImlhdCI6MTYwMTM4MTIzNn0.AOtq-J-hhCuxXW_s4W7nmwH3HxMoxpnWC9Fb5_Ov4ORni4mH7p_ACJ-VOoFVPfLRwC_CjqQIJgjz-L____KOtQ'),
(15, 'ravindra@123', 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJyYXZpbmRyYUAxMjMiLCJleHAiOjE2MDE0MDE2MzMsImlhdCI6MTYwMTM4MzYzM30.VgV7K5Lqf9AF8gh3PhfTgRM_w3noU3oEldiXsuKtUrgEIofLmYf0zmcsrHpyqzixi0nsRAPAHTtYRk3iUU3zew'),
(16, 'ravindra@123', 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJyYXZpbmRyYUAxMjMiLCJleHAiOjE2MDE0NTQ3MzQsImlhdCI6MTYwMTQzNjczNH0.xXk1HqDdm2VWvQrQtTS7rl_5jM39k-02hZyE5AAWBFNwJ0htLwygvJvl06xL-Drm1J7RwonIpILrkBatNPXbJQ'),
(17, 'ravindra@123', 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJyYXZpbmRyYUAxMjMiLCJleHAiOjE2MDE0NTQ3MzQsImlhdCI6MTYwMTQzNjczNH0.xXk1HqDdm2VWvQrQtTS7rl_5jM39k-02hZyE5AAWBFNwJ0htLwygvJvl06xL-Drm1J7RwonIpILrkBatNPXbJQ'),
(18, 'ravindra@123', 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJyYXZpbmRyYUAxMjMiLCJleHAiOjE2MDE0NzA5ODQsImlhdCI6MTYwMTQ1Mjk4NH0.gC7HRbEYhxU3v87-CFr4ObR86CEOfl5nNBhV1hwp2-roWa44YRDGRU2VJroeCcP2vOxE6WE_MhFYoO4DGSdUng'),
(19, 'ravindra@123', 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJyYXZpbmRyYUAxMjMiLCJleHAiOjE2MDE0Nzc3NDEsImlhdCI6MTYwMTQ1OTc0MX0.5y-spDe47acpVuEFCC6DL-cS896QJAPo30sri1y2jT2O1KsLzCTXXkSXU68ImDx26flgTXk1BLemU858PVEnvw'),
(20, 'ravindra@123', 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJyYXZpbmRyYUAxMjMiLCJleHAiOjE2MDE0ODA3MTAsImlhdCI6MTYwMTQ2MjcxMH0.Djnk0ulzxHzefKXZr1IBfARyWAjyKmM9vfulmQSyWEBrvSzgUXhVhxAvA5-pVmzu303wTfRgVUTDAqED-zzJ-Q'),
(21, 'ravindra@123', 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJyYXZpbmRyYUAxMjMiLCJleHAiOjE2MDE0ODQwNzksImlhdCI6MTYwMTQ2NjA3OX0.JtBxTZV278pyq_JXAQuhuEyz1fTR40eARDBm6Jw26b_jET4TK9sJoDkMSiUC_ZO-JhBhubKqFGmjzviRmbr2YA');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `area`
--
ALTER TABLE `area`
  ADD CONSTRAINT `area_ibfk_2` FOREIGN KEY (`hid`) REFERENCES `headquarter` (`hid`);

--
-- Constraints for table `schedule`
--
ALTER TABLE `schedule`
  ADD CONSTRAINT `schedule_ibfk_1` FOREIGN KEY (`doctorid`) REFERENCES `doctors` (`doctorid`);

--
-- Constraints for table `stokiestcontact`
--
ALTER TABLE `stokiestcontact`
  ADD CONSTRAINT `stokiestcontact_ibfk_1` FOREIGN KEY (`sid`) REFERENCES `stockiest` (`sid`);

--
-- Constraints for table `subarea`
--
ALTER TABLE `subarea`
  ADD CONSTRAINT `subarea_ibfk_1` FOREIGN KEY (`aid`) REFERENCES `area` (`aid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
