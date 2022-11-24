-- ShowRawScores.sql
-- Reports table of an SID's raw scores

DROP PROCEDURE IF EXISTS ShowRawScores;

DELIMITER //

-- construct a one-row table of asssignment scores for a specified student
-- assignments for which a student has no grade are null values in the result
CREATE PROCEDURE ShowRawScores(IN sid VARCHAR(10))

BEGIN
   SET @sql = NULL;

   -- accumulate into the variable named @sql a list of assignment names
   -- and expressions to that will get the associated scores, for use 
   -- as part of a later query of table HW4_RawScore
   SELECT
     GROUP_CONCAT(DISTINCT
       CONCAT(
         'max(case when aname = ''',
         aname,
         ''' then score end) as ''',aname,''''
       )
       ORDER BY atype DESC, aname ASC
     ) INTO @sql
   FROM HW4_Assignment;

   -- concatenate the assignment name list and associated expressions
   -- into a larger query string so we can execute it, but leave ?
   -- in place so we can plug in the specific sid value in a careful way
   SET @sql = CONCAT('SELECT sid, ',
                     @sql,
                     ' FROM HW4_RawScore WHERE sid = ',
		     '?');
    
    SET @sql = CONCAT('SELECT * FROM HW4_Student JOIN (', @sql, ') WHERE sid = ', '?')

   -- alert the server we have a statement shell to set up
   PREPARE stmt FROM @sql;

   -- now execute the statement shell with a value plugged in for the ?
   EXECUTE stmt USING sid;

   -- tear down the prepared shell since no longer needed (we won't requery it)
   DEALLOCATE PREPARE stmt;

END; //

DELIMITER ;

