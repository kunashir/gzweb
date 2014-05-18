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
				<title><xsl:value-of select="//CardOrd[1]/MainInfo/@Name"/></title>
			</head>
			<body>
				<span class="header">
					<xsl:value-of select="//CardOrd[1]/MainInfo/@Name"/>
				</span>
				<br></br>				
				<span class="header2">Реєстрація</span>
				<table border="0" width="100%">
					<tr>
						<td class="fieldheader" width="25%">Ім'я:</td>
						<td colspan="3"><xsl:value-of select="//CardOrd[1]/MainInfo/@Name"/></td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Тип:</td>
						<td width="25%"><xsl:value-of select="//CardOrd[1]/MainInfo/@DocType_Name"/></td>
						<td class="fieldheader" width="25%">Номер:</td>
						<td><xsl:value-of select="//CardOrd[1]/MainInfo/@FullNumber"/></td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Дата створення:</td>
						<td width="25%">
							<xsl:call-template name="convertdatetime">
								<xsl:with-param name="str" select="//CardOrd[1]/MainInfo/@CreationDate"/>
							</xsl:call-template>
						</td>
						<td class="fieldheader" width="25%">Дата реєстрації:</td>
						<td width="25%">
							<xsl:call-template name="convertdatetime">
								<xsl:with-param name="str" select="//CardOrd[1]/MainInfo/@RegistrationDate"/>
							</xsl:call-template>
						</td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Реєстрація:</td>
						<td colspan="3"><xsl:value-of select="//CardOrd[1]/MainInfo/@Reg_LName"/><xsl:if test="string-length(//CardOrd[1]/MainInfo/@Reg_LName)!=0"> </xsl:if><xsl:value-of select="//CardOrd[1]/MainInfo/@Reg_FName"/><xsl:if test="string-length(//CardOrd[1]/MainInfo/@Reg_FName)!=0"> </xsl:if><xsl:value-of select="//CardOrd[1]/MainInfo/@Reg_MName"/></td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Автор:</td>
						<td colspan="3"><xsl:value-of select="//CardOrd[1]/MainInfo/@Recip_LName"/><xsl:if test="string-length(//CardOrd[1]/MainInfo/@Recip_LName)!=0"> </xsl:if><xsl:value-of select="//CardOrd[1]/MainInfo/@Recip_FName"/><xsl:if test="string-length(//CardOrd[1]/MainInfo/@Recip_FName)!=0"> </xsl:if><xsl:value-of select="//CardOrd[1]/MainInfo/@Recip_MName"/></td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Виконавець:</td>
						<td colspan="3">
						<xsl:for-each select="//CardOrd[1]/Employees/EmployeesRow[@Type=0]">
							<xsl:if test="@IsResponsible=1"><xsl:text disable-output-escaping="yes">&lt;span class="fieldheader"&gt;</xsl:text></xsl:if>
							<xsl:value-of select="@LastName"/><xsl:if test="string-length(@LastName)!=0"> </xsl:if><xsl:value-of select="@FirstName"/><xsl:if test="string-length(@FirstName)!=0"> </xsl:if><xsl:value-of select="@MiddleName"/>
							<xsl:if test="@IsResponsible=1"><xsl:text disable-output-escaping="yes">&lt;/span class="fieldheader"&gt;</xsl:text></xsl:if>
							<xsl:if test="position()!=last()">, </xsl:if>
						</xsl:for-each>
						</td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Подписано:</td>
						<td colspan="3">
						<xsl:for-each select="//CardOrd[1]/Employees/EmployeesRow[@Type=2]">
							<xsl:value-of select="@LastName"/><xsl:if test="string-length(@LastName)!=0"> </xsl:if><xsl:value-of select="@FirstName"/><xsl:if test="string-length(@FirstName)!=0"> </xsl:if><xsl:value-of select="@MiddleName"/>
							<xsl:if test="position()!=last()">, </xsl:if>
						</xsl:for-each>
						</td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Погоджувачі:</td>
						<td colspan="3">
						<xsl:for-each select="//CardOrd[1]/Employees/EmployeesRow[@Type=3]">
							<xsl:value-of select="@LastName"/><xsl:if test="string-length(@LastName)!=0"> </xsl:if><xsl:value-of select="@FirstName"/><xsl:if test="string-length(@FirstName)!=0"> </xsl:if><xsl:value-of select="@MiddleName"/>
							<xsl:if test="position()!=last()">, </xsl:if>
						</xsl:for-each>
						</td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Стан документу:</td>
						<td colspan="3"><xsl:value-of select="//CardOrd[1]/MainInfo/@StateName"/></td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Категорії:</td>
						<td colspan="3">
							<xsl:for-each select="//CardOrd[1]/Categories/CategoriesRow">
								<xsl:value-of select="@Name"/>
								<xsl:if test="position()!=last()">, </xsl:if>
							</xsl:for-each>
						</td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Реквізит документу:</td>
						<td width="25%"><xsl:value-of select="//CardOrd[1]/MainInfo/@DocProperty"/></td>
						<td colspan="2"><xsl:if test="//CardOrd[1]/MainInfo/@Confidential=1">Конфиденциально</xsl:if></td>
					</tr>
					<tr>
						<td colspan="4" class="fieldheader">Зміст:</td>
					</tr>
					<tr>
						<td colspan="4">
							<xsl:call-template name="replace">
								<xsl:with-param name="str" select="//CardOrd[1]/MainInfo/@Digest"/>
							</xsl:call-template>
						</td>
					</tr>
				</table>
				<br></br>				
				<span class="header2">Зберігання</span>
				<table border="0" width="100%">
					<tr>
						<td class="fieldheader" width="25%">Кількість листів:</td>
						<td width="25%"><xsl:value-of select="//CardOrd[1]/MainInfo/@PageCount"/></td>
						<td class="fieldheader" width="25%">Кількість листів в додатку:</td>
						<td width="30%"><xsl:value-of select="//CardOrd[1]/MainInfo/@AttachmentPageCount"/></td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Підшитий до папки:</td>
						<td colspan="3"><xsl:value-of select="//CardOrd[1]/MainInfo/@Folder_Name"/></td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Підшитий до справи:</td>
						<td colspan="3"><xsl:value-of select="//CardOrd[1]/MainInfo/@Case_Name"/></td>
					</tr>
				</table>
				<br></br>								
				<xsl:for-each select="//CardOrd[1]/CardReferences/CardReferencesRow">
					<xsl:if test="position()=1">
						<xsl:text disable-output-escaping="yes">
							&lt;span class="header2"&gt;Посилання на картки&lt;/span&gt;
							&lt;table border="0" cellpadding="0" cellspacing="0" style="BORDER-COLLAPSE: collapse" bordercolor="black" width="100%"&gt;
								&lt;tr&gt;
									&lt;th class="tableheader" align="left"&gt;Тип&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Картка&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Дата створення&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Створено&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Коментар&lt;/th&gt;
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
				<xsl:for-each select="//CardOrd[1]/Properties/PropertiesRow[(@Hidden=0 or not(@Hidden)) and @ParamType!=19]">
					<xsl:if test="position()=1">
						<xsl:text disable-output-escaping="yes">
							&lt;span class="header2"&gt;Властивість документа&lt;/span&gt;
							&lt;table border="0" cellpadding="0" cellspacing="0" style="BORDER-COLLAPSE: collapse" bordercolor="black" width="100%"&gt;
								&lt;tr&gt;
									&lt;th class="tableheader" align="left"&gt;№&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Назва&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Значення&lt;/th&gt;
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
				<p class="smalltext">
				Для того щоб змінити вигляд даного шаблону, Ви можете відредагувати "Стандартний шаблон друку" для картки "Внутрішній документ" або створити новий шаблон на основі даного.
				<br>DocsVision © 2002-2010. Всі права захищені.</br>
				</p>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
