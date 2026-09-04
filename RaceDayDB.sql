USE RaceDayDB;
GO

-- ===================================================================
-- Drop existing tables (if any exist to prevent duplicates and errors
-- ===================================================================
DROP TABLE IF EXISTS RaceSponsor;
DROP TABLE IF EXISTS Sponsor;
DROP TABLE IF EXISTS Result;
DROP TABLE IF EXISTS Registration;
DROP TABLE IF EXISTS Race;
DROP TABLE IF EXISTS Runner;
DROP TABLE IF EXISTS Organizer;
GO

CREATE TABLE Organizer (
    OrgID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    ContactInfo VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL
);

CREATE TABLE Runner (
    RunnerID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Age INT CHECK (Age > 0),
    Gender VARCHAR(10),
    ContactInfo VARCHAR(100)
);

CREATE TABLE Race (
    RaceID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Date DATE NOT NULL,
    Location VARCHAR(100),
    Distance DECIMAL(5,2),
    OrgID INT NOT NULL,
    FOREIGN KEY (OrgID) REFERENCES Organizer(OrgID)
);

CREATE TABLE Registration (
    RegID INT IDENTITY(1,1) PRIMARY KEY,
    RunnerID INT NOT NULL,
    RaceID INT NOT NULL,
    PaymentStatus VARCHAR(20) DEFAULT 'Pending',
    FOREIGN KEY (RunnerID) REFERENCES Runner(RunnerID),
    FOREIGN KEY (RaceID) REFERENCES Race(RaceID)
);

CREATE TABLE Result (
    ResultID INT IDENTITY(1,1) PRIMARY KEY,
    RunnerID INT NOT NULL,
    RaceID INT NOT NULL,
    FinishTime TIME,
    Position INT,
    FOREIGN KEY (RunnerID) REFERENCES Runner(RunnerID),
    FOREIGN KEY (RaceID) REFERENCES Race(RaceID)
);

CREATE TABLE Sponsor (
    SponsorID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL
);

CREATE TABLE RaceSponsor (
    RaceSponsorID INT IDENTITY(1,1) PRIMARY KEY,
    RaceID INT NOT NULL,
    SponsorID INT NOT NULL,
    SponsorshipAmount DECIMAL(10,2),
    FOREIGN KEY (RaceID) REFERENCES Race(RaceID),
    FOREIGN KEY (SponsorID) REFERENCES Sponsor(SponsorID)
);

INSERT INTO Organizer (Name, ContactInfo, Email)
VALUES ('Speed Events SA', 'speed@events.co.za', 'contact@speed.co.za'),
       ('Marathon Masters', 'info@mm.co.za', 'support@mm.co.za');

INSERT INTO Runner (Name, Age, Gender, ContactInfo)
VALUES ('Preston M', 20, 'Male', 'preston@mail.com'),
       ('Lerato N', 23, 'Female', 'lerato@mail.com');

INSERT INTO Race (Name, Date, Location, Distance, OrgID)
VALUES ('Pretoria Fun Run', '2026-09-15', 'Pretoria', 5.00, 1),
       ('Gauteng Marathon', '2026-10-01', 'Johannesburg', 42.20, 2),
       ('Spring Sprint', '2026-11-10', 'Centurion', 10.00, 1);

INSERT INTO Registration (RunnerID, RaceID, PaymentStatus)
VALUES (1, 1, 'Paid'),
       (2, 2, 'Pending');

INSERT INTO Result (RunnerID, RaceID, FinishTime, Position)
VALUES (1, 1, '00:25:30', 1),
       (2, 2, '03:45:10', 5);

INSERT INTO Sponsor (Name, Email)
VALUES ('Nike SA', 'nike@sa.com'),
       ('Coca-Cola', 'coke@za.com');

INSERT INTO RaceSponsor (RaceID, SponsorID, SponsorshipAmount)
VALUES (1, 1, 50000.00),
       (2, 2, 30000.00);

SELECT * FROM Organizer;
SELECT * FROM Runner;
SELECT * FROM Race;
SELECT * FROM Registration;
SELECT * FROM Result;
SELECT * FROM Sponsor;
SELECT * FROM RaceSponsor;



