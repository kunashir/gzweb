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
			<body>
				<span class="header">
					<xsl:value-of select="//WorkflowTask[1]/MainInfo/@Name"/>
				</span>
				<br></br>				
				<span class="header2">Task information</span>
				<table border="0" width="100%">
					<tr>
						<td class="fieldheader" width="25%">Name:</td>
						<td colspan="3"><xsl:value-of select="//WorkflowTask[1]/MainInfo/@Name"/></td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Created by:</td>
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
						<td class="fieldheader" width="25%">Registered by:</td>
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
							<td class="fieldheader" width="25%">Controlled by:</td>
						</xsl:if>
						<xsl:if test="//WorkflowTask[1]/MainInfo/@IsControllerTask=0 or not(//WorkflowTask[1]/MainInfo/@IsControllerTask)">
							<td class="fieldheader" width="25%">Performer:</td>
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
						<td class="fieldheader" width="25%">Responsible:</td>
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
							<td class="fieldheader" width="25%">Controlled by:</td>
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
						<td class="fieldheader" width="25%">Signed by:</td>
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
						<td colspan="4" class="fieldheader">Comments:</td>
					</tr>
					<tr>
						<td colspan="4">
							<xsl:call-template name="replace">
								<xsl:with-param name="str" select="//WorkflowTask[1]/MainInfo/@Comments"/>
							</xsl:call-template>
						</td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Start ASAP:</td>
						<td width="25%"><xsl:if test="//WorkflowTask[1]/MainInfo/@StartASAP=1">Yes</xsl:if></td>
						<td class="fieldheader" width="25%">Expected duration (h):</td>
						<td width="25%"><xsl:value-of select="//WorkflowTask[1]/MainInfo/@ExpectedDuration"/></td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Expected begin date:</td>
						<td width="25%">
							<xsl:call-template name="convertdatetime">
								<xsl:with-param name="str" select="//WorkflowTask[1]/MainInfo/@ExpectedStartDate"/>
							</xsl:call-template>
						</td>
						<td class="fieldheader" width="25%">Expected end date:</td>
						<td width="25%">
							<xsl:call-template name="convertdatetime">
								<xsl:with-param name="str" select="//WorkflowTask[1]/MainInfo/@ExpectedEndDate"/>
							</xsl:call-template>
						</td>
					</tr>
					<xsl:if test="//WorkflowTask[1]/MainInfo/@WorkDuration">
						<xsl:if test="//WorkflowTask[1]/MainInfo/@WorkDuration > 0">
							<tr>
								<td class="fieldheader" width="25%">Expected labor input (h):</td>
								<td colspan="3">
									<xsl:value-of select="//WorkflowTask[1]/MainInfo/@WorkDuration"/>
								</td>
							</tr>
						</xsl:if>
					</xsl:if>
					<tr>
						<td class="fieldheader" width="25%">To read only:</td>
						<td width="25%"><xsl:if test="//WorkflowTask[1]/AdditionalSettings/@ToRead=1">Yes</xsl:if></td>
						<td class="fieldheader" width="25%">Create MS Outlook task:</td>
						<td width="25%"><xsl:if test="//WorkflowTask[1]/MainInfo/@CreateOutlookTask=1">Yes</xsl:if></td>
					</tr>
				</table>
				<br></br>												
				<span class="header2">Task performing</span>
				<table border="0" width="100%">
					<tr>
						<td class="fieldheader" width="25%">Actual start date:</td>
						<td width="25%">
							<xsl:call-template name="convertdatetime">
								<xsl:with-param name="str" select="//WorkflowTask[1]/Performing/@ActualStartDate"/>
							</xsl:call-template>
						</td>
						<td class="fieldheader" width="25%">Actual end date:</td>
						<td width="25%">
							<xsl:call-template name="convertdatetime">
								<xsl:with-param name="str" select="//WorkflowTask[1]/Performing/@ActualEndDate"/>
							</xsl:call-template>
						</td>
					</tr>
					<xsl:if test="//WorkflowTask[1]/Performing/@ActualWorkDuration">
						<xsl:if test="//WorkflowTask[1]/Performing/@ActualWorkDuration > 0">
							<tr>
								<td class="fieldheader" width="25%">Actual labor input (h):</td>
								<td colspan="3">
									<xsl:value-of select="//WorkflowTask[1]/Performing/@ActualWorkDuration"/>
								</td>
							</tr>
						</xsl:if>
					</xsl:if>
					<tr>					
						<td class="fieldheader" width="25%">Task state:</td>
						<td width="25%">
							<xsl:choose>
								<xsl:when test="//WorkflowTask[1]/Performing/@TaskState=0">Inactive</xsl:when>
								<xsl:when test="//WorkflowTask[1]/Performing/@TaskState=1">To perform</xsl:when>
								<xsl:when test="//WorkflowTask[1]/Performing/@TaskState=2">To begin</xsl:when>
								<xsl:when test="//WorkflowTask[1]/Performing/@TaskState=3">In process</xsl:when>
								<xsl:when test="//WorkflowTask[1]/Performing/@TaskState=4">Postponed</xsl:when>
								<xsl:when test="//WorkflowTask[1]/Performing/@TaskState=5">Completed</xsl:when>
								<xsl:when test="//WorkflowTask[1]/Performing/@TaskState=6">Rejected</xsl:when>
								<xsl:when test="//WorkflowTask[1]/Performing/@TaskState=7">Recalled</xsl:when>
								<xsl:when test="//WorkflowTask[1]/Performing/@TaskState=8">Delegated - to begin</xsl:when>
								<xsl:when test="//WorkflowTask[1]/Performing/@TaskState=9">Delegated - in process</xsl:when>
								<xsl:when test="//WorkflowTask[1]/Performing/@TaskState=10">Delegated - postponed</xsl:when>
								<xsl:when test="//WorkflowTask[1]/Performing/@TaskState=11">Delegated - to perform</xsl:when>
								<xsl:when test="//WorkflowTask[1]/Performing/@TaskState=12">Being delegated</xsl:when>
								<xsl:when test="//WorkflowTask[1]/Performing/@TaskState=13">Delegated - returning</xsl:when>
								<xsl:when test="//WorkflowTask[1]/Performing/@TaskState=14">Delegated - returned</xsl:when>
							</xsl:choose>
						</td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Percent completed:</td>
						<td width="25%"><xsl:value-of select="//WorkflowTask[1]/Performing/@PercentCompleted"/>%</td>
						<td class="fieldheader" width="25%">Performing started:</td>
						<td width="25%"><xsl:if test="//WorkflowTask[1]/Performing/@ExecutionStarted=1">Yes</xsl:if></td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Completed by employee:</td>
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
				<span class="header2">Additional settings</span>
				<table border="0" width="100%">
					<tr>
						<td class="fieldheader" width="25%">Can reject:</td>
						<td width="25%"><xsl:if test="//WorkflowTask[1]/AdditionalSettings/@CanReject=1">Yes</xsl:if></td>
						<td class="fieldheader" width="25%">Can view log:</td>
						<td width="25%"><xsl:if test="//WorkflowTask[1]/AdditionalSettings/@CanViewLog=1">Yes</xsl:if></td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Can reshedule:</td>
						<td width="25%"><xsl:if test="//WorkflowTask[1]/AdditionalSettings/@CanReschedule=1">Yes</xsl:if></td>
						<td class="fieldheader" width="25%">Controller can reschedule:</td>
						<td width="25%"><xsl:if test="//WorkflowTask[1]/AdditionalSettings/@ControllerCanReschedule=1">Yes</xsl:if></td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Can delegate:</td>
						<td width="25%"><xsl:if test="//WorkflowTask[1]/AdditionalSettings/@CanDelegate=1">Yes</xsl:if></td>
						<td class="fieldheader" width="25%">Delegate to all:</td>
						<td width="25%"><xsl:if test="//WorkflowTask[1]/AdditionalSettings/@DelegateToAll=1">Yes</xsl:if></td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Is report needed:</td>
						<td width="25%"><xsl:if test="//WorkflowTask[1]/AdditionalSettings/@IsReportNeeded=1">Yes</xsl:if></td>
						<td class="fieldheader" width="25%">Can add documents:</td>
						<td width="25%"><xsl:if test="//WorkflowTask[1]/AdditionalSettings/@CanAddDocuments=1">Yes</xsl:if></td>
					</tr>
				</table>
				<br></br>
				
				<xsl:for-each select="//WorkflowTask[1]/Properties/PropertiesRow[(@Hidden=0 or not(@Hidden)) and @ParamType!=19]">
					<xsl:if test="position()=1">
						<xsl:text disable-output-escaping="yes">
							&lt;span class="header2"&gt;Task properties&lt;/span&gt;
							&lt;table border="0" cellpadding="0" cellspacing="0" style="BORDER-COLLAPSE: collapse" bordercolor="black" width="100%"&gt;
								&lt;tr&gt;
									&lt;th class="tableheader" align="left"&gt;Name&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Value&lt;/th&gt;
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
							&lt;span class="header2"&gt;Task comments&lt;/span&gt;
							&lt;table border="0" cellpadding="0" cellspacing="0" style="BORDER-COLLAPSE: collapse" bordercolor="black" width="100%"&gt;
								&lt;tr&gt;
									&lt;th class="tableheader" align="left"&gt;Created by&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Comment date&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Comment&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Report&lt;/th&gt;
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
						<td class="field" width="10%"><xsl:if test="@IsReport=1">Yes</xsl:if></td>
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
							&lt;span class="header2"&gt;Task log&lt;/span&gt;
							&lt;table border="0" cellpadding="0" cellspacing="0" style="BORDER-COLLAPSE: collapse" bordercolor="black" width="100%"&gt;
								&lt;tr&gt;
									&lt;th class="tableheader" align="left"&gt;Action by&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Action&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Action date&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Percent comleted&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Task state&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Description&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;New end date&lt;/th&gt;
								&lt;/tr&gt;
						</xsl:text>
					</xsl:if>
					<tr>
						<td class="field" width="15%"><xsl:value-of select="@FirstName"/> <xsl:value-of select="@MiddleName"/> <xsl:value-of select="@LastName"/></td>
						<td class="field" width="15%">
							<xsl:choose>
								<xsl:when test="@Action=0">None</xsl:when>
								<xsl:when test="@Action=1">Task opened</xsl:when>
								<xsl:when test="@Action=2">Task closed</xsl:when>
								<xsl:when test="@Action=3">Document added</xsl:when>
								<xsl:when test="@Action=4">Document modified</xsl:when>
								<xsl:when test="@Action=5">Document opened</xsl:when>
								<xsl:when test="@Action=6">Version created</xsl:when>
								<xsl:when test="@Action=7">Status changed</xsl:when>
								<xsl:when test="@Action=8">Time changed</xsl:when>
								<xsl:when test="@Action=9">Comment added</xsl:when>
								<xsl:when test="@Action=10">Document comment added</xsl:when>
								<xsl:when test="@Action=11">Percent changed</xsl:when>
								<xsl:when test="@Action=12">Task recalled</xsl:when>
								<xsl:when test="@Action=13">Task rejected</xsl:when>
								<xsl:when test="@Action=14">Task finished</xsl:when>
								<xsl:when test="@Action=15">Sent to perform</xsl:when>
								<xsl:when test="@Action=16">Task delegated</xsl:when>
								<xsl:when test="@Action=17">Delegated return</xsl:when>
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
								<xsl:when test="@TaskState=0">Inactive</xsl:when>
								<xsl:when test="@TaskState=1">To perform</xsl:when>
								<xsl:when test="@TaskState=2">To begin</xsl:when>
								<xsl:when test="@TaskState=3">In process</xsl:when>
								<xsl:when test="@TaskState=4">Postponed</xsl:when>
								<xsl:when test="@TaskState=5">Completed</xsl:when>
								<xsl:when test="@TaskState=6">Rejected</xsl:when>
								<xsl:when test="@TaskState=7">Recalled</xsl:when>
								<xsl:when test="@TaskState=8">Delegated - to begin</xsl:when>
								<xsl:when test="@TaskState=9">Delegated - in process</xsl:when>
								<xsl:when test="@TaskState=10">Delegated - postponed</xsl:when>
								<xsl:when test="@TaskState=11">Delegated - to perform</xsl:when>
								<xsl:when test="@TaskState=12">Task delegated</xsl:when>
								<xsl:when test="@TaskState=13">Delegated returning</xsl:when>
								<xsl:when test="@TaskState=14">Delegated returned</xsl:when>
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
				In order to change the printing template, edit Print Template for the Workflow Task card type or create a new one based on this template.
				<br>DocsVision © 2002-2010. All rights reserved.</br>
				</p>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
