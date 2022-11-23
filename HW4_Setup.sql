-- HW4_Setup.sql

DROP TABLE IF EXISTS HW4_Password;
DROP TABLE IF EXISTS HW4_RawScore;
DROP TABLE IF EXISTS HW4_Assignment;
DROP TABLE IF EXISTS HW4_Student;


CREATE TABLE HW4_Student(
    SID	    VARCHAR(4) PRIMARY KEY,
    LName   VARCHAR(11),
    FName   VARCHAR(11),
    Sec     VARCHAR(3)
);

CREATE TABLE HW4_Assignment(
    AName	VARCHAR(10) PRIMARY KEY,
    AType	VARCHAR(4),
    PtsPoss     VARCHAR(11)
);

CREATE TABLE HW4_RawScore(
    AName   VARCHAR(10),
    SID	    VARCHAR(4),
    Score   DECIMAL(5,2),
    PRIMARY KEY(AName, SID, Score),
    FOREIGN KEY(AName) REFERENCES HW4_Assignment(AName) ON DELETE CASCADE  ON UPDATE CASCADE,
    FOREIGN KEY(SID)   REFERENCES HW4_Student(SID)      ON DELETE CASCADE  ON UPDATE CASCADE
);

CREATE TABLE HW4_Password (
  CurPasswords  VARCHAR(15)
);


-- create student roster
INSERT INTO HW4_Student VALUES ('3774', 'Adamu',   'Musa',   '01');
INSERT INTO HW4_Student VALUES ('9176', 'Epp',     'Eric',   '02');
INSERT INTO HW4_Student VALUES ('1212', 'Farooqi', 'Nasrin', '01');
INSERT INTO HW4_Student VALUES ('5992', 'Lundin',  'Klaraa', '01'); 
INSERT INTO HW4_Student VALUES ('8213', 'Naran',   'Zoila',  '03');
INSERT INTO HW4_Student VALUES ('1006', 'Nielsen', 'Rowan',  '02');
INSERT INTO HW4_Student VALUES ('1180', 'Qin',     'Dongmei','03');
INSERT INTO HW4_Student VALUES ('8888', 'Skipper', 'ImaQuiz','02');
INSERT INTO HW4_Student VALUES ('4198', 'Wilson',  'Amanda', '02');



-- quiz1 is worth 30 pts total
INSERT INTO HW4_Assignment VALUES ('quiz1', 'QUIZ', '30');
INSERT INTO HW4_RawScore VALUES ('quiz1', '9176', '30');
INSERT INTO HW4_RawScore VALUES ('quiz1', '5992', '30');
INSERT INTO HW4_RawScore VALUES ('quiz1', '3774', '28');
INSERT INTO HW4_RawScore VALUES ('quiz1', '1212', '26');
INSERT INTO HW4_RawScore VALUES ('quiz1', '4198', '30');
INSERT INTO HW4_RawScore VALUES ('quiz1', '1006', '29');
INSERT INTO HW4_RawScore VALUES ('quiz1', '8213', '29');
INSERT INTO HW4_RawScore VALUES ('quiz1', '1180', '20');


-- quiz2 is worth 30 pts total
INSERT INTO HW4_Assignment VALUES ('quiz2', 'QUIZ', '30');
INSERT INTO HW4_RawScore VALUES ('quiz2', '9176', '27');
INSERT INTO HW4_RawScore VALUES ('quiz2', '5992', '27');
INSERT INTO HW4_RawScore VALUES ('quiz2', '1212', '25');
INSERT INTO HW4_RawScore VALUES ('quiz2', '4198', '26');
INSERT INTO HW4_RawScore VALUES ('quiz2', '1006', '19');
INSERT INTO HW4_RawScore VALUES ('quiz2', '8213', '30');
INSERT INTO HW4_RawScore VALUES ('quiz2', '1180', '29');


-- quiz3 is worth 40 pts total
INSERT INTO HW4_Assignment VALUES ('quiz3', 'QUIZ', '40');
INSERT INTO HW4_RawScore VALUES ('quiz3', '9176', '39');
INSERT INTO HW4_RawScore VALUES ('quiz3', '5992', '36');
INSERT INTO HW4_RawScore VALUES ('quiz3', '3774', '37');
INSERT INTO HW4_RawScore VALUES ('quiz3', '1212', '35');
INSERT INTO HW4_RawScore VALUES ('quiz3', '4198', '32');
INSERT INTO HW4_RawScore VALUES ('quiz3', '8213', '0');
INSERT INTO HW4_RawScore VALUES ('quiz3', '1180', '40');


-- quiz4 is worth 50 pts total
INSERT INTO HW4_Assignment VALUES ('quiz4', 'QUIZ', '50');
INSERT INTO HW4_RawScore VALUES ('quiz4', '5992', '48');
INSERT INTO HW4_RawScore VALUES ('quiz4', '3774', '37');
INSERT INTO HW4_RawScore VALUES ('quiz4', '1212', '36');
INSERT INTO HW4_RawScore VALUES ('quiz4', '1006', '29');
INSERT INTO HW4_RawScore VALUES ('quiz4', '8213', '45');
INSERT INTO HW4_RawScore VALUES ('quiz4', '1180', '42');



-- test1 is worth 100 pts total
INSERT INTO HW4_Assignment VALUES ('test1', 'EXAM', '100');
INSERT INTO HW4_RawScore VALUES ('test1', '1212', '86');
INSERT INTO HW4_RawScore VALUES ('test1', '1006', '93');
INSERT INTO HW4_RawScore VALUES ('test1', '1180', '50');
INSERT INTO HW4_RawScore VALUES ('test1', '8888', '100');
INSERT INTO HW4_RawScore VALUES ('test1', '9176', '99');
INSERT INTO HW4_RawScore VALUES ('test1', '8213', '100');
INSERT INTO HW4_RawScore VALUES ('test1', '5992', '98');
INSERT INTO HW4_RawScore VALUES ('test1', '3774', '85');
INSERT INTO HW4_RawScore VALUES ('test1', '4198', '84');


-- test2 is worth 80 pts total
INSERT INTO HW4_Assignment VALUES ('test2', 'EXAM', '80');
INSERT INTO HW4_RawScore VALUES ('test2', '9176', '79');
INSERT INTO HW4_RawScore VALUES ('test2', '8888', '80');
INSERT INTO HW4_RawScore VALUES ('test2', '8213', '80');
INSERT INTO HW4_RawScore VALUES ('test2', '5992', '71');
INSERT INTO HW4_RawScore VALUES ('test2', '4198', '73');
INSERT INTO HW4_RawScore VALUES ('test2', '3774', '76');
INSERT INTO HW4_RawScore VALUES ('test2', '1212', '77');
INSERT INTO HW4_RawScore VALUES ('test2', '1180', '40');
INSERT INTO HW4_RawScore VALUES ('test2', '1006', '76');


-- test3 is worth 100 pts total
INSERT INTO HW4_Assignment VALUES ('test3', 'EXAM', '100');
INSERT INTO HW4_RawScore VALUES ('test3', '1006', '95');
INSERT INTO HW4_RawScore VALUES ('test3', '1180', '88');
INSERT INTO HW4_RawScore VALUES ('test3', '1212', '86');
INSERT INTO HW4_RawScore VALUES ('test3', '3774', '91');
INSERT INTO HW4_RawScore VALUES ('test3', '4198', '79');
INSERT INTO HW4_RawScore VALUES ('test3', '5992', '82');
INSERT INTO HW4_RawScore VALUES ('test3', '8213', '97');
INSERT INTO HW4_RawScore VALUES ('test3', '8888', '100');
INSERT INTO HW4_RawScore VALUES ('test3', '9176', '93');



INSERT INTO HW4_Password VALUES ('OpenSesame');
INSERT INTO HW4_Password VALUES ('GuessMe');
INSERT INTO HW4_Password VALUES ('ImTheTA');

