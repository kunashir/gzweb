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
				<title><xsl:value-of select="//CardResolution[1]/MainInfo/@Name"/></title>
			</head>
			<body>
				<span class="header">
					<xsl:value-of select="//CardResolution[1]/MainInfo/@Name"/>
				</span>
				<br></br>				
				<span class="header2">Регистрация</span>
				<table border="0" width="100%">
					<tr>
						<td class="fieldheader" width="25%">Имя:</td>
						<td colspan="3"><xsl:value-of select="//CardResolution[1]/MainInfo/@Name"/></td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Вид:</td>
						<td colspan="3"><xsl:value-of select="//CardResolution[1]/MainInfo/@DocType_Name"/></td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Дата создания:</td>
						<td width="25%">
							<xsl:call-template name="convertdatetime">
								<xsl:with-param name="str" select="//CardResolution[1]/MainInfo/@CreationDate"/>
							</xsl:call-template>
						</td>
						<td class="fieldheader" width="25%">Дата подписания:</td>
						<td width="25%">
							<xsl:call-template name="convertdatetime">
								<xsl:with-param name="str" select="//CardResolution[1]/MainInfo/@SignedDate"/>
							</xsl:call-template>
						</td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Автор:</td>
						<td colspan="3"><xsl:value-of select="//CardResolution[1]/MainInfo/@Create_LName"/><xsl:if test="string-length(//CardResolution[1]/MainInfo/@Create_LName)!=0"> </xsl:if><xsl:value-of select="//CardResolution[1]/MainInfo/@Create_FName"/><xsl:if test="string-length(//CardResolution[1]/MainInfo/@Create_FName)!=0"> </xsl:if><xsl:value-of select="//CardResolution[1]/MainInfo/@Create_MName"/></td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Регистратор:</td>
						<td colspan="3"><xsl:value-of select="//CardResolution[1]/MainInfo/@Register_LName"/><xsl:if test="string-length(//CardResolution[1]/MainInfo/@Register_LName)!=0"> </xsl:if><xsl:value-of select="//CardResolution[1]/MainInfo/@Register_FName"/><xsl:if test="string-length(//CardResolution[1]/MainInfo/@Register_FName)!=0"> </xsl:if><xsl:value-of select="//CardResolution[1]/MainInfo/@Register_MName"/></td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Подписано:</td>
						<td colspan="3">
						<xsl:for-each select="//CardResolution[1]/Employees/EmployeesRow[@Type=2]">
							<xsl:value-of select="@LastName"/><xsl:if test="string-length(@LastName)!=0"> </xsl:if><xsl:value-of select="@FirstName"/><xsl:if test="string-length(@FirstName)!=0"> </xsl:if><xsl:value-of select="@MiddleName"/>
							<xsl:if test="position()!=last()">, </xsl:if>
						</xsl:for-each>
						</td>
					</tr>
					<xsl:if test="//CardResolution[1]/MainInfo/@ControlType!=0">
					<tr>
						<td class="fieldheader" width="25%">
							<xsl:choose>
								<xsl:when test="//CardResolution[1]/MainInfo/@ControlType=1">На контроле:</xsl:when>
								<xsl:when test="//CardResolution[1]/MainInfo/@ControlType=2">На особом контроле:</xsl:when>
							</xsl:choose>
						</td>
						<td colspan="3"><xsl:value-of select="//CardResolution[1]/MainInfo/@Control_LName"/><xsl:if test="string-length(//CardResolution[1]/MainInfo/@Control_LName)!=0"> </xsl:if><xsl:value-of select="//CardResolution[1]/MainInfo/@Control_FName"/><xsl:if test="string-length(//CardResolution[1]/MainInfo/@Control_FName)!=0"> </xsl:if><xsl:value-of select="//CardResolution[1]/MainInfo/@Control_MName"/></td>
					</tr>
					</xsl:if>
					<tr>
						<td class="fieldheader" width="25%">Исполнители:</td>
						<td colspan="3"><xsl:value-of select="//CardResolution[1]/MainInfo/@Performers"/></td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Ответственный исполнитель:</td>
						<td colspan="3"><xsl:value-of select="//CardResolution[1]/MainInfo/@Responsible"/></td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Категории:</td>
						<td colspan="3">
							<xsl:for-each select="//CardResolution[1]/Categories/CategoriesRow">
								<xsl:value-of select="@Name"/>
								<xsl:if test="position()!=last()">, </xsl:if>
							</xsl:for-each>
						</td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Виды:</td>
						<td colspan="3">
							<xsl:for-each select="//CardResolution[1]/Types/TypesRow">
								<xsl:value-of select="@Name"/>
								<xsl:if test="position()!=last()">, </xsl:if>
							</xsl:for-each>
						</td>
					</tr>
					<tr>
						<td colspan="4" class="fieldheader">Содержание:</td>
					</tr>
					<tr>
						<td colspan="4">
							<xsl:call-template name="replace">
								<xsl:with-param name="str" select="//CardResolution[1]/MainInfo/@Comments"/>
							</xsl:call-template>
						</td>
					</tr>
				</table>
				<br></br>				
				<span class="header2">Выполнение</span>
				<table border="0" width="100%">
					<tr>
						<td class="fieldheader" width="25%">Дата начала:</td>
						<td width="25%">
							<xsl:call-template name="convertdatetime">
								<xsl:with-param name="str" select="//CardResolution[1]/MainInfo/@StartDate"/>
							</xsl:call-template>
						</td>
						<td class="fieldheader" width="25%">Ожидаемая продолжительность:</td>
						<td width="25%"><xsl:value-of select="//CardResolution[1]/MainInfo/@ExpectedDuration"/></td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Ожидаемая дата завершения:</td>
						<td width="25%">
							<xsl:call-template name="convertdatetime">
								<xsl:with-param name="str" select="//CardResolution[1]/MainInfo/@ExpectedEndDate"/>
							</xsl:call-template>
						</td>
						<td class="fieldheader" width="25%">Действительная дата завершения:</td>
						<td width="25%">
							<xsl:call-template name="convertdatetime">
								<xsl:with-param name="str" select="//CardResolution[1]/MainInfo/@ActualEndDate"/>
							</xsl:call-template>
						</td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Дата контроля:</td>
						<td width="25%">
							<xsl:call-template name="convertdatetime">
								<xsl:with-param name="str" select="//CardResolution[1]/MainInfo/@ControlDate"/>
							</xsl:call-template>
						</td>
					</tr>
					<xsl:if test="//CardResolution[1]/MainInfo/@IsUrgent=1">
					<tr><td class="fieldheader" colspan="4">Высокая срочность</td></tr>
					</xsl:if>
					<tr>
						<td class="fieldheader" width="25%">Состояние задачи:</td>
						<td colspan="3">
							<xsl:choose>
								<xsl:when test="//CardResolution[1]/MainInfo/@ResolutionState=0">Не активна</xsl:when>
								<xsl:when test="//CardResolution[1]/MainInfo/@ResolutionState=1">К исполнению</xsl:when>
								<xsl:when test="//CardResolution[1]/MainInfo/@ResolutionState=2">В процессе</xsl:when>
								<xsl:when test="//CardResolution[1]/MainInfo/@ResolutionState=3">Исполнена</xsl:when>
								<xsl:when test="//CardResolution[1]/MainInfo/@ResolutionState=4">Отозвана</xsl:when>
							</xsl:choose>
						</td>
					</tr>
				</table>
				<br></br>
				
				<xsl:for-each select="//CardResolution[1]/Properties/PropertiesRow[(@Hidden=0 or not(@Hidden)) and @ParamType!=19]">
					<xsl:if test="position()=1">
						<xsl:text disable-output-escaping="yes">
							&lt;span class="header2"&gt;Свойства задачи&lt;/span&gt;
							&lt;table border="0" cellpadding="0" cellspacing="0" style="BORDER-COLLAPSE: collapse" bordercolor="black" width="100%"&gt;
								&lt;tr&gt;
									&lt;th class="tableheader" align="left"&gt;Имя&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Значение&lt;/th&gt;
								&lt;/tr&gt;
						</xsl:text>
					</xsl:if>
					<tr>
						<td class="field" width="40%">
							<xsl:value-of select="@Name"/>
						</td>
						<td class="field" width="60%">
							<xsl:value-of select="@DisplayValue"/>
						</td>
					</tr>
					<xsl:if test="position()=last()">
						<xsl:text disable-output-escaping="yes">
							&lt;/table&gt;
							&lt;br/&gt;
						</xsl:text>
					</xsl:if>
				</xsl:for-each>

				<xsl:for-each select="//CardResolution[1]/Comments/CommentsRow">
					<xsl:if test="position()=1">
						<xsl:text disable-output-escaping="yes">
							&lt;span class="header2"&gt;Комментарии&lt;/span&gt;
							&lt;table border="0" cellpadding="0" cellspacing="0" style="BORDER-COLLAPSE: collapse" bordercolor="black" width="100%"&gt;
								&lt;tr&gt;
									&lt;th class="tableheader" align="left"&gt;Дата комментария&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Автор&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Комментарий&lt;/th&gt;
								&lt;/tr&gt;
						</xsl:text>
					</xsl:if>
					<tr>
						<td class="field" width="20%">
							<xsl:call-template name="convertdatetime">
								<xsl:with-param name="str" select="@CreationDate"/>
							</xsl:call-template>
						</td>
						<td class="field" width="30%"><xsl:value-of select="@LastName"/><xsl:if test="string-length(@LastName)!=0"> </xsl:if><xsl:value-of select="@FirstName"/><xsl:if test="string-length(@FirstName)!=0"> </xsl:if><xsl:value-of select="@MiddleName"/></td>
						<td class="field" width="50%"><xsl:value-of select="@Comment"/></td>
					</tr>
					<xsl:if test="position()=last()">
						<xsl:text disable-output-escaping="yes">
							&lt;/table&gt;
							&lt;br/&gt;
						</xsl:text>
					</xsl:if>
				</xsl:for-each>
				<p class="smalltext">
				Для того чтобы изменить вид данного шаблона, Вы можете отредактировать "Стандартный шаблон печати" для карточки "Задача" или создать новый шаблон на основе данного. 
				<br>DocsVision © 2002-2010. Все права защищены.</br>
				</p>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
