# Milestone 3 - NBA Database
# CPSC 3300
# Ajani, Cole, Victor
# 5/28/25
# Complete NBA Playoff Database - May 2025 Data


# User Table w/Default Profile Picture 
CREATE TABLE User(
    UID char(9) PRIMARY KEY NOT NULL,
    F_Name varchar(15) NOT NULL,
    L_Name varchar(15) NOT NULL,
    Username varchar(20) NOT NULL,
    Email varchar(50) NOT NULL,
    Phone_Number varchar(20) NOT NULL,
    ProfileURL varchar(400) DEFAULT('https://e7.pngegg.com/pngimages/753/432/png-clipart-user-profile-2018-in-sight-user-conference-expo-business-default-business-angle-service.png')
);

# Team Table
CREATE TABLE Team(
    Team_ID char(9) PRIMARY KEY NOT NULL,
    Team_Name varchar(50) NOT NULL,
    Coach_FName varchar(15) NOT NULL,
    Coach_LName varchar(15) NOT NULL,
    Location varchar(15) NOT NULL,
    Win int NOT NULL,
    Lose int NOT NULL,
    LogoURL varchar(400)
);

# Player Table
CREATE TABLE Player(
    Player_ID char(9) PRIMARY KEY NOT NULL,
    F_Name varchar(40) NOT NULL,
    L_Name varchar(40) NOT NULL,
    Age char(2) NOT NULL,
    Year char(2) NOT NULL,
    Position char(2) NOT NULL,
    Points int NOT NULL,
    Rebounds int NOT NULL,
    Assists int NOT NULL,
    PlayerURL varchar(400),
    Team_ID char(9) NOT NULL,
    FOREIGN KEY (Team_ID) REFERENCES Team(Team_ID) ON UPDATE CASCADE
);

# Game Table
CREATE TABLE Game(
    Game_ID char(9) PRIMARY KEY NOT NULL,
    Home_Score varchar(3),
    Away_Score varchar(3),
    Game_Time time NOT NULL,
    Game_Date date NOT NULL, 
    Location varchar(15),
    Ticket int NOT NULL,
    Home_Team char(9) NOT NULL,
    Away_Team char(9) NOT NULL,
    FOREIGN KEY (Home_Team) REFERENCES Team(Team_ID) ON UPDATE CASCADE,
    FOREIGN KEY (Away_Team) REFERENCES Team(Team_ID) ON UPDATE CASCADE
);

# Media Table
CREATE TABLE Media(
    Media_ID char(9) PRIMARY KEY NOT NULL,
    UID char(9) NOT NULL,
    Team_ID char(9) NOT NULL,
    Media_Type varchar(12),
    Description varchar(100),
    MediaURL varchar(400),
    Like_Counter int NOT NULL,
    FOREIGN KEY (UID) REFERENCES User(UID) ON UPDATE CASCADE,
    FOREIGN KEY (Team_ID) REFERENCES Team(Team_ID) ON UPDATE CASCADE
);

# Comment Table
CREATE TABLE Comment(
    Comment_ID char(9) PRIMARY KEY NOT NULL,
    UID char(9) NOT NULL,
    Media_ID char(9) NOT NULL,
    Post_Time date NOT NULL,
    Comment varchar(100) NOT NULL,
    FOREIGN KEY (UID) REFERENCES User(UID) ON UPDATE CASCADE,
    FOREIGN KEY (Media_ID) REFERENCES Media(Media_ID) ON UPDATE CASCADE
);

# MVP_Pick Table
CREATE TABLE MVP_Pick(
    MVP_ID char(9) PRIMARY KEY NOT NULL,
    Season year NOT NULL,
    Rank_Num char(1) NOT NULL,
    Player_ID char(9) NOT NULL,
    FOREIGN KEY (Player_ID) REFERENCES Player(Player_ID) ON UPDATE CASCADE
);

# TeamGameLog Table
CREATE TABLE TeamGameLog(
    TeamID char(9) NOT NULL,
    GameID char(9) NOT NULL,
    Points int,
    Rebounds int, 
    Assists int, 
    Blocks int, 
    Steals int,
    ThreePtrs int,
    FreeThrow int,
    PRIMARY KEY (TeamID, GameID),
    FOREIGN KEY (TeamID) REFERENCES Team(Team_ID) ON UPDATE CASCADE,
    FOREIGN KEY (GameID) REFERENCES Game(Game_ID) ON UPDATE CASCADE
);

# PlayerGameLog Table
CREATE TABLE PlayerGameLog(
    PlayerID char(9) NOT NULL,
    GameID char(9) NOT NULL,
    Points int,
    Rebounds int, 
    Assists int, 
    Blocks int, 
    Steals int,
    ThreePtrs int,
    FreeThrow int,
    PRIMARY KEY (PlayerID, GameID),
    FOREIGN KEY (PlayerID) REFERENCES Player(Player_ID) ON UPDATE CASCADE,
    FOREIGN KEY (GameID) REFERENCES Game(Game_ID) ON UPDATE CASCADE
);

# Favorite Player Table
CREATE TABLE Fav_Player(
    UID char(9),
    Player_ID char(9),
    PRIMARY KEY(UID, Player_ID),
    FOREIGN KEY (UID) REFERENCES User(UID) ON UPDATE CASCADE,
    FOREIGN KEY (Player_ID) REFERENCES Player(Player_ID) ON UPDATE CASCADE
);

# Favorite Team Table
CREATE TABLE Fav_Team(
    UID char(9),
    Team_ID char(9),
    PRIMARY KEY(UID, Team_ID),
    FOREIGN KEY (UID) REFERENCES User(UID) ON UPDATE CASCADE,
    FOREIGN KEY (Team_ID) REFERENCES Team(Team_ID) ON UPDATE CASCADE
);

# 1. Insert Users (random generated users)
INSERT INTO User (UID, F_Name, L_Name, Username, Email, Phone_Number) VALUES
('000000001', 'Ryan', 'Wilson', 'DunkMaster', 'ryan.wilson@gmail.com', '555-111-2222'),
('000000002', 'Nicole', 'Taylor', 'ThreePointQueen', 'nicole.t@yahoo.com', '555-222-3333'),
('000000003', 'Brandon', 'Anderson', 'ClutchTime', 'b.anderson@outlook.com', '555-333-4444'),
('000000004', 'Samantha', 'Moore', 'FastBreak', 'sam.moore@email.com', '555-444-5555'),
('000000005', 'Tyler', 'Jackson', 'BenchWarmer', 'tyler.j@gmail.com', '555-555-6666'),
('000000006', 'Alex', 'Johnson', 'PlayoffFan', 'alex.j@email.com', '555-666-7777'),
('000000007', 'Jordan', 'Smith', 'BasketballFan', 'jordan.s@gmail.com', '555-777-8888');

# Insert Team data (2025 NBA Playoff Teams)
INSERT INTO Team (Team_ID, Team_Name, Coach_FName, Coach_LName, Location, Win, Lose, LogoURL) VALUES
-- Eastern Conference Playoff Teams
('000000001', 'Boston Celtics', 'Joe', 'Mazzulla', 'East', 64, 18, 'https://cdn.nba.com/logos/nba/1610612738/primary/L/logo.svg'),
('000000002', 'New York Knicks', 'Tom', 'Thibodeau', 'East', 50, 32, 'https://cdn.nba.com/logos/nba/1610612752/primary/L/logo.svg'),
('000000003', 'Milwaukee Bucks', 'Doc', 'Rivers', 'East', 49, 33, 'https://cdn.nba.com/logos/nba/1610612749/primary/L/logo.svg'),
('000000004', 'Cleveland Cavaliers', 'J.B.', 'Bickerstaff', 'East', 48, 34, 'https://cdn.nba.com/logos/nba/1610612739/primary/L/logo.svg'),
('000000005', 'Orlando Magic', 'Jamahl', 'Mosley', 'East', 47, 35, 'https://cdn.nba.com/logos/nba/1610612753/primary/L/logo.svg'),
('000000006', 'Indiana Pacers', 'Rick', 'Carlisle', 'East', 47, 35, 'https://cdn.nba.com/logos/nba/1610612754/primary/L/logo.svg'),
('000000007', 'Miami Heat', 'Erik', 'Spoelstra', 'East', 46, 36, 'https://cdn.nba.com/logos/nba/1610612748/primary/L/logo.svg'),
('000000008', 'Detroit Pistons', 'Monty', 'Williams', 'East', 43, 39, 'https://cdn.nba.com/logos/nba/1610612765/primary/L/logo.svg'),
-- Western Conference Playoff Teams  
('000000009', 'Oklahoma City Thunder', 'Mark', 'Daigneault', 'West', 57, 25, 'https://cdn.nba.com/logos/nba/1610612760/primary/L/logo.svg'),
('000000010', 'Denver Nuggets', 'Michael', 'Malone', 'West', 53, 29, 'https://cdn.nba.com/logos/nba/1610612743/primary/L/logo.svg'),
('000000011', 'Minnesota Timberwolves', 'Chris', 'Finch', 'West', 50, 32, 'https://cdn.nba.com/logos/nba/1610612750/primary/L/logo.svg'),
('000000012', 'LA Clippers', 'Tyronn', 'Lue', 'West', 51, 31, 'https://cdn.nba.com/logos/nba/1610612746/primary/L/logo.svg'),
('000000013', 'Dallas Mavericks', 'Jason', 'Kidd', 'West', 50, 32, 'https://cdn.nba.com/logos/nba/1610612742/primary/L/logo.svg'),
('000000014', 'Phoenix Suns', 'Frank', 'Vogel', 'West', 49, 33, 'https://cdn.nba.com/logos/nba/1610612756/primary/L/logo.svg'),
('000000015', 'Golden State Warriors', 'Steve', 'Kerr', 'West', 46, 36, 'https://cdn.nba.com/logos/nba/1610612744/primary/L/logo.svg'),
('000000016', 'Houston Rockets', 'Ime', 'Udoka', 'West', 41, 41, 'https://cdn.nba.com/logos/nba/1610612745/primary/L/logo.svg');

# Insert Player data (Only key players in playoffs)
INSERT INTO Player (Player_ID, F_Name, L_Name, Age, Year, Position, Points, Rebounds, Assists, PlayerURL, Team_ID) VALUES
-- Oklahoma City Thunder (Conference Finals)
('000000001', 'Shai', 'Gilgeous-Alexander', '26', '06', 'PG', 31, 6, 6, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1628983.png', '000000009'),
('000000002', 'Jalen', 'Williams', '23', '03', 'SF', 19, 4, 4, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1631094.png', '000000009'),
('000000003', 'Chet', 'Holmgren', '22', '02', 'C', 16, 8, 2, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1631165.png', '000000009'),
('000000004', 'Lu', 'Dort', '25', '05', 'SG', 11, 4, 2, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1629755.png', '000000009'),
-- Minnesota Timberwolves (Conference Finals)
('000000005', 'Anthony', 'Edwards', '23', '05', 'SG', 28, 6, 5, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1630162.png', '000000011'),
('000000006', 'Julius', 'Randle', '30', '10', 'PF', 20, 7, 5, 'https://cdn.nba.com/headshots/nba/latest/1040x760/203944.png', '000000011'),
('000000007', 'Rudy', 'Gobert', '32', '13', 'C', 14, 12, 1, 'https://cdn.nba.com/headshots/nba/latest/1040x760/203497.png', '000000011'),
('000000008', 'Jaden', 'McDaniels', '24', '05', 'SF', 10, 4, 2, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1630185.png', '000000011'),
-- New York Knicks (Conference Finals)
('000000009', 'Jalen', 'Brunson', '28', '07', 'PG', 32, 4, 7, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1628973.png', '000000002'),
('000000010', 'Karl-Anthony', 'Towns', '28', '10', 'C', 25, 13, 3, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1626157.png', '000000002'),
('000000011', 'OG', 'Anunoby', '27', '08', 'SF', 14, 5, 2, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1628384.png', '000000002'),
('000000012', 'Josh', 'Hart', '29', '08', 'SG', 14, 9, 5, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1628404.png', '000000002'),
-- Indiana Pacers (Conference Finals)
('000000013', 'Tyrese', 'Haliburton', '24', '05', 'PG', 21, 4, 11, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1630173.png', '000000006'),
('000000014', 'Pascal', 'Siakam', '30', '12', 'PF', 21, 7, 4, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1627783.png', '000000006'),
('000000015', 'Bennedict', 'Mathurin', '22', '03', 'SG', 16, 6, 2, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1631104.png', '000000006'),
('000000016', 'Aaron', 'Nesmith', '25', '05', 'SF', 12, 4, 2, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1630180.png', '000000006'),
-- Boston Celtics (Eliminated)
('000000017', 'Jayson', 'Tatum', '26', '08', 'SF', 26, 8, 5, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1628369.png', '000000001'),
('000000018', 'Jaylen', 'Brown', '28', '08', 'SG', 23, 6, 4, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1627759.png', '000000001'),
('000000019', 'Kristaps', 'Porzingis', '29', '10', 'C', 20, 7, 2, 'https://cdn.nba.com/headshots/nba/latest/1040x760/204001.png', '000000001'),
('000000020', 'Derrick', 'White', '30', '08', 'PG', 16, 4, 5, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1628401.png', '000000001'),
-- Cleveland Cavaliers (Eliminated)
('000000021', 'Donovan', 'Mitchell', '28', '08', 'SG', 24, 4, 5, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1628378.png', '000000004'),
('000000022', 'Evan', 'Mobley', '23', '04', 'PF', 16, 9, 3, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1630596.png', '000000004'),
('000000023', 'Darius', 'Garland', '25', '06', 'PG', 18, 3, 7, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1629636.png', '000000004'),
('000000024', 'Jarrett', 'Allen', '26', '07', 'C', 14, 11, 3, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1628386.png', '000000004'),
-- Denver Nuggets (Eliminated)
('000000025', 'Nikola', 'Jokic', '30', '10', 'C', 29, 14, 10, 'https://cdn.nba.com/headshots/nba/latest/1040x760/203999.png', '000000010'),
('000000026', 'Jamal', 'Murray', '28', '08', 'PG', 21, 4, 6, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1627750.png', '000000010'),
('000000027', 'Michael', 'Porter Jr.', '26', '06', 'SF', 16, 7, 2, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1629718.png', '000000010'),
('000000028', 'Aaron', 'Gordon', '29', '10', 'PF', 14, 7, 3, 'https://cdn.nba.com/headshots/nba/latest/1040x760/203932.png', '000000010'),
-- Milwaukee Bucks (Eliminated)
('000000029', 'Giannis', 'Antetokounmpo', '30', '12', 'PF', 32, 11, 6, 'https://cdn.nba.com/headshots/nba/latest/1040x760/203507.png', '000000003'),
('000000030', 'Damian', 'Lillard', '34', '13', 'PG', 26, 4, 7, 'https://cdn.nba.com/headshots/nba/latest/1040x760/203081.png', '000000003'),
('000000031', 'Brook', 'Lopez', '36', '17', 'C', 12, 5, 2, 'https://cdn.nba.com/headshots/nba/latest/1040x760/201572.png', '000000003'),
('000000032', 'Bobby', 'Portis', '29', '09', 'PF', 14, 7, 2, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1626187.png', '000000003'),
-- Golden State Warriors (Eliminated)
('000000033', 'Stephen', 'Curry', '36', '15', 'PG', 27, 4, 5, 'https://cdn.nba.com/headshots/nba/latest/1040x760/201939.png', '000000015'),
('000000034', 'Klay', 'Thompson', '34', '13', 'SG', 17, 3, 2, 'https://cdn.nba.com/headshots/nba/latest/1040x760/202691.png', '000000015'),
('000000035', 'Draymond', 'Green', '34', '12', 'PF', 8, 7, 6, 'https://cdn.nba.com/headshots/nba/latest/1040x760/203110.png', '000000015'),
('000000036', 'Andrew', 'Wiggins', '29', '10', 'SF', 13, 4, 2, 'https://cdn.nba.com/headshots/nba/latest/1040x760/203952.png', '000000015'),
-- LA Clippers (Eliminated)
('000000037', 'James', 'Harden', '35', '15', 'PG', 17, 5, 8, 'https://cdn.nba.com/headshots/nba/latest/1040x760/201935.png', '000000012'),
('000000038', 'Kawhi', 'Leonard', '33', '13', 'SF', 23, 6, 4, 'https://cdn.nba.com/headshots/nba/latest/1040x760/202695.png', '000000012'),
('000000039', 'Paul', 'George', '34', '14', 'SF', 23, 5, 4, 'https://cdn.nba.com/headshots/nba/latest/1040x760/202331.png', '000000012'),
('000000040', 'Ivica', 'Zubac', '27', '08', 'C', 16, 12, 3, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1627826.png', '000000012');

# Insert Game data (May 2025 playoff games)
INSERT INTO Game (Game_ID, Home_Score, Away_Score, Game_Time, Game_Date, Location, Ticket, Home_Team, Away_Team) VALUES
-- Western Conference Finals - Thunder vs Timberwolves  
('000000001', '126', '124', '20:30:00', '2025-05-27', 'West', 19500, '000000009', '000000011'),
('000000002', '121', '112', '20:30:00', '2025-05-25', 'West', 19500, '000000009', '000000011'),
('000000003', '135', '102', '20:30:00', '2025-05-23', 'West', 18000, '000000011', '000000009'),
('000000004', '117', '110', '20:30:00', '2025-05-21', 'West', 18000, '000000011', '000000009'),
-- Eastern Conference Finals - Knicks vs Pacers
('000000005', '129', '114', '20:00:00', '2025-05-26', 'East', 18500, '000000006', '000000002'),
('000000006', '111', '106', '20:00:00', '2025-05-24', 'East', 20000, '000000002', '000000006'),
('000000007', '108', '103', '20:00:00', '2025-05-22', 'East', 18500, '000000006', '000000002'),
('000000008', '121', '117', '20:00:00', '2025-05-20', 'East', 20000, '000000002', '000000006'),
-- Conference Semifinals Games (Recently Completed)  
('000000009', '125', '93', '20:30:00', '2025-05-19', 'West', 19500, '000000009', '000000010'),
('000000010', '124', '87', '20:00:00', '2025-05-18', 'East', 19000, '000000004', '000000003'),
('000000011', '121', '110', '20:30:00', '2025-05-16', 'West', 18000, '000000011', '000000015'),
('000000012', '138', '83', '19:00:00', '2025-05-15', 'East', 19000, '000000004', '000000007'),
('000000013', '102', '97', '20:30:00', '2025-05-14', 'West', 18000, '000000011', '000000015'),
('000000014', '117', '93', '20:30:00', '2025-05-12', 'West', 18000, '000000011', '000000015');

# Insert Media data
INSERT INTO Media (Media_ID, UID, Team_ID, Media_Type, Description, MediaURL, Like_Counter) VALUES
('000000001', '000000001', '000000009', 'Video', 'Shai 40-point masterpiece in Game 4 WCF', 'https://cdn.nba.com/media/highlights/sga-40pts-wcf.mp4', 3250),
('000000002', '000000002', '000000006', 'Video', 'Haliburton historic 32/10/15 with 0 turnovers', 'https://cdn.nba.com/media/highlights/tyrese-perfect-triple.mp4', 4100),
('000000003', '000000003', '000000011', 'Video', 'Anthony Edwards 37-point explosion in Game 3', 'https://cdn.nba.com/media/highlights/ant-37-wcf.mp4', 2850),
('000000004', '000000004', '000000002', 'Image', 'MSG erupts as KAT scores 20 in 4th quarter', 'https://cdn.nba.com/media/highlights/kat-clutch-msg.jpg', 2275),
('000000005', '000000005', '000000010', 'Video', 'Jokic final playoff moment - 32/16/12 masterclass', 'https://cdn.nba.com/media/highlights/jokic-farewell.mp4', 1975);

# Insert Comment data
INSERT INTO Comment (Comment_ID, UID, Media_ID, Post_Time, Comment) VALUES
('000000001', '000000001', '000000001', '2025-05-27', 'SGA is absolutely unstoppable! Thunder bound for Finals!'),
('000000002', '000000002', '000000002', '2025-05-26', 'First player EVER with 30/15/10 and 0 turnovers in playoffs!'),
('000000003', '000000003', '000000003', '2025-05-23', 'Ant Edwards in playoff mode is different level'),
('000000004', '000000004', '000000004', '2025-05-24', 'MSG was ELECTRIC when KAT took over the 4th'),
('000000005', '000000005', '000000005', '2025-05-19', 'Jokic went out like a champion. What a performance'),
('000000006', '000000006', '000000001', '2025-05-27', 'Thunder vs Pacers Finals would be incredible'),
('000000007', '000000007', '000000002', '2025-05-26', 'Pacers are one win away from the FINALS!');

# MVP_Pick data
INSERT INTO MVP_Pick (MVP_ID, Season, Rank_Num, Player_ID) VALUES
('000000001', 2025, '1', '000000001'), -- Shai Gilgeous-Alexander wins MVP
('000000002', 2025, '2', '000000025'), -- Nikola Jokic 2nd
('000000003', 2025, '3', '000000029'), -- Giannis Antetokounmpo 3rd
('000000004', 2025, '4', '000000021'), -- Donovan Mitchell 4th  
('000000005', 2025, '5', '000000017'); -- Jayson Tatum 5th

# Insert TeamGameLog data 
INSERT INTO TeamGameLog (TeamID, GameID, Points, Rebounds, Assists, Blocks, Steals, ThreePtrs, FreeThrow) VALUES
('000000009', '000000001', 126, 43, 25, 8, 9, 18, 16),
('000000011', '000000001', 124, 41, 22, 6, 7, 15, 14),
('000000009', '000000002', 121, 45, 27, 7, 11, 16, 12),
('000000011', '000000002', 112, 42, 25, 5, 6, 13, 17),
('000000011', '000000003', 135, 52, 34, 9, 13, 20, 22),
('000000009', '000000003', 102, 38, 21, 4, 8, 10, 15),
('000000006', '000000005', 129, 48, 30, 5, 12, 19, 18),
('000000002', '000000005', 114, 38, 24, 4, 8, 12, 15),
('000000002', '000000006', 111, 44, 26, 6, 9, 14, 19),
('000000006', '000000006', 106, 40, 23, 3, 7, 11, 13),
('000000009', '000000009', 125, 46, 28, 9, 11, 17, 20),
('000000010', '000000009', 93, 35, 18, 3, 6, 8, 12);

# Insert PlayerGameLog data
INSERT INTO PlayerGameLog (PlayerID, GameID, Points, Rebounds, Assists, Blocks, Steals, ThreePtrs, FreeThrow) VALUES
-- Shai Gilgeous-Alexander performances
('000000001', '000000001', 40, 9, 10, 1, 2, 5, 8),
('000000001', '000000002', 34, 8, 12, 1, 3, 4, 6),
('000000001', '000000003', 22, 5, 8, 0, 1, 2, 4),
-- Anthony Edwards performances  
('000000005', '000000001', 16, 7, 3, 0, 2, 2, 2),
('000000005', '000000002', 25, 8, 5, 1, 1, 3, 4),
('000000005', '000000003', 37, 9, 6, 2, 3, 6, 8),
-- Tyrese Haliburton historic performance
('000000013', '000000005', 32, 10, 15, 0, 0, 6, 2), 
-- Jalen Brunson performances
('000000009', '000000005', 18, 3, 5, 0, 1, 4, 2),
('000000009', '000000006', 24, 4, 8, 0, 2, 3, 6),
-- Karl-Anthony Towns clutch performance  
('000000010', '000000006', 20, 12, 2, 1, 1, 1, 6), 
-- Nikola Jokic final games
('000000025', '000000009', 32, 16, 12, 2, 2, 2, 8), 
('000000025', '000000010', 28, 14, 11, 1, 1, 1, 6);

# Insert Fav_Player data 
INSERT INTO Fav_Player (UID, Player_ID) VALUES
('000000001', '000000001'), -- Ryan likes SGA
('000000002', '000000013'), -- Nicole likes Haliburton  
('000000003', '000000005'), -- Brandon likes Anthony Edwards
('000000004', '000000009'), -- Samantha likes Jalen Brunson
('000000005', '000000025'), -- Tyler likes Nikola Jokic
('000000006', '000000017'), -- Alex likes Jayson Tatum
('000000007', '000000021'); -- Jordan likes Donovan Mitchell

# Insert Fav_Team Data 
INSERT INTO Fav_Team (UID, Team_ID) VALUES
('000000001', '000000009'), 
('000000002', '000000006'), 
('000000003', '000000011'), 
('000000004', '000000002'),
('000000005', '000000010'), 
('000000006', '000000001'), 
('000000007', '000000004'); 

# NBA Database SQL Queries - May 2025 Playoff Data
# Five different query types demonstrating various SQL concepts

# Query 1
# This query shows information about every player in our database along with their team stats 
SELECT 
    p.F_Name,
    p.L_Name,
    p.Position,
    p.Points,
    p.Rebounds,
    p.Assists,
    t.Team_Name,
    t.Location AS Conference,
    t.Win,
    t.Lose
FROM Player p
INNER JOIN Team t ON p.Team_ID = t.Team_ID
ORDER BY p.Points DESC;

# Query 2
# This query uses calculates the average points/rebounds/assists of players by position along with the highest and lowest scorers.
SELECT 
    Position,
    COUNT(*) AS Total_Players,
    AVG(Points) AS Avg_Points,
    AVG(Rebounds) AS Avg_Rebounds,
    AVG(Assists) AS Avg_Assists,
    MAX(Points) AS Highest_Scorer,
    MIN(Points) AS Lowest_Scorer
FROM Player
GROUP BY Position
ORDER BY Avg_Points DESC;

# Query 3 
# This query uses a subquery to find players whose points are above the average of all players
SELECT 
    p.F_Name,
    p.L_Name,
    p.Points,
    t.Team_Name,
    (SELECT AVG(Points) FROM Player) AS League_Average
FROM Player p
INNER JOIN Team t ON p.Team_ID = t.Team_ID
WHERE p.Points > (SELECT AVG(Points) FROM Player)
ORDER BY p.Points DESC;

# Query 4
# This query finds positions with strong rebounding performances 
SELECT 
    Position,
    COUNT(*) AS Total_Players,
    AVG(Rebounds) AS Avg_Rebounds,
    MAX(Rebounds) AS Best_Rebounder,
    MIN(Rebounds) AS Worst_Rebounder,
    SUM(Rebounds) AS Total_Rebounds
FROM Player
GROUP BY Position
HAVING AVG(Rebounds) > 6
ORDER BY Avg_Rebounds DESC;

# Query 5
# This query uses left join to show teams that do and don't have media on our database
SELECT 
    t.Team_Name,
    t.Location AS Conference,
    t.Win,
    t.Lose,
    m.Media_Type,
    m.Description,
    m.Like_Counter,
    COALESCE(m.Like_Counter, 0) AS Likes_Count
FROM Team t
LEFT OUTER JOIN Media m ON t.Team_ID = m.Team_ID
ORDER BY t.Win DESC, m.Like_Counter DESC;


