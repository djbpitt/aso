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
      <xsl:apply-templates/>
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
    <xsl:value-of select="string-join((country, settlement, repository, shelfmark), ', ')"/>
    <xsl:apply-templates select="catalog"/>
  </xsl:template>
  <xsl:template match="catalog">
    <xsl:text> (</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>) </xsl:text>
  </xsl:template>
  <xsl:template match="altIdentifier">
    <p>
      <span class="label">Alternative identifier:</span>
      <xsl:apply-templates select="location"/>
    </p>
  </xsl:template>
  <!-- ================================================================== -->
  <!-- Bibliography                                                       -->
  <!-- ================================================================== -->
  <xsl:template match="bibl">
    <span class="label">Bibliography: </span>
    <xsl:apply-templates/>
  </xsl:template>
  <!-- ================================================================== -->
  <!-- Physical description                                               -->
  <!-- ================================================================== -->
  <xsl:template match="physDesc">
    <h3>Physical description</h3>
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="material | extent | layout">
    <span class="label">
      <xsl:value-of select="re:titleCase(name())"/>
      <xsl:text>: </xsl:text>
    </span>
    <xsl:apply-templates/>
    <xsl:if test="not(ends-with(., '.'))">.</xsl:if>
    <xsl:text> </xsl:text>
  </xsl:template>
  <!-- ================================================================== -->
  <!-- Scribes                                                            -->
  <!-- ================================================================== -->
  <xsl:template match="scribes">
    <h3>
      <xsl:text>Scribe</xsl:text>
      <xsl:if test="count(scribe) gt 1">s</xsl:if>
    </h3>
    <ul>
      <xsl:apply-templates/>
    </ul>
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
  <!-- ================================================================== -->
  <!-- Contents                                                           -->
  <!-- ================================================================== -->
  <xsl:template match="contents">
    <h3>Contents</h3>
    <p>
      <xsl:apply-templates/>
    </p>
  </xsl:template>
  <!-- ================================================================== -->
  <!-- History                                                            -->
  <!-- ================================================================== -->
  <xsl:template match="history">
    <h3>History</h3>
    <p>
      <xsl:apply-templates/>
    </p>
  </xsl:template>
</xsl:stylesheet>
