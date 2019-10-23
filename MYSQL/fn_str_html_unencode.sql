
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES';
DELIMITER $$

DROP FUNCTION IF EXISTS str_html_unencode$$
CREATE FUNCTION str_html_unencode(x TEXT) RETURNS TEXT 
BEGIN

DECLARE TextString VARCHAR(255) ;
SET TextString = x ;

#quotation mark
IF INSTR( x , '&quot;' )
THEN SET TextString = REPLACE(TextString, '&quot;','"') ;
END IF ;

#apostrophe 
IF INSTR( x , '&apos;' )
THEN SET TextString = REPLACE(TextString, '&apos;','"') ;
END IF ;

#ampersand
IF INSTR( x , '&amp;' )
THEN SET TextString = REPLACE(TextString, '&amp;','&') ;
END IF ;

#less-than
IF INSTR( x , '&lt;' )
THEN SET TextString = REPLACE(TextString, '&lt;','<') ;
END IF ;

#greater-than
IF INSTR( x , '&gt;' )
THEN SET TextString = REPLACE(TextString, '&gt;','>') ;
END IF ;

#non-breaking space
IF INSTR( x , '&nbsp;' )
THEN SET TextString = REPLACE(TextString, '&nbsp;',' ') ;
END IF ;

#inverted exclamation mark
IF INSTR( x , '&iexcl;' )
THEN SET TextString = REPLACE(TextString, '&iexcl;','¡') ;
END IF ;

#cent
IF INSTR( x , '&cent;' )
THEN SET TextString = REPLACE(TextString, '&cent;','¢') ;
END IF ;

#pound
IF INSTR( x , '&pound;' )
THEN SET TextString = REPLACE(TextString, '&pound;','£') ;
END IF ;

#currency
IF INSTR( x , '&curren;' )
THEN SET TextString = REPLACE(TextString, '&curren;','¤') ;
END IF ;

#yen
IF INSTR( x , '&yen;' )
THEN SET TextString = REPLACE(TextString, '&yen;','¥') ;
END IF ;

#broken vertical bar
IF INSTR( x , '&brvbar;' )
THEN SET TextString = REPLACE(TextString, '&brvbar;','¦') ;
END IF ;

#section
IF INSTR( x , '&sect;' )
THEN SET TextString = REPLACE(TextString, '&sect;','§') ;
END IF ;

#spacing diaeresis
IF INSTR( x , '&uml;' )
THEN SET TextString = REPLACE(TextString, '&uml;','¨') ;
END IF ;

#copyright
IF INSTR( x , '&copy;' )
THEN SET TextString = REPLACE(TextString, '&copy;','©') ;
END IF ;

#feminine ordinal indicator
IF INSTR( x , '&ordf;' )
THEN SET TextString = REPLACE(TextString, '&ordf;','ª') ;
END IF ;

#angle quotation mark (left)
IF INSTR( x , '&laquo;' )
THEN SET TextString = REPLACE(TextString, '&laquo;','«') ;
END IF ;

#negation
IF INSTR( x , '&not;' )
THEN SET TextString = REPLACE(TextString, '&not;','¬') ;
END IF ;

#soft hyphen
IF INSTR( x , '&shy;' )
THEN SET TextString = REPLACE(TextString, '&shy;','­') ;
END IF ;

#registered trademark
IF INSTR( x , '&reg;' )
THEN SET TextString = REPLACE(TextString, '&reg;','®') ;
END IF ;

#spacing macron
IF INSTR( x , '&macr;' )
THEN SET TextString = REPLACE(TextString, '&macr;','¯') ;
END IF ;

#degree
IF INSTR( x , '&deg;' )
THEN SET TextString = REPLACE(TextString, '&deg;','°') ;
END IF ;

#plus-or-minus 
IF INSTR( x , '&plusmn;' )
THEN SET TextString = REPLACE(TextString, '&plusmn;','±') ;
END IF ;

#superscript 2
IF INSTR( x , '&sup2;' )
THEN SET TextString = REPLACE(TextString, '&sup2;','²') ;
END IF ;

#superscript 3
IF INSTR( x , '&sup3;' )
THEN SET TextString = REPLACE(TextString, '&sup3;','³') ;
END IF ;

#spacing acute
IF INSTR( x , '&acute;' )
THEN SET TextString = REPLACE(TextString, '&acute;','´') ;
END IF ;

#micro
IF INSTR( x , '&micro;' )
THEN SET TextString = REPLACE(TextString, '&micro;','µ') ;
END IF ;

#paragraph
IF INSTR( x , '&para;' )
THEN SET TextString = REPLACE(TextString, '&para;','¶') ;
END IF ;

#middle dot
IF INSTR( x , '&middot;' )
THEN SET TextString = REPLACE(TextString, '&middot;','·') ;
END IF ;

#spacing cedilla
IF INSTR( x , '&cedil;' )
THEN SET TextString = REPLACE(TextString, '&cedil;','¸') ;
END IF ;

#superscript 1
IF INSTR( x , '&sup1;' )
THEN SET TextString = REPLACE(TextString, '&sup1;','¹') ;
END IF ;

#masculine ordinal indicator
IF INSTR( x , '&ordm;' )
THEN SET TextString = REPLACE(TextString, '&ordm;','º') ;
END IF ;

#angle quotation mark (right)
IF INSTR( x , '&raquo;' )
THEN SET TextString = REPLACE(TextString, '&raquo;','»') ;
END IF ;

#fraction 1/4
IF INSTR( x , '&frac14;' )
THEN SET TextString = REPLACE(TextString, '&frac14;','¼') ;
END IF ;

#fraction 1/2
IF INSTR( x , '&frac12;' )
THEN SET TextString = REPLACE(TextString, '&frac12;','½') ;
END IF ;

#fraction 3/4
IF INSTR( x , '&frac34;' )
THEN SET TextString = REPLACE(TextString, '&frac34;','¾') ;
END IF ;

#inverted question mark
IF INSTR( x , '&iquest;' )
THEN SET TextString = REPLACE(TextString, '&iquest;','¿') ;
END IF ;

#multiplication
IF INSTR( x , '&times;' )
THEN SET TextString = REPLACE(TextString, '&times;','×') ;
END IF ;

#division
IF INSTR( x , '&divide;' )
THEN SET TextString = REPLACE(TextString, '&divide;','÷') ;
END IF ;

#capital a, grave accent
IF INSTR( x , '&Agrave;' )
THEN SET TextString = REPLACE(TextString, '&Agrave;','À') ;
END IF ;

#capital a, acute accent
IF INSTR( x , '&Aacute;' )
THEN SET TextString = REPLACE(TextString, '&Aacute;','Á') ;
END IF ;

#capital a, circumflex accent
IF INSTR( x , '&Acirc;' )
THEN SET TextString = REPLACE(TextString, '&Acirc;','Â') ;
END IF ;

#capital a, tilde
IF INSTR( x , '&Atilde;' )
THEN SET TextString = REPLACE(TextString, '&Atilde;','Ã') ;
END IF ;

#capital a, umlaut mark
IF INSTR( x , '&Auml;' )
THEN SET TextString = REPLACE(TextString, '&Auml;','Ä') ;
END IF ;

#capital a, ring
IF INSTR( x , '&Aring;' )
THEN SET TextString = REPLACE(TextString, '&Aring;','Å') ;
END IF ;

#capital ae
IF INSTR( x , '&AElig;' )
THEN SET TextString = REPLACE(TextString, '&AElig;','Æ') ;
END IF ;

#capital c, cedilla
IF INSTR( x , '&Ccedil;' )
THEN SET TextString = REPLACE(TextString, '&Ccedil;','Ç') ;
END IF ;

#capital e, grave accent
IF INSTR( x , '&Egrave;' )
THEN SET TextString = REPLACE(TextString, '&Egrave;','È') ;
END IF ;

#capital e, acute accent
IF INSTR( x , '&Eacute;' )
THEN SET TextString = REPLACE(TextString, '&Eacute;','É') ;
END IF ;

#capital e, circumflex accent
IF INSTR( x , '&Ecirc;' )
THEN SET TextString = REPLACE(TextString, '&Ecirc;','Ê') ;
END IF ;

#capital e, umlaut mark
IF INSTR( x , '&Euml;' )
THEN SET TextString = REPLACE(TextString, '&Euml;','Ë') ;
END IF ;

#capital i, grave accent
IF INSTR( x , '&Igrave;' )
THEN SET TextString = REPLACE(TextString, '&Igrave;','Ì') ;
END IF ;

#capital i, acute accent
IF INSTR( x , '&Iacute;' )
THEN SET TextString = REPLACE(TextString, '&Iacute;','Í') ;
END IF ;

#capital i, circumflex accent
IF INSTR( x , '&Icirc;' )
THEN SET TextString = REPLACE(TextString, '&Icirc;','Î') ;
END IF ;

#capital i, umlaut mark
IF INSTR( x , '&Iuml;' )
THEN SET TextString = REPLACE(TextString, '&Iuml;','Ï') ;
END IF ;

#capital eth, Icelandic
IF INSTR( x , '&ETH;' )
THEN SET TextString = REPLACE(TextString, '&ETH;','Ð') ;
END IF ;

#capital n, tilde
IF INSTR( x , '&Ntilde;' )
THEN SET TextString = REPLACE(TextString, '&Ntilde;','Ñ') ;
END IF ;

#capital o, grave accent
IF INSTR( x , '&Ograve;' )
THEN SET TextString = REPLACE(TextString, '&Ograve;','Ò') ;
END IF ;

#capital o, acute accent
IF INSTR( x , '&Oacute;' )
THEN SET TextString = REPLACE(TextString, '&Oacute;','Ó') ;
END IF ;

#capital o, circumflex accent
IF INSTR( x , '&Ocirc;' )
THEN SET TextString = REPLACE(TextString, '&Ocirc;','Ô') ;
END IF ;

#capital o, tilde
IF INSTR( x , '&Otilde;' )
THEN SET TextString = REPLACE(TextString, '&Otilde;','Õ') ;
END IF ;

#capital o, umlaut mark
IF INSTR( x , '&Ouml;' )
THEN SET TextString = REPLACE(TextString, '&Ouml;','Ö') ;
END IF ;

#capital o, slash
IF INSTR( x , '&Oslash;' )
THEN SET TextString = REPLACE(TextString, '&Oslash;','Ø') ;
END IF ;

#capital u, grave accent
IF INSTR( x , '&Ugrave;' )
THEN SET TextString = REPLACE(TextString, '&Ugrave;','Ù') ;
END IF ;

#capital u, acute accent
IF INSTR( x , '&Uacute;' )
THEN SET TextString = REPLACE(TextString, '&Uacute;','Ú') ;
END IF ;

#capital u, circumflex accent
IF INSTR( x , '&Ucirc;' )
THEN SET TextString = REPLACE(TextString, '&Ucirc;','Û') ;
END IF ;

#capital u, umlaut mark
IF INSTR( x , '&Uuml;' )
THEN SET TextString = REPLACE(TextString, '&Uuml;','Ü') ;
END IF ;

#capital y, acute accent
IF INSTR( x , '&Yacute;' )
THEN SET TextString = REPLACE(TextString, '&Yacute;','Ý') ;
END IF ;

#capital THORN, Icelandic
IF INSTR( x , '&THORN;' )
THEN SET TextString = REPLACE(TextString, '&THORN;','Þ') ;
END IF ;

#small sharp s, German
IF INSTR( x , '&szlig;' )
THEN SET TextString = REPLACE(TextString, '&szlig;','ß') ;
END IF ;

#small a, grave accent
IF INSTR( x , '&agrave;' )
THEN SET TextString = REPLACE(TextString, '&agrave;','à') ;
END IF ;

#small a, acute accent
IF INSTR( x , '&aacute;' )
THEN SET TextString = REPLACE(TextString, '&aacute;','á') ;
END IF ;

#small a, circumflex accent
IF INSTR( x , '&acirc;' )
THEN SET TextString = REPLACE(TextString, '&acirc;','â') ;
END IF ;

#small a, tilde
IF INSTR( x , '&atilde;' )
THEN SET TextString = REPLACE(TextString, '&atilde;','ã') ;
END IF ;

IF INSTR( x , '&auml;' )
THEN SET TextString = REPLACE(TextString, '&auml;','ä') ;
END IF ;

IF INSTR( x , '&aring;' )
THEN SET TextString = REPLACE(TextString, '&aring;','å') ;
END IF ;

IF INSTR( x , '&aelig;' )
THEN SET TextString = REPLACE(TextString, '&aelig;','æ') ;
END IF ;

IF INSTR( x , '&ccedil;' )
THEN SET TextString = REPLACE(TextString, '&ccedil;','ç') ;
END IF ;

IF INSTR( x , '&egrave;' )
THEN SET TextString = REPLACE(TextString, '&egrave;','è') ;
END IF ;

IF INSTR( x , '&eacute;' )
THEN SET TextString = REPLACE(TextString, '&eacute;','é') ;
END IF ;

IF INSTR( x , '&ecirc;' )
THEN SET TextString = REPLACE(TextString, '&ecirc;','ê') ;
END IF ;

IF INSTR( x , '&euml;' )
THEN SET TextString = REPLACE(TextString, '&euml;','ë') ;
END IF ;

IF INSTR( x , '&igrave;' )
THEN SET TextString = REPLACE(TextString, '&igrave;','ì') ;
END IF ;

IF INSTR( x , '&iacute;' )
THEN SET TextString = REPLACE(TextString, '&iacute;','í') ;
END IF ;

IF INSTR( x , '&icirc;' )
THEN SET TextString = REPLACE(TextString, '&icirc;','î') ;
END IF ;

IF INSTR( x , '&iuml;' )
THEN SET TextString = REPLACE(TextString, '&iuml;','ï') ;
END IF ;

IF INSTR( x , '&eth;' )
THEN SET TextString = REPLACE(TextString, '&eth;','ð') ;
END IF ;

IF INSTR( x , '&ntilde;' )
THEN SET TextString = REPLACE(TextString, '&ntilde;','ñ') ;
END IF ;

IF INSTR( x , '&ograve;' )
THEN SET TextString = REPLACE(TextString, '&ograve;','ò') ;
END IF ;

IF INSTR( x , '&oacute;' )
THEN SET TextString = REPLACE(TextString, '&oacute;','ó') ;
END IF ;

IF INSTR( x , '&ocirc;' )
THEN SET TextString = REPLACE(TextString, '&ocirc;','ô') ;
END IF ;

IF INSTR( x , '&otilde;' )
THEN SET TextString = REPLACE(TextString, '&otilde;','õ') ;
END IF ;

IF INSTR( x , '&ouml;' )
THEN SET TextString = REPLACE(TextString, '&ouml;','ö') ;
END IF ;

IF INSTR( x , '&oslash;' )
THEN SET TextString = REPLACE(TextString, '&oslash;','ø') ;
END IF ;

IF INSTR( x , '&ugrave;' )
THEN SET TextString = REPLACE(TextString, '&ugrave;','ù') ;
END IF ;

IF INSTR( x , '&uacute;' )
THEN SET TextString = REPLACE(TextString, '&uacute;','ú') ;
END IF ;

IF INSTR( x , '&ucirc;' )
THEN SET TextString = REPLACE(TextString, '&ucirc;','û') ;
END IF ;

IF INSTR( x , '&uuml;' )
THEN SET TextString = REPLACE(TextString, '&uuml;','ü') ;
END IF ;

IF INSTR( x , '&yacute;' )
THEN SET TextString = REPLACE(TextString, '&yacute;','ý') ;
END IF ;

IF INSTR( x , '&thorn;' )
THEN SET TextString = REPLACE(TextString, '&thorn;','þ') ;
END IF ;

IF INSTR( x , '&yuml;' )
THEN SET TextString = REPLACE(TextString, '&yuml;','ÿ') ;
END IF ;

RETURN TextString ;

END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
