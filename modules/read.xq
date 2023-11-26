xquery version "3.1";

declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace re = "http://www.ilit.bas.bg/repertorium/ns/3.0";
declare namespace m = "http://repertorium.obdurodon.org/model";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "xml";
declare option output:indent "no";
declare variable $exist:root as xs:string :=
request:get-parameter("exist:root", "xmldb:exist:///db/apps");
declare variable $exist:controller as xs:string :=
request:get-parameter("exist:controller", "/Slovo-Aso");
declare variable $id as xs:string :=
request:get-parameter('id', 'ASO_DR_4_14RM');
declare variable $path-to-ms as xs:string := concat($exist:root, $exist:controller, '/data/', $id, '.xml');
declare variable $ms as element(tei:TEI)? :=
doc($path-to-ms)/*;
declare function local:normalize($input as xs:string?) as xs:string? {
  if ($input) then
    replace(normalize-space($input), '\p{P}$', '')
  else
    ()
};

(: 
  $input is <msIdentifier> or <altIdentifier>
  <msIdentifier> must have at least one <msName> child
:)
declare function local:process-identifier($input as element()) as element(m:identifier) {
  let $names as xs:string* := $input/tei:msName ! local:normalize(.)
  let $country as xs:string := $input/tei:country ! local:normalize(.)
  let $settlement as xs:string := $input/tei:settlement ! local:normalize(.)
  let $repository as xs:string := $input/tei:repository ! local:normalize(.)
  let $shelfmark as xs:string? := $input/tei:idno[@type eq 'shelfmark'] ! local:normalize(.)
  let $catalog as xs:string? := $input/tei:idno[@type eq 'catalogue'] ! local:normalize(.)
  let $collection as xs:string? := $input/tei:collection ! local:normalize(.)
  return
    <m:identifier>{
        if (exists($names)) then
          <m:name>{string-join($names, '; ')}</m:name>
        else
          ()
      }
      <m:location>
        <m:country>{$country}</m:country>
        <m:settlement>{$settlement}</m:settlement>
        <m:repository>{$repository}</m:repository>
        {$shelfmark ! <m:shelfmark>{.}</m:shelfmark>}
        {$catalog ! <m:catalog>{.}</m:catalog>}
        {$collection ! <m:collection>{.}</m:collection>}
      </m:location>
    </m:identifier>
};

<m:main>
  <m:identifiers>
    <m:msIdentifier>{local:process-identifier($ms/descendant::tei:msIdentifier)}</m:msIdentifier>
    {
      for $altIdentifier in $ms/descendant::tei:altIdentifier
      return
        local:process-identifier($altIdentifier)
    }
  </m:identifiers>
  <m:physDesc>{
      $ms/descendant::tei:physDesc/descendant::tei:support ! <m:material>{local:normalize(.)}</m:material>,
      $ms/descendant::tei:physDesc/descendant::tei:extent ! <m:extent>{local:normalize(.)}</m:extent>,
      $ms/descendant::tei:physDesc/descendant::tei:layoutDesc ! <m:layout>{string-join(tei:layout, ' ')}</m:layout>,
      $ms/descendant::tei:physDesc/descendant::tei:condition ! <m:condition>{string-join(., ' ')}</m:condition>,
      $ms/descendant::tei:physDesc/descendant::tei:decoDesc ! <m:decoration>{string(.)}</m:decoration>,
      $ms/descendant::tei:physDesc/descendant::tei:additions ! <m:additions>{string(.)}</m:additions>
    }</m:physDesc>
  <!-- Files were validated against DTD and are not namespace-aware; there are inconsistencies in the namespacing -->
  <m:scribes>{
      for $summary in $ms/descendant::*:scribeDesc/*:summary
      return
        <m:summary>{local:normalize($summary)}</m:summary>,
      for $scribe in $ms/descendant::*:scribeDesc/*:scribe
      return
        <m:scribe>{
            for $name in $scribe/*:name
            return
              <m:name>{string($name)}</m:name>,
            if ($scribe/*:scriptDesc[node()] or $scribe/*:scribeLang[node()]) then
              <m:script>{string-join(($scribe/*:scriptDesc, $scribe/*:scribeLang), ' ')}</m:script>
            else
              ()
          }</m:scribe>,
          for $note in $ms/descendant::*:scribeDesc/descendant::*:note
          return
            <m:scribeNote>{local:normalize($note)}</m:scribeNote>
    }</m:scribes>
  <m:contents>{string($ms/descendant::*:msContents)}</m:contents>
  {
    if ($ms/descendant::tei:history) then
      <m:history>{
          for $child in $ms/descendant::tei:history/*
          return
            concat(string-join($child/node(), ' '), ' ')
        }</m:history>
    else
      ()
  }
  <m:bibl>{
      let $bibItems := $ms/descendant::tei:bibl/tei:ref ! local:normalize(.)
      return
        distinct-values($bibItems) => sort() => string-join('; ') || '.'
    }</m:bibl>

</m:main>