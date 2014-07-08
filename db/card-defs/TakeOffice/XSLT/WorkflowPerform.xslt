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
		<xsl:copy-of select="substring($str, 6, 2)"/>
		<xsl:text>/</xsl:text>
		<xsl:copy-of select="substring($str, 9, 2)"/>
		<xsl:text>/</xsl:text>
		<xsl:copy-of select="substring($str, 1, 4)"/>
	</xsl:template>

	<xsl:template match="/">
		<html>
			<head>
				<link rel="stylesheet" type="text/css" href="%ServerUrl%/StorageServer/File.axd?BaseName=%BaseName%&amp;TransformID=B5344DA1-D28F-4024-8798-3FC3992C94B7"/>
				<title><xsl:value-of select="//WorkflowTask[1]/MainInfo/@Name"/></title>
			</head>
			<body style="padding-top: 0px; padding-left: 0px">
				<table border="0" width="100%">
					<tr>
						<td class="fieldheader" width="30%">
							<xsl:if test="//WorkflowTask[1]/@WorkMode=2">Task control:</xsl:if>
							<xsl:if test="//WorkflowTask[1]/@WorkMode!=2 or not(//WorkflowTask[1]/@WorkMode)">Task:</xsl:if>
						</td>
						<td>
							<xsl:value-of select="//WorkflowTask[1]/MainInfo/@Name"/>
						</td>
					</tr>

					<tr>
						<td class="fieldheader" width="30%">Due period:</td>
						<td>
							<xsl:text disable-output-escaping="yes">&lt;enddate1&gt;</xsl:text>
							<xsl:if test="//WorkflowTask[1]/MainInfo/@ExpectedStartDate">
								from
								<xsl:call-template name="convertdatetime">
									<xsl:with-param name="str" select="//WorkflowTask[1]/MainInfo/@ExpectedStartDate"/>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="//WorkflowTask[1]/MainInfo/@ExpectedEndDate">
								to
								<xsl:call-template name="convertdatetime">
									<xsl:with-param name="str" select="//WorkflowTask[1]/MainInfo/@ExpectedEndDate"/>
								</xsl:call-template>
							</xsl:if>
							<xsl:text disable-output-escaping="yes">&lt;/enddate1&gt;</xsl:text>
						</td>
					</tr>

					<xsl:if test="//WorkflowTask[1]/MainInfo/@Priority=0">
						<tr>
							<td class="fieldheader" colspan="2">Low priority</td>
						</tr>
					</xsl:if>
					<xsl:if test="//WorkflowTask[1]/MainInfo/@Priority=2">
						<tr>
							<td class="fieldheader" colspan="2">High priority</td>
						</tr>
					</xsl:if>

					<xsl:if test="//WorkflowTask[1]/MainInfo/@WorkDuration">
						<xsl:if test="//WorkflowTask[1]/MainInfo/@WorkDuration > 0">
							<tr>
								<td class="fieldheader" width="30%">Expected labor <br/> input (h):</td>
								<td>
									<xsl:value-of select="//WorkflowTask[1]/MainInfo/@WorkDuration"/>
								</td>
							</tr>
						</xsl:if>
					</xsl:if>
				</table>

				<br/>

				<table border="0" width="100%" style="font-size: 8pt;">
					<xsl:if test="//WorkflowTask[1]/MainInfo/@CreatedBy">
						<tr>
							<td class="fieldheader" width="30%">Author:</td>
							<td>
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
					</xsl:if>

					<xsl:for-each select="//WorkflowTask[1]/Employees/EmployeesRow[@Type=2]">
						<xsl:if test="position()=1">
							<xsl:text disable-output-escaping="yes">
								&lt;tr&gt;&lt;td class="fieldheader" width="30%"&gt;Signed by:&lt;/td&gt;&lt;td&gt;
							</xsl:text>
						</xsl:if>
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
						<xsl:if test="position()=last()">
							<xsl:text disable-output-escaping="yes">
								&lt;/td&gt;&lt;/tr&gt;
							</xsl:text>
						</xsl:if>
					</xsl:for-each>

					<xsl:if test="//WorkflowTask[1]/MainInfo/@RegisteredBy">
						<tr>
							<td class="fieldheader" width="30%">Registered by:</td>
							<td>
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
					</xsl:if>

					<xsl:if test="//WorkflowTask[1]/MainInfo/@TaskController">
						<tr>
							<td class="fieldheader" width="30%">Controlled by:</td>
							<td>
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

					<xsl:if test="//WorkflowTask[1]/@WorkMode=1">
						<tr>
							<xsl:if test="//WorkflowTask[1]/MainInfo/@IsControllerTask=1">
								<td class="fieldheader" width="30%">Controlled by:</td>
							</xsl:if>
							<xsl:if test="//WorkflowTask[1]/MainInfo/@IsControllerTask=0 or not(//WorkflowTask[1]/MainInfo/@IsControllerTask)">
								<td class="fieldheader" width="30%">Performer:</td>
							</xsl:if>
							<td>
								<xsl:for-each select="//WorkflowTask[1]/CurrentPerformers/CurrentPerformersRow[@IsCurrent=1]">
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
									<xsl:if test="@DeputyFor">
										(deputy for:
										<xsl:if test="string-length(@Dep_DisplayString)!=0">
											<xsl:value-of select="@Dep_DisplayString"/>
										</xsl:if>
										<xsl:if test="string-length(@Dep_DisplayString)=0">
											<xsl:value-of select="@Dep_LastName"/>
											<xsl:if test="string-length(@Dep_LastName)!=0"> </xsl:if>
											<xsl:value-of select="@Dep_FirstName"/>
											<xsl:if test="string-length(@Dep_FirstName)!=0"> </xsl:if>
											<xsl:value-of select="@Dep_MiddleName"/>
										</xsl:if>)
									</xsl:if>
									<xsl:if test="@DelegatedFrom">
										<xsl:variable name="DelegatedFromID">
											<xsl:value-of select="@DelegatedFrom"/>
										</xsl:variable>
										<xsl:for-each select="//WorkflowTask[1]/CurrentPerformers/CurrentPerformersRow[@RowID=$DelegatedFromID]">
											(delegated from: 
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
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="//WorkflowTask[1]/@WorkMode!=1 or not(//WorkflowTask[1]/@WorkMode)">
						<xsl:if test="//WorkflowTask[1]/MainInfo/@IsControllerTask=1">
							<td class="fieldheader" width="30%">Controlled by:</td>
						</xsl:if>
						<xsl:if test="//WorkflowTask[1]/MainInfo/@IsControllerTask=0 or not(//WorkflowTask[1]/MainInfo/@IsControllerTask)">
							<td class="fieldheader" width="30%">Performer:</td>
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
										(deputy for:
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
											(delegated from: 
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
					</xsl:if>

					<xsl:if test="//WorkflowTask[1]/MainInfo/@ControlledBy">
						<tr>
							<td class="fieldheader" width="30%">Responsible:</td>
							<td>
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
					</xsl:if>

					<xsl:if test="//WorkflowTask[1]/Performing/@CompletedEmployeeID">
						<tr>
							<td class="fieldheader" width="30%">Completed by employee:</td>
							<td>
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
					</xsl:if>
				</table>

				<br/>

				<table border="0" width="100%">
					<xsl:if test="//WorkflowTask[1]/AdditionalSettings/@IsReportNeeded=1">
						<tr>
							<xsl:if test="//WorkflowTask[1]/AdditionalSettings/@ReportCardRequired=1">
								<td colspan="2">A report card is required to complete the task.</td>
							</xsl:if>
							<xsl:if test="//WorkflowTask[1]/AdditionalSettings/@ReportCardRequired=0 or not(//WorkflowTask[1]/AdditionalSettings/@ReportCardRequired)">
								<td colspan="2">A report text is required to complete the task.</td>
							</xsl:if>
						</tr>
					</xsl:if>
				</table>

				<br/>
				
				<table>
					<xsl:if test="//WorkflowTask[1]/MainInfo/@Comments">
						<tr>
							<td class="fieldheader">Comments:</td>
						</tr>
						<tr>
							<td>
								<xsl:call-template name="replace">
									<xsl:with-param name="str" select="//WorkflowTask[1]/MainInfo/@Comments"/>
								</xsl:call-template>
							</td>
						</tr>
					</xsl:if>
				</table>

				<br/>

				<table border="0" width="100%">
					<xsl:if test="//WorkflowTask[1]/Performing/@ReturnReason=1">
						<tr>
							<td width="30%">Return reason:</td>
							<xsl:if test="//WorkflowTask[1]/Performing/@TaskState=14">
								<td>There are no available employees to delegate the task.</td>
							</xsl:if>
							<xsl:if test="//WorkflowTask[1]/Performing/@TaskState!=14">
								<td>There are no available employees to process task.</td>
							</xsl:if>
						</tr>
					</xsl:if>
				</table>

				<br/>

				<xsl:for-each select="//WorkflowTask[1]/Comments/CommentsRow[@IsReport=1]">
					<xsl:if test="position()=1">
						<xsl:text disable-output-escaping="yes">
							&lt;span class="header2"&gt;Task performing history&lt;/span&gt;
							&lt;table border="0" cellpadding="0" cellspacing="0" style="BORDER-COLLAPSE: collapse" bordercolor="black" width="100%"&gt;
						</xsl:text>
					</xsl:if>
					<tr>
						<td class="field" width="30%">
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
						</td>
						<td class="field" width="25%">
							<xsl:call-template name="convertdatetime">
								<xsl:with-param name="str" select="@CreationDate"/>
							</xsl:call-template>
						</td>
						<td class="field" width="45%">
							<xsl:value-of select="@Comment"/>
						</td>
					</tr>
					<xsl:if test="position()=last()">
						<xsl:text disable-output-escaping="yes">
							&lt;/table&gt;
						</xsl:text>
					</xsl:if>
				</xsl:for-each>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
