

-- create admin user

INSERT INTO `user` (`rollNo`,`fName`,`lName`,`email`,`password`,`type`,`city`,`country`,`active`) VALUES (0,'admin','admin','admin@admin.com','admin','admin','NA','NA','1');

-- create grades

INSERT INTO `grade` (`id`,`grade_code`,`definition`,`min_mark`,`max_mark`) VALUES (1,'HD','High Distinction',85,100);
INSERT INTO `grade` (`id`,`grade_code`,`definition`,`min_mark`,`max_mark`) VALUES (2,'D','Distinction',75,84);
INSERT INTO `grade` (`id`,`grade_code`,`definition`,`min_mark`,`max_mark`) VALUES (3,'C','Credit',60,74);
INSERT INTO `grade` (`id`,`grade_code`,`definition`,`min_mark`,`max_mark`) VALUES (4,'P','Pass',50,59);
INSERT INTO `grade` (`id`,`grade_code`,`definition`,`min_mark`,`max_mark`) VALUES (5,'F2','Fail 2',45,49);
INSERT INTO `grade` (`id`,`grade_code`,`definition`,`min_mark`,`max_mark`) VALUES (6,'F1','Fail 1',0,45);