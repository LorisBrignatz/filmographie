<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="iso-8859-1" indent="yes"/>

    <xsl:template match="/">
        <html>
            <link rel="stylesheet" type="text/css" href="film.css" />
            <head>
                <title>Cinématographie</title>
                <script src ="https://code.jquery.com/jquery-2.2.4.min.js" > </script>
                <script src="scroll.js"> </script>
                <link rel="stylesheet" type="text/css" href="scroll.css" />
            </head>
            <body>
                <div id="main">
                    <section>
                        <h1>Cinématographie</h1>
                    </section>
                    <section>
                        <h2>Table des matières des films</h2>
                        <xsl:apply-templates select="/films/film" mode="tdm" />
                    </section>
                    <section>
                        <h2>Table des matières des acteurs</h2>
                        <xsl:apply-templates select="//acteurDescription" mode="tdm"/>
                    </section>
                        <xsl:apply-templates select="/films/film" mode="complet" >
                            <xsl:sort select="@annee" order="descending" data-type="number" />
                            <xsl:sort select="exploitation/nbEntrees" order="descending" data-type="number" />
                        </xsl:apply-templates>
                </div>
                <script>
                    $("#main").onepage_scroll({
                    sectionContainer: "section",
                    easing: "ease",
                    animationTime: 1000,
                    pagination: true,
                    updateURL: false,
                    beforeMove: function(index) {},
                    afterMove: function(index) {},
                    loop: false,
                    keyboard: true,
                    responsiveFallback: false
                    });
                </script>
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
                [ <xsl:value-of select="scenario/keyword"/> ]
                <xsl:value-of select="concat(' (', count(acteurs/acteur), ' acteurs)')"/>
            </li>
        </ul>
    </xsl:template>

    <xsl:template match="acteurDescription" mode="tdm">
        <ul>
            <li>
                <xsl:value-of select="prenom" />
                <xsl:text> </xsl:text>
                <xsl:value-of select="nom" />
                <xsl:text> (</xsl:text>
                <xsl:value-of select="count(//film[acteurs/acteur/@ref = current()/@id])" />
                <xsl:text> film(s)) - né(e) le : </xsl:text>
                <xsl:value-of select="dateNaissance " />
                <xsl:text>. Films :</xsl:text>
                <xsl:for-each select="//film[acteurs/acteur/@ref = @id]">
                    <a>
                        <xsl:attribute name="href">
                            <xsl:text>#</xsl:text>
                            <xsl:value-of select="@visa" />
                        </xsl:attribute>
                        <xsl:value-of select="position()" />
                    </a>
                    <xsl:if test="position() != last()">
                        <xsl:text> </xsl:text>
                    </xsl:if>
                </xsl:for-each>
            </li>
        </ul>
    </xsl:template>

    <xsl:template match="film" mode="complet">
        <section>
            <xsl:if test="@annee = '2023'">
                <h3>
                    <xsl:value-of select="titre" />
                    <span><font color="red"><small> (Nouveauté)</small></font></span>
                </h3>
            </xsl:if>
        <a name="{titre}" />
        <a name="{acteur}" />
            <xsl:if test="@annee != '2023'">
                <h3><xsl:value-of select="titre" /></h3>
            </xsl:if>
            <p><i>Genre(s) : <xsl:apply-templates select="genres/genre" /></i></p>
            <img>
                <xsl:attribute name="src">
                    <xsl:value-of select="image/@ref" />
                </xsl:attribute>
            </img>
            <p><i>film américian de <xsl:value-of select="duree" />mn sorti en <xsl:value-of select="@annee" /></i></p>
            <p><i>réalisé par <xsl:value-of select="realisateur" /></i></p>
            <ul>
                <xsl:apply-templates select="acteurs/acteur" />
            </ul>
            <p class="histoireType">
                <xsl:apply-templates select="scenario" />
            </p>
        </section>
    </xsl:template>

    <xsl:template match="acteur">
        <li><xsl:value-of select="." /></li>
    </xsl:template>

    <xsl:template match="ev">
        <i><xsl:value-of select="."/></i>
    </xsl:template>

    <xsl:template match="personnage">
        <b><xsl:value-of select="."/></b>
    </xsl:template>

</xsl:stylesheet>
