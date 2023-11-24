xquery version "3.1";

declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace m = "http://repertorium.obdurodon.org/model";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "xml";
declare option output:indent "no";

(: Housekeeping :)
declare variable $exist:root as xs:string := (request:get-attribute("$exist:root"), "xmldb:exist:///db/apps")[1];
declare variable $exist:controller as xs:string := (request:get-attribute("$exist:controller"), "/Slovo-Aso")[1];
declare variable $pathToMss as xs:string := concat($exist:root, $exist:controller, '/data');
declare variable $mss as document-node()+ := collection($pathToMss);

declare function local:normalize($input as xs:string?) as xs:string? {
  if ($input) then
    replace(normalize-space($input), '\p{P}$', '')
  else
    ()
};
<m:main>
  <m:header>
    <m:title>Browse the collection</m:title>
  </m:header>
  <m:body>{
    for $ms in $mss
    let $uri as xs:string := substring-before(tokenize(base-uri($ms), '/')[last()], '.xml')
    let $name as xs:string? := $ms/descendant::tei:msIdentifier/tei:msName ! local:normalize(.) => string-join('; ')
    let $country as xs:string := $ms/descendant::tei:msIdentifier/tei:country ! local:normalize(.)
    let $settlement as xs:string := $ms/descendant::tei:msIdentifier/tei:settlement ! local:normalize(.)
    let $repository as xs:string := $ms/descendant::tei:msIdentifier/tei:repository ! local:normalize(.)
    let $shelfmark as xs:string := $ms/descendant::tei:msIdentifier/tei:idno[@type eq 'shelfmark'] ! local:normalize(.)
    let $catalog as xs:string? := $ms/descendant::tei:msIdentifier/tei:idno[@type eq 'catalogue'] ! local:normalize(.)
    let $filename as xs:string := ($ms ! base-uri(.) ! tokenize(., '/'))[last()] ! substring-before(., '.xml')
    order by $country, $settlement, $repository, $shelfmark, $catalog
    return
      <m:ms>
        <m:country>{$country}</m:country>
        <m:settlement>{$settlement}</m:settlement>
        <m:repository>{$repository}</m:repository>
        <m:shelfmark>{$shelfmark}</m:shelfmark>
        {$catalog ! <m:catalog>{.}</m:catalog>}
        <m:name>{$name}</m:name>
        <m:filename>{$filename}</m:filename>
      </m:ms>
  }</m:body>
</m:main>
