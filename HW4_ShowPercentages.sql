-- ShowPercentages.sql
-- Reports table of SID's percentages and course average

DROP PROCEDURE IF EXISTS ShowPercentages; 

DELIMETER // 

CREATE PROCEDURE ShowPercentages(IN sid VARCHAR(10))

BEGIN

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
   WITH SInfo AS (SELECT sid, LName, FName, Sec
     FROM HW4_Student WHERE sid = ?),
        
      SPercents AS (SELECT HW4_RawScore.AName, AType, SID, 
        TRUNCATE((Score / PtsPoss) * 100,2) AS Percent
        FROM HW4_Assignment JOIN HW4_RawScore ON HW4_Assignment.AName = HW4_RawScore.AName
        WHERE HW4_RawScore.sid = ?),

        SAvgs AS (SELECT sid, AType,
                SUM(Score) / SUM(PtsPoss) AS QEAvg,
                FROM HW4_Assignment JOIN HW4_RawScore ON HW4_Assignment.AName = HW4_RawScore.AName
                GROUP BY HW4_RawScore.sid, HW4_Assignment.AType), 

        CAvgs AS (SELECT sid,
                TRUNCATE(100 * (CASE WHEN AType = ''EXAM'' THEN QEAvg ELSE 0 END) * 0.6 + (CASE WHEN AType = ''QUIZ'' THEN QEAvg ELSE 0 END) * 0.4, 2) As CourseAvg
                FROM SAvgs
                GROUP BY sid),
        SCAvgs AS (SELECT CourseAvg
                   FROM CAvgs
                   WHERE CAvgs.sid = ?),  
 
        PForStudent AS (SELECT ', @assigns, '
              FROM SPercents 
              WHERE sid = ?)  
 
        SELECT * 
              FROM SInfo JOIN PForStudent JOIN SCAvgs
              ');
  PREPARE stmt FROM @sql;

   -- now execute the statement shell with a value plugged in for the ?
   EXECUTE stmt USING sid, sid, sid, sid;

   -- tear down the prepared shell since no longer needed (we won't requery it)
   DEALLOCATE PREPARE stmt;
   

END; //
DELIMITER;