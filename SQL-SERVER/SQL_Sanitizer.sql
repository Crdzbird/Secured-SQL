
create function regexp_like (@sourceString varchar(4000), @pattern varchar(4000)) returns int
as
begin
    declare
        @objRegexExp int, 
        @res         int,
        @result      int;

    if @sourceString is null /* or len(ltrim(rtrim(@sourceString))) = 0 */ begin
       return null;
    end;

    exec @res = sp_OACreate 'VBScript.RegExp', @objRegexExp out;

    if @res <> 0 begin
       return 'VBScript did not initialize!';
    end;

    exec @res=sp_OASetProperty @objRegexExp, 'Pattern', @pattern;

    if @res <> 0 begin
       return 'Pattern property set failed!';
    end;

    exec @res=sp_OASetProperty @objRegexExp, 'IgnoreCase', 0;

    if @res <> 0 begin
       return 'IgnoreCase option failed!';
    end;

    exec @res=sp_OAMethod @objRegexExp, 'Test', @result out, @sourceString;

    if @res <> 0 begin
       return 'Calling Test failed';
    end;

    exec @res=sp_OADestroy @objRegexExp;

    return @result
end;
GO

CREATE FUNCTION str_html_unencode(@value NVARCHAR(max)) RETURNS NVARCHAR(max)
BEGIN
	DECLARE @textString NVARCHAR(MAX);
		set @textString = @value;

	IF CHARINDEX('&quot;', @value) > 0
		SET @textString = REPLACE(@textString, '&quot;','"') ;

	IF CHARINDEX('&apos;', @value) > 0
		SET @textString = REPLACE(@textString, '&apos;','"') ;

	IF CHARINDEX('&amp;', @value) > 0
		SET @textString = REPLACE(@textString, '&amp;','&') ;

	IF CHARINDEX('&lt;', @value) > 0
		SET @textString = REPLACE(@textString, '&lt;','<') ;

	IF CHARINDEX('&gt;', @value) > 0
		SET @textString = REPLACE(@textString, '&gt;','>') ;

	IF CHARINDEX('&nbsp;', @value) > 0
		SET @textString = REPLACE(@textString, '&nbsp;',' ') ;

	IF CHARINDEX('&iexcl;', @value) > 0
		SET @textString = REPLACE(@textString, '&iexcl;','¡') ;

	IF CHARINDEX('&cent;', @value) > 0
		SET @textString = REPLACE(@textString, '&cent;','¢') ;

	IF CHARINDEX('&pound;', @value) > 0
		SET @textString = REPLACE(@textString, '&pound;','£') ;

	IF CHARINDEX('&curren;', @value) > 0
		SET @textString = REPLACE(@textString, '&curren;','¤') ;

	IF CHARINDEX('&yen;', @value) > 0
		SET @textString = REPLACE(@textString, '&yen;','¥') ;

	IF CHARINDEX('&brvbar;', @value) > 0
		SET @textString = REPLACE(@textString, '&brvbar;','¦') ;

	IF CHARINDEX('&sect;', @value) > 0
		SET @textString = REPLACE(@textString, '&sect;','§') ;

	IF CHARINDEX('&uml;', @value) > 0
		SET @textString = REPLACE(@textString, '&uml;','¨') ;

	IF CHARINDEX('&copy;', @value) > 0
		SET @textString = REPLACE(@textString, '&copy;','©') ;

	IF CHARINDEX('&ordf;', @value) > 0
		SET @textString = REPLACE(@textString, '&ordf;','ª') ;

	IF CHARINDEX('&laquo;', @value) > 0
		SET @textString = REPLACE(@textString, '&laquo;','«') ;

	IF CHARINDEX('&not;', @value) > 0
		SET @textString = REPLACE(@textString, '&not;','¬') ;

	IF CHARINDEX('&shy;', @value) > 0
		SET @textString = REPLACE(@textString, '&shy;','­') ;

	IF CHARINDEX('&reg;', @value) > 0
		SET @textString = REPLACE(@textString, '&reg;','®') ;

	IF CHARINDEX('&macr;', @value) > 0
		SET @textString = REPLACE(@textString, '&macr;','¯') ;

	IF CHARINDEX('&deg;', @value) > 0
		SET @textString = REPLACE(@textString, '&deg;','°') ;

	IF CHARINDEX('&plusmn;', @value) > 0
		SET @textString = REPLACE(@textString, '&plusmn;','±') ;

	IF CHARINDEX('&sup2;' , @value) > 0
		SET @textString = REPLACE(@textString, '&sup2;','²') ;

	IF CHARINDEX('&sup3;', @value) > 0
		SET @textString = REPLACE(@textString, '&sup3;','³') ;

	IF CHARINDEX('&acute;', @value) > 0
		SET @textString = REPLACE(@textString, '&acute;','´') ;

	IF CHARINDEX('&micro;', @value) > 0
		SET @textString = REPLACE(@textString, '&micro;','µ') ;

	IF CHARINDEX('&para;', @value) > 0
		SET @textString = REPLACE(@textString, '&para;','¶') ;

	IF CHARINDEX('&middot;', @value) > 0
		SET @textString = REPLACE(@textString, '&middot;','·') ;

	IF CHARINDEX('&cedil;', @value) > 0
		SET @textString = REPLACE(@textString, '&cedil;','¸') ;

	IF CHARINDEX('&sup1;', @value) > 0
		SET @textString = REPLACE(@textString, '&sup1;','¹') ;

	IF CHARINDEX('&ordm;', @value) > 0
		SET @textString = REPLACE(@textString, '&ordm;','º') ;

	IF CHARINDEX('&raquo;', @value) > 0
		SET @textString = REPLACE(@textString, '&raquo;','»') ;

	IF CHARINDEX('&frac14;', @value) > 0
		SET @textString = REPLACE(@textString, '&frac14;','¼') ;

	IF CHARINDEX('&frac12;', @value) > 0
		SET @textString = REPLACE(@textString, '&frac12;','½') ;

	IF CHARINDEX('&frac34;', @value) > 0
		SET @textString = REPLACE(@textString, '&frac34;','¾') ;

	IF CHARINDEX('&iquest;', @value) > 0
		SET @textString = REPLACE(@textString, '&iquest;','¿') ;

	IF CHARINDEX('&times;', @value) > 0
		SET @textString = REPLACE(@textString, '&times;','×') ;

	IF CHARINDEX('&divide;', @value) > 0
		SET @textString = REPLACE(@textString, '&divide;','÷') ;

	IF CHARINDEX('&Agrave;', @value) > 0
		SET @textString = REPLACE(@textString, '&Agrave;','À') ;

	IF CHARINDEX('&Aacute;', @value) > 0
		SET @textString = REPLACE(@textString, '&Aacute;','Á') ;

	IF CHARINDEX('&Acirc;', @value) > 0
		SET @textString = REPLACE(@textString, '&Acirc;','Â') ;

	IF CHARINDEX('&Atilde;', @value) > 0
		SET @textString = REPLACE(@textString, '&Atilde;','Ã') ;

	IF CHARINDEX('&Auml;', @value) > 0
		SET @textString = REPLACE(@textString, '&Auml;','Ä') ;

	IF CHARINDEX('&Aring;', @value) > 0
		SET @textString = REPLACE(@textString, '&Aring;','Å') ;

	IF CHARINDEX('&AElig;', @value) > 0
		SET @textString = REPLACE(@textString, '&AElig;','Æ') ;

	IF CHARINDEX('&Ccedil;', @value) > 0
		SET @textString = REPLACE(@textString, '&Ccedil;','Ç') ;

	IF CHARINDEX('&Egrave;', @value) > 0
		SET @textString = REPLACE(@textString, '&Egrave;','È') ;

	IF CHARINDEX('&Eacute;', @value) > 0
		SET @textString = REPLACE(@textString, '&Eacute;','É') ;

	IF CHARINDEX('&Ecirc;', @value) > 0
		SET @textString = REPLACE(@textString, '&Ecirc;','Ê') ;

	IF CHARINDEX('&Euml;', @value) > 0
		SET @textString = REPLACE(@textString, '&Euml;','Ë') ;

	IF CHARINDEX('&Igrave;', @value) > 0
		SET @textString = REPLACE(@textString, '&Igrave;','Ì') ;

	IF CHARINDEX('&Iacute;', @value) > 0
		SET @textString = REPLACE(@textString, '&Iacute;','Í') ;

	IF CHARINDEX('&Icirc;', @value) > 0
		SET @textString = REPLACE(@textString, '&Icirc;','Î') ;

	IF CHARINDEX('&Iuml;', @value) > 0
		SET @textString = REPLACE(@textString, '&Iuml;','Ï') ;

	IF CHARINDEX('&ETH;', @value) > 0
		SET @textString = REPLACE(@textString, '&ETH;','Ð') ;

	IF CHARINDEX('&Ntilde;', @value) > 0
		SET @textString = REPLACE(@textString, '&Ntilde;','Ñ') ;

	IF CHARINDEX('&Ograve;', @value) > 0
		SET @textString = REPLACE(@textString, '&Ograve;','Ò') ;

	IF CHARINDEX('&Oacute;', @value) > 0
		SET @textString = REPLACE(@textString, '&Oacute;','Ó') ;

	IF CHARINDEX('&Ocirc;', @value) > 0
		SET @textString = REPLACE(@textString, '&Ocirc;','Ô') ;

	IF CHARINDEX('&Otilde;', @value) > 0
		SET @textString = REPLACE(@textString, '&Otilde;','Õ') ;

	IF CHARINDEX('&Ouml;', @value) > 0
		SET @textString = REPLACE(@textString, '&Ouml;','Ö') ;

	IF CHARINDEX('&Oslash;', @value) > 0
		SET @textString = REPLACE(@textString, '&Oslash;','Ø') ;

	IF CHARINDEX('&Ugrave;', @value) > 0
		SET @textString = REPLACE(@textString, '&Ugrave;','Ù') ;

	IF CHARINDEX('&Uacute;', @value) > 0
		SET @textString = REPLACE(@textString, '&Uacute;','Ú') ;

	IF CHARINDEX('&Ucirc;', @value) > 0
		SET @textString = REPLACE(@textString, '&Ucirc;','Û') ;

	IF CHARINDEX('&Uuml;', @value) > 0
		SET @textString = REPLACE(@textString, '&Uuml;','Ü') ;


	IF CHARINDEX('&Yacute;', @value) > 0
		SET @textString = REPLACE(@textString, '&Yacute;','Ý') ;


	IF CHARINDEX('&THORN;', @value) > 0
		SET @textString = REPLACE(@textString, '&THORN;','Þ') ;


	IF CHARINDEX('&szlig;', @value) > 0
		SET @textString = REPLACE(@textString, '&szlig;','ß') ;


	IF CHARINDEX('&agrave;', @value) > 0
		SET @textString = REPLACE(@textString, '&agrave;','à') ;


	IF CHARINDEX('&aacute;', @value) > 0
		SET @textString = REPLACE(@textString, '&aacute;','á') ;

	IF CHARINDEX('&acirc;', @value) > 0
		SET @textString = REPLACE(@textString, '&acirc;','â') ;

	IF CHARINDEX('&atilde;', @value) > 0
		SET @textString = REPLACE(@textString, '&atilde;','ã') ;

	IF CHARINDEX('&auml;', @value) > 0
		SET @textString = REPLACE(@textString, '&auml;','ä') ;

	IF CHARINDEX('&aring;', @value) > 0
		SET @textString = REPLACE(@textString, '&aring;','å') ;

	IF CHARINDEX('&aelig;', @value) > 0
		SET @textString = REPLACE(@textString, '&aelig;','æ') ;

	IF CHARINDEX('&ccedil;', @value) > 0
		SET @textString = REPLACE(@textString, '&ccedil;','ç') ;

	IF CHARINDEX('&egrave;', @value) > 0
		SET @textString = REPLACE(@textString, '&egrave;','è') ;

	IF CHARINDEX('&eacute;', @value) > 0
		SET @textString = REPLACE(@textString, '&eacute;','é') ;

	IF CHARINDEX('&ecirc;', @value) > 0
		SET @textString = REPLACE(@textString, '&ecirc;','ê') ;

	IF CHARINDEX('&euml;', @value) > 0
		SET @textString = REPLACE(@textString, '&euml;','ë') ;

	IF CHARINDEX('&igrave;', @value) > 0
		SET @textString = REPLACE(@textString, '&igrave;','ì') ;

	IF CHARINDEX('&iacute;', @value) > 0
		SET @textString = REPLACE(@textString, '&iacute;','í') ;

	IF CHARINDEX('&icirc;', @value) > 0
		SET @textString = REPLACE(@textString, '&icirc;','î') ;

	IF CHARINDEX('&iuml;', @value) > 0
		SET @textString = REPLACE(@textString, '&iuml;','ï') ;

	IF CHARINDEX('&eth;', @value) > 0
		SET @textString = REPLACE(@textString, '&eth;','ð') ;

	IF CHARINDEX('&ntilde;', @value) > 0
		SET @textString = REPLACE(@textString, '&ntilde;','ñ') ;

	IF CHARINDEX('&ograve;', @value) > 0
		SET @textString = REPLACE(@textString, '&ograve;','ò') ;

	IF CHARINDEX('&oacute;', @value) > 0
		SET @textString = REPLACE(@textString, '&oacute;','ó') ;

	IF CHARINDEX('&ocirc;', @value) > 0
		SET @textString = REPLACE(@textString, '&ocirc;','ô') ;

	IF CHARINDEX('&otilde;', @value) > 0
		SET @textString = REPLACE(@textString, '&otilde;','õ') ;

	IF CHARINDEX('&ouml;', @value) > 0
		SET @textString = REPLACE(@textString, '&ouml;','ö') ;

	IF CHARINDEX('&oslash;', @value) > 0
		SET @textString = REPLACE(@textString, '&oslash;','ø') ;

	IF CHARINDEX('&ugrave;', @value) > 0
		SET @textString = REPLACE(@textString, '&ugrave;','ù') ;

	IF CHARINDEX('&uacute;', @value) > 0
		SET @textString = REPLACE(@textString, '&uacute;','ú') ;

	IF CHARINDEX('&ucirc;', @value) > 0
		SET @textString = REPLACE(@textString, '&ucirc;','û') ;

	IF CHARINDEX('&uuml;', @value) > 0
		SET @textString = REPLACE(@textString, '&uuml;','ü') ;

	IF CHARINDEX('&yacute;', @value) > 0
		SET @textString = REPLACE(@textString, '&yacute;','ý') ;

	IF CHARINDEX('&thorn;', @value) > 0
		SET @textString = REPLACE(@textString, '&thorn;','þ') ;

	IF CHARINDEX('&yuml;', @value) > 0
		SET @textString = REPLACE(@textString, '&yuml;','ÿ') ;

	RETURN @textString;
END;
GO

CREATE FUNCTION convert_uai(@value NVARCHAR(max)) RETURNS NVARCHAR(max)
BEGIN
    DECLARE @convert NVARCHAR(max);
        SET @convert = REPLACE(@value , 'Ã¡', 'á');
        SET @convert = REPLACE(@convert , 'Ã©', 'é');
        SET @convert = REPLACE(@convert , 'Ã*', 'í');
        SET @convert = REPLACE(@convert , 'Ã³', 'ó');
        SET @convert = REPLACE(@convert , 'Ãº', 'ú');
        SET @convert = REPLACE(@convert , 'Ã ', 'à');
        SET @convert = REPLACE(@convert , 'Ã¨', 'è');
        SET @convert = REPLACE(@convert , 'Ã¬', 'ì');
        SET @convert = REPLACE(@convert , 'Ã²', 'ò');
        SET @convert = REPLACE(@convert , 'Ã¹', 'ù');
        SET @convert = REPLACE(@convert , 'Ã¤', 'ä');
        SET @convert = REPLACE(@convert , 'Ã«', 'ë');
        SET @convert = REPLACE(@convert , 'Ã¯', 'ï');
        SET @convert = REPLACE(@convert , 'Ã¶', 'ö');
        SET @convert = REPLACE(@convert , 'Ã¼', 'ü');
        SET @convert = REPLACE(@convert , 'Ã', 'Á');
        SET @convert = REPLACE(@convert , 'Ã', 'É');
        SET @convert = REPLACE(@convert , 'Ã', 'Í');
        SET @convert = REPLACE(@convert , 'Ã', 'Ó');
        SET @convert = REPLACE(@convert , 'Ã', 'Ú');
        SET @convert = REPLACE(@convert , 'Ã', 'Ñ');
        SET @convert = REPLACE(@convert , 'Ã', 'À');
        SET @convert = REPLACE(@convert , 'Ã', 'È');
        SET @convert = REPLACE(@convert , 'Ã', 'Ì');
        SET @convert = REPLACE(@convert , 'Ã', 'Ò');
        SET @convert = REPLACE(@convert , 'Ã', 'Ù');
        SET @convert = REPLACE(@convert , 'Ã', 'Ñ');
        SET @convert = REPLACE(@convert , 'Ã', 'Ä');
        SET @convert = REPLACE(@convert , 'Ã', 'Ë');
        SET @convert = REPLACE(@convert , 'Ã', 'Ï');
        SET @convert = REPLACE(@convert, 'Ã', 'Ö');
        SET @convert = REPLACE(@convert , 'Ã', 'Ü');
    RETURN @convert;
END

GO

CREATE FUNCTION INSTR(@str VARCHAR(8000), @substr VARCHAR(255), @start INT, @occurrence INT) RETURNS INT
AS
BEGIN
	DECLARE @found INT = @occurrence, @pos INT = @start;
	WHILE 1=1
		BEGIN
			SET @pos = CHARINDEX(@substr, @str, @pos);
			IF @pos IS NULL OR @pos = 0
				RETURN @pos;
			IF @found = 1
				BREAK;
			SET @found = @found - 1;
			SET @pos = @pos + 1;
		END
	RETURN @pos;
END
GO

SELECT dbo.str_clean('hola  <script>dede</script> is :3',1, 1, 1, 1, 1, 1, 1, 1);
go

drop function str_clean;
go

select 1 where 'hola  <script>dede</script> holis :3' like '%[<[^>]*>]%';
go

create function str_clean(@p_text nvarchar(max), @p_convert_uai bit, @p_remove_multiple_blanks bit, @p_remove_linebreaks bit, @p_remove_tabs bit, @p_remove_multiple_backslashes bit, @p_remove_htmlentities bit, @p_html_unencode bit, @p_remove_html bit) returns nvarchar(max)
BEGIN
	DECLARE @v_result nvarchar(max);
	DECLARE @v_start INT;
	DECLARE @v_end INT;
	DECLARE @v_len INT;
    SET @v_result = LTRIM(RTRIM(@p_text));
    IF (@p_remove_linebreaks = 1 )
        SET @v_result = REPLACE( @v_result ,CHAR(13),' ');
        SET @v_result = REPLACE( @v_result ,CHAR(10),' ');
    IF (@p_remove_tabs = 1 )
        SET @v_result = REPLACE( @v_result ,CHAR(9),' ');
	IF (@p_convert_uai = 1)
		SET @v_result = dbo.convert_uai(@v_result);
    IF (@p_remove_multiple_blanks = 1 )
        SET @v_result = REPLACE(REPLACE( @v_result,'  ',' '),'   ',' ');
        SET @v_result = REPLACE(REPLACE( @v_result,'  ',' '),'   ',' ');
        SET @v_result = REPLACE(REPLACE( @v_result,'  ',' '),'   ',' ');
        SET @v_result = REPLACE(REPLACE( @v_result,'  ',' '),'   ',' ');
        SET @v_result = REPLACE(REPLACE( @v_result,'  ',' '),'   ',' ');
    IF (@p_remove_multiple_backslashes = 1 )
        SET @v_result = REPLACE(REPLACE(REPLACE( @v_result,'\',''),'\"','"'),'\\','\');
    IF (@p_remove_htmlentities = 1 )
		IF EXISTS(select 1 where @v_result like '%[&*;]%')
			WHILE (CHARINDEX('&', @v_result) > 0 AND CHARINDEX(';', @v_result) > 0 AND CHARINDEX('&', @v_result) > 0)
			BEGIN
				SET @v_start = CHARINDEX('&', @v_result);
                SET @v_end   = CHARINDEX(';', @v_result);
                IF (@v_end > 0)
					SET @v_len = (@v_end - @v_start) + 1;
				ELSE
					SET @v_end = CHARINDEX('&', @v_result);
					SET @v_len = (@v_end - @v_start) + 1;
				IF (@v_len > 0)
					SET @v_result = REPLACE(@v_result, SUBSTRING(@v_result, @v_start, @v_end - 1), '');
			END
    IF (@p_remove_html = 1 )
        IF EXISTS(select 1 where @v_result like '%[<>]%')
			WHILE (CHARINDEX('<', @v_result) > 0 AND CHARINDEX('>', @v_result) > 0 AND CHARINDEX('<', @v_result) > 0)
			BEGIN
				SET @v_start = CHARINDEX('<', @v_result);
                SET @v_end   = CHARINDEX('>', @v_result);
                SET @v_len   = (@v_end - @v_start) + 1;
                IF (@v_len > 0)
					SET @v_result = REPLACE(@v_result, SUBSTRING(@v_result, @v_start, @v_len), '');
			END
    IF (@p_html_unencode = 1 )
        IF EXISTS(select 1 where @v_result like '%[&*;]%')
            SET @v_result = dbo.str_html_unencode(@v_result);
    RETURN @v_result;
END;
GO

SELECT SUBSTRING('HELLO WORLD',6,5);
--(<[^>]*>)(?<=>)([\w\s]+)(?=<\/)(<[^>]*>)