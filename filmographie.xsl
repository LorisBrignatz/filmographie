<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="iso-8859-1" indent="yes"/>

    <xsl:template match="/">
        <html>
            <link rel="stylesheet" type="text/css" href="film.css" />
            <head>
                <title>Cinématographie</title>
            </head>
            <body>
                <h1>Cinématographie</h1>
                <h1>Table des matières des films</h1>
                <xsl:apply-templates select="/films/film" mode="tdm" />
                <xsl:apply-templates select="/films/film" mode="complet" >
                    <xsl:sort select="@annee" order="descending" data-type="number" />
                    <xsl:sort select="exploitation/nbEntrees" order="descending" data-type="number" />
                </xsl:apply-templates>
                <!--<h2>Films sortis en 2023 :</h2>
                <xsl:apply-templates select="/films/film[@annee='2023']" mode="nouveaute" />
                <h2>Films sortis avant 2023 :</h2>
                <xsl:apply-templates select="/films/film[not(@annee = '2023')]" mode="autres" />-->
            </body>
        </html>
    </xsl:template>

    <xsl:template match="film" mode="tdm">
        <ul>
            <li>
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>#</xsl:text>
                        <xsl:value-of select="titre"/>
                    </xsl:attribute>
                    <xsl:value-of select="titre"/>
                </a>
                <xsl:value-of select="concat(' (', count(acteurs/acteur), ' acteurs)')" />
            </li>
        </ul>
    </xsl:template>

    <xsl:template match="film" mode="complet">
        <xsl:if test="@annee = '2023'">
            <h3>
                <xsl:value-of select="titre" />
                <span><font color="red"><small> (Nouveauté)</small></font></span>
            </h3>
        </xsl:if>
        <a name="{titre}" />
        <xsl:if test="@annee != '2023'">
            <h3><xsl:value-of select="titre" /></h3>
        </xsl:if>
        <p><i>film américian de <xsl:value-of select="duree" />mn sorti en <xsl:value-of select="@annee" /></i></p>
        <p><i>réalisé par <xsl:value-of select="realisateur" /></i></p>
        <ul>
            <xsl:apply-templates select="acteurs/acteur" />
        </ul>
        <p class="histoireType"><xsl:value-of select="scenario" /></p>
    </xsl:template>

    <!--<xsl:template match="film" mode="autres">
        <h3><xsl:value-of select="titre" /></h3>
        <p><i>film américian de <xsl:value-of select="duree" />mn sorti en <xsl:value-of select="@annee" /></i></p>
        <p><i>réalisé par <xsl:value-of select="realisateur" /></i></p>
        <ul>
            <xsl:apply-templates select="acteurs/acteur" />
        </ul>
        <p class="histoireType"><xsl:value-of select="scenario" /></p>
    </xsl:template>-->
    <xsl:template match="acteur">
        <li><xsl:value-of select="." /></li>
    </xsl:template>
</xsl:stylesheet>
