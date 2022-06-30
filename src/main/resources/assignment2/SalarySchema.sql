CREATE DATABASE IF NOT EXISTS `employeesSalaryManagement`;

USE `employeesSalaryManagement`;

-- DROP DATABASE IF EXISTS `employeesSalaryManagement`;

DROP TABLE IF EXISTS `departments`;

CREATE TABLE `departments`(
    `departmentCode` VARCHAR(10) NOT NULL,
    `fullName` VARCHAR(50) NOT NULL,

    PRIMARY KEY `departmentCode` (`departmentCode`)

) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `departments` (`departmentCode`, `fullName`) VALUES
    ('PGE', 'Payment Growth Enablement'),
    ('PCT', 'Payment Consumer Technology');

DROP TABLE IF EXISTS `jobs`;

CREATE TABLE `jobs`(
   `jobTitleID` VARCHAR(10) NOT NULL,
   `jobTitle` VARCHAR(50) NOT NULL,
   `jobSalary` INT UNSIGNED,

  PRIMARY KEY `jobTitleID` (`jobTitleID`)

) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `jobs` (`jobTitleID`, `jobTitle`, `jobSalary`) VALUES
    ('SDF', 'Software Development Fresher', 15000000),
    ('ASE', 'Associate Software Engineer', 16000000),
    ('SWE', 'Software Engineer', 25000000),
    ('SEM', 'Software Engineer Manager', 99000000);

DROP TABLE IF EXISTS `employees`;

CREATE TABLE `employees` (
    `employeeID` VARCHAR(10) NOT NULL,
    `firstName` VARCHAR(50) NOT NULL,
    `lastName` VARCHAR(50) NOT NULL,
    `email` VARCHAR(50) NOT NULL,
    `departmentCode` VARCHAR(10) NOT NULL,
    `reportsTo` VARCHAR(10) DEFAULT NULL,
    `jobTitleID` VARCHAR(10) NOT NULL,

    PRIMARY KEY (`employeeID`),
    KEY `departmentCode` (`departmentCode`),
    KEY `reportsTo` (`reportsTo`),
    KEY `jobTitleID` (`jobTitleID`),

    CONSTRAINT `employees_reportsTo_fk`FOREIGN KEY (`reportsTo`) REFERENCES `employees` (`employeeID`),
    CONSTRAINT `employees_departmentCode_fk`FOREIGN KEY (`departmentCode`) REFERENCES `departments` (`departmentCode`),
    CONSTRAINT `employees_jobTitle_fk`FOREIGN KEY (`jobTitleID`) REFERENCES `jobs` (`jobTitleID`)

--    INDEX `departmentCode_index` (`departmentCode`),
--    INDEX `reportsTo_index` (`reportsTo`),
--    INDEX `jobTitleID_index` (`jobTitleID`)

) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `employees` (`employeeID`, `firstName`, `lastName`, `email`, `departmentCode`, `reportsTo`, `jobTitleID`) VALUES
    ('ZN00100', 'Huy', 'Vo Huynh Anh', 'huyvha@vng.com.vn', 'PGE', NULL, 'SEM'),
    ('ZN00974', 'Nhu', 'Tran Nguyen Hue', 'nhutnh3@vng.com.vn', 'PGE', 'ZN00100', 'SDF'),
    ('ZN00975', 'An', 'Nguyen Van', 'vunvx@vng.com.vn', 'PCT', NULL,'SWE');


DROP TABLE IF EXISTS `furloughs`;

CREATE TABLE `furloughs` (
    `furloughID` VARCHAR(20) NOT NULL,
    `employeeID` VARCHAR(10) NOT NULL,
    `description` TEXT DEFAULT NULL,
    `startDate` DATE NOT NULL,
    `endDate` DATE NOT NULL,

    PRIMARY KEY `furloughID` (furloughID),
    KEY `employeeID` (`employeeID`),

    CONSTRAINT `furloughs_fk_1` FOREIGN KEY (`employeeID`) REFERENCES `employees` (`employeeID`)

--    INDEX `employeeID_index` (`employeeID`)

) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `furloughs` (`furloughID`, `employeeID`, `description`, `startDate`, `endDate`) VALUES
    ('OFF0001', 'ZN00974', 'get sick', '2022-06-20', '2022-06-25');

DROP TABLE IF EXISTS `payrollTransactions`;

CREATE TABLE `payrollTransactions` (
    `transactionID` VARCHAR(10) NOT NULL,
    `employeeID` VARCHAR(10) NOT NULL,
    `amount` INT UNSIGNED NOT NULL,
    `month` INT UNSIGNED NOT NULL,
    `year` INT UNSIGNED NOT NULL,
    `logDate` DATE NOT NULL,

    PRIMARY KEY `transactionID` (`transactionID`),
    KEY `employeeID` (`employeeID`),

    CONSTRAINT `trans_employeeID` FOREIGN KEY (`employeeID`) REFERENCES `employees` (`employeeID`),

--    INDEX `employeeID_index` (`employeeID`),
    INDEX `timestamp_index` (`month`, `year`)

) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `payrollTransactions` (`transactionID`, `employeeID`, `amount`, `month`, `year`, `logDate`) VALUES
    ('T001', 'ZN00100', 99000000, 6, 2022, '2022-06-30'),
    ('T002', 'ZN00974', 15000000, 6, 2022, '2022-06-30'),
    ('T003', 'ZN00975', 25000000, 6, 2022, '2022-06-30');
