CREATE TABLE `Users` (
	`Login` varchar(50) NOT NULL UNIQUE,
	`Name` varchar(255) NOT NULL,
	`Password` varchar(255) NOT NULL,
	`IdLevel` INT NOT NULL,
	PRIMARY KEY (`Login`)
);

CREATE TABLE `Levels` (
	`Id` INT NOT NULL AUTO_INCREMENT,
	`Name` varchar(50) NOT NULL,
	PRIMARY KEY (`Id`)
);

CREATE TABLE `Questions` (
	`Id` INT NOT NULL,
	`Text` varchar(4000) NOT NULL,
	`IdSubject` INT NOT NULL,
	PRIMARY KEY (`Id`)
);

CREATE TABLE `Answers` (
	`Id` INT NOT NULL AUTO_INCREMENT,
	`IdQuestion` INT,
	`Text` varchar(4000) NOT NULL,
	`Seq` INT,
	PRIMARY KEY (`Id`)
);

CREATE TABLE `Lists` (
	`Id` INT NOT NULL AUTO_INCREMENT,
	`IdUser` varchar(50) NOT NULL,
	`Title` varchar(1000),
	`LinkList` BINARY NOT NULL DEFAULT '0',
	`IdLinkList` INT DEFAULT '0',
	PRIMARY KEY (`Id`)
);

CREATE TABLE `ListQuestion` (
	`IdList` INT NOT NULL,
	`IdQuestion` INT NOT NULL,
	`IdGroup` INT NOT NULL,
	`Order` INT NOT NULL,
	PRIMARY KEY (`IdList`,`IdQuestion`,`IdGroup`)
);

CREATE TABLE `Subjects` (
	`Id` INT NOT NULL AUTO_INCREMENT,
	`Name` varchar(255) NOT NULL,
	`IdMatter` INT NOT NULL,
	PRIMARY KEY (`Id`)
);

CREATE TABLE `Group` (
	`IdGroup` INT NOT NULL AUTO_INCREMENT,
	`Title` varchar(4000) NOT NULL,
	`IdUser` varchar(50) NOT NULL,
	`Type` INT NOT NULL,
	PRIMARY KEY (`IdGroup`)
);

CREATE TABLE `Options` (
	`IdOption` INT NOT NULL AUTO_INCREMENT,
	`IdQuestion` INT NOT NULL,
	`Text` varchar(4000) NOT NULL,
	PRIMARY KEY (`IdOption`)
);

CREATE TABLE `Followers` (
	`IdFollower` varchar(50) NOT NULL,
	`IdFollowed` varchar(50) NOT NULL,
	PRIMARY KEY (`IdFollower`,`IdFollowed`)
);

CREATE TABLE `Class` (
	`idClass` INT NOT NULL AUTO_INCREMENT,
	`Name` varchar(255) NOT NULL,
	`Private` BINARY DEFAULT '0',
	`IdTeacher` varchar(50) NOT NULL DEFAULT '0',
	PRIMARY KEY (`idClass`)
);

CREATE TABLE `Matters` (
	`Id` INT NOT NULL AUTO_INCREMENT,
	`Name` INT NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (`Id`)
);

CREATE TABLE `ClassStudent` (
	`IdClass` INT NOT NULL,
	`IdStudent` varchar(50) NOT NULL,
	PRIMARY KEY (`IdClass`,`IdStudent`)
);

CREATE TABLE `HomeWorks` (
	`Id` INT NOT NULL AUTO_INCREMENT,
	`Name` varchar(255) NOT NULL,
	`IdList` INT NOT NULL,
	PRIMARY KEY (`Id`)
);

CREATE TABLE `GroupQuestion` (
	`idQuestion` INT NOT NULL,
	`idGroup` INT NOT NULL,
	PRIMARY KEY (`idQuestion`,`idGroup`)
);

CREATE TABLE `HomeWorkUser` (
	`IdHomeWork` INT NOT NULL,
	`idUser` varchar(50) NOT NULL,
	PRIMARY KEY (`IdHomeWork`,`idUser`)
);

CREATE TABLE `WrongQuestions` (
	`IdList` INT NOT NULL,
	`IdQuestion` INT NOT NULL,
	`IdGroup` INT NOT NULL,
	`IdHomeWork` INT NOT NULL,
	`IdUser` varchar(50) NOT NULL,
	`Answer` varchar(4000) NOT NULL,
	PRIMARY KEY (`IdList`,`IdQuestion`,`IdGroup`,`IdHomeWork`,`IdUser`)
);

ALTER TABLE `Users` ADD CONSTRAINT `Users_fk0` FOREIGN KEY (`IdLevel`) REFERENCES `Levels`(`Id`);

ALTER TABLE `Questions` ADD CONSTRAINT `Questions_fk0` FOREIGN KEY (`IdSubject`) REFERENCES `Subjects`(`Id`);

ALTER TABLE `Answers` ADD CONSTRAINT `Answers_fk0` FOREIGN KEY (`IdQuestion`) REFERENCES `Questions`(`Id`);

ALTER TABLE `Lists` ADD CONSTRAINT `Lists_fk0` FOREIGN KEY (`IdUser`) REFERENCES `Users`(`Login`);

ALTER TABLE `Lists` ADD CONSTRAINT `Lists_fk1` FOREIGN KEY (`IdLinkList`) REFERENCES `Lists`(`Id`);

ALTER TABLE `ListQuestion` ADD CONSTRAINT `ListQuestion_fk0` FOREIGN KEY (`IdList`) REFERENCES `Lists`(`Id`);

ALTER TABLE `ListQuestion` ADD CONSTRAINT `ListQuestion_fk1` FOREIGN KEY (`IdQuestion`) REFERENCES `GroupQuestion`(`idQuestion`);

ALTER TABLE `ListQuestion` ADD CONSTRAINT `ListQuestion_fk2` FOREIGN KEY (`IdGroup`) REFERENCES `GroupQuestion`(`idGroup`);

ALTER TABLE `Subjects` ADD CONSTRAINT `Subjects_fk0` FOREIGN KEY (`IdMatter`) REFERENCES `Matters`(`Id`);

ALTER TABLE `Group` ADD CONSTRAINT `Group_fk0` FOREIGN KEY (`IdUser`) REFERENCES `Users`(`Login`);

ALTER TABLE `Options` ADD CONSTRAINT `Options_fk0` FOREIGN KEY (`IdQuestion`) REFERENCES `Questions`(`Id`);

ALTER TABLE `Followers` ADD CONSTRAINT `Followers_fk0` FOREIGN KEY (`IdFollower`) REFERENCES `Users`(`Login`);

ALTER TABLE `Followers` ADD CONSTRAINT `Followers_fk1` FOREIGN KEY (`IdFollowed`) REFERENCES `Users`(`Login`);

ALTER TABLE `Class` ADD CONSTRAINT `Class_fk0` FOREIGN KEY (`IdTeacher`) REFERENCES `Users`(`Login`);

ALTER TABLE `ClassStudent` ADD CONSTRAINT `ClassStudent_fk0` FOREIGN KEY (`IdClass`) REFERENCES `Class`(`idClass`);

ALTER TABLE `ClassStudent` ADD CONSTRAINT `ClassStudent_fk1` FOREIGN KEY (`IdStudent`) REFERENCES `Users`(`Login`);

ALTER TABLE `HomeWorks` ADD CONSTRAINT `HomeWorks_fk0` FOREIGN KEY (`IdList`) REFERENCES `Lists`(`Id`);

ALTER TABLE `GroupQuestion` ADD CONSTRAINT `GroupQuestion_fk0` FOREIGN KEY (`idQuestion`) REFERENCES `Questions`(`Id`);

ALTER TABLE `GroupQuestion` ADD CONSTRAINT `GroupQuestion_fk1` FOREIGN KEY (`idGroup`) REFERENCES `Group`(`IdGroup`);

ALTER TABLE `HomeWorkUser` ADD CONSTRAINT `HomeWorkUser_fk0` FOREIGN KEY (`IdHomeWork`) REFERENCES `HomeWorks`(`Id`);

ALTER TABLE `HomeWorkUser` ADD CONSTRAINT `HomeWorkUser_fk1` FOREIGN KEY (`idUser`) REFERENCES `Users`(`Login`);

ALTER TABLE `WrongQuestions` ADD CONSTRAINT `WrongQuestions_fk0` FOREIGN KEY (`IdList`) REFERENCES `ListQuestion`(`IdList`);

ALTER TABLE `WrongQuestions` ADD CONSTRAINT `WrongQuestions_fk1` FOREIGN KEY (`IdQuestion`) REFERENCES `ListQuestion`(`IdQuestion`);

ALTER TABLE `WrongQuestions` ADD CONSTRAINT `WrongQuestions_fk2` FOREIGN KEY (`IdGroup`) REFERENCES `ListQuestion`(`IdGroup`);

ALTER TABLE `WrongQuestions` ADD CONSTRAINT `WrongQuestions_fk3` FOREIGN KEY (`IdHomeWork`) REFERENCES `HomeWorkUser`(`IdHomeWork`);

ALTER TABLE `WrongQuestions` ADD CONSTRAINT `WrongQuestions_fk4` FOREIGN KEY (`IdUser`) REFERENCES `HomeWorkUser`(`idUser`);
