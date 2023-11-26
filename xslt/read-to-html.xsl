<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:re="http://repertorium.obdurodon.org/model" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:math="http://www.w3.org/2005/xpath-functions/math"
  xpath-default-namespace="http://repertorium.obdurodon.org/model"
  xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="#all" version="3.0">
  <xsl:function name="re:titleCase" as="xs:string">
    <xsl:param name="input" as="xs:string"/>
    <xsl:sequence select="substring($input, 1, 1) ! upper-case(.) || substring($input, 2)"/>
  </xsl:function>
  <xsl:template match="main">
    <main id="read">
      <xsl:apply-templates select="msIdentifier"/>
      <table>
        <xsl:apply-templates select="* except msIdentifier"/>
      </table>
    </main>
  </xsl:template>
  <!-- ================================================================== -->
  <!-- msIdentifier, altIdentifier                                        -->
  <!-- ================================================================== -->
  <xsl:template match="msIdentifier/identifier">
    <h2>
      <xsl:apply-templates select="name"/>
    </h2>
    <h3>
      <xsl:apply-templates select="location"/>
    </h3>
  </xsl:template>
  <xsl:template match="location">
    <xsl:value-of select="string-join((country, settlement, repository, shelfmark), ', ') || '. '"/>
    <xsl:apply-templates select="catalog, collection"/>
  </xsl:template>
  <xsl:template match="catalog | collection">
    <span class="label">
      <xsl:value-of select="re:titleCase(name()) || ': '"/>
    </span>
    <xsl:apply-templates/>
    <xsl:text>. </xsl:text>
  </xsl:template>
  <xsl:template match="identifiers/identifier">
    <!-- ================================================================ -->
    <!-- altIdentifier                                                    -->
    <!-- ================================================================ -->
    <p>
      <span class="label">Alternative identifier: </span>
      <xsl:apply-templates select="location"/>
    </p>
  </xsl:template>
  <!-- ================================================================== -->
  <!-- Physical description                                               -->
  <!-- ================================================================== -->
  <xsl:template match="physDesc">
    <tr>
      <th>Physical description</th>
      <td>
        <xsl:apply-templates/>
      </td>
    </tr>
  </xsl:template>
  <xsl:template match="material | extent | layout | decoration | condition | additions">
    <span class="label">
      <xsl:value-of select="re:titleCase(name())"/>
      <xsl:text>: </xsl:text>
    </span>
    <xsl:apply-templates/>
    <xsl:if test="not(matches(., '\. *$'))">.</xsl:if>
    <xsl:text> </xsl:text>
  </xsl:template>
  <!-- ================================================================== -->
  <!-- Scribes                                                            -->
  <!-- ================================================================== -->
  <xsl:template match="scribes">
    <xsl:if test="exists(scribe/node())">
      <tr>
        <th>
          <xsl:text>Scribe</xsl:text>
          <xsl:if test="count(scribe) gt 1">s</xsl:if>
        </th>
        <td>
          <xsl:apply-templates select="summary"/>
          <ul>
            <xsl:apply-templates select="scribe"/>
          </ul>
          <xsl:apply-templates select="scribeNote"/>
        </td>
      </tr>
    </xsl:if>
  </xsl:template>
  <xsl:template match="scribes/summary">
    <p>
      <span class="label">Summary: </span>
      <xsl:apply-templates/>
    </p>
  </xsl:template>
  <xsl:template match="scribe">
    <li>
      <xsl:apply-templates/>
    </li>
  </xsl:template>
  <xsl:template match="scribe/name">
    <span class="label">Name: </span>
    <xsl:apply-templates/>
    <xsl:text> </xsl:text>
  </xsl:template>
  <xsl:template match="script">
    <span class="label">Hand: </span>
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="scribeNote">
    <p>
      <span class="label">Note: </span>
      <xsl:apply-templates/>
    </p>
  </xsl:template>
  
  <!-- ================================================================== -->
  <!-- Contents                                                           -->
  <!-- ================================================================== -->
  <xsl:template match="contents">
    <xsl:if test="exists(node())">
      <tr>
        <th>Contents</th>
        <td>
          <xsl:apply-templates/>
        </td>
      </tr>
    </xsl:if>
  </xsl:template>
  <!-- ================================================================== -->
  <!-- History                                                            -->
  <!-- ================================================================== -->
  <xsl:template match="history">
    <tr>
      <th>History</th>
      <td>
        <xsl:apply-templates/>
      </td>
    </tr>
  </xsl:template>
  <!-- ================================================================== -->
  <!-- Bibliography                                                       -->
  <!-- ================================================================== -->
  <xsl:template match="bibl">
    <tr>
      <th>Bibliography</th>
      <td>
        <xsl:apply-templates/>
      </td>
    </tr>
  </xsl:template>
</xsl:stylesheet>
