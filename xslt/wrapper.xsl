<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns:svg="http://www.w3.org/2000/svg"
    xpath-default-namespace="http://www.w3.org/1999/xhtml" xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="#all" version="3.0">
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="no" include-content-type="no"
        indent="no" byte-order-mark="no"/>
    <xsl:param name="xslt.fqcontroller" required="no"/>
    <xsl:param name="xslt.query-filename" required="no"/>

    <!-- ================================================================ -->
    <!-- Main                                                             -->
    <!-- ================================================================ -->
    <xsl:template match="/">
        <html>
            <head>
                <title>
                    <!-- ============================================ -->
                    <!-- Main page headers are all <h2>               -->
                    <!-- ============================================ -->
                    <xsl:value-of select="descendant::h2"/>
                </title>
                <link rel="stylesheet" type="text/css" href="resources/css/style.css"/>
                <link rel="stylesheet" type="text/css" href="resources/css/aso.css"/>
                <link rel="icon" href="resources/images/favicon.ico" sizes="any"/>
            </head>
            <body>
                <header>
                    <h1><a class="logo" href="index"><span>&lt;aso&gt;</span></a> Slovo-ASO: Toward
                        a digital library of South Slavic manuscripts</h1>
                </header>
                <xsl:apply-templates select="main"/>
                <xsl:if test="main/@id eq 'read'">
                    <!-- ================================================ -->
                    <!-- First footer with Slovo-ASO identifier in read   -->
                    <!-- ================================================ -->
                    <footer>
                        <hr/>
                        <p>
                            <span class="label">Slovo-ASO identifier: </span>
                            <xsl:value-of select="$xslt.query-filename"/>
                        </p>
                    </footer>
                </xsl:if>
                <footer>
                    <hr/>
                    <p>Maintained by David J. Birnbaum. Results generated <xsl:value-of select="
                                current-dateTime() =>
                                format-dateTime('[Y0001]-[M01]-[D01] at [H01]:[m01]:[s01] [z,6-6]')
                                "/>. <a
                            href="https://creativecommons.org/licenses/by-nc-sa/4.0/"><img
                                title="[CC BY-NC-SA 4.0]"
                                src="resources/images/cc-by-nc-sa-80x15.png"/></a>
                    </p>
                </footer>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="h2[not(ancestor::main/@id = ('index'))]" priority="10">
        <!-- ============================================================ -->
        <!-- Surround title with rule on all pages except main            -->
        <!-- ============================================================ -->
        <hr/>
        <xsl:next-match/>
        <hr/>
    </xsl:template>
    <xsl:template match="h2">
        <h2>
            <xsl:apply-templates/>
        </h2>
    </xsl:template>
    <xsl:template match="h2[. eq 'Slovo-ASO: Toward a digital library of South Slavic manuscripts']">
        <!-- ============================================================ -->
        <!-- Suppress textual value of <h2> for main page (only)          -->
        <!-- (<h2> is needed because it's also used for <title>)          -->
        <!-- ============================================================ -->
        <xsl:apply-templates select="img"/>
    </xsl:template>
    <xsl:template match="main">
        <main>
            <xsl:copy-of select="@id"/>
            <xsl:apply-templates/>
        </main>
    </xsl:template>
    <xsl:template match="svg:svg">
        <!-- ============================================================ -->
        <!-- Retain namespace only for SVG (others are in m:)             -->
        <!-- ============================================================ -->
        <xsl:copy-of select="."/>
    </xsl:template>
    <xsl:template match="*">
        <xsl:element name="{local-name()}">
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
