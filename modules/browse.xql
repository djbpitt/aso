xquery version "3.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace rep="http://www.ilit.bas.bg/repertorium/ns/3.0";
declare function local:normalize($input as xs:string?) as xs:string? {
    if ($input) then replace(normalize-space($input),'\p{P}$','') else ()
};
let $mss := collection('/db/aso/mss')
for $ms in $mss 
let $uri := substring-before(tokenize(base-uri($ms),'/')[last()],'.xml')
let $msIdentifier := $ms//tei:msIdentifier
let $msId := 
      (string-join(
        (local:normalize($msIdentifier/tei:country),
        local:normalize($msIdentifier/tei:settlement), 
        local:normalize($msIdentifier/tei:repository), 
        local:normalize($msIdentifier/tei:idno[@type='shelfmark'])
      ),', '),
      if ($msIdentifier/tei:idno[@type='catalogue']) then 
          concat(' (',$msIdentifier/tei:idno[@type='catalogue']/local:normalize(.),')') else ())      
let $msName := string-join(($ms//tei:msName[@type='general']/local:normalize(.),$ms//tei:msName[@type='individual']/local:normalize(.)),'. ')
order by $msId[1]
return
    <li>{$msId} (<a href="http://aso.obdurodon.org/html/{$uri}.html">{$uri}</a> <a href="http://aso.obdurodon.org/xml/{$uri}.xml"><img alt="[XML]" title="[XML]" src="images/xml.gif"/></a>)
        <br/>
    <span class="msName">{$msName}</span>
    </li>