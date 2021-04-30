<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="text" indent="yes"/>

  <xsl:template match="/tale">
    digraph tale {
        node [style = "filled"]

      <xsl:apply-templates select="technology"/>
    }
  </xsl:template>

  <xsl:template match="technology">
      subgraph tech_cluster_<xsl:value-of select="generate-id()" /> {
        tech_<xsl:value-of select="generate-id()" /> [
            label = "<xsl:value-of select="@name" />",
            color = <xsl:value-of select="//discipline[@name=current()/@discipline]/@color" />
        ]
        <xsl:apply-templates select="prerequisite"/>
      }
  </xsl:template>

  <xsl:template match="prerequisite">
      <xsl:call-template name="connectTechs">
        <xsl:with-param name="targetId">
            <xsl:value-of select="generate-id(./parent::technology)" />
        </xsl:with-param>
        <xsl:with-param name="sourceName">
            <xsl:value-of select="@technology" />
        </xsl:with-param>
      </xsl:call-template>
  </xsl:template>

  <xsl:template name="connectTechs">
    <xsl:param name="targetId"></xsl:param>
    <xsl:param name="sourceName"></xsl:param>
    tech_<xsl:value-of select="generate-id(//technology[@name=$sourceName])" /> -> tech_<xsl:value-of select="$targetId" />
  </xsl:template>
</xsl:stylesheet>
