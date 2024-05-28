/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE TABLE `chat` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `room_id` varchar(255) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `unique_id` (`id`),
  KEY `fk_constraint_userid` (`user_id`),
  CONSTRAINT `fk_constraint_userid` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `code` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(50) DEFAULT NULL,
  `expired` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `pass_word` varchar(255) DEFAULT NULL,
  `face_app_id` varchar(255) DEFAULT NULL,
  `role` varchar(50) DEFAULT NULL,
  `refresh_token` text,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `video` (
  `video_id` int NOT NULL AUTO_INCREMENT,
  `video_name` varchar(255) DEFAULT NULL,
  `thumbnail` varchar(255) DEFAULT NULL,
  `description` text,
  `views` int DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `type_id` int DEFAULT NULL,
  PRIMARY KEY (`video_id`),
  KEY `user_id` (`user_id`),
  KEY `type_id` (`type_id`),
  CONSTRAINT `video_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `video_ibfk_2` FOREIGN KEY (`type_id`) REFERENCES `video_type` (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `video_comment` (
  `comment_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `video_id` int DEFAULT NULL,
  `date_create` datetime DEFAULT NULL,
  `content` text,
  `reply_list` varchar(255) DEFAULT NULL,
  `timestamp` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`comment_id`),
  KEY `user_id` (`user_id`),
  KEY `video_id` (`video_id`),
  CONSTRAINT `video_comment_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `video_comment_ibfk_2` FOREIGN KEY (`video_id`) REFERENCES `video` (`video_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `video_like` (
  `like_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `video_id` int DEFAULT NULL,
  `date_create` datetime DEFAULT NULL,
  `dis_like` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`like_id`),
  KEY `user_id` (`user_id`),
  KEY `video_id` (`video_id`),
  CONSTRAINT `video_like_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `video_like_ibfk_2` FOREIGN KEY (`video_id`) REFERENCES `video` (`video_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `video_type` (
  `type_id` int NOT NULL AUTO_INCREMENT,
  `type_name` varchar(255) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `chat` (`id`, `user_id`, `content`, `room_id`, `date`) VALUES
(14, 16, 'a', '15-16', '2024-05-11 13:23:18');
INSERT INTO `chat` (`id`, `user_id`, `content`, `room_id`, `date`) VALUES
(15, 15, 'b', '15-16', '2024-05-11 13:29:34');
INSERT INTO `chat` (`id`, `user_id`, `content`, `room_id`, `date`) VALUES
(16, 15, 'oke', '15-16', '2024-05-11 13:31:51');
INSERT INTO `chat` (`id`, `user_id`, `content`, `room_id`, `date`) VALUES
(17, 15, 'helo', '15-16', '2024-05-11 13:33:06'),
(18, 16, 'oke', '15-16', '2024-05-11 13:33:19'),
(19, 15, 'good mornong', '15-16', '2024-05-11 13:33:37'),
(20, 16, 'thanks', '15-16', '2024-05-11 13:33:48');

INSERT INTO `code` (`id`, `code`, `expired`) VALUES
(1, '1708224798752', '2024-02-18 02:53:18');
INSERT INTO `code` (`id`, `code`, `expired`) VALUES
(2, '1708225615899', '2024-02-18 03:06:55');
INSERT INTO `code` (`id`, `code`, `expired`) VALUES
(3, '1708225688713', '2024-02-18 03:08:08');
INSERT INTO `code` (`id`, `code`, `expired`) VALUES
(4, '1708226530401', '2024-02-18 03:22:10'),
(5, 'itFIGc', '2024-04-29 13:48:45'),
(7, 'fmJAAg', '2024-04-29 13:52:19'),
(8, 'ORPeL6', '2024-04-29 13:52:39');

INSERT INTO `users` (`user_id`, `full_name`, `email`, `avatar`, `pass_word`, `face_app_id`, `role`, `refresh_token`) VALUES
(1, 'John Doe', 'john@example.com', 'http://res.cloudinary.com/dghvdbogx/image/upload/v1708524200/node39/cgnoxdrfftlfdfe8qu1j.jpg', 'hashed_pass1', 'face123', 'user', NULL);
INSERT INTO `users` (`user_id`, `full_name`, `email`, `avatar`, `pass_word`, `face_app_id`, `role`, `refresh_token`) VALUES
(2, 'Jane Smith', 'jane@example.com', 'avatar2.jpg', 'hashed_pass2', 'face456', 'user', NULL);
INSERT INTO `users` (`user_id`, `full_name`, `email`, `avatar`, `pass_word`, `face_app_id`, `role`, `refresh_token`) VALUES
(3, 'Admin User', 'admin@example.com', 'admin_avatar.jpg', 'hashed_pass3', 'face789', 'admin', NULL);
INSERT INTO `users` (`user_id`, `full_name`, `email`, `avatar`, `pass_word`, `face_app_id`, `role`, `refresh_token`) VALUES
(4, 'Alice Johnson', 'alice@example.com', 'avatar3.jpg', 'hashed_pass4', 'face987', 'user', NULL),
(5, 'Bob Brown', 'bob@example.com', '123121512_thor.jpeg', 'hashed_pass5', 'face654', 'user', NULL),
(6, 'MCK', 'khaitruong2112@gmail.com', '123121512_thor.jpeg', '1234', '', 'USER', NULL),
(7, 'abc', 'mck2@gmail.com', '123121512_thor.jpeg', '1234', '', 'USER', NULL),
(8, 'Mono', 'mono@gmail.com', 'http://res.cloudinary.com/dghvdbogx/image/upload/v1708524200/node39/cgnoxdrfftlfdfe8qu1j.jpg', '$2b$10$edTpAwt6OFnIeAnz8NcAs.6oTUP.YviYXhQ/5Xpt5uSkJoUvWdlom', '', 'USER', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjgsImtleSI6MTcwODUyNDQwNTU4MCwiaWF0IjoxNzA4NTI0NDA1LCJleHAiOjE3MDkxMjkyMDV9.yXSOloaU4kd7J4pQSRPeB60sbfpOmbdIUniczihgBgs'),
(9, 'test', 'test@gmail.com', '123121512_thor.jpeg', '', '1234', 'USER', NULL),
(10, 'Nguyễn Đình Sang', 'sangrom2003@gmail.com', '123121512_thor.jpeg', '', '7057226420992277', 'USER', NULL),
(11, 'khoa', 'khoa@gmail.com', '', '1234', '', 'USER', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7InVzZXJJZCI6MTEsImtleSI6IlJ4d1A5SSJ9LCJpYXQiOjE3MTQ3NTQ3OTYsImV4cCI6MTcxOTkzODc5Nn0.ESn1XDggcdk7uAd1bbHB_Yl33LgrfTYb9d1nAh022Xk'),
(13, 'khoa2', 'khoa2@gmail.com', '', '$2b$10$mWLDsLi5CxkfrmUu8BQDKeAmR6tSjTGJRrqwJUunf5TpPwlx4tApu', '', 'USER', ''),
(14, 'Trần Đăng Khoa', 'dangkhoa020228@gmail.com', '', '', 'userID', 'USER', ''),
(15, 'abc1', 'abc1@gmail.com', '', '$2b$10$Yjr6/mrEjMdKpAXyNxJ.euY2CD87riUqfupvsEWJUAlr3b1EPD2ai', '', 'USER', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7InVzZXJJZCI6MTUsImtleSI6IjRzVXI4YSJ9LCJpYXQiOjE3MTU0MzIzOTYsImV4cCI6MTcyMDYxNjM5Nn0.SJDAJQnzLYBDe5BPQfoDqpXMrkgK1CIJOkkzJsrc0OU'),
(16, 'abc2', 'abc2@gmail.com', '', '$2b$10$C0zr3afUH1o6iBtz6ib1pODxwQ4f5/iudwaoSI1N59eXb5AvpcO0S', '', 'USER', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7InVzZXJJZCI6MTYsImtleSI6IjdvQ1ExcyJ9LCJpYXQiOjE3MTU0MzI0MjIsImV4cCI6MTcyMDYxNjQyMn0.k3jsI-p-Fj_OuuvFmyD8YGpi4nPyLrr5828GaLNu4F4');

INSERT INTO `video` (`video_id`, `video_name`, `thumbnail`, `description`, `views`, `source`, `user_id`, `type_id`) VALUES
(1, 'Introduction to Coding', 'http://res.cloudinary.com/dghvdbogx/image/upload/v1708524200/node39/cgnoxdrfftlfdfe8qu1j.jpg', 'Learn the basics of coding', 1500, 'youtube.com', 1, 2);
INSERT INTO `video` (`video_id`, `video_name`, `thumbnail`, `description`, `views`, `source`, `user_id`, `type_id`) VALUES
(2, 'Music Concert Highlights', 'music_concert.jpg', 'Highlights from a live music concert', 800, 'vimeo.com', 2, 3);
INSERT INTO `video` (`video_id`, `video_name`, `thumbnail`, `description`, `views`, `source`, `user_id`, `type_id`) VALUES
(3, 'Gaming Adventure Episode 1', 'gaming_adventure1.jpg', 'First episode of a gaming adventure', 2500, 'twitch.tv', 3, 5);
INSERT INTO `video` (`video_id`, `video_name`, `thumbnail`, `description`, `views`, `source`, `user_id`, `type_id`) VALUES
(4, 'Fashion Trends for Spring', 'spring_fashion.jpg', 'Latest fashion trends for the spring season', 1200, 'instagram.com', 4, 7),
(5, 'Introduction to Cryptocurrency', 'crypto_intro.jpg', 'Understanding the basics of cryptocurrency', 300, 'youtube.com', 5, 9),
(6, 'Full Stack Web Development Tutorial', 'web_dev_tutorial.jpg', 'Complete guide to full stack web development', 1200, 'youtube.com', 1, 2),
(7, 'Acoustic Guitar Performance', 'acoustic_guitar.jpg', 'Soulful acoustic guitar performance', 650, 'vimeo.com', 2, 3),
(8, 'Epic Gaming Moments Compilation', 'gaming_compilation.jpg', 'Compilation of epic gaming moments', 3500, 'twitch.tv', 3, 5),
(9, 'Fitness Workout Routine', 'fitness_workout.jpg', 'Effective fitness workout routine', 900, 'instagram.com', 4, 8),
(10, 'Understanding Blockchain Technology', 'blockchain_technology.jpg', 'Exploring the concepts of blockchain', 500, 'youtube.com', 5, 9);

INSERT INTO `video_comment` (`comment_id`, `user_id`, `video_id`, `date_create`, `content`, `reply_list`, `timestamp`) VALUES
(1, 8, 9, '2023-02-21 01:01:01', 'test', NULL, NULL);
INSERT INTO `video_comment` (`comment_id`, `user_id`, `video_id`, `date_create`, `content`, `reply_list`, `timestamp`) VALUES
(2, 10, 9, '2023-02-21 01:01:01', 'abc', NULL, NULL);
INSERT INTO `video_comment` (`comment_id`, `user_id`, `video_id`, `date_create`, `content`, `reply_list`, `timestamp`) VALUES
(3, 8, 9, '2024-02-21 12:57:22', '123', NULL, NULL);
INSERT INTO `video_comment` (`comment_id`, `user_id`, `video_id`, `date_create`, `content`, `reply_list`, `timestamp`) VALUES
(4, 8, 9, '2024-02-21 12:57:32', '123', NULL, NULL),
(5, 8, 9, '2024-02-21 12:57:32', '123', NULL, NULL),
(6, 8, 9, '2024-02-21 12:57:32', '123', NULL, NULL),
(7, 8, 9, '2024-02-21 12:57:32', '123', NULL, NULL),
(8, 8, 9, '2024-02-21 12:57:32', '123', NULL, NULL),
(9, 11, 9, '2024-04-23 18:04:05', '1234', NULL, NULL);



INSERT INTO `video_type` (`type_id`, `type_name`, `icon`) VALUES
(1, 'New', 'fa-solid fa-house');
INSERT INTO `video_type` (`type_id`, `type_name`, `icon`) VALUES
(2, 'Coding', 'fa-solid fa-code');
INSERT INTO `video_type` (`type_id`, `type_name`, `icon`) VALUES
(3, 'Music', 'fa-solid fa-music');
INSERT INTO `video_type` (`type_id`, `type_name`, `icon`) VALUES
(4, 'Movie', 'fa-solid fa-video'),
(5, 'Gaming', 'fa-sharp fa-solid fa-gamepad'),
(6, 'Sport', 'fa-solid fa-baseball'),
(7, 'Fashion', 'fa-sharp fa-solid fa-shirt'),
(8, 'Gym', 'fa-solid fa-dumbbell'),
(9, 'Crypto', 'fa-solid fa-diamond');


/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;