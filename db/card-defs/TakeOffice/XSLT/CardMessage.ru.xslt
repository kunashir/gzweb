<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template name="replace" match="text()" mode="replace">
		<xsl:param name="str" select="."/>
		<xsl:param name="search-for" select="'&#xA;'"/>
		<xsl:param name="replace-with">
			<xsl:element name="BR"/>
			<xsl:text>&#xA;</xsl:text>
		</xsl:param>
		<xsl:choose>
			<xsl:when test="contains($str, $search-for)">
				<xsl:value-of select="substring-before($str, $search-for)"/>
				<xsl:copy-of select="$replace-with"/>
				<xsl:call-template name="replace">
					<xsl:with-param name="str"
						select="substring-after($str, $search-for)"/>
					<xsl:with-param name="search-for" select="$search-for"/>
					<xsl:with-param name="replace-with" select="$replace-with"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$str"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="convertdatetime" match="text()" mode="replace">
		<xsl:param name="str" select="."/>
		<xsl:copy-of select="substring($str, 12, 8)"/>
		<xsl:text> </xsl:text>
		<xsl:copy-of select="substring($str, 9, 2)"/>
		<xsl:text>.</xsl:text>
		<xsl:copy-of select="substring($str, 6, 2)"/>
		<xsl:text>.</xsl:text>
		<xsl:copy-of select="substring($str, 1, 4)"/>
	</xsl:template>
	<xsl:template match="/">
		<html>
			<head>
				<link rel="stylesheet" type="text/css" href="%ServerUrl%/StorageServer/File.axd?BaseName=%BaseName%&amp;TransformID=B5344DA1-D28F-4024-8798-3FC3992C94B7"/>
				<title><xsl:value-of select="//CardMessage[1]/MainInfo/@Subject"/></title>
			</head>
			<body>
				<span class="header2">Сообщение</span>
				<table border="0" width="100%">
					<xsl:if test="string-length(//CardMessage[1]/MainInfo/@LastName)!=0">
					<tr>
						<td class="fieldheader" width="25%">Автор:</td>
						<td colspan="3">
							<xsl:value-of select="//CardMessage[1]/MainInfo/@LastName"/><xsl:if test="string-length(//CardMessage[1]/MainInfo/@LastName)!=0"> </xsl:if><xsl:value-of select="//CardMessage[1]/MainInfo/@FirstName"/><xsl:if test="string-length(//CardMessage[1]/MainInfo/@FirstName)!=0"> </xsl:if><xsl:value-of select="//CardMessage[1]/MainInfo/@MiddleName"/>
						</td>
					</tr>
					</xsl:if>
					<tr>
						<td class="fieldheader" width="25%">Дата создания:</td>
						<td colspan="3">
						<xsl:call-template name="convertdatetime">
							<xsl:with-param name="str" select="//CardMessage[1]/MainInfo/@CreationDate"/>
						</xsl:call-template>
						</td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Тема:</td>
						<td colspan="3"><xsl:value-of select="//CardMessage[1]/MainInfo/@Subject"/></td>
					</tr>
					<tr>
						<td colspan="4" class="fieldheader">Сообщение:</td>
					</tr>
					<tr>
						<td colspan="4">
							<xsl:call-template name="replace">
								<xsl:with-param name="str" select="//CardMessage[1]/MainInfo/@Body"/>
							</xsl:call-template>
						</td>
					</tr>
					<xsl:if test="string-length(//CardMessage[1]/MainInfo/@Description)!=0">
					<tr>
						<td class="fieldheader" width="25%">Связанная карточка:</td>
						<td colspan="3"><xsl:value-of select="//CardMessage[1]/MainInfo/@Description"/></td>
					</tr>
					</xsl:if>
				</table>
				<p class="smalltext">
				Для того чтобы изменить вид данного шаблона, Вы можете отредактировать "Стандартный шаблон печати" для карточки "Сообщение" или создать новый шаблон на основе данного. 
				<br>DocsVision © 2002-2010. Все права защищены.</br>
				</p>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
