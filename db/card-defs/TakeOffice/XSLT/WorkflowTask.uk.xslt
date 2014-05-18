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
				<title><xsl:value-of select="//WorkflowTask[1]/MainInfo/@Name"/></title>
			</head>
			<body>
				<span class="header">
					<xsl:value-of select="//WorkflowTask[1]/MainInfo/@Name"/>
				</span>
				<br></br>				
				<span class="header2">Інформація про завдання</span>
				<table border="0" width="100%">
					<tr>
						<td class="fieldheader" width="25%">Назва:</td>
						<td colspan="3"><xsl:value-of select="//WorkflowTask[1]/MainInfo/@Name"/></td>
					</tr>
					<tr>
						<td colspan="4" class="fieldheader">Зміст:</td>
					</tr>
					<tr>
						<td colspan="4">
							<xsl:call-template name="replace">
								<xsl:with-param name="str" select="//WorkflowTask[1]/MainInfo/@Comments"/>
							</xsl:call-template>
						</td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Розпочинати якомога раніше:</td>
						<td width="25%"><xsl:if test="//WorkflowTask[1]/MainInfo/@StartASAP=1">Так</xsl:if></td>
						<td class="fieldheader" width="25%">Очікувана тривалість:</td>
						<td width="25%"><xsl:value-of select="//WorkflowTask[1]/MainInfo/@ExpectedDuration"/></td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Очікувана дата початку:</td>
						<td width="25%">
							<xsl:call-template name="convertdatetime">
								<xsl:with-param name="str" select="//WorkflowTask[1]/MainInfo/@ExpectedStartDate"/>
							</xsl:call-template>
						</td>
						<td class="fieldheader" width="25%">Очікувана дата закінчення:</td>
						<td width="25%">
							<xsl:call-template name="convertdatetime">
								<xsl:with-param name="str" select="//WorkflowTask[1]/MainInfo/@ExpectedEndDate"/>
							</xsl:call-template>
						</td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">До ознайомлення:</td>
						<td width="25%"><xsl:if test="//WorkflowTask[1]/AdditionalSettings/@ToRead=1">Так</xsl:if></td>
						<td class="fieldheader" width="25%">Створити завдання MS Outlook:</td>
						<td width="25%"><xsl:if test="//WorkflowTask[1]/MainInfo/@CreateOutlookTask=1">Так</xsl:if></td>
					</tr>
				</table>
				<br></br>												
				<span class="header2">Виконання завдання</span>
				<table border="0" width="100%">
					<tr>
						<td class="fieldheader" width="25%">Дійсна дата початку:</td>
						<td width="25%">
							<xsl:call-template name="convertdatetime">
								<xsl:with-param name="str" select="//WorkflowTask[1]/Performing/@ActualStartDate"/>
							</xsl:call-template>
						</td>
						<td class="fieldheader" width="25%">Дійсна дата закінчення:</td>
						<td width="25%">
							<xsl:call-template name="convertdatetime">
								<xsl:with-param name="str" select="//WorkflowTask[1]/Performing/@ActualEndDate"/>
							</xsl:call-template>
						</td>
					</tr>
					<tr>					
						<td class="fieldheader" width="25%">Стан завдання:</td>
						<td width="25%">
							<xsl:choose>
								<xsl:when test="//WorkflowTask[1]/Performing/@TaskState=0">Неактивно</xsl:when>
								<xsl:when test="//WorkflowTask[1]/Performing/@TaskState=1">До виконання</xsl:when>
								<xsl:when test="//WorkflowTask[1]/Performing/@TaskState=2">Не розпочато</xsl:when>
								<xsl:when test="//WorkflowTask[1]/Performing/@TaskState=3">В роботі</xsl:when>
								<xsl:when test="//WorkflowTask[1]/Performing/@TaskState=4">Відкладено</xsl:when>
								<xsl:when test="//WorkflowTask[1]/Performing/@TaskState=5">Завершено</xsl:when>
								<xsl:when test="//WorkflowTask[1]/Performing/@TaskState=6">Відмовлено</xsl:when>
								<xsl:when test="//WorkflowTask[1]/Performing/@TaskState=7">Відізвано</xsl:when>
								<xsl:when test="//WorkflowTask[1]/Performing/@TaskState=8">Делеговано - не розпочато</xsl:when>
								<xsl:when test="//WorkflowTask[1]/Performing/@TaskState=9">Делеговано - в роботі</xsl:when>
								<xsl:when test="//WorkflowTask[1]/Performing/@TaskState=10">Делеговано - відкладено</xsl:when>
								<xsl:when test="//WorkflowTask[1]/Performing/@TaskState=11">Делеговано - до виконання</xsl:when>
								<xsl:when test="//WorkflowTask[1]/Performing/@TaskState=12">Підготовка до делегування</xsl:when>
								<xsl:when test="//WorkflowTask[1]/Performing/@TaskState=13">Повернення з делегування</xsl:when>
								<xsl:when test="//WorkflowTask[1]/Performing/@TaskState=14">Повернено з делегування</xsl:when>
							</xsl:choose>
						</td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Відсоток виконання:</td>
						<td width="25%"><xsl:value-of select="//WorkflowTask[1]/Performing/@PercentCompleted"/>%</td>
						<td class="fieldheader" width="25%">Виконання розпочато:</td>
						<td width="25%"><xsl:if test="//WorkflowTask[1]/Performing/@ExecutionStarted=1">Так</xsl:if></td>
					</tr>
				</table>
				<br></br>
				<span class="header2">Додаткові налаштування</span>
				<table border="0" width="100%">
					<tr>
						<td class="fieldheader" width="25%">Право на відмову:</td>
						<td width="25%"><xsl:if test="//WorkflowTask[1]/AdditionalSettings/@CanReject=1">Так</xsl:if></td>
						<td class="fieldheader" width="25%">Право на перегляд журналу:</td>
						<td width="25%"><xsl:if test="//WorkflowTask[1]/AdditionalSettings/@CanViewLog=1">Так</xsl:if></td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Право на зміну термінів:</td>
						<td width="25%"><xsl:if test="//WorkflowTask[1]/AdditionalSettings/@CanReschedule=1">Так</xsl:if></td>
						<td class="fieldheader" width="25%">Право на зміну термінів контролером:</td>
						<td width="25%"><xsl:if test="//WorkflowTask[1]/AdditionalSettings/@ControllerCanReschedule=1">Так</xsl:if></td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Право делегувати:</td>
						<td width="25%"><xsl:if test="//WorkflowTask[1]/AdditionalSettings/@CanDelegate=1">Так</xsl:if></td>
						<td class="fieldheader" width="25%">Делегувати всім:</td>
						<td width="25%"><xsl:if test="//WorkflowTask[1]/AdditionalSettings/@DelegateToAll=1">Так</xsl:if></td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Необхідний звіт:</td>
						<td width="25%"><xsl:if test="//WorkflowTask[1]/AdditionalSettings/@IsReportNeeded=1">Так</xsl:if></td>
						<td class="fieldheader" width="25%">Право додавати документи</td>
						<td width="25%"><xsl:if test="//WorkflowTask[1]/AdditionalSettings/@CanAddDocuments=1">Так</xsl:if></td>
					</tr>
				</table>
				<br></br>
				<xsl:for-each select="//WorkflowTask[1]/Properties/PropertiesRow[(@Hidden=0 or not(@Hidden)) and @ParamType!=19]">
					<xsl:if test="position()=1">
						<xsl:text disable-output-escaping="yes">
							&lt;span class="header2"&gt;Властивості завдання&lt;/span&gt;
							&lt;table border="0" cellpadding="0" cellspacing="0" style="BORDER-COLLAPSE: collapse" bordercolor="black" width="100%"&gt;
								&lt;tr&gt;
									&lt;th class="tableheader" align="left"&gt;Ім'я&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Значення&lt;/th&gt;
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

				<xsl:for-each select="//WorkflowTask[1]/Comments/CommentsRow">
					<xsl:if test="position()=1">
						<xsl:text disable-output-escaping="yes">
							&lt;span class="header2"&gt;Коментарі до завдання&lt;/span&gt;
							&lt;table border="0" cellpadding="0" cellspacing="0" style="BORDER-COLLAPSE: collapse" bordercolor="black" width="100%"&gt;
								&lt;tr&gt;
									&lt;th class="tableheader" align="left"&gt;Автор&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Дата коментарю&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Коментар&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Звіт&lt;/th&gt;
								&lt;/tr&gt;
						</xsl:text>
					</xsl:if>
					<tr>
						<td class="field" width="25%"><xsl:value-of select="@LastName"/><xsl:if test="string-length(@LastName)!=0"> </xsl:if><xsl:value-of select="@FirstName"/><xsl:if test="string-length(@FirstName)!=0"> </xsl:if><xsl:value-of select="@MiddleName"/></td>
						<td class="field" width="25%">
							<xsl:call-template name="convertdatetime">
								<xsl:with-param name="str" select="@CreationDate"/>
							</xsl:call-template>
						</td>
						<td class="field" width="40%"><xsl:value-of select="@Comment"/></td>
						<td class="field" width="10%"><xsl:if test="@IsReport=1">Так</xsl:if></td>
					</tr>
					<xsl:if test="position()=last()">
						<xsl:text disable-output-escaping="yes">
							&lt;/table&gt;
							&lt;br/&gt;
						</xsl:text>
					</xsl:if>
				</xsl:for-each>

				<xsl:for-each select="//WorkflowTask[1]/Log/LogRows">
					<xsl:if test="position()=1">
						<xsl:text disable-output-escaping="yes">
							&lt;span class="header2"&gt;Журнал завдання&lt;/span&gt;
							&lt;table border="0" cellpadding="0" cellspacing="0" style="BORDER-COLLAPSE: collapse" bordercolor="black" width="100%"&gt;
								&lt;tr&gt;
									&lt;th class="tableheader" align="left"&gt;Ким зроблено&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Подія&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Дата події&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Відсоток виконання&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Стан завдання&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Опис&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Нова дата закінчення&lt;/th&gt;
								&lt;/tr&gt;
						</xsl:text>
					</xsl:if>
					<tr>
						<td class="field" width="15%"><xsl:value-of select="@LastName"/><xsl:if test="string-length(@LastName)!=0"> </xsl:if><xsl:value-of select="@FirstName"/><xsl:if test="string-length(@FirstName)!=0"> </xsl:if><xsl:value-of select="@MiddleName"/></td>
						<td class="field" width="15%">
							<xsl:choose>
								<xsl:when test="@Action=0">Відсутній</xsl:when>
								<xsl:when test="@Action=1">Завдання відкрите</xsl:when>
								<xsl:when test="@Action=2">Завдання закрите</xsl:when>
								<xsl:when test="@Action=3">Доданий документ</xsl:when>
								<xsl:when test="@Action=4">Змінений документ</xsl:when>
								<xsl:when test="@Action=5">Відкритий документ</xsl:when>
								<xsl:when test="@Action=6">Створена версія</xsl:when>
								<xsl:when test="@Action=7">Змінений статус</xsl:when>
								<xsl:when test="@Action=8">Змінений час</xsl:when>
								<xsl:when test="@Action=9">Доданий коментар</xsl:when>
								<xsl:when test="@Action=10">Доданий коментар до документу</xsl:when>
								<xsl:when test="@Action=11">Змінений відсоток</xsl:when>
								<xsl:when test="@Action=12">Завдання відкликане</xsl:when>
								<xsl:when test="@Action=13">Завдання відмовлене</xsl:when>
								<xsl:when test="@Action=14">Завдання закінчене</xsl:when>
								<xsl:when test="@Action=15">Надіслане на виконання</xsl:when>
								<xsl:when test="@Action=16">Делеговано</xsl:when>
								<xsl:when test="@Action=17">Повернення з делегування</xsl:when>
							</xsl:choose>
						</td>
						<td class="field" width="15%">
							<xsl:call-template name="convertdatetime">
								<xsl:with-param name="str" select="@ActionDate"/>
							</xsl:call-template>
						</td>
						<td class="field" width="5%"><xsl:value-of select="@PercentCompleted"/>%</td>
						<td class="field" width="15%">
							<xsl:choose>
								<xsl:when test="@TaskState=0">Неактивно</xsl:when>
								<xsl:when test="@TaskState=1">До виконання</xsl:when>
								<xsl:when test="@TaskState=2">Не почато</xsl:when>
								<xsl:when test="@TaskState=3">В роботі</xsl:when>
								<xsl:when test="@TaskState=4">Відкладено</xsl:when>
								<xsl:when test="@TaskState=5">Закінчено</xsl:when>
								<xsl:when test="@TaskState=6">Відмовлено</xsl:when>
								<xsl:when test="@TaskState=7">Відкликано</xsl:when>
								<xsl:when test="@TaskState=8">Делеговано - не розпочато</xsl:when>
								<xsl:when test="@TaskState=9">Делеговано - в роботі</xsl:when>
								<xsl:when test="@TaskState=10">Делеговано - відкладено</xsl:when>
								<xsl:when test="@TaskState=11">Делеговано - до виконання</xsl:when>
								<xsl:when test="@TaskState=12">Завдання делеговано</xsl:when>
								<xsl:when test="@TaskState=13">Повернення з делегування</xsl:when>
								<xsl:when test="@TaskState=14">Повернено з делегування</xsl:when>
							</xsl:choose>
						</td>
						<td class="field" width="20%"><xsl:value-of select="@Description"/></td>
						<td class="field" width="15%">
							<xsl:call-template name="convertdatetime">
								<xsl:with-param name="str" select="@NewEndDate"/>
							</xsl:call-template>
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
				Для того щоб змінити вигляд даного шаблону, Ви можете відредагувати "Стандартний шаблон друку" для картки "Завдання бізнес-процесу" або створити новий шаблон на основі даного. 
				<br>DocsVision © 2002-2010. Всі права захищені.</br>
				</p>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
