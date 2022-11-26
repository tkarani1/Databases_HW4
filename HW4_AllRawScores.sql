
DROP PROCEDURE IF EXISTS AllRawScores;

DELIMITER //

-- construct a one-row table of asssignment scores for a specified student
-- assignments for which a student has no grade are null values in the result
CREATE PROCEDURE AllRawScores(IN pw VARCHAR(15))

BEGIN
 
 SET @assigns = NULL;
 SET @assign_name = NULL; 
 SET @sql = NULL;
 
   SELECT
     GROUP_CONCAT(DISTINCT
       CONCAT(
         'max(case when aname = ''',
         aname,
         ''' then score end) as ''',aname,''''
       )
       ORDER BY atype DESC, aname ASC
     ) INTO @assigns
   FROM HW4_Assignment;
   
   SELECT
     GROUP_CONCAT(DISTINCT
       CONCAT(' ', aname, ' ')
       ORDER BY atype DESC, aname ASC
     ) INTO @assign_name
   FROM HW4_Assignment;
 
   
   SET @sql = CONCAT('
        WITH 
        AllScores AS (SELECT sid, ' , @assigns,  '
               FROM HW4_RawScore 
               GROUP BY sid)
        
        SELECT HW4_Student.SID AS SID, LName, FName, Sec, ', @assign_name, '
        FROM HW4_Student JOIN AllScores ON HW4_Student.sid = AllScores.sid'
        );
  
    PREPARE stmt FROM @sql;

   -- now execute the statement shell with a value plugged in for the ?
   EXECUTE stmt;

   -- tear down the prepared shell since no longer needed (we won't requery it)
   DEALLOCATE PREPARE stmt;

END; //

DELIMITER ;