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

	<xsl:template name="printfile">
		<xsl:param name="file" select="."/>
		<td class="field" width="70%">
			<xsl:value-of select="$file/MainInfo/@Name"/>
		</td>
		<td class="field" width="30%">
			<xsl:variable name ="VersionedFileID">
				<xsl:value-of select="$file/MainInfo/@FileID"/>
			</xsl:variable>
			<xsl:value-of select="//VersionedFileCard[@CardID=$VersionedFileID]/MainInfo/@CurrentVersion"/>
		</td>
	</xsl:template>

	<xsl:template name="printfilelist">
		<xsl:param name = "filelist" select="."/>
		<xsl:for-each select="$filelist/FileReferences/FileReferencesRow">
			<xsl:if test="position()=1">
				<xsl:text disable-output-escaping="yes">
					&lt;span class="header2"&gt;Файлы документов&lt;/span&gt;
					&lt;table border="0" cellpadding="0" cellspacing="0" style="BORDER-COLLAPSE: collapse" bordercolor="black" width="100%"&gt;
						&lt;tr&gt;
							&lt;th class="tableheader" align="left"&gt;Файл&lt;/th&gt;
							&lt;th class="tableheader" align="left"&gt;Версия&lt;/th&gt;
						&lt;/tr&gt;
				</xsl:text>
			</xsl:if>
			<tr>
				<xsl:variable name="CardFileID">
					<xsl:value-of select="@CardFileID"/>
				</xsl:variable>
				<xsl:call-template name="printfile">
					<xsl:with-param name="file" select="//CardFile[@CardID=$CardFileID]"/>
				</xsl:call-template>
			</tr>
			<xsl:if test="position()=last()">
				<xsl:text disable-output-escaping="yes">
					&lt;/table&gt;
					&lt;br/&gt;
					&lt;br/&gt;
				</xsl:text>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="/">
		<html>
			<head>
				<link rel="stylesheet" type="text/css" href="%ServerUrl%/StorageServer/File.axd?BaseName=%BaseName%&amp;TransformID=B5344DA1-D28F-4024-8798-3FC3992C94B7"/>
				<title><xsl:value-of select="//CardUni[1]/@Description"/></title>
			</head>
			<body>
				<span class="header">
					<xsl:value-of select="//CardUni[1]/@Description"/>
				</span>				 
				<br></br>				
				<span class="header2">Регистрация</span>				 
				<table border="0" width="100%">
					<tr>
						<td class="fieldheader" width="25%">Имя:</td>
						<td colspan="3"><xsl:value-of select="//CardUni[1]/@Description"/></td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Вид:</td>
						<td colspan="3"><xsl:value-of select="//CardUni[1]/MainInfo/@DocType_Name"/></td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Состояние документа:</td>
						<td colspan="3"><xsl:value-of select="//CardUni[1]/MainInfo/@StateName"/></td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Категории:</td>
						<td colspan="3">
							<xsl:for-each select="//CardUni[1]/Categories/CategoriesRow">
								<xsl:value-of select="@Name"/>
								<xsl:if test="position()!=last()">, </xsl:if>
							</xsl:for-each>
						</td>
					</tr>
				</table>
				<br></br>				
				<xsl:for-each select="//CardUni[1]/CardReferences/CardReferencesRow">
					<xsl:if test="position()=1">
						<xsl:text disable-output-escaping="yes">
							&lt;span class="header2"&gt;Ссылки на карточки&lt;/span&gt;
							&lt;table border="0" cellpadding="0" cellspacing="0" style="BORDER-COLLAPSE: collapse" bordercolor="black" width="100%"&gt;
								&lt;tr&gt;
									&lt;th class="tableheader" align="left"&gt;Тип&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Карточка&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Дата создания&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Создано&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Комментарии&lt;/th&gt;
								&lt;/tr&gt;
						</xsl:text>
					</xsl:if>
					<tr>
						<td class="field" width="10%"><xsl:value-of select="@LinkName"/></td>
						<td class="field" width="15%"><xsl:value-of select="@Description"/></td>
						<td class="field" width="25%">
							<xsl:call-template name="convertdatetime">
								<xsl:with-param name="str" select="@CreationDate"/>
							</xsl:call-template>
						</td>
						<td class="field" width="20%"><xsl:value-of select="@Create_LName"/><xsl:if test="string-length(@Create_LName)!=0"> </xsl:if><xsl:value-of select="@Create_FName"/><xsl:if test="string-length(@Create_FName)!=0"> </xsl:if><xsl:value-of select="@Create_MName"/></td>
						<td class="field" width="30%"><xsl:value-of select="@Comments"/></td>
					</tr>
					<xsl:if test="position()=last()">
						<xsl:text disable-output-escaping="yes">
							&lt;/table&gt;
							&lt;br/&gt;
						</xsl:text>
					</xsl:if>
				</xsl:for-each>
				<br></br>
				<xsl:variable name="FileListID">
					<xsl:value-of select="//CardUni[1]/MainInfo/@FilesID"/>
				</xsl:variable>
				<xsl:call-template name="printfilelist">
					<xsl:with-param name="filelist" select="//FileList[@CardID=$FileListID]"/>
				</xsl:call-template>
				<xsl:for-each select="//CardUni[1]/Properties/PropertiesRow[(@Hidden=0 or not(@Hidden)) and @ParamType!=19]">
					<xsl:if test="position()=1">
						<xsl:text disable-output-escaping="yes">
							&lt;span class="header2"&gt;Свойства документа&lt;/span&gt;
							&lt;table border="0" cellpadding="0" cellspacing="0" style="BORDER-COLLAPSE: collapse" bordercolor="black" width="100%"&gt;
								&lt;tr&gt;
									&lt;th class="tableheader" align="left"&gt;№&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Название&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Значение&lt;/th&gt;
								&lt;/tr&gt;
						</xsl:text>
					</xsl:if>
					<tr>
						<td class="field" width="10%"><xsl:value-of select="@Order"/></td>
						<td class="field" width="30%"><xsl:value-of select="@Name"/></td>
						<td class="field" width="60%"><xsl:value-of select="@DisplayValue"/></td>
					</tr>
					<xsl:if test="position()=last()">
						<xsl:text disable-output-escaping="yes">
							&lt;/table&gt;
							&lt;br/&gt;
						</xsl:text>
					</xsl:if>
				</xsl:for-each>

				<xsl:for-each select="//CardUni[1]/TransferLog/TransferLogRow">
					<xsl:if test="position()=1">
						<xsl:text disable-output-escaping="yes">
							&lt;span class="header2"&gt;Журнал передач документа&lt;/span&gt;
							&lt;table border="0" cellpadding="0" cellspacing="0" style="BORDER-COLLAPSE: collapse" bordercolor="black" width="100%"&gt;
								&lt;tr&gt;
									&lt;th class="tableheader" align="left"&gt;Дата&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Тип передачи&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Местонахождение документа&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Тип документа&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Комментарий&lt;/th&gt;
								&lt;/tr&gt;
						</xsl:text>
					</xsl:if>
					<tr>
						<td class="field" width="15%">
							<xsl:call-template name="convertdatetime">
								<xsl:with-param name="str" select="@TransferDate"/>
							</xsl:call-template>
						</td>
						<td class="field" width="10%">
							<xsl:if test="@IsReceived=0 or not(@IsReceived)">Сдан</xsl:if>
							<xsl:if test="@IsReceived=1">Принят</xsl:if>
						</td>
						<td class="field" width="30%">
							<xsl:if test="@IsReceived=0 or not(@IsReceived)">
								<xsl:if test="@ToEmployee">
									<xsl:value-of select="@To_LName"/>
									<xsl:if test="string-length(@To_LName)!=0"> </xsl:if>
									<xsl:value-of select="@To_FName"/>
									<xsl:if test="string-length(@To_FName)!=0"> </xsl:if>
									<xsl:value-of select="@To_MName"/>
								</xsl:if>
								<xsl:if test="not(@ToEmployee)">
									<xsl:value-of select="@To_DepName"/>
								</xsl:if>
							</xsl:if>
							<xsl:if test="@IsReceived=1">
								<xsl:value-of select="@From_LName"/>
								<xsl:if test="string-length(@From_LName)!=0"> </xsl:if>
								<xsl:value-of select="@From_FName"/>
								<xsl:if test="string-length(@From_FName)!=0"> </xsl:if>
								<xsl:value-of select="@From_MName"/>
							</xsl:if>
						</td>
						<td class="field" width="10%">
							<xsl:if test="@IsCopy=0 or not(@IsCopy)">Оригинал</xsl:if>
							<xsl:if test="@IsCopy=1">Копия</xsl:if>
						</td>
						<td class="field" width="35%">
							<xsl:value-of select="@Comments"/>
						</td>
					</tr>
					<xsl:if test="position()=last()">
						<xsl:text disable-output-escaping="yes">
							&lt;/table&gt;
							&lt;br/&gt;
						</xsl:text>
					</xsl:if>
				</xsl:for-each>

				<p class="smalltext">
				Для того чтобы изменить вид данного шаблона, Вы можете отредактировать "Стандартный шаблон печати" для карточки "Универсальный документ" или создать новый шаблон на основе данного. 
				<br>DocsVision © 2002-2010. Все права защищены.</br>
				</p>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
