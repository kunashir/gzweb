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
		<xsl:copy-of select="substring($str, 9, 2)"/>
		<xsl:text>.</xsl:text>
		<xsl:copy-of select="substring($str, 6, 2)"/>
		<xsl:text>.</xsl:text>
		<xsl:copy-of select="substring($str, 1, 4)"/>
		<xsl:text> </xsl:text>
		<xsl:copy-of select="substring($str, 12, 5)"/>
	</xsl:template>
	
	<xsl:template name="printresolution">
		<xsl:param name="resolution" select="."/>
		<xsl:param name="level" select="."/>
		<tr>
			<td style="border-top-style: solid; border-top-color: #CCCCCC; border-top-width: 1px;">
				<xsl:value-of select="$level"/>
			</td>
			<td class="fieldheader" style="border-top-style: solid; border-top-color: #CCCCCC; border-top-width: 1px;">
				<xsl:if test="string-length(CardReport/MainInfo/@DocType_Name)!=0">
					<xsl:value-of select="$resolution/CardResolution/MainInfo/@DocType_Name"/>
				</xsl:if>
				<xsl:if test="string-length(CardReport/MainInfo/@DocType_Name)=0">Задача</xsl:if>
			</td>
			<td colspan="5" style="border-top-style: solid; border-top-color: #CCCCCC; border-top-width: 1px;">
				<xsl:value-of select="$resolution/CardResolution/MainInfo/@Name"/>
			</td>
		</tr>
		<tr>
			<td></td>
			<td class="fieldheader">Содержание</td>
			<td colspan="5">
				<xsl:value-of select="$resolution/CardResolution/MainInfo/@Comments"/>
			</td>
		</tr>
		<tr>
			<td></td>
			<td>
				<xsl:value-of select="$resolution/CardResolution/MainInfo/@Create_LName"/>
				<xsl:if test="string-length($resolution/CardResolution/MainInfo/@Create_LName)!=0"> </xsl:if>
				<xsl:value-of select="$resolution/CardResolution/MainInfo/@Create_FName"/>
				<xsl:if test="string-length($resolution/CardResolution/MainInfo/@Create_FName)!=0"> </xsl:if>
				<xsl:value-of select="$resolution/CardResolution/MainInfo/@Create_MName"/>
			</td>
			<td>
				<xsl:value-of select="$resolution/CardResolution/MainInfo/@Performers"/>
			</td>
			<td>
				<xsl:if test="string-length($resolution/CardResolution/MainInfo/@StartDate)!=0">
					С <xsl:call-template name="convertdatetime">
						<xsl:with-param name="str" select="$resolution/CardResolution/MainInfo/@StartDate"/>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="string-length($resolution/CardResolution/MainInfo/@ExpectedEndDate)!=0"> По <xsl:call-template name="convertdatetime">
						<xsl:with-param name="str" select="$resolution/CardResolution/MainInfo/@ExpectedEndDate"/>
					</xsl:call-template>
				</xsl:if>
			</td>
			<td>
				<xsl:call-template name="convertdatetime">
					<xsl:with-param name="str" select="$resolution/CardResolution/MainInfo/@ControlDate"/>
				</xsl:call-template>
			</td>
			<td>
				<xsl:value-of select="$resolution/CardResolution/MainInfo/@Control_LName"/>
				<xsl:if test="string-length($resolution/CardResolution/MainInfo/@Control_LName)!=0"> </xsl:if>
				<xsl:value-of select="$resolution/CardResolution/MainInfo/@Control_FName"/>
				<xsl:if test="string-length($resolution/CardResolution/MainInfo/@Control_FName)!=0"> </xsl:if>
				<xsl:value-of select="$resolution/CardResolution/MainInfo/@Control_MName"/>
			</td>
			<td>
				<xsl:choose>
					<xsl:when test="$resolution/CardResolution/MainInfo/@ResolutionState=-1">Ошибка</xsl:when>
					<xsl:when test="$resolution/CardResolution/MainInfo/@ResolutionState=0">Не активна</xsl:when>
					<xsl:when test="$resolution/CardResolution/MainInfo/@ResolutionState=1">К исполнению</xsl:when>
					<xsl:when test="$resolution/CardResolution/MainInfo/@ResolutionState=2">В процессе</xsl:when>
					<xsl:when test="$resolution/CardResolution/MainInfo/@ResolutionState=3">Завершена</xsl:when>
					<xsl:when test="$resolution/CardResolution/MainInfo/@ResolutionState=4">Отозвана</xsl:when>
				</xsl:choose>
			</td>
		</tr>

		<xsl:for-each select="$resolution/Tasks/Data/Reports/Data">
			<tr>
				<td></td>
				<td class="fieldheader">Отчет</td>
				<td colspan="5">
					<xsl:value-of select="CardReport/MainInfo/@Name"/>
				</td>
			</tr>
			<tr>
				<td></td>
				<td></td>
				<td>
					<xsl:value-of select="CardReport/MainInfo/@Create_LName"/>
					<xsl:if test="string-length(CardReport/MainInfo/@Create_LName)!=0"> </xsl:if>
					<xsl:value-of select="CardReport/MainInfo/@Create_FName"/>
					<xsl:if test="string-length(CardReport/MainInfo/@Create_FName)!=0"> </xsl:if>
					<xsl:value-of select="CardReport/MainInfo/@Create_MName"/>
				</td>
				<td>
					<xsl:if test="string-length(CardReport/MainInfo/@PlannedDate)!=0">
						По <xsl:call-template name="convertdatetime">
							<xsl:with-param name="str" select="CardReport/MainInfo/@PlannedDate"/>
						</xsl:call-template>
					</xsl:if>
				</td>
				<td>
					<xsl:call-template name="convertdatetime">
						<xsl:with-param name="str" select="CardReport/MainInfo/@ControlDate"/>
					</xsl:call-template>
				</td>
				<td>
					<xsl:value-of select="CardReport/MainInfo/@Contr_LName"/>
					<xsl:if test="string-length(CardReport/MainInfo/@Contr_LName)!=0"> </xsl:if>
					<xsl:value-of select="CardReport/MainInfo/@Contr_FName"/>
					<xsl:if test="string-length(CardReport/MainInfo/@Contr_FName)!=0"> </xsl:if>
					<xsl:value-of select="CardReport/MainInfo/@Contr_MName"/>
				</td>
				<td>
					<xsl:choose>
						<xsl:when test="CardReport/MainInfo/@ReportState=-1">Ошибка</xsl:when>
						<xsl:when test="CardReport/MainInfo/@ReportState=0">Не активен</xsl:when>
						<xsl:when test="CardReport/MainInfo/@ReportState=1">Подготовлен к контролю</xsl:when>
						<xsl:when test="CardReport/MainInfo/@ReportState=2">На контроле</xsl:when>
						<xsl:when test="CardReport/MainInfo/@ReportState=3">Принят</xsl:when>
						<xsl:when test="CardReport/MainInfo/@ReportState=4">Отклонен</xsl:when>
					</xsl:choose>
				</td>
			</tr>
			<tr>
				<td></td>
				<td></td>
				<td colspan="5">
					<xsl:value-of select="CardReport/MainInfo/@Comments"/>
				</td>
			</tr>
		</xsl:for-each>
		
		<xsl:for-each select="$resolution/Tasks/Data/Resolutions/Data">
			<xsl:call-template name="printresolution">
				<xsl:with-param name="resolution" select="."/>
				<xsl:with-param name="level" select="concat($level, '.', position())"/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template match="//Resolutions">
		<html>
			<head>
				<link rel="stylesheet" type="text/css" href="%ServerUrl%/StorageServer/File.axd?BaseName=%BaseName%&amp;TransformID=B5344DA1-D28F-4024-8798-3FC3992C94B7"/>
				<title><xsl:value-of select="//Resolutions/ParentDocument/Data/*/MainInfo/@Name"/></title>
			</head>
			<body>
				<table>
					<tr>
						<td class="fieldheader">Тема</td>
						<td>
							<xsl:value-of select="//Resolutions/ParentDocument/Data/*/MainInfo/@Name"/>
						</td>
					</tr>
					<tr>
						<td class="fieldheader">Номер</td>
						<td>
							<xsl:value-of select="//Resolutions/ParentDocument/Data/*/MainInfo/@FullNumber"/>
						</td>
					</tr>
					<tr>
						<td class="fieldheader">Дата</td>
						<td>
							<xsl:call-template name="convertdatetime">
								<xsl:with-param name="str" select="//Resolutions/ParentDocument/Data/*/MainInfo/@CreationDate"/>
							</xsl:call-template>
						</td>
					</tr>
				</table>
				<br></br>
				<table>
					<th class="tableheader">Номер</th>
					<th class="tableheader">Автор</th>
					<th class="tableheader">Исполнители</th>
					<th class="tableheader">Срок исполнения</th>
					<th class="tableheader">Дата контроля</th>
					<th class="tableheader">Контролер</th>
					<th class="tableheader">Состояние</th>
					<xsl:for-each select="Data">
						<xsl:call-template name="printresolution">
							<xsl:with-param name="resolution" select="."/>
							<xsl:with-param name="level" select="position()"/>
						</xsl:call-template>
					</xsl:for-each>
				</table>
				<p class="smalltext">
				Для того чтобы изменить вид данного шаблона, Вы можете отредактировать "Стандартный шаблон печати" для дерева задач или создать новый шаблон на основе данного. 
				<br>DocsVision © 2002-2010. Все права защищены.</br>
				</p>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
