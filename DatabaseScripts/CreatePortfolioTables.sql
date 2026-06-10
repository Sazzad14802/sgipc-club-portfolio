IF DB_ID('sgipcdb') IS NULL
BEGIN
    CREATE DATABASE sgipcdb;
END;
GO

USE [sgipcdb];
GO

IF OBJECT_ID('dbo.Snapshot', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Snapshot
    (
        SnapshotId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        MetricValue NVARCHAR(80) NOT NULL,
        Description NVARCHAR(300) NOT NULL,
        DisplayOrder INT NOT NULL CONSTRAINT DF_Snapshot_DisplayOrder DEFAULT (0),
        CreatedAt DATETIME2 NOT NULL CONSTRAINT DF_Snapshot_CreatedAt DEFAULT (SYSUTCDATETIME())
    );
END;
GO

IF OBJECT_ID('dbo.Achievements', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Achievements
    (
        AchievementId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        Title NVARCHAR(160) NOT NULL,
        Description NVARCHAR(800) NOT NULL,
        DisplayOrder INT NOT NULL CONSTRAINT DF_Achievements_DisplayOrder DEFAULT (0),
        CreatedAt DATETIME2 NOT NULL CONSTRAINT DF_Achievements_CreatedAt DEFAULT (SYSUTCDATETIME())
    );
END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.Snapshot)
BEGIN
    INSERT INTO dbo.Snapshot (MetricValue, Description, DisplayOrder)
    VALUES
        (N'120+', N'Active members across beginner to advanced ladders', 1),
        (N'2x / Week', N'Live training sessions and upsolving labs', 2),
        (N'20', N'Members with 1600+ rating on online judges', 3);
END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.Achievements)
BEGIN
    INSERT INTO dbo.Achievements (Title, Description, DisplayOrder)
    VALUES
        (N'ICPC World Finalists 2024', N'A team from KUET reached the ICPC World Finals for the first time in 2024, marking a historic milestone for the university, setting a new benchmark for excellence within our club and inspiring future competitors.', 1),
        (N'Asia West Finalists 2026', N'Eight teams from KUET participated in the ICPC Dhaka Regional 2026. One team secured a top 20 position overall, became the Khulna divisional champion, and qualified for the ICPC Asia West Finals, marking another significant milestone for the club.', 2),
        (N'BUET IUPC 2026 - 4th Place', N'A team from KUET secured 4th place at the BUET Inter University Programming Contest (IUPC) 2026, demonstrating exceptional problem-solving skills and competitive excellence among top universities.', 3);
END;
GO

IF OBJECT_ID('dbo.ContactMessages', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.ContactMessages
    (
        ContactMessageId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        Name NVARCHAR(100) NOT NULL,
        Email NVARCHAR(150) NOT NULL,
        Subject NVARCHAR(200) NOT NULL,
        Message NVARCHAR(MAX) NOT NULL,
        CreatedAt DATETIME2 NOT NULL CONSTRAINT DF_ContactMessages_CreatedAt DEFAULT (SYSUTCDATETIME())
    );
END;
GO

IF OBJECT_ID('dbo.Events', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Events
    (
        EventId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        Title NVARCHAR(160) NOT NULL,
        Description NVARCHAR(800) NOT NULL,
        ImageUrl NVARCHAR(500) NULL,
        DisplayOrder INT NOT NULL CONSTRAINT DF_Events_DisplayOrder DEFAULT (0),
        CreatedAt DATETIME2 NOT NULL CONSTRAINT DF_Events_CreatedAt DEFAULT (SYSUTCDATETIME())
    );
END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.Events)
BEGIN
    INSERT INTO dbo.Events (Title, Description, ImageUrl, DisplayOrder)
    VALUES
        (N'KUET IUPC 2025', N'A grand national level programming contest hosted by KUET, bringing together the brightest minds from universities across the country.', N'Assets/kuetiupc.jpg', 1),
        (N'Intra-KUET Programming Contest', N'An exclusive competitive programming event for KUET students to showcase their algorithmic skills and compete for top honors within the university.', N'Assets/intrakuet.jpg', 2);
END;
GO
