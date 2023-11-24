xquery version "3.1";

declare namespace m = "http://repertorium.obdurodon.org/model";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "xml";
declare option output:indent "no";

<m:main>
  <m:header>
    <m:title>Slovo-ASO: Toward a digital library of South Slavic manuscripts</m:title>
    <m:image
      url="resources/images/conference-RilaBook.jpg"/>
  </m:header>
  <m:body>
    <m:section>
      <m:title>About the project</m:title>
      <m:p>Slovo-ASO was an international project directed by Anisava Miltenova that produced, among other things,
        brief descriptions of 140 South Slavic manuscripts (most from the St. Catherine, Zograph, and Rila
        monasteries) encoded according to the Guidelines developed for the Repertorium of Old Bulgarian Literature
        and Letters. Additional information is available at the main Slovo-ASO web site
        (<m:a
          url="http://slovo-aso.cl.bas.bg/">http://slovo-aso.cl.bas.bg</m:a>) and at the Repertorium web site
        (<m:a
          url="http://repertorium.obdurodon.org">http://repertorium.obdurodon.org</m:a>).</m:p>
    </m:section>
    <m:section>
      <m:title>Manuscripts</m:title>
      <m:ul>
        <m:li><m:a
            url="search">Explore the manuscripts</m:a></m:li>
      </m:ul>
    </m:section>
    <m:section>
      <m:title>Associated projects</m:title>
      <m:ul>
        <m:li><m:a
            url="http://repertorium.obdurodon.org">Repertorium of Old Bulgarian Literature and Letters</m:a></m:li>
        <m:li><m:a
            url="https://slav.uni-sofia.bg/exist/apps/paesnoslovec/">Пѣснословьць</m:a> (hymnographic manuscripts)</m:li>
      </m:ul>
    </m:section>
  </m:body>
</m:main>
