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
				<title><xsl:value-of select="//CardReport[1]/MainInfo/@Subject"/></title>
			</head>
			<body>
				<span class="header2">Отчет</span>
				<table border="0" width="100%">
               <tr>
                  <td class="fieldheader" width="25%">Тема:</td>
                  <td colspan="3">
                     <xsl:value-of select="//CardReport[1]/MainInfo/@Name"/>
                  </td>
               </tr>
					<tr>
						<td class="fieldheader" width="25%">Автор:</td>
						<td colspan="3">
                     <xsl:value-of select="//CardReport[1]/MainInfo/@Create_LName"/>
                     <xsl:if test="string-length(//CardReport[1]/MainInfo/@Create_LName)!=0"> </xsl:if>
                     <xsl:value-of select="//CardReport[1]/MainInfo/@Create_FName"/>
                     <xsl:if test="string-length(//CardReport[1]/MainInfo/@Create_FName)!=0"> </xsl:if>
                     <xsl:value-of select="//CardReport[1]/MainInfo/@Create_MName"/>
						</td>
					</tr>
               <tr>
						<td class="fieldheader" width="25%">Дата создания:</td>
						<td colspan="3">
						<xsl:call-template name="convertdatetime">
							<xsl:with-param name="str" select="//CardReport[1]/MainInfo/@CreationDate"/>
						</xsl:call-template>
						</td>
					</tr>
               <tr>
                  <td class="fieldheader" width="25%">Контролер:</td>
                  <td colspan="3">
                     <xsl:value-of select="//CardReport[1]/MainInfo/@Contr_LName"/>
                     <xsl:if test="string-length(//CardReport[1]/MainInfo/@Contr_LName)!=0"> </xsl:if>
                     <xsl:value-of select="//CardReport[1]/MainInfo/@Contr_FName"/>
                     <xsl:if test="string-length(//CardReport[1]/MainInfo/@Contr_FName)!=0"> </xsl:if>
                     <xsl:value-of select="//CardReport[1]/MainInfo/@Contr_MName"/>
                  </td>
               </tr>
               <tr>
						<td class="fieldheader" width="25%">Состояние отчета:</td>
						<td colspan="3">
                     <xsl:choose>
                        <xsl:when test="//CardReport[1]/MainInfo/@ReportState=-1">Ошибка</xsl:when>
                        <xsl:when test="//CardReport[1]/MainInfo/@ReportState=0">Не активен</xsl:when>
                        <xsl:when test="//CardReport[1]/MainInfo/@ReportState=1">Подготовлен к контролю</xsl:when>
                        <xsl:when test="//CardReport[1]/MainInfo/@ReportState=2">На контроле</xsl:when>
                        <xsl:when test="//CardReport[1]/MainInfo/@ReportState=3">Принят</xsl:when>
                        <xsl:when test="//CardReport[1]/MainInfo/@ReportState=4">Отклонен</xsl:when>
                     </xsl:choose>
                  </td>
					</tr>
               <tr>
                  <td class="fieldheader" width="25%">Родительское задание:</td>
                  <td colspan="3">
                     <xsl:value-of select="//CardReport[1]/MainInfo/@ParentDescription"/>
                  </td>
               </tr>
               <tr>
                  <td class="fieldheader" width="25%">Плановый срок сдачи:</td>
                  <td>
                     <xsl:call-template name="convertdatetime">
                        <xsl:with-param name="str" select="//CardReport[1]/MainInfo/@PlannedDate"/>
                     </xsl:call-template>
                  </td>
                  <td class="fieldheader" width="25%">Фактический срок сдачи:</td>
                  <td>
                     <xsl:call-template name="convertdatetime">
                        <xsl:with-param name="str" select="//CardReport[1]/MainInfo/@ActualDate"/>
                     </xsl:call-template>
                  </td>
               </tr>
               <tr>
                  <td class="fieldheader" width="25%">Дата контроля:</td>
                  <td>
                     <xsl:call-template name="convertdatetime">
                        <xsl:with-param name="str" select="//CardReport[1]/MainInfo/@ControlDate"/>
                     </xsl:call-template>
                  </td>
                  <td class="fieldheader" width="25%">Дата принятия:</td>
                  <td>
                     <xsl:call-template name="convertdatetime">
                        <xsl:with-param name="str" select="//CardReport[1]/MainInfo/@AcceptDate"/>
                     </xsl:call-template>
                  </td>
               </tr>
               <tr>
                  <td colspan="4" class="fieldheader">
                     <xsl:if test="//CardReport[1]/MainInfo/@Confidential=1">Конфиденциально</xsl:if>
                  </td>
               </tr>
               <tr>
						<td colspan="4" class="fieldheader">Содержание:</td>
					</tr>
					<tr>
						<td colspan="4">
							<xsl:call-template name="replace">
								<xsl:with-param name="str" select="//CardReport[1]/MainInfo/@Comments"/>
							</xsl:call-template>
						</td>
					</tr>
				</table>
            <br></br>

				<xsl:for-each select="//CardReport[1]/Properties/PropertiesRow[(@Hidden=0 or not(@Hidden)) and @ParamType!=19]">
					<xsl:if test="position()=1">
						<xsl:text disable-output-escaping="yes">
							&lt;span class="header2"&gt;Свойства отчета&lt;/span&gt;
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

				<xsl:for-each select="//CardReport[1]/Comments/CommentsRow">
               <xsl:if test="position()=1">
                  <xsl:text disable-output-escaping="yes">
							&lt;span class="header2"&gt;Комментарии отчета&lt;/span&gt;
							&lt;table border="0" cellpadding="0" cellspacing="0" style="BORDER-COLLAPSE: collapse" bordercolor="black" width="100%"&gt;
								&lt;tr&gt;
									&lt;th class="tableheader" align="left"&gt;Автор&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Дата&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Комментарий&lt;/th&gt;
								&lt;/tr&gt;
						</xsl:text>
               </xsl:if>
               <tr>
                  <td class="field" width="30%">
                     <xsl:value-of select="@LastName"/>
                     <xsl:if test="string-length(@LastName)!=0"> </xsl:if>
                     <xsl:value-of select="@FirstName"/>
                     <xsl:if test="string-length(@FirstName)!=0"> </xsl:if>
                     <xsl:value-of select="@MiddleName"/>
                  </td>
                  <td class="field" width="25%">
                     <xsl:value-of select="translate(@CreationDate, 'T', ' ')"/>
                  </td>
                  <td class="field" width="45%">
                     <xsl:value-of select="@Comment"/>
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
               Для того чтобы изменить вид данного шаблона, Вы можете отредактировать "Стандартный шаблон печати" для карточки "Отчет" или создать новый шаблон на основе данного.
               <br>DocsVision © 2002-2010. Все права защищены.</br>
            </p>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
