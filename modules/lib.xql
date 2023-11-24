xquery version "3.0";

(: Based on https://github.com/joewiz/exist/wiki/xqsuite :)
(: Uses project-specific namespaces :)

module namespace f="http://www.obdurodon.org";

declare function f:factorial($n as xs:int) as xs:int {
    if ($n = 1) then
        1
    else
       $n * f:factorial($n - 1)
};
