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
				<title><xsl:value-of select="//CardFile[1]/MainInfo/@FileName"/></title>
			</head>
			<body>
				<span class="header">
					<xsl:value-of select="//CardFile[1]/MainInfo/@FileName"/>
				</span>				 
				<br></br>				
				<span class="header2">Реєстрація</span>				 
				<table border="0" width="100%">
					<tr>
						<td class="fieldheader" width="25%">Ім'я:</td>
						<td colspan="3"><xsl:value-of select="//CardFile[1]/MainInfo/@FileName"/></td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">URL:</td>
						<td colspan="3"><xsl:value-of select="//CardFile[1]/MainInfo/@URL"/></td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Автор:</td>
						<td colspan="3"><xsl:value-of select="//CardFile[1]/MainInfo/@LastName"/><xsl:if test="string-length(//CardFile[1]/MainInfo/@LastName)!=0"> </xsl:if><xsl:value-of select="//CardFile[1]/MainInfo/@FirstName"/><xsl:if test="string-length(//CardFile[1]/MainInfo/@FirstName)!=0"> </xsl:if><xsl:value-of select="//CardFile[1]/MainInfo/@MiddleName"/></td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Категорії:</td>
						<td colspan="3">
							<xsl:for-each select="//CardFile[1]/Categories/CategoriesRow">
								<xsl:value-of select="@Name"/>
								<xsl:if test="position()!=last()">, </xsl:if>
							</xsl:for-each>
						</td>
					</tr>
				</table>				 
				<br></br>				
				<xsl:for-each select="//CardFile[1]/Properties/PropertiesRow[@ParamType!=19]">
					<xsl:if test="position()=1">
						<xsl:text disable-output-escaping="yes">
							&lt;span class="header2"&gt;Властивості документу&lt;/span&gt;
							&lt;table border="0" cellpadding="0" cellspacing="0" style="BORDER-COLLAPSE: collapse" bordercolor="black" width="100%"&gt;
								&lt;tr&gt;
									&lt;th class="tableheader" align="left"&gt;Назва&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Значення&lt;/th&gt;
								&lt;/tr&gt;
						</xsl:text>
					</xsl:if>
					<tr>
						<td class="field" width="10%"><xsl:value-of select="@Name"/></td>
						<td class="field" width="30%"><xsl:value-of select="@DisplayValue"/></td>
					</tr>
					<xsl:if test="position()=last()">
						<xsl:text disable-output-escaping="yes">
							&lt;/table&gt;
							&lt;br/&gt;
						</xsl:text>
					</xsl:if>
				</xsl:for-each>
				<p class="smalltext">
				Для того щоб змінити вигляд даного шаблону, Ви можете відредагувати "Стандартный шаблон друку" для картки "Картка файлу" або створити новий шаблон на основі даного. 
				<br>DocsVision © 2002-2010. Всі права захищені.</br>
				</p>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
