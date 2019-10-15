
-- create database gbook2;

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rollNo` int(11) DEFAULT NULL,
  `fName` varchar(45) DEFAULT NULL,
  `lName` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `country` varchar(12) DEFAULT NULL,
  `active` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;


CREATE TABLE `subject` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(45) DEFAULT NULL,
  `title` varchar(45) DEFAULT NULL,
  `detail` varchar(2500) DEFAULT NULL,
  `summary` varchar(2500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

CREATE TABLE `user_subject` (
  `user_id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL,
  KEY `fk_user_subject_user_id_idx` (`user_id`),
  KEY `fk_user_subject_subject_id_idx` (`subject_id`),
  CONSTRAINT `fk_user_subject_subject_id` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_subject_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `assignment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `description` varchar(1250) DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `max_grade` float DEFAULT NULL,
  `passing_grade` float DEFAULT NULL,
  `subject_id` int(11) NOT NULL,
  `hurdle` bit(1) DEFAULT b'0',
  PRIMARY KEY (`id`),
  KEY `fk_assignment_subject_id_idx` (`subject_id`),
  CONSTRAINT `fk_assignment_subject_id` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;


CREATE TABLE `submission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `submission_date` date DEFAULT NULL,
  `submitted_by` int(11) DEFAULT NULL,
  `submitted_to` int(11) DEFAULT NULL,
  `assignment_id` int(11) DEFAULT NULL,
  `marks` float DEFAULT NULL,
  `comments` varchar(125) DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_submission_submitted_by_idx` (`submitted_by`),
  KEY `fk_submission_submitted_to_idx` (`submitted_to`),
  KEY `fk_submission_assignment_id_idx` (`assignment_id`),
  CONSTRAINT `fk_submission_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `assignment` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_submission_submitted_by` FOREIGN KEY (`submitted_by`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_submission_submitted_to` FOREIGN KEY (`submitted_to`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

CREATE TABLE `grade` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `grade_code` varchar(3) DEFAULT NULL,
  `definition` varchar(45) DEFAULT NULL,
  `min_mark` int(11) DEFAULT NULL,
  `max_mark` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

CREATE TABLE `shared_report` (
  `subject_id` int(11) NOT NULL,
  `lecturer_id` int(11) NOT NULL,
  KEY `fk_sharedReport_stbject_id_idx` (`subject_id`),
  KEY `fk_sharedReport_lecturer_id_idx` (`lecturer_id`),
  CONSTRAINT `fk_sharedReport_lecturer_id` FOREIGN KEY (`lecturer_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_sharedReport_stbject_id` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

