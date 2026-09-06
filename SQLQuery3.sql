
CREATE TABLE [User]
(
    User_id INT PRIMARY KEY,
    F_name VARCHAR(50) NOT NULL,
    L_name VARCHAR(50) NOT NULL,
    Registration_date DATE,
    Role VARCHAR(20),
    Password VARCHAR(255) NOT NULL,
    City VARCHAR(50),
    State VARCHAR(50),
    Country VARCHAR(50),
    Age INT CHECK (Age >= 0)
);

CREATE TABLE User_ph
(
    User_id INT,
    Phone VARCHAR(20),

    PRIMARY KEY (User_id, Phone),

    FOREIGN KEY (User_id) REFERENCES [User](User_id)
);

CREATE TABLE User_Em
(
    User_id INT,
    Email VARCHAR(100) UNIQUE CHECK (Email LIKE '%@%.%'),

    PRIMARY KEY (User_id, Email),

    FOREIGN KEY (User_id) REFERENCES [User](User_id)
);

CREATE TABLE Competition
(
    Competition_id INT PRIMARY KEY,
    Title VARCHAR(100) NOT NULL,
    Status VARCHAR(20),
    Description VARCHAR(500),
    Start_date DATE NOT NULL,
    End_date DATE NOT NULL,
    Prize_pool DECIMAL(10,2),
    Competition_type VARCHAR(50),
    User_id INT,

    FOREIGN KEY (User_id) REFERENCES [User](User_id),

    CHECK (End_date > Start_date)
);

CREATE TABLE Competition_Tag
(
    Competition_id INT,
    Tags VARCHAR(100),

    PRIMARY KEY (Competition_id, Tags),

    FOREIGN KEY (Competition_id) REFERENCES Competition(Competition_id)
);

CREATE TABLE Participate
(
    User_id INT,
    Competition_id INT,
    Join_date DATE,

    PRIMARY KEY (User_id, Competition_id),

    FOREIGN KEY (User_id) REFERENCES [User](User_id),

    FOREIGN KEY (Competition_id) REFERENCES Competition(Competition_id)
);

CREATE TABLE Participation
(
    Participation_id INT PRIMARY KEY,
    Participation_status VARCHAR(30),
    Join_date DATE,
    User_id INT,
    Competition_id INT,

    FOREIGN KEY (User_id) REFERENCES [User](User_id),

    FOREIGN KEY (Competition_id) REFERENCES Competition(Competition_id)
);

CREATE TABLE Submission
(
    Submission_id INT PRIMARY KEY,
    Title VARCHAR(100) NOT NULL,
    Content VARCHAR(MAX),
    Subm_date DATE,
    Content_url VARCHAR(300),
    Description VARCHAR(500),
    File_type VARCHAR(20),
    Score DECIMAL(5,2),
    Device_ip VARCHAR(50),
    User_id INT,
    Competition_id INT,

    FOREIGN KEY (User_id) REFERENCES [User](User_id),

    FOREIGN KEY (Competition_id) REFERENCES Competition(Competition_id)
);

CREATE TABLE Submission_Medies
(
    Submission_id INT,
    Media_links VARCHAR(300),

    PRIMARY KEY (Submission_id, Media_links),

    FOREIGN KEY (Submission_id) REFERENCES Submission(Submission_id)
);

CREATE TABLE Result
(
    Result_id INT PRIMARY KEY,
    [Rank] INT CHECK ([Rank] > 0),
    Result_date DATE,
    Submission_id INT,
    Competition_id INT,

    FOREIGN KEY (Submission_id) REFERENCES Submission(Submission_id),

    FOREIGN KEY (Competition_id) REFERENCES Competition(Competition_id)
);

CREATE TABLE Vote
(
    Voteid_id INT PRIMARY KEY,
    Voted_date DATE,
    Voted_value INT CHECK (Voted_value BETWEEN 1 AND 5),
    Device_ip VARCHAR(50),
    User_id INT,
    Submission_id INT,

    UNIQUE(User_id, Submission_id),

    FOREIGN KEY (User_id) REFERENCES [User](User_id),

    FOREIGN KEY (Submission_id) REFERENCES Submission(Submission_id)
);

CREATE TABLE Payment
(
    Payment_id INT PRIMARY KEY,
    Payment_date DATE,
    Amount DECIMAL(10,2) CHECK (Amount > 0),
    Payment_method VARCHAR(50),
    Payment_status VARCHAR(20),
    Transaction_reference VARCHAR(100) UNIQUE,
    User_id INT,

    FOREIGN KEY (User_id) REFERENCES [User](User_id)
);

CREATE TABLE Notification
(
    Notification_id INT PRIMARY KEY,
    Message VARCHAR(500) NOT NULL,
    Status VARCHAR(20),
    Notification_date DATE,
    Notification_type VARCHAR(50),
    User_id INT,

    FOREIGN KEY (User_id) REFERENCES [User](User_id)
);


INSERT INTO [User]
VALUES
(1, 'Mohamed', 'Hany', '2026-01-01', 'participant', 'pass1', 'Cairo', 'Cairo', 'Egypt', 22),
(2, 'Mahmoud', 'Hamdy', '2026-01-03', 'judge', 'pass2', 'Giza', 'Giza', 'Egypt', 24),
(3, 'Mohamed', 'Tag', '2026-01-05', 'participant', 'pass3', 'Alex', 'Alex', 'Egypt', 21);

INSERT INTO User_ph
VALUES
(1, '01095342259'),
(2, '01022222222'),
(3, '01033333333');

INSERT INTO User_Em
VALUES
(1, 'mohamedHany@mail.com'),
(2, 'mahmoud@mail.com'),
(3, 'mohamedtag@mail.com');

INSERT INTO Competition
VALUES
(101, 'Photo Challenge', 'upcoming', 'Photography Competition', '2026-06-01', '2026-06-30', 5000, 'Photography', 1),
(102, 'Coding Hackathon', 'active', 'Programming Event', '2026-05-01', '2026-05-31', 10000, 'Programming', 2),
(103, 'Design Sprint', 'closed', 'UI UX Competition', '2026-04-01', '2026-04-20', 3000, 'Design', 3);

INSERT INTO Competition_Tag
VALUES
(101, 'photo'),
(102, 'coding'),
(103, 'design');

INSERT INTO Participate
VALUES
(1, 101, '2026-05-01'),
(2, 102, '2026-04-20'),
(3, 103, '2026-03-25');

INSERT INTO Participation
VALUES
(1, 'active', '2026-05-01', 1, 101),
(2, 'active', '2026-04-20', 2, 102),
(3, 'withdrawn', '2026-03-25', 3, 103);

INSERT INTO Submission
VALUES
(501, 'Golden Sunrise', 'Nature Photo', '2026-06-10', 'https://files.com/photo1.jpg', 'Nature Photography', 'jpg', 88.5, '192.168.1.1', 1, 101),
(502, 'AI Chat Bot', 'AI Project', '2026-05-15', 'https://files.com/project.zip', 'Artificial Intelligence', 'zip', 95, '192.168.1.2', 2, 102),
(503, 'Modern Dashboard', 'Dashboard UI', '2026-04-10', 'https://files.com/design.pdf', 'UI UX Design', 'pdf', 90, '192.168.1.3', 3, 103);

INSERT INTO Submission_Medies
VALUES
(501, 'https://instagram.com/post1'),
(502, 'https://github.com/project'),
(503, 'https://behance.net/project');

INSERT INTO Result
VALUES
(201, 1, '2026-06-21', 501, 101),
(202, 1, '2026-05-31', 502, 102),
(203, 2, '2026-04-21', 503, 103);

INSERT INTO Vote
VALUES
(1001, '2026-06-11', 5, '192.168.10.1', 2, 501),
(1002, '2026-06-12', 4, '192.168.10.2', 3, 501),
(1003, '2026-05-16', 5, '192.168.10.3', 1, 502);

INSERT INTO Payment
VALUES
(301, '2026-05-25', 5000, 'Credit Card', 'completed', 'TXN-001', 1),
(302, '2026-04-15', 10000, 'Bank Transfer', 'completed', 'TXN-002', 2),
(303, '2026-03-20', 3000, 'PayPal', 'pending', 'TXN-003', 3);

INSERT INTO Notification
VALUES
(401, 'Submission received', 'read', '2026-06-10', 'submission', 1),
(402, 'Assigned as judge', 'unread', '2026-04-19', 'system', 2),
(403, 'Rank published', 'unread', '2026-04-21', 'result', 3);


UPDATE Submission
SET Score = 0
WHERE Score IS NULL;

UPDATE Submission
SET Score = Score * 1.05
WHERE Competition_id = 101;

UPDATE Notification
SET Status = 'unread'
WHERE Status IS NULL;


DELETE FROM Participation
WHERE Participation_status = 'withdrawn';


DELETE FROM Vote
WHERE Submission_id IN (SELECT Submission_id FROM Submission WHERE Score = 0);

DELETE FROM Result
WHERE Submission_id IN (SELECT Submission_id FROM Submission WHERE Score = 0);

DELETE FROM Submission_Medies
WHERE Submission_id IN (SELECT Submission_id FROM Submission WHERE Score = 0);

DELETE FROM Submission
WHERE Score = 0;

SELECT * FROM [User];

SELECT * FROM Competition
WHERE Status = 'active';

SELECT F_name, L_name, Age, Country
FROM [User]
ORDER BY L_name ASC;

SELECT Title, Prize_pool
FROM Competition
ORDER BY Prize_pool DESC;

SELECT Title, Score
FROM Submission
ORDER BY Score DESC;


SELECT * FROM Competition
WHERE Title LIKE 'C%';

SELECT * FROM [User]
WHERE F_name LIKE '_h%';

SELECT DISTINCT City
FROM [User]
WHERE City LIKE '%a%';


SELECT COUNT(*) AS Total_users FROM [User];

SELECT COUNT(*) AS Active_competitions
FROM Competition
WHERE Status = 'active';

SELECT SUM(Prize_pool) AS Total_prizes FROM Competition;

SELECT AVG(Score) AS Avg_score FROM Submission;

SELECT MAX(Score) AS Highest_score,
       MIN(Score) AS Lowest_score
FROM Submission;


SELECT Competition_id, COUNT(*) AS Total_submissions
FROM Submission
GROUP BY Competition_id;

SELECT Country, COUNT(*) AS Users_count
FROM [User]
GROUP BY Country;

SELECT Competition_id, COUNT(*) AS Total_submissions
FROM Submission
GROUP BY Competition_id
HAVING COUNT(*) > 1;


SELECT Title, Score
FROM Submission
WHERE Score > (SELECT AVG(Score) FROM Submission);

SELECT U.F_name, U.L_name
FROM [User] U
WHERE U.User_id NOT IN
(
    SELECT N.User_id
    FROM Notification N
);

SELECT Title FROM Competition
WHERE Competition_id NOT IN
(
    SELECT Competition_id FROM Result
);

SELECT F_name, L_name FROM [User] U
WHERE EXISTS
(
    SELECT * FROM Vote V
    WHERE V.User_id = U.User_id
);


SELECT U.F_name, U.L_name, S.Title, S.Score FROM [User] U
INNER JOIN Submission S
    ON U.User_id = S.User_id;

SELECT C.Title AS Competition, S.Title AS Submission, S.Score
FROM Competition C
INNER JOIN Submission S
    ON C.Competition_id = S.Competition_id;

SELECT U.F_name, U.L_name, S.Title
FROM [User] U
LEFT JOIN Submission S
    ON U.User_id = S.User_id;

SELECT S.Title, V.Voted_value
FROM Vote V
RIGHT JOIN Submission S
    ON V.Submission_id = S.Submission_id;


SELECT User_id
FROM Participation
UNION
SELECT User_id
FROM Submission;

SELECT User_id, 'participant' AS Activity
FROM Participation
UNION ALL
SELECT User_id, 'submitter'
FROM Submission
UNION ALL
SELECT User_id, 'voter' FROM Vote;

SELECT User_id
FROM Participation
INTERSECT
SELECT User_id
FROM Submission;

SELECT User_id
FROM [User]
EXCEPT
SELECT User_id
FROM Notification;


SELECT DISTINCT City
FROM [User];

SELECT DISTINCT File_type
FROM Submission;