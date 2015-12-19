-- phpMyAdmin SQL Dump
-- version 4.3.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Dec 19, 2015 at 03:00 PM
-- Server version: 5.6.24
-- PHP Version: 5.6.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `movies`
--

-- --------------------------------------------------------

--
-- Table structure for table `movies`
--

CREATE TABLE IF NOT EXISTS `movies` (
  `id` int(11) NOT NULL,
  `genre_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `imdb_score` varchar(50) NOT NULL,
  `popularity` varchar(50) NOT NULL,
  `director` varchar(50) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `added_by` int(11) DEFAULT NULL,
  `added_date` date NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `movies`
--

INSERT INTO `movies` (`id`, `genre_id`, `name`, `imdb_score`, `popularity`, `director`, `status`, `added_by`, `added_date`) VALUES
(1, 2, 'The Wizard of Oz', '8.3', '83.0', 'Victor Fleming', 1, 1, '2015-12-18'),
(2, 1, 'Star Wars', '8.8', '88.0', 'George Lucas', 1, 1, '2015-12-18'),
(4, 2, 'Cabiria', '6.6', '66.0', 'Giovanni Pastrone', 1, 1, '2015-12-18'),
(5, 2, 'Algiers', '6.6', '66.0', 'Giovanni Pastrone', 1, 1, '2015-12-18'),
(6, 2, 'Greed', '6.6', '66.0', 'Giovanni Pastrone', 1, 1, '2015-12-18'),
(7, 2, 'Mad Love', '6.6', '66.0', 'Giovanni Pastrone', 0, 1, '2015-12-18'),
(8, 2, 'Mad Love', '6.6', '66.0', 'Giovanni Pastrone', 0, 1, '2015-12-18');

-- --------------------------------------------------------

--
-- Table structure for table `movies_genre`
--

CREATE TABLE IF NOT EXISTS `movies_genre` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `movies_genre`
--

INSERT INTO `movies_genre` (`id`, `name`) VALUES
(1, 'Adventure'),
(2, 'Family'),
(3, 'Fantasy'),
(4, 'Musical');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int(11) NOT NULL,
  `user_fullname` varchar(25) NOT NULL,
  `user_email` varchar(50) NOT NULL,
  `user_password` varchar(50) NOT NULL,
  `user_status` tinyint(1) NOT NULL DEFAULT '0',
  `user_types_id` int(2) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `user_fullname`, `user_email`, `user_password`, `user_status`, `user_types_id`) VALUES
(1, 'Brij Sundar', 'brij@gmail.com', '79207edbca58007eba8571b5c4172c18', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_types`
--

CREATE TABLE IF NOT EXISTS `user_types` (
  `id` int(11) NOT NULL,
  `name` varchar(25) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_types`
--

INSERT INTO `user_types` (`id`, `name`) VALUES
(1, 'Admin'),
(2, 'User');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `movies`
--
ALTER TABLE `movies`
  ADD PRIMARY KEY (`id`), ADD KEY `added_by` (`added_by`), ADD KEY `genre_id` (`genre_id`);

--
-- Indexes for table `movies_genre`
--
ALTER TABLE `movies_genre`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`), ADD KEY `user_types_id` (`user_types_id`);

--
-- Indexes for table `user_types`
--
ALTER TABLE `user_types`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `movies`
--
ALTER TABLE `movies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `movies_genre`
--
ALTER TABLE `movies_genre`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `user_types`
--
ALTER TABLE `user_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `movies`
--
ALTER TABLE `movies`
ADD CONSTRAINT `movies_ibfk_1` FOREIGN KEY (`added_by`) REFERENCES `users` (`user_id`),
ADD CONSTRAINT `movies_ibfk_2` FOREIGN KEY (`genre_id`) REFERENCES `movies_genre` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`user_types_id`) REFERENCES `user_types` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
