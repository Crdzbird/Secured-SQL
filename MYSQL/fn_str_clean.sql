SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES';

DELIMITER //
DROP FUNCTION IF EXISTS str_clean;
//

CREATE FUNCTION str_clean(p_text TEXT
                         ,p_remove_multiple_blanks BOOLEAN
                         ,p_remove_linebreaks BOOLEAN
                         ,p_remove_tabs BOOLEAN
                         ,p_remove_multiple_backslashes BOOLEAN
                         ,p_remove_htmlentities BOOLEAN
                         ,p_html_unencode BOOLEAN
                         ,p_remove_html BOOLEAN
                                 )
    RETURNS TEXT
    DETERMINISTIC
    NO SQL
    BEGIN
        DECLARE v_result TEXT DEFAULT NULL;
        DECLARE v_start, v_end, v_len INT;

        SET v_result := TRIM(BOTH FROM p_text);
        IF (p_remove_linebreaks = TRUE ) THEN
            SET v_result := REPLACE( v_result ,CHAR(13),' ');
            SET v_result := REPLACE( v_result ,CHAR(10),' ');
        END IF;
        IF (p_remove_tabs = TRUE ) THEN
            SET v_result := REPLACE( v_result ,CHAR(9),' ');
        END IF;
        IF (p_remove_multiple_blanks = TRUE ) THEN
            SET v_result := REPLACE(REPLACE( v_result,'  ',' '),'   ',' ');
            SET v_result := REPLACE(REPLACE( v_result,'  ',' '),'   ',' ');
            SET v_result := REPLACE(REPLACE( v_result,'  ',' '),'   ',' ');
            SET v_result := REPLACE(REPLACE( v_result,'  ',' '),'   ',' ');
            -- SET v_result := SELECT REPLACE(REPLACE( v_result,'  ',' '),'   ',' ');
        END IF;
        IF (p_remove_multiple_backslashes = TRUE ) THEN
            SET v_result := REPLACE(REPLACE(REPLACE( v_result,'\\\'','\''),'\\\"','"'),'\\\\','\\');
        END IF;

        IF (p_remove_htmlentities = TRUE ) THEN
           IF (v_result REGEXP '&*;') THEN
                WHILE LOCATE( '&', v_result ) > 0 AND LOCATE( ';', v_result, LOCATE( '&', v_result )) > 0 DO
                    SET v_start := LOCATE( '&', v_result );
                    SET v_end   := LOCATE( ';', v_result, LOCATE('&', v_result ));
                    SET v_len   := ( v_end - v_start) + 1;
                    IF (v_len > 0) THEN
                        SET v_result := INSERT( v_result, v_start, v_len, '');
                    END IF;
                END WHILE;
            END IF;
        END IF;

        IF (p_remove_html = TRUE ) THEN
            IF (v_result REGEXP '<*>') THEN
                WHILE LOCATE( '<', v_result ) > 0 AND LOCATE( '>', v_result, LOCATE( '<', v_result )) > 0 DO
                    SET v_start := LOCATE( '<', v_result );
                    SET v_end   := LOCATE( '>', v_result, LOCATE('<', v_result ));
                    SET v_len   := ( v_end - v_start) + 1;
                    IF (v_len > 0) THEN
                        SET v_result := INSERT( v_result, v_start, v_len, '');
                    END IF;
                END WHILE;
            END IF;
        END IF;

        IF (p_html_unencode = TRUE ) THEN
           IF (v_result REGEXP '&*;') THEN
              SET v_result := str_html_unencode(v_result);
           END IF;
        END IF;

        RETURN v_result;
    END;
//
DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
