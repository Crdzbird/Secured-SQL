create function str_clean(p_text text, p_remove_multiple_blanks boolean, p_remove_linebreaks boolean, p_remove_tabs boolean, p_remove_multiple_backslashes boolean, p_remove_htmlentities boolean, p_html_unencode boolean, p_remove_html boolean) returns text
    language plpgsql
as
$$
DECLARE v_result TEXT;
    DECLARE v_start INT;
        v_end INT; v_len INT;
BEGIN
    v_result := TRIM(BOTH FROM p_text);
    IF (p_remove_linebreaks = TRUE ) THEN
        v_result := REPLACE( v_result ,CHR(13),' ');
        v_result := REPLACE( v_result ,CHR(10),' ');
    END IF;
    IF (p_remove_tabs = TRUE ) THEN
        v_result := REPLACE( v_result ,CHR(9),' ');
    END IF;
    IF (p_remove_multiple_blanks = TRUE ) THEN
        v_result := REPLACE(REPLACE( v_result,'  ',' '),'   ',' ');
        v_result := REPLACE(REPLACE( v_result,'  ',' '),'   ',' ');
        v_result := REPLACE(REPLACE( v_result,'  ',' '),'   ',' ');
        v_result := REPLACE(REPLACE( v_result,'  ',' '),'   ',' ');
        v_result := REPLACE(REPLACE( v_result,'  ',' '),'   ',' ');
        -- v_result := SELECT REPLACE(REPLACE( v_result,'  ',' '),'   ',' ');
    END IF;
    IF (p_remove_multiple_backslashes = TRUE ) THEN
        v_result := REPLACE(REPLACE(REPLACE( v_result,'\',''),'\"','"'),'\\','\');
    END IF;

    IF (p_remove_htmlentities = TRUE ) THEN
        IF (v_result ~ '&*;') THEN
            WHILE POSITION( '&' in v_result) > 0 AND POSITION( ';' IN v_result) > 0 AND POSITION( '&' IN v_result ) > 0 LOOP
                    v_start := POSITION( '&' IN v_result );
                    v_end   := POSITION(';' IN v_result);
                    IF v_end > 0 THEN
                        v_len   := ( v_end - v_start) + 1;
                    ELSE
                        v_end   := POSITION('&' IN v_result);
                        v_len   := ( v_end - v_start) + 1;
                    END IF;
                    IF (v_len > 0) THEN
                        v_result := REPLACE(v_result, SUBSTRING(v_result, v_start, v_end - 1), '');
                    END IF;
                END LOOP;
        END IF;
    END IF;
    IF (p_remove_html = TRUE ) THEN
        IF (v_result ~ '<*>') THEN
            WHILE POSITION( '<' IN v_result ) > 0 AND POSITION('>' IN v_result ) > 0 AND POSITION( '<' IN v_result ) > 0 LOOP
                    v_start := POSITION( '<' IN v_result );
                    v_end   := POSITION( '>'  IN v_result);
                    v_len   := ( v_end - v_start) + 1;
                    IF (v_len > 0) THEN
                        v_result := REPLACE( v_result, SUBSTRING(v_result, v_start, v_end - 1), '');
                    END IF;
                END LOOP;
        END IF;
    END IF;

    IF (p_html_unencode = TRUE ) THEN
        IF (cardinality(regexp_matches(v_result, '&*;')) > 0) THEN
            v_result := str_html_unencode(v_result);
        END IF;
    END IF;

    IF (p_remove_multiple_blanks = TRUE ) THEN
        v_result := REPLACE(REPLACE( v_result,'  ',' '),'   ',' ');
        v_result := REPLACE(REPLACE( v_result,'  ',' '),'   ',' ');
        v_result := REPLACE(REPLACE( v_result,'  ',' '),'   ',' ');
        v_result := REPLACE(REPLACE( v_result,'  ',' '),'   ',' ');
        v_result := REPLACE(REPLACE( v_result,'  ',' '),'   ',' ');
        -- v_result := SELECT REPLACE(REPLACE( v_result,'  ',' '),'   ',' ');
    END IF;

    RETURN v_result;
END
$$;

create function instr(str text, sub text, startpos integer DEFAULT 1, occurrence integer DEFAULT 1) returns integer
    language plpgsql
as
$$
declare
    tail text;
    shift int;
    pos int;
    i int;
begin
    shift:= 0;
    if startpos = 0 or occurrence <= 0 then
        return 0;
    end if;
    if startpos < 0 then
        str:= reverse(str);
        sub:= reverse(sub);
        pos:= -startpos;
    else
        pos:= startpos;
    end if;
    for i in 1..occurrence loop
            shift:= shift+ pos;
            tail:= substr(str, shift);
            pos:= strpos(tail, sub);
            if pos = 0 then
                return 0;
            end if;
        end loop;
    if startpos > 0 then
        return pos+ shift- 1;
    else
        return length(str)- pos- shift+ 1;
    end if;
end
$$;

alter function instr(text, text, integer, integer) owner to postgres;

alter function str_clean(text, boolean, boolean, boolean, boolean, boolean, boolean, boolean) owner to postgres;

create function str_html_unencode(x text) returns text
    language plpgsql
as
$$
DECLARE
    TextString VARCHAR(255);
BEGIN
    TextString := x;
    IF INSTR( x , '&quot;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&quot;','"','g' ,'g');
    END IF ;

    IF INSTR( x , '&apos;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&apos;','"','g');
    END IF ;

    IF INSTR( x , '&amp;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&amp;','&');
    END IF ;

    IF INSTR( x , '&lt;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&lt;','<' ,'g');
    END IF ;

    IF INSTR( x , '&gt;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&gt;','>' ,'g');
    END IF ;

    IF INSTR( x , '&nbsp;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&nbsp;',' ' ,'g');
    END IF ;

    IF INSTR( x , '&iexcl;' )
    THEN  TextString := regexp_replace(TextString, '&iexcl;','¡' ,'g');
    END IF ;

    IF INSTR( x , '&cent;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&cent;','¢' ,'g');
    END IF ;

    IF INSTR( x , '&pound;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&pound;','£' ,'g');
    END IF ;

    IF INSTR( x , '&curren;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&curren;','¤' ,'g');
    END IF ;

    IF INSTR( x , '&yen;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&yen;','¥' ,'g');
    END IF ;

    IF INSTR( x , '&brvbar;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&brvbar;','¦' ,'g');
    END IF ;

    IF INSTR( x , '&sect;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&sect;','§' ,'g');
    END IF ;

    IF INSTR( x , '&uml;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&uml;','¨' ,'g');
    END IF ;

    IF INSTR( x , '&copy;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&copy;','©' ,'g');
    END IF ;

    IF INSTR( x , '&ordf;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&ordf;','ª' ,'g');
    END IF ;

    IF INSTR( x , '&laquo;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&laquo;','«' ,'g');
    END IF ;

    IF INSTR( x , '&not;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&not;','¬' ,'g');
    END IF ;

    IF INSTR( x , '&shy;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&shy;','­' ,'g');
    END IF ;

    IF INSTR( x , '&reg;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&reg;','®' ,'g');
    END IF ;

    IF INSTR( x , '&macr;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&macr;','¯' ,'g');
    END IF ;

    IF INSTR( x , '&deg;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&deg;','°' ,'g');
    END IF ;

    IF INSTR( x , '&plusmn;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&plusmn;','±' ,'g');
    END IF ;

    IF INSTR( x , '&sup2;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&sup2;','²' ,'g');
    END IF ;

    IF INSTR( x , '&sup3;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&sup3;','³' ,'g');
    END IF ;

    IF INSTR( x , '&acute;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&acute;','´' ,'g');
    END IF ;

    IF INSTR( x , '&micro;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&micro;','µ' ,'g');
    END IF ;

    IF INSTR( x , '&para;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&para;','¶' ,'g');
    END IF ;

    IF INSTR( x , '&middot;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&middot;','·' ,'g');
    END IF ;

    IF INSTR( x , '&cedil;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&cedil;','¸' ,'g');
    END IF ;

    IF INSTR( x , '&sup1;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&sup1;','¹' ,'g');
    END IF ;

    IF INSTR( x , '&ordm;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&ordm;','º' ,'g');
    END IF ;

    IF INSTR( x , '&raquo;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&raquo;','»' ,'g');
    END IF ;

    IF INSTR( x , '&frac14;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&frac14;','¼' ,'g');
    END IF ;

    IF INSTR( x , '&frac12;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&frac12;','½' ,'g');
    END IF ;

    IF INSTR( x , '&frac34;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&frac34;','¾' ,'g');
    END IF ;

    IF INSTR( x , '&iquest;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&iquest;','¿' ,'g');
    END IF ;

    IF INSTR( x , '&times;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&times;','×' ,'g');
    END IF ;

    IF INSTR( x , '&divide;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&divide;','÷' ,'g');
    END IF ;

    IF INSTR( x , '&Agrave;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&Agrave;','À' ,'g');
    END IF ;

    IF INSTR( x , '&Aacute;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&Aacute;','Á' ,'g');
    END IF ;

    IF INSTR( x , '&Acirc;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&Acirc;','Â' ,'g');
    END IF ;

    IF INSTR( x , '&Atilde;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&Atilde;','Ã' ,'g');
    END IF ;

    IF INSTR( x , '&Auml;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&Auml;','Ä' ,'g');
    END IF ;

    IF INSTR( x , '&Aring;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&Aring;','Å' ,'g');
    END IF ;

    IF INSTR( x , '&AElig;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&AElig;','Æ' ,'g');
    END IF ;

    IF INSTR( x , '&Ccedil;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&Ccedil;','Ç' ,'g');
    END IF ;

    IF INSTR( x , '&Egrave;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&Egrave;','È' ,'g');
    END IF ;

    IF INSTR( x , '&Eacute;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&Eacute;','É' ,'g');
    END IF ;

    IF INSTR( x , '&Ecirc;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&Ecirc;','Ê' ,'g');
    END IF ;

    IF INSTR( x , '&Euml;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&Euml;','Ë' ,'g');
    END IF ;

    IF INSTR( x , '&Igrave;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&Igrave;','Ì' ,'g');
    END IF ;

    IF INSTR( x , '&Iacute;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&Iacute;','Í' ,'g');
    END IF ;

    IF INSTR( x , '&Icirc;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&Icirc;','Î' ,'g');
    END IF ;

    IF INSTR( x , '&Iuml;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&Iuml;','Ï' ,'g');
    END IF ;

    IF INSTR( x , '&ETH;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&ETH;','Ð' ,'g');
    END IF ;

    IF INSTR( x , '&Ntilde;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&Ntilde;','Ñ' ,'g');
    END IF ;

    IF INSTR( x , '&Ograve;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&Ograve;','Ò' ,'g');
    END IF ;

    IF INSTR( x , '&Oacute;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&Oacute;','Ó' ,'g');
    END IF ;

    IF INSTR( x , '&Ocirc;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&Ocirc;','Ô' ,'g');
    END IF ;

    IF INSTR( x , '&Otilde;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&Otilde;','Õ' ,'g');
    END IF ;

    IF INSTR( x , '&Ouml;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&Ouml;','Ö' ,'g');
    END IF ;

    IF INSTR( x , '&Oslash;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&Oslash;','Ø' ,'g');
    END IF ;

    IF INSTR( x , '&Ugrave;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&Ugrave;','Ù' ,'g');
    END IF ;

    IF INSTR( x , '&Uacute;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&Uacute;','Ú' ,'g');
    END IF ;

    IF INSTR( x , '&Ucirc;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&Ucirc;','Û' ,'g');
    END IF ;

    IF INSTR( x , '&Uuml;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&Uuml;','Ü' ,'g');
    END IF ;

    IF INSTR( x , '&Yacute;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&Yacute;','Ý' ,'g');
    END IF ;

    IF INSTR( x , '&THORN;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&THORN;','Þ' ,'g');
    END IF ;

    IF INSTR( x , '&szlig;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&szlig;','ß' ,'g');
    END IF ;

    IF INSTR( x , '&agrave;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&agrave;','à' ,'g');
    END IF ;

    IF INSTR( x , '&aacute;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&aacute;','á' ,'g');
    END IF ;

    IF INSTR( x , '&acirc;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&acirc;','â' ,'g');
    END IF ;

    IF INSTR( x , '&atilde;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&atilde;','ã' ,'g');
    END IF ;

    IF INSTR( x , '&auml;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&auml;','ä' ,'g');
    END IF ;

    IF INSTR( x , '&aring;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&aring;','å' ,'g');
    END IF ;

    IF INSTR( x , '&aelig;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&aelig;','æ' ,'g');
    END IF ;

    IF INSTR( x , '&ccedil;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&ccedil;','ç' ,'g');
    END IF ;

    IF INSTR( x , '&egrave;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&egrave;','è' ,'g');
    END IF ;

    IF INSTR( x , '&eacute;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&eacute;','é' ,'g');
    END IF ;

    IF INSTR( x , '&ecirc;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&ecirc;','ê' ,'g');
    END IF ;

    IF INSTR( x , '&euml;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&euml;','ë' ,'g');
    END IF ;

    IF INSTR( x , '&igrave;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&igrave;','ì' ,'g');
    END IF ;

    IF INSTR( x , '&iacute;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&iacute;','í' ,'g');
    END IF ;

    IF INSTR( x , '&icirc;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&icirc;','î' ,'g');
    END IF ;

    IF INSTR( x , '&iuml;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&iuml;','ï' ,'g');
    END IF ;

    IF INSTR( x , '&eth;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&eth;','ð' ,'g');
    END IF ;

    IF INSTR( x , '&ntilde;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&ntilde;','ñ' ,'g');
    END IF ;

    IF INSTR( x , '&ograve;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&ograve;','ò' ,'g');
    END IF ;

    IF INSTR( x , '&oacute;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&oacute;','ó' ,'g');
    END IF ;

    IF INSTR( x , '&ocirc;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&ocirc;','ô' ,'g');
    END IF ;

    IF INSTR( x , '&otilde;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&otilde;','õ' ,'g');
    END IF ;

    IF INSTR( x , '&ouml;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&ouml;','ö' ,'g');
    END IF ;

    IF INSTR( x , '&oslash;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&oslash;','ø' ,'g');
    END IF ;

    IF INSTR( x , '&ugrave;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&ugrave;','ù' ,'g');
    END IF ;

    IF INSTR( x , '&uacute;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&uacute;','ú' ,'g');
    END IF ;

    IF INSTR( x , '&ucirc;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&ucirc;','û' ,'g');
    END IF ;

    IF INSTR( x , '&uuml;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&uuml;','ü' ,'g');
    END IF ;

    IF INSTR( x , '&yacute;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&yacute;','ý' ,'g');
    END IF ;

    IF INSTR( x , '&thorn;' ) > 0
    THEN  TextString := regexp_replace(TextString, '&thorn;','þ' ,'g');
    END IF ;

    IF INSTR( x , '&yuml;' ) > 0
    THEN
        TextString := regexp_replace(TextString, '&yuml;','ÿ' ,'g');
    END IF ;

    RETURN TextString ;
END
$$;

alter function str_html_unencode(text) owner to postgres;

create function empty2null(text_i character varying) returns character varying
    language plpgsql
as
$$
declare
    text_p varchar;
begin
    if text_i = ''
    then text_p := null;
    else text_p := text_i;
    end if;
    return text_p;
end;
$$;

alter function empty2null(varchar) owner to postgres;


