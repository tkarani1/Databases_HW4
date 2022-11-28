
DROP PROCEDURE IF EXISTS HW4_AllCourseAverages;

DELIMITER //

CREATE PROCEDURE HW4_AllCourseAverages(IN pw VARCHAR(15))

BEGIN
IF (SELECT COUNT(CurPasswords) FROM HW4_Password WHERE CurPasswords = pw > 0) THEN
    WITH 
    
    SPercents AS (SELECT HW4_RawScore.AName, AType, SID, 
            TRUNCATE((Score / PtsPoss) * 100,2) AS Percent
            FROM HW4_Assignment JOIN HW4_RawScore ON HW4_Assignment.AName = HW4_RawScore.AName),
    
    ECount AS (SELECT COUNT(AName) AS ECount
            FROM HW4_Assignment
            WHERE AType = 'EXAM'),
            
    QCount AS (SELECT COUNT(AName) AS QCount
            FROM HW4_Assignment
            WHERE AType = 'QUIZ'),
            
    WeightedAvgs AS (
            SELECT sid, SPercents.AType,
            CASE WHEN SPercents.AType = 'QUIZ' THEN 0.4 * (SUM(Percent) / (SELECT QCount FROM QCount)) ELSE 0 END AS QAvg,
            CASE WHEN SPercents.AType = 'EXAM' THEN 0.6 * (SUM(Percent) / (SELECT ECount FROM ECount)) ELSE 0 END AS EAvg
            FROM HW4_Assignment JOIN SPercents ON HW4_Assignment.AName = SPercents.AName
            GROUP BY SPercents.sid, HW4_Assignment.AType),
            
    CourseAvgs AS (SELECT sid, 
            TRUNCATE(SUM(QAvg) + SUM(EAvg),2) AS CourseAvg
            FROM WeightedAvgs
            GROUP BY sid)
    
    SELECT HW4_Student.SID AS SID, LName, FName, Sec, CourseAvg
            FROM HW4_Student JOIN CourseAvgs ON HW4_Student.sid = CourseAvgs.sid
            ORDER BY Sec ASC, CourseAvg DESC, LName ASC, FName ASC;
END IF; 

END; //

DELIMITER ;
