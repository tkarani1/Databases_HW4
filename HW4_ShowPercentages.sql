-- ShowPercentages.sql
-- Reports table of SID's percentages and course average

DROP PROCEDURE IF EXISTS HW4_ShowPercentages; 

DELIMITER // 

CREATE PROCEDURE HW4_ShowPercentages(IN this_sid VARCHAR(10))

BEGIN
IF (SELECT COUNT(SID) FROM HW4_Student WHERE SID = this_sid > 0) THEN
 SET @assigns = NULL;
 SET @sql = NULL;
 
 SELECT
     GROUP_CONCAT(DISTINCT
       CONCAT(
         'max(case when AName = ''',
         aname,
         ''' then Percent end) as ''',aname,''''
       )
       ORDER BY atype DESC, aname ASC
     ) INTO @assigns
   FROM HW4_Assignment;
   
   SET @sql = CONCAT('
        WITH 
        
        SInfo AS (SELECT sid, LName, FName, Sec
                FROM HW4_Student WHERE sid = ?),
        
        SPercents AS (SELECT HW4_RawScore.AName, AType, SID, 
                TRUNCATE((Score / PtsPoss) * 100,2) AS Percent
                FROM HW4_Assignment JOIN HW4_RawScore ON HW4_Assignment.AName = HW4_RawScore.AName),
        
        ECount AS (SELECT COUNT(AName) AS ECount
                FROM HW4_Assignment
                WHERE AType = ''EXAM''),
                
        QCount AS (SELECT COUNT(AName) AS QCount
                FROM HW4_Assignment
                WHERE AType = ''QUIZ''),
               
        WeightedAvgs AS (
                SELECT sid, SPercents.AType,
                CASE WHEN SPercents.AType = ''QUIZ'' THEN 0.4 * (SUM(Percent) / (SELECT QCount FROM QCount)) ELSE 0 END AS QAvg,
                CASE WHEN SPercents.AType = ''EXAM'' THEN 0.6 * (SUM(Percent) / (SELECT ECount FROM ECount)) ELSE 0 END AS EAvg
                FROM HW4_Assignment JOIN SPercents ON HW4_Assignment.AName = SPercents.AName
                GROUP BY SPercents.sid, HW4_Assignment.AType),
                
        CourseAvgs AS (SELECT sid, 
                TRUNCATE(SUM(QAvg) + SUM(EAvg),2) AS CourseAvg
                FROM WeightedAvgs
                GROUP BY sid),
        
       StudentCourseAvgs AS (SELECT CourseAvg
           FROM CourseAvgs
           WHERE CourseAvgs.sid = ?),
       
       StudentPercents AS (SELECT ', @assigns, '
              FROM SPercents 
             WHERE sid = ?)
       
       SELECT *
              FROM SInfo JOIN StudentPercents JOIN StudentCourseAvgs
              ');
  PREPARE stmt FROM @sql;

   -- now execute the statement shell with a value plugged in for the ?
   EXECUTE stmt USING this_sid, this_sid, this_sid;

   -- tear down the prepared shell since no longer needed (we won't requery it)
   DEALLOCATE PREPARE stmt;
   END IF;

END; //
DELIMITER ;
