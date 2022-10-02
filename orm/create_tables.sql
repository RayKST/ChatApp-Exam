DROP TABLE IF EXISTS `country`;

CREATE TABLE `country` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`)
) 


DROP TABLE IF EXISTS `group`;

CREATE TABLE `group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(150) NOT NULL,
  `language_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `group_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `language` (`id`)
)



DROP TABLE IF EXISTS `group_interests`;

CREATE TABLE `group_interests` (
  `group_id` int NOT NULL,
  `interest_id` int NOT NULL,
  PRIMARY KEY (`group_id`,`interest_id`),
  KEY `interest_id` (`interest_id`),
  CONSTRAINT `group_interests_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `group` (`id`),
  CONSTRAINT `group_interests_ibfk_2` FOREIGN KEY (`interest_id`) REFERENCES `interest` (`id`)
)

DROP TABLE IF EXISTS `group_members`;

CREATE TABLE `group_members` (
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`user_id`,`group_id`),
  KEY `group_id` (`group_id`),
  CONSTRAINT `group_members_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `group_members_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `group` (`id`)
)



DROP TABLE IF EXISTS `interest`;

CREATE TABLE `interest` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(150) NOT NULL,
  PRIMARY KEY (`id`)
) 

DROP TABLE IF EXISTS `language`;

CREATE TABLE `language` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`)
)



DROP TABLE IF EXISTS `profile_photo`;

CREATE TABLE `profile_photo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `url` varchar(150) NOT NULL,
  PRIMARY KEY (`id`)
)



DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nickname` varchar(150) NOT NULL,
  `photo_id` int NOT NULL,
  `about_me` varchar(150) NOT NULL,
  `language_id` int NOT NULL,
  `country_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `photo_id` (`photo_id`),
  KEY `language_id` (`language_id`),
  KEY `country_id` (`country_id`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`photo_id`) REFERENCES `profile_photo` (`id`),
  CONSTRAINT `user_ibfk_2` FOREIGN KEY (`language_id`) REFERENCES `language` (`id`),
  CONSTRAINT `user_ibfk_3` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`)
)


DROP TABLE IF EXISTS `user_interests`;

CREATE TABLE `user_interests` (
  `user_id` int NOT NULL,
  `interest_id` int NOT NULL,
  PRIMARY KEY (`user_id`,`interest_id`),
  KEY `interest_id` (`interest_id`),
  CONSTRAINT `user_interests_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `user_interests_ibfk_2` FOREIGN KEY (`interest_id`) REFERENCES `interest` (`id`)
)