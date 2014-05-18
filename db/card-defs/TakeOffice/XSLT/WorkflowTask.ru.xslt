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
				<span class="header2">Информация о задании</span>
				<table border="0" width="100%">
					<tr>
						<td class="fieldheader" width="25%">Название:</td>
						<td colspan="3"><xsl:value-of select="//WorkflowTask[1]/MainInfo/@Name"/></td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Автор:</td>
						<td colspan="3">
							<xsl:if test="string-length(//WorkflowTask[1]/MainInfo/@Cre_DisplayString)!=0">
								<xsl:value-of select="//WorkflowTask[1]/MainInfo/@Cre_DisplayString"/>
							</xsl:if>
							<xsl:if test="string-length(//WorkflowTask[1]/MainInfo/@Cre_DisplayString)=0">
								<xsl:value-of select="//WorkflowTask[1]/MainInfo/@Cre_LastName"/>
								<xsl:if test="string-length(//WorkflowTask[1]/MainInfo/@Cre_LastName)!=0"> </xsl:if>
								<xsl:value-of select="//WorkflowTask[1]/MainInfo/@Cre_FirstName"/>
								<xsl:if test="string-length(//WorkflowTask[1]/MainInfo/@Cre_FirstName)!=0"> </xsl:if>
								<xsl:value-of select="//WorkflowTask[1]/MainInfo/@Cre_MiddleName"/>
							</xsl:if>
						</td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Регистратор:</td>
						<td colspan="3">
							<xsl:if test="string-length(//WorkflowTask[1]/MainInfo/@Reg_DisplayString)!=0">
								<xsl:value-of select="//WorkflowTask[1]/MainInfo/@Reg_DisplayString"/>
							</xsl:if>
							<xsl:if test="string-length(//WorkflowTask[1]/MainInfo/@Reg_DisplayString)=0">
								<xsl:value-of select="//WorkflowTask[1]/MainInfo/@Reg_LastName"/>
								<xsl:if test="string-length(//WorkflowTask[1]/MainInfo/@Reg_LastName)!=0"> </xsl:if>
								<xsl:value-of select="//WorkflowTask[1]/MainInfo/@Reg_FirstName"/>
								<xsl:if test="string-length(//WorkflowTask[1]/MainInfo/@Reg_FirstName)!=0"> </xsl:if>
								<xsl:value-of select="//WorkflowTask[1]/MainInfo/@Reg_MiddleName"/>
							</xsl:if>
						</td>
					</tr>
					<tr>
						<xsl:if test="//WorkflowTask[1]/MainInfo/@IsControllerTask=1">
							<td class="fieldheader" width="25%">Контролер:</td>
						</xsl:if>
						<xsl:if test="//WorkflowTask[1]/MainInfo/@IsControllerTask=0 or not(//WorkflowTask[1]/MainInfo/@IsControllerTask)">
							<td class="fieldheader" width="25%">Исполнитель:</td>
						</xsl:if>
						<td>
							<xsl:if test="//WorkflowTask[1]/Performing/@CurrentPerformer">
								<xsl:if test="string-length(//WorkflowTask[1]/Performing/@DisplayString)!=0">
									<xsl:value-of select="//WorkflowTask[1]/Performing/@DisplayString"/>
								</xsl:if>
								<xsl:if test="string-length(//WorkflowTask[1]/Performing/@DisplayString)=0">
									<xsl:value-of select="//WorkflowTask[1]/Performing/@LastName"/>
									<xsl:if test="string-length(//WorkflowTask[1]/Performing/@LastName)!=0"> </xsl:if>
									<xsl:value-of select="//WorkflowTask[1]/Performing/@FirstName"/>
									<xsl:if test="string-length(//WorkflowTask[1]/Performing/@FirstName)!=0"> </xsl:if>
									<xsl:value-of select="//WorkflowTask[1]/Performing/@MiddleName"/>
								</xsl:if>
								<xsl:for-each select="//WorkflowTask[1]/CurrentPerformers/CurrentPerformersRow[@IsActive=1]">
									<xsl:if test="@DeputyFor">
										(исполняется за:
										<xsl:if test="string-length(@Dep_DisplayString)!=0">
											<xsl:value-of select="@Dep_DisplayString"/>
										</xsl:if>
										<xsl:if test="string-length(@Dep_DisplayString)=0">
											<xsl:value-of select="@Dep_LastName"/>
											<xsl:if test="string-length(@Dep_LastName)!=0"> </xsl:if>
											<xsl:value-of select="@Dep_FirstName"/>
											<xsl:if test="string-length(@Dep_FirstName)!=0"> </xsl:if>
											<xsl:value-of select="@Dep_MiddleName"/>
										</xsl:if>
										)
									</xsl:if>
									<xsl:if test="@DelegatedFrom">
										<xsl:variable name="DelegatedFromID">
											<xsl:value-of select="@DelegatedFrom"/>
										</xsl:variable>
										<xsl:for-each select="//WorkflowTask[1]/CurrentPerformers/CurrentPerformersRow[@RowID=$DelegatedFromID]">
											(делегировано от:
											<xsl:if test="string-length(@DisplayString)!=0">
												<xsl:value-of select="@DisplayString"/>
											</xsl:if>
											<xsl:if test="string-length(@DisplayString)=0">
												<xsl:value-of select="@LastName"/>
												<xsl:if test="string-length(@LastName)!=0"> </xsl:if>
												<xsl:value-of select="@FirstName"/>
												<xsl:if test="string-length(@FirstName)!=0"> </xsl:if>
												<xsl:value-of select="@MiddleName"/>
											</xsl:if>)
										</xsl:for-each>
									</xsl:if>
								</xsl:for-each>
							</xsl:if>
							<xsl:if test="not(//WorkflowTask[1]/Performing/@CurrentPerformer)">
								<xsl:for-each select="//WorkflowTask[1]/Performers/PerformersRow">
									<xsl:value-of select="@PerformerName"/>
									<xsl:if test="position()!=last()">, </xsl:if>
								</xsl:for-each>
							</xsl:if>
						</td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Ответственный исполнитель:</td>
						<td colspan="3">
							<xsl:if test="string-length(//WorkflowTask[1]/MainInfo/@Con_DisplayString)!=0">
								<xsl:value-of select="//WorkflowTask[1]/MainInfo/@Con_DisplayString"/>
							</xsl:if>
							<xsl:if test="string-length(//WorkflowTask[1]/MainInfo/@Con_DisplayString)=0">
								<xsl:value-of select="//WorkflowTask[1]/MainInfo/@Con_LastName"/>
								<xsl:if test="string-length(//WorkflowTask[1]/MainInfo/@Con_LastName)!=0"> </xsl:if>
								<xsl:value-of select="//WorkflowTask[1]/MainInfo/@Con_FirstName"/>
								<xsl:if test="string-length(//WorkflowTask[1]/MainInfo/@Con_FirstName)!=0"> </xsl:if>
								<xsl:value-of select="//WorkflowTask[1]/MainInfo/@Con_MiddleName"/>
							</xsl:if>
						</td>
					</tr>
					<xsl:if test="//WorkflowTask[1]/MainInfo/@IsControllerTask=0 or not(//WorkflowTask[1]/MainInfo/@IsControllerTask)">
						<tr>
							<td class="fieldheader" width="25%">Контролер:</td>
							<td colspan="3">
								<xsl:if test="string-length(//WorkflowTask[1]/MainInfo/@TCo_DisplayString)!=0">
									<xsl:value-of select="//WorkflowTask[1]/MainInfo/@TCo_DisplayString"/>
								</xsl:if>
								<xsl:if test="string-length(//WorkflowTask[1]/MainInfo/@TCo_DisplayString)=0">
									<xsl:value-of select="//WorkflowTask[1]/MainInfo/@TCo_LastName"/>
									<xsl:if test="string-length(//WorkflowTask[1]/MainInfo/@TCo_LastName)!=0"> </xsl:if>
									<xsl:value-of select="//WorkflowTask[1]/MainInfo/@TCo_FirstName"/>
									<xsl:if test="string-length(//WorkflowTask[1]/MainInfo/@TCo_FirstName)!=0"> </xsl:if>
									<xsl:value-of select="//WorkflowTask[1]/MainInfo/@TCo_MiddleName"/>
								</xsl:if>
							</td>
						</tr>
					</xsl:if>
					<tr>
						<td class="fieldheader" width="25%">Подписано:</td>
						<td colspan="3">
							<xsl:for-each select="//WorkflowTask[1]/Employees/EmployeesRow[@Type=2]">
								<xsl:if test="string-length(@DisplayString)!=0">
									<xsl:value-of select="@DisplayString"/>
								</xsl:if>
								<xsl:if test="string-length(@DisplayString)=0">
									<xsl:value-of select="@LastName"/>
									<xsl:if test="string-length(@LastName)!=0"> </xsl:if>
									<xsl:value-of select="@FirstName"/>
									<xsl:if test="string-length(@FirstName)!=0"> </xsl:if>
									<xsl:value-of select="@MiddleName"/>
								</xsl:if>
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
								<xsl:with-param name="str" select="//WorkflowTask[1]/MainInfo/@Comments"/>
							</xsl:call-template>
						</td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Начинать как можно раньше:</td>
						<td width="25%"><xsl:if test="//WorkflowTask[1]/MainInfo/@StartASAP=1">Да</xsl:if></td>
						<td class="fieldheader" width="25%">Ожидаемая продолжительность (час):</td>
						<td width="25%"><xsl:value-of select="//WorkflowTask[1]/MainInfo/@ExpectedDuration"/></td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Ожидаемая дата начала:</td>
						<td width="25%">
							<xsl:call-template name="convertdatetime">
								<xsl:with-param name="str" select="//WorkflowTask[1]/MainInfo/@ExpectedStartDate"/>
							</xsl:call-template>
						</td>
						<td class="fieldheader" width="25%">Ожидаемая дата окончания:</td>
						<td width="25%">
							<xsl:call-template name="convertdatetime">
								<xsl:with-param name="str" select="//WorkflowTask[1]/MainInfo/@ExpectedEndDate"/>
							</xsl:call-template>
						</td>
					</tr>
					<xsl:if test="//WorkflowTask[1]/MainInfo/@WorkDuration">
						<xsl:if test="//WorkflowTask[1]/MainInfo/@WorkDuration > 0">
							<tr>
								<td class="fieldheader" width="25%">Планируемая трудоемкость (час):</td>
								<td colspan="3">
									<xsl:value-of select="//WorkflowTask[1]/MainInfo/@WorkDuration"/>
								</td>
							</tr>
						</xsl:if>
					</xsl:if>
					<tr>
						<td class="fieldheader" width="25%">К ознакомлению:</td>
						<td width="25%"><xsl:if test="//WorkflowTask[1]/AdditionalSettings/@ToRead=1">Да</xsl:if></td>
						<td class="fieldheader" width="25%">Создать задание MS Outlook:</td>
						<td width="25%"><xsl:if test="//WorkflowTask[1]/MainInfo/@CreateOutlookTask=1">Да</xsl:if></td>
					</tr>
				</table>
				<br></br>												
				<span class="header2">Выполнение задания</span>
				<table border="0" width="100%">
					<tr>
						<td class="fieldheader" width="25%">Действительная дата начала:</td>
						<td width="25%">
							<xsl:call-template name="convertdatetime">
								<xsl:with-param name="str" select="//WorkflowTask[1]/Performing/@ActualStartDate"/>
							</xsl:call-template>
						</td>
						<td class="fieldheader" width="25%">Действительная дата окончания:</td>
						<td width="25%">
							<xsl:call-template name="convertdatetime">
								<xsl:with-param name="str" select="//WorkflowTask[1]/Performing/@ActualEndDate"/>
							</xsl:call-template>
						</td>
					</tr>
					<xsl:if test="//WorkflowTask[1]/Performing/@ActualWorkDuration">
						<xsl:if test="//WorkflowTask[1]/Performing/@ActualWorkDuration > 0">
							<tr>
								<td class="fieldheader" width="25%">Фактическая трудоемкость (час):</td>
								<td colspan="3">
									<xsl:value-of select="//WorkflowTask[1]/Performing/@ActualWorkDuration"/>
								</td>
							</tr>
						</xsl:if>
					</xsl:if>
					<tr>					
						<td class="fieldheader" width="25%">Состояние задания:</td>
						<td width="25%">
							<xsl:choose>
								<xsl:when test="//WorkflowTask[1]/Performing/@TaskState=0">Неактивно</xsl:when>
								<xsl:when test="//WorkflowTask[1]/Performing/@TaskState=1">К исполнению</xsl:when>
								<xsl:when test="//WorkflowTask[1]/Performing/@TaskState=2">Не начато</xsl:when>
								<xsl:when test="//WorkflowTask[1]/Performing/@TaskState=3">В работе</xsl:when>
								<xsl:when test="//WorkflowTask[1]/Performing/@TaskState=4">Отложено</xsl:when>
								<xsl:when test="//WorkflowTask[1]/Performing/@TaskState=5">Завершено</xsl:when>
								<xsl:when test="//WorkflowTask[1]/Performing/@TaskState=6">Отказано</xsl:when>
								<xsl:when test="//WorkflowTask[1]/Performing/@TaskState=7">Отозвано</xsl:when>
								<xsl:when test="//WorkflowTask[1]/Performing/@TaskState=8">Делегировано - не начато</xsl:when>
								<xsl:when test="//WorkflowTask[1]/Performing/@TaskState=9">Делегировано - в работе</xsl:when>
								<xsl:when test="//WorkflowTask[1]/Performing/@TaskState=10">Делегировано - отложено</xsl:when>
								<xsl:when test="//WorkflowTask[1]/Performing/@TaskState=11">Делегировано - к исполнению</xsl:when>
								<xsl:when test="//WorkflowTask[1]/Performing/@TaskState=12">Подготовка к делегированию</xsl:when>
								<xsl:when test="//WorkflowTask[1]/Performing/@TaskState=13">Возврат с делегирования</xsl:when>
								<xsl:when test="//WorkflowTask[1]/Performing/@TaskState=14">Возвращено с делегирования</xsl:when>
							</xsl:choose>
						</td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Процент выполнения:</td>
						<td width="25%"><xsl:value-of select="//WorkflowTask[1]/Performing/@PercentCompleted"/>%</td>
						<td class="fieldheader" width="25%">Исполнение начато:</td>
						<td width="25%"><xsl:if test="//WorkflowTask[1]/Performing/@ExecutionStarted=1">Да</xsl:if></td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Завершивший сотрудник:</td>
						<td colspan="3">
							<xsl:if test="string-length(//WorkflowTask[1]/Performing/@Com_DisplayString)!=0">
								<xsl:value-of select="//WorkflowTask[1]/Performing/@Com_DisplayString"/>
							</xsl:if>
							<xsl:if test="string-length(//WorkflowTask[1]/Performing/@Com_DisplayString)=0">
								<xsl:value-of select="//WorkflowTask[1]/Performing/@Com_LastName"/>
								<xsl:if test="string-length(//WorkflowTask[1]/Performing/@Com_LastName)!=0"> </xsl:if>
								<xsl:value-of select="//WorkflowTask[1]/Performing/@Com_FirstName"/>
								<xsl:if test="string-length(//WorkflowTask[1]/Performing/@Com_FirstName)!=0"> </xsl:if>
								<xsl:value-of select="//WorkflowTask[1]/Performing/@Com_MiddleName"/>
							</xsl:if>
						</td>
					</tr>
				</table>
				<br></br>
				<span class="header2">Дополнительные настройки</span>
				<table border="0" width="100%">
					<tr>
						<td class="fieldheader" width="25%">Право на отказ:</td>
						<td width="25%"><xsl:if test="//WorkflowTask[1]/AdditionalSettings/@CanReject=1">Да</xsl:if></td>
						<td class="fieldheader" width="25%">Право просмотра журнала:</td>
						<td width="25%"><xsl:if test="//WorkflowTask[1]/AdditionalSettings/@CanViewLog=1">Да</xsl:if></td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Право изменения сроков:</td>
						<td width="25%"><xsl:if test="//WorkflowTask[1]/AdditionalSettings/@CanReschedule=1">Да</xsl:if></td>
						<td class="fieldheader" width="25%">Право изменения сроков контролером:</td>
						<td width="25%"><xsl:if test="//WorkflowTask[1]/AdditionalSettings/@ControllerCanReschedule=1">Да</xsl:if></td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Право делегировать:</td>
						<td width="25%"><xsl:if test="//WorkflowTask[1]/AdditionalSettings/@CanDelegate=1">Да</xsl:if></td>
						<td class="fieldheader" width="25%">Делегировать всем:</td>
						<td width="25%"><xsl:if test="//WorkflowTask[1]/AdditionalSettings/@DelegateToAll=1">Да</xsl:if></td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Необходим отчет:</td>
						<td width="25%"><xsl:if test="//WorkflowTask[1]/AdditionalSettings/@IsReportNeeded=1">Да</xsl:if></td>
						<td class="fieldheader" width="25%">Право добавлять документы</td>
						<td width="25%"><xsl:if test="//WorkflowTask[1]/AdditionalSettings/@CanAddDocuments=1">Да</xsl:if></td>
					</tr>
				</table>
				<br></br>
				
				<xsl:for-each select="//WorkflowTask[1]/Properties/PropertiesRow[(@Hidden=0 or not(@Hidden)) and @ParamType!=19]">
					<xsl:if test="position()=1">
						<xsl:text disable-output-escaping="yes">
							&lt;span class="header2"&gt;Свойства задания&lt;/span&gt;
							&lt;table border="0" cellpadding="0" cellspacing="0" style="BORDER-COLLAPSE: collapse" bordercolor="black" width="100%"&gt;
								&lt;tr&gt;
									&lt;th class="tableheader" align="left"&gt;Имя&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Значение&lt;/th&gt;
								&lt;/tr&gt;
						</xsl:text>
					</xsl:if>
					<tr>
						<td class="field" width="40%"><xsl:value-of select="@Name"/></td>
						<td class="field" width="60%"><xsl:value-of select="@DisplayValue"/></td>
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
							&lt;span class="header2"&gt;Комментарии к заданию&lt;/span&gt;
							&lt;table border="0" cellpadding="0" cellspacing="0" style="BORDER-COLLAPSE: collapse" bordercolor="black" width="100%"&gt;
								&lt;tr&gt;
									&lt;th class="tableheader" align="left"&gt;Автор&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Дата комментария&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Комментарий&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Отчет&lt;/th&gt;
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
						<td class="field" width="10%"><xsl:if test="@IsReport=1">Да</xsl:if></td>
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
							&lt;span class="header2"&gt;Журнал задания&lt;/span&gt;
							&lt;table border="0" cellpadding="0" cellspacing="0" style="BORDER-COLLAPSE: collapse" bordercolor="black" width="100%"&gt;
								&lt;tr&gt;
									&lt;th class="tableheader" align="left"&gt;Кем совершено&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Событие&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Дата события&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Процент завершения&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Состояние задания&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Описание&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Новая дата завершения&lt;/th&gt;
								&lt;/tr&gt;
						</xsl:text>
					</xsl:if>
					<tr>
						<td class="field" width="15%"><xsl:value-of select="@LastName"/><xsl:if test="string-length(@LastName)!=0"> </xsl:if><xsl:value-of select="@FirstName"/><xsl:if test="string-length(@FirstName)!=0"> </xsl:if><xsl:value-of select="@MiddleName"/></td>
						<td class="field" width="15%">
							<xsl:choose>
								<xsl:when test="@Action=0">Отсутствует</xsl:when>
								<xsl:when test="@Action=1">Задание открыто</xsl:when>
								<xsl:when test="@Action=2">Задание закрыто</xsl:when>
								<xsl:when test="@Action=3">Добавлен документ</xsl:when>
								<xsl:when test="@Action=4">Изменен документ</xsl:when>
								<xsl:when test="@Action=5">Открыт документ</xsl:when>
								<xsl:when test="@Action=6">Создана версия</xsl:when>
								<xsl:when test="@Action=7">Изменен статус</xsl:when>
								<xsl:when test="@Action=8">Изменено время</xsl:when>
								<xsl:when test="@Action=9">Добавлен комментарий</xsl:when>
								<xsl:when test="@Action=10">Добавлен комментарий к документу</xsl:when>
								<xsl:when test="@Action=11">Изменен процент</xsl:when>
								<xsl:when test="@Action=12">Задание отозвано</xsl:when>
								<xsl:when test="@Action=13">Задание отказано</xsl:when>
								<xsl:when test="@Action=14">Задание завершено</xsl:when>
								<xsl:when test="@Action=15">Послано на исполнение</xsl:when>
								<xsl:when test="@Action=16">Делегировано</xsl:when>
								<xsl:when test="@Action=17">Возврат с делегирования</xsl:when>
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
								<xsl:when test="@TaskState=1">К исполнению</xsl:when>
								<xsl:when test="@TaskState=2">Не начато</xsl:when>
								<xsl:when test="@TaskState=3">В работе</xsl:when>
								<xsl:when test="@TaskState=4">Отложено</xsl:when>
								<xsl:when test="@TaskState=5">Завершено</xsl:when>
								<xsl:when test="@TaskState=6">Отказано</xsl:when>
								<xsl:when test="@TaskState=7">Отозвано</xsl:when>
								<xsl:when test="@TaskState=8">Делегировано - не начато</xsl:when>
								<xsl:when test="@TaskState=9">Делегировано - в работе</xsl:when>
								<xsl:when test="@TaskState=10">Делегировано - отложено</xsl:when>
								<xsl:when test="@TaskState=11">Делегировано - к исполнению</xsl:when>
								<xsl:when test="@TaskState=12">Задание делегировано</xsl:when>
								<xsl:when test="@TaskState=13">Возврат с делегирования</xsl:when>
								<xsl:when test="@TaskState=14">Возвращено с делегирования</xsl:when>
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
				Для того чтобы изменить вид данного шаблона, Вы можете отредактировать "Стандартный шаблон печати" для карточки "Задание бизнес-процесса" или создать новый шаблон на основе данного. 
				<br>DocsVision © 2002-2010. Все права защищены.</br>
				</p>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
