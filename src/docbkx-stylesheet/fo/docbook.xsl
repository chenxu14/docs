<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:d="http://docbook.org/ns/docbook"
	xmlns:exsl="http://exslt.org/common"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:ng="http://docbook.org/docbook-ng"
	xmlns:db="http://docbook.org/ns/docbook"
	exclude-result-prefixes="db ng exsl d"
	version='1.0'>
	<!-- imports the original docbook stylesheet -->
	<xsl:import href="urn:docbkx:stylesheet"/>
	<!-- set bellow all your custom xsl configuration -->
	<xsl:param name="body.start.indent">0pt</xsl:param><!-- 正文不缩进-->
    <xsl:param name="section.autolabel" select="1"></xsl:param><!-- 为section编号 -->
	<xsl:param name="draft.mode">no</xsl:param>
	<xsl:param name="alignment">justify</xsl:param>
	<!-- callout图标配置 -->
	<xsl:param name="callout.graphics" select="0"></xsl:param>
	<xsl:param name="callout.graphics.extension">.jpg</xsl:param>
	<xsl:param name="callout.graphics.path">media/system/callouts/</xsl:param>
	
	<!-- admon图标配置 -->
	<xsl:param name="admon.graphics" select="1" />
	<xsl:param name="admon.graphics.extension">.jpg</xsl:param>
	<xsl:param name="admon.graphics.path">media/system/admonitions/</xsl:param>
	<xsl:param name="admon.textlabel" select="0"></xsl:param><!--不显示标题-->
	
    <!-- 国际化配置 -->
	<xsl:param name="l10n.gentext.language" select="'zh_CN'"/>
	<xsl:param name="local.l10n.xml" select="document('')"/>
	<l:i18n xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0">
		<l:l10n language="zh_cn">  
			<l:context name="title-numbered">
				<l:template name="chapter" text="第 %n 章 %t"/>  
				<l:template name="section" text="%n %t"/>  
			</l:context>  
		</l:l10n>  
	</l:i18n>  
	
	<xsl:attribute-set name="normal.para.spacing">
		<xsl:attribute name="text-indent">0em</xsl:attribute><!--段首缩进-->
	</xsl:attribute-set>
	
	<xsl:template name="table.cell.properties">
		<xsl:param name="bgcolor.pi" select="''"/>
		<xsl:param name="rowsep.inherit" select="1"/>
		<xsl:param name="colsep.inherit" select="1"/>
		<xsl:param name="col" select="1"/>
		<xsl:param name="valign.inherit" select="''"/>
		<xsl:param name="align.inherit" select="''"/>
		<xsl:param name="char.inherit" select="''"/>
		<xsl:choose>
			<xsl:when test="ancestor::d:tgroup">
				<!-- new add begin -->
				<xsl:if test="ancestor::d:thead">
					<xsl:attribute name="background-color">antiquewhite</xsl:attribute>
				</xsl:if>
				<!-- new add end -->
				<xsl:if test="$bgcolor.pi != ''">
					<xsl:attribute name="background-color">
						<xsl:value-of select="$bgcolor.pi"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="$rowsep.inherit &gt; 0">
					<xsl:call-template name="border">
						<xsl:with-param name="side" select="'bottom'"/>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="$colsep.inherit &gt; 0 and
					$col &lt; (ancestor::d:tgroup/@cols|ancestor::d:entrytbl/@cols)[last()]">
					<xsl:call-template name="border">
						<xsl:with-param name="side" select="'end'"/>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="$valign.inherit != ''">
					<xsl:attribute name="display-align">
						<xsl:choose>
							<xsl:when test="$valign.inherit='top'">before</xsl:when>
							<xsl:when test="$valign.inherit='middle'">center</xsl:when>
							<xsl:when test="$valign.inherit='bottom'">after</xsl:when>
							<xsl:otherwise>
								<xsl:message>
									<xsl:text>Unexpected valign value: </xsl:text>
									<xsl:value-of select="$valign.inherit"/>
									<xsl:text>, center used.</xsl:text>
								</xsl:message>
								<xsl:text>center</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="$align.inherit = 'char' and $char.inherit != ''">
						<xsl:attribute name="text-align">
							<xsl:value-of select="$char.inherit"/>
						</xsl:attribute>
					</xsl:when>
					<xsl:when test="$align.inherit != ''">
						<xsl:attribute name="text-align">
							<xsl:value-of select="$align.inherit"/>
						</xsl:attribute>
					</xsl:when>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<!-- HTML table -->
				<xsl:if test="$bgcolor.pi != ''">
					<xsl:attribute name="background-color">
						<xsl:value-of select="$bgcolor.pi"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="$align.inherit != ''">
					<xsl:attribute name="text-align">
						<xsl:value-of select="$align.inherit"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="$valign.inherit != ''">
					<xsl:attribute name="display-align">
						<xsl:choose>
							<xsl:when test="$valign.inherit='top'">before</xsl:when>
							<xsl:when test="$valign.inherit='middle'">center</xsl:when>
							<xsl:when test="$valign.inherit='bottom'">after</xsl:when>
							<xsl:otherwise>
								<xsl:message>
									<xsl:text>Unexpected valign value: </xsl:text>
									<xsl:value-of select="$valign.inherit"/>
									<xsl:text>, center used.</xsl:text>
								</xsl:message>
								<xsl:text>center</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
				</xsl:if>
				<xsl:call-template name="html.table.cell.rules"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>