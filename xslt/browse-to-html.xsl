<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:math="http://www.w3.org/2005/xpath-functions/math"
  xpath-default-namespace="http://repertorium.obdurodon.org/model"
  xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="#all" version="3.0">
  <xsl:template match="main">
    <main id="browse">
      <h2>
        <xsl:value-of select="header/title"/>
      </h2>
      <ul>
        <xsl:apply-templates select="body/node()"/>
      </ul>
    </main>
  </xsl:template>
  <xsl:template match="ms">
    <li>
      <xsl:value-of select="string-join((country, settlement, repository, shelfmark), ', ')"/>
      <xsl:apply-templates select="catalog"/>
      <xsl:apply-templates select="filename"/>
      <xsl:apply-templates select="name"/>
    </li>
  </xsl:template>
  <xsl:template match="catalog">
    <xsl:text> (</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>) </xsl:text>
  </xsl:template>
  <xsl:template match="name">
    <br/>
    <span class="msName">
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  <xsl:template match="filename">
    <xsl:text> (</xsl:text>
    <a href="read?id={.}">
      <xsl:value-of select="."/>
    </a>
    <xsl:text> </xsl:text>
    <a href="data/{.}.xml">
      <img src="resources/images/xml.gif" alt="[Link to XML]" title="View raw XML"/>
    </a>
    <xsl:text>)</xsl:text>
  </xsl:template>
</xsl:stylesheet>
