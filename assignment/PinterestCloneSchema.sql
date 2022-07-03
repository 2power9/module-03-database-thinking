CREATE DATABASE IF NOT EXISTS `PinterestCloneDatabase`;

USE `PinterestCloneDatabase`;

-- DROP DATABASE IF EXISTS `PinterestCloneDatabase`;

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
    `userID` VARCHAR(10) NOT NULL,
    `userName` VARCHAR(20) NOT NULL,
    `password` VARCHAR(50) NOT NULL,
    `email` VARCHAR(50) NOT NULL,
    `numberFollowers` INT UNSIGNED DEFAULT 0,
    `numberFollowings` INT UNSIGNED DEFAULT 0,

    PRIMARY KEY `userID` (`userID`)

) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `users` (`userID`, `userName`, `password`, `email`, `numberFollowers`, `numberFollowings`) VALUES
    ('U001', 'nhutnh3', 'pikachu1', 'nhutnh3@vng.com.vn', 1, 2),
    ('U002', 'toanntt', 'pikachu2', 'toanntt@vng.com.vn', 1, 1),
    ('U003', 'thanhndt', 'pikachu3', 'thanhndt@vng.com.vn', 1, 0);

DROP TABLE IF EXISTS `pins`;

CREATE TABLE `pins` (
    `pinID` VARCHAR(10) NOT NULL,
    `owner` VARCHAR(10) NOT NULL,
    `title` VARCHAR(50) NOT NULL,
    `description` TEXT DEFAULT NULL,
    `numberReacts` INT UNSIGNED DEFAULT 0,
    `numberComments` INT UNSIGNED DEFAULT 0,

    PRIMARY KEY `pinID` (`pinID`),
    KEY `owner` (`owner`),

    CONSTRAINT `pin_owner_fk` FOREIGN KEY (`owner`) REFERENCES `users` (`userID`)

--    INDEX `owner_index` (`owner`)

) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `pins` (`pinID`, `owner`, `title`, `description`, `numberComments`, `numberReacts`) VALUES
    ('P001', 'U001', 'Pikachu', 'my favorite pokemon', 2, 1),
    ('P002', 'U001', 'Celebi', 'Celebi is small, angular Pokemon with short arms and stubby rounded feet', 1, 1),
    ('P003', 'U002', 'waifu', 'ma petite waifu', 0, 1);

DROP TABLE IF EXISTS `pictures`;

CREATE TABLE `pictures` (
    `pictureID` VARCHAR(10) NOT NULL,
    `pinID` VARCHAR(10) NOT NULL,
    `url` VARCHAR(50) NOT NULL,

    PRIMARY KEY `pictureID` (`pictureID`),
    KEY `pinID` (`pinID`),

    CONSTRAINT `pictures_pinID_fk` FOREIGN KEY (`pinID`) REFERENCES `pins` (`pinID`)

--    INDEX `pinID_index` (`pinID`)

) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `pictures` (`pictureID`, `pinID`, `url`) VALUES
    ('PC001', 'P001', 'https://pinterestclone.com/pic1.png'),
    ('PC002', 'P001', 'https://pinterestclone.com/pic2.png'),
    ('PC003', 'P002', 'https://pinterestclone.com/pic3.png'),
    ('PC004', 'P003', 'https://pinterestclone.com/pic4.png');

DROP TABLE IF EXISTS `boards`;

CREATE TABLE `boards` (
    `boardID` VARCHAR(10) NOT NULL,
    `owner` VARCHAR(10) NOT NULL,
    `title` VARCHAR(50) NOT NULL,
    `visibility` VARCHAR(7) NOT NULL,

    PRIMARY KEY `boardID` (`boardID`),
    KEY `owner` (`owner`),

    CONSTRAINT `board_owner_fk` FOREIGN KEY (`owner`) REFERENCES `users` (`userID`)

--    INDEX `owner_index` (`owner`)

) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `boards` (`boardID`, `owner`, `title`, `visibility`) VALUES
    ('B001', 'U001', 'pokemons collection','public'),
    ('B002', 'U002', 'waifu collection', 'private');

DROP TABLE IF EXISTS `belongsToBoard`;

CREATE TABLE `belongsToBoard` (
    `pinID` VARCHAR(10) NOT NULL,
    `boardID` VARCHAR(10) NOT NULL,

    PRIMARY KEY `ID` (`pinID`,`boardID`),
    KEY `pinID` (`pinID`),
    KEY `boardID` (`boardID`),

    CONSTRAINT `bltb_pinID_fk` FOREIGN KEY (`pinID`) REFERENCES `pins` (`pinID`),
    CONSTRAINT `bltb_boardID_fk` FOREIGN KEY (`boardID`) REFERENCES `boards` (`boardID`)

--    INDEX `pinID_index` (`pinID`),
--    INDEX `boardID_index` (`boardID`)

) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `belongsToBoard` (`pinID`, `boardID`) VALUES
    ('P001', 'B001'),
    ('P002', 'B001'),
    ('P003', 'B002');

DROP TABLE IF EXISTS `followers`;

CREATE TABLE `followers` (
     `followeeID` VARCHAR(10) NOT NULL,
     `followerID` VARCHAR(10) NOT NULL,

    PRIMARY KEY `ID` (`followerID`, `followeeID`),
     KEY `followeeID` (`followeeID`),
     KEY `followerID` (`followerID`),

     CONSTRAINT `followeeID_fk` FOREIGN KEY (`followeeID`) REFERENCES `users` (`userID`),
     CONSTRAINT `followerID_fk` FOREIGN KEY (`followerID`) REFERENCES `users` (`userID`)

--     INDEX `followeeID_index` (`followeeID`),
--     INDEX `followerID_index` (`followerID`)

) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `followers` (`followeeID`, `followerID`) VALUES
    ('U002', 'U001'),
    ('U001', 'U002'),
    ('U003', 'U001');

DROP TABLE IF EXISTS `collaborators`;

CREATE TABLE `collaborators` (
     `boardID` VARCHAR(10) NOT NULL,
     `userID` VARCHAR(10) NOT NULL,

     PRIMARY KEY `ID` (`boardID`,`userID`),
     KEY `boardID` (`boardID`),
     KEY `userID` (`userID`),

     CONSTRAINT `collab_boardID_fk` FOREIGN KEY (`boardID`) REFERENCES `boards` (`boardID`),
     CONSTRAINT `collab_userID_fk` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`)

--     INDEX `boardID_index` (`boardID`),
--     INDEX `userID_index` (`userID`)

) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `collaborators` (`boardID`, `userID`) VALUES
    ('B001', 'U002'),
    ('B002', 'U003');

DROP TABLE IF EXISTS `reacts`;

CREATE TABLE `reacts` (
      `pinID` VARCHAR(10) NOT NULL,
      `userID` VARCHAR(10) NOT NULL,

      PRIMARY KEY `ID` (`pinID`, `userID`),
      KEY `pinID` (`pinID`),
      KEY `userID` (`userID`),

      CONSTRAINT `react_pinID_fk` FOREIGN KEY (`pinID`) REFERENCES `pins` (`pinID`),
      CONSTRAINT `react_userID_fk` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`)

--      INDEX `pinID_index` (`pinID`),
--      INDEX `userID_index` (`userID`)

) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `reacts` (`pinID`, `userID`) VALUES
    ('P001', 'U002'),
    ('P001', 'U003'),
    ('P002', 'U003');

DROP TABLE IF EXISTS `comments`;

CREATE TABLE `comments` (
    `commentID` VARCHAR(10) NOT NULL,
    `pinID` VARCHAR(10) NOT NULL,
    `userID` VARCHAR(10) NOT NULL,
    `timeStamp` TIMESTAMP DEFAULT NOW(),
    `description` TEXT NOT NULL,

    PRIMARY KEY `commentID` (`commentID`),
    KEY `pinID` (`pinID`),
    KEY `userID` (`userID`),

    CONSTRAINT `cmt_pinID_fk` FOREIGN KEY (`pinID`) REFERENCES `pins` (`pinID`),
    CONSTRAINT `cmt_userID_fk` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`),

    INDEX `pinID_and_userID_index` (`pinID`, `userID`)

--    INDEX `pinID_index` (`pinID`),
--    INDEX `userID_index` (`userID`)

) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `comments` (`commentID`, `pinID`, `userID`, `timeStamp`, `description`) VALUES
    ('C001', 'P001', 'U002', '2022-06-06 23:00:00', 'This pokemon is so cute.'),
    ('C002', 'P002', 'U003', '2022-06-06 22:00:00', 'I saw it in the movie last week.'),
    ('C003', 'P003', 'U002', '2022-06-06 21:00:00', 'She is my waifu also.');