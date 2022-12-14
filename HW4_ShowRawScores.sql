-- ShowRawScores.sql
-- Reports table of an SID's raw scores

DROP PROCEDURE IF EXISTS HW4_ShowRawScores;

DELIMITER //

-- construct a one-row table of asssignment scores for a specified student
-- assignments for which a student has no grade are null values in the result
CREATE PROCEDURE HW4_ShowRawScores(IN this_sid VARCHAR(10))

BEGIN
    IF (SELECT COUNT(SID) FROM HW4_Student WHERE SID = this_sid > 0) THEN
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
            SET @sql = CONCAT('SELECT ',
                            @sql,
                            ' FROM HW4_RawScore WHERE sid = ',
                    '?');

        SET @sql = CONCAT('WITH SInfo AS (SELECT sid, LName, FName, Sec
                        FROM HW4_Student WHERE sid = ?),',
                        'SScores AS (', @sql, ')',
                        'SELECT * FROM SInfo JOIN SScores');
        -- alert the server we have a statement shell to set up
        PREPARE stmt FROM @sql;

        -- now execute the statement shell with a value plugged in for the ?
        EXECUTE stmt USING this_sid, this_sid;

        -- tear down the prepared shell since no longer needed (we won't requery it)
        DEALLOCATE PREPARE stmt;

            -- this is another way to structure the query
            -- SELECT LName, FName, Sec, HW4_RawScore.sid, max(case when aname = 'quiz1' then score end) as 'quiz1'
            --        FROM HW4_RawScore JOIN HW4_Student ON HW4_RawScore.sid = HW4_Student.sid
            --        WHERE HW4_RawScore.sid = @sid
  --  ELSE 
   --   SELECT COUNT(SID) FROM HW4_Student WHERE SID = this_sid > 0;
    END IF;

END; //

DELIMITER ;

