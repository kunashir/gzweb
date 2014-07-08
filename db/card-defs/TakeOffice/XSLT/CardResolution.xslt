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
				<title><xsl:value-of select="//CardResolution[1]/MainInfo/@Name"/></title>
			</head>
			<body>
				<span class="header">
					<xsl:value-of select="//CardResolution[1]/MainInfo/@Name"/>
				</span>
				<br></br>				
				<span class="header2">Registration</span>
				<table border="0" width="100%">
					<tr>
						<td class="fieldheader" width="25%">Name:</td>
						<td colspan="3"><xsl:value-of select="//CardResolution[1]/MainInfo/@Name"/></td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Type:</td>
						<td colspan="3"><xsl:value-of select="//CardResolution[1]/MainInfo/@DocType_Name"/></td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Creation date:</td>
						<td width="25%">
							<xsl:call-template name="convertdatetime">
								<xsl:with-param name="str" select="//CardResolution[1]/MainInfo/@CreationDate"/>
							</xsl:call-template>
						</td>
						<td class="fieldheader" width="25%">Signed date:</td>
						<td width="25%">
							<xsl:call-template name="convertdatetime">
								<xsl:with-param name="str" select="//CardResolution[1]/MainInfo/@SignedDate"/>
							</xsl:call-template>
						</td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Author:</td>
						<td colspan="3"><xsl:value-of select="//CardResolution[1]/MainInfo/@Create_LName"/><xsl:if test="string-length(//CardResolution[1]/MainInfo/@Create_LName)!=0"> </xsl:if><xsl:value-of select="//CardResolution[1]/MainInfo/@Create_FName"/><xsl:if test="string-length(//CardResolution[1]/MainInfo/@Create_FName)!=0"> </xsl:if><xsl:value-of select="//CardResolution[1]/MainInfo/@Create_MName"/></td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Registered by:</td>
						<td colspan="3"><xsl:value-of select="//CardResolution[1]/MainInfo/@Register_LName"/><xsl:if test="string-length(//CardResolution[1]/MainInfo/@Register_LName)!=0"> </xsl:if><xsl:value-of select="//CardResolution[1]/MainInfo/@Register_FName"/><xsl:if test="string-length(//CardResolution[1]/MainInfo/@Register_FName)!=0"> </xsl:if><xsl:value-of select="//CardResolution[1]/MainInfo/@Register_MName"/></td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Signed by:</td>
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
								<xsl:when test="//CardResolution[1]/MainInfo/@ControlType=1">Control:</xsl:when>
								<xsl:when test="//CardResolution[1]/MainInfo/@ControlType=2">Special control:</xsl:when>
							</xsl:choose>
						</td>
						<td colspan="3"><xsl:value-of select="//CardResolution[1]/MainInfo/@Control_LName"/><xsl:if test="string-length(//CardResolution[1]/MainInfo/@Control_LName)!=0"> </xsl:if><xsl:value-of select="//CardResolution[1]/MainInfo/@Control_FName"/><xsl:if test="string-length(//CardResolution[1]/MainInfo/@Control_FName)!=0"> </xsl:if><xsl:value-of select="//CardResolution[1]/MainInfo/@Control_MName"/></td>
					</tr>
					</xsl:if>
					<tr>
						<td class="fieldheader" width="25%">Performers:</td>
						<td colspan="3"><xsl:value-of select="//CardResolution[1]/MainInfo/@Performers"/></td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Responsible performer:</td>
						<td colspan="3"><xsl:value-of select="//CardResolution[1]/MainInfo/@Responsible"/></td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Categories:</td>
						<td colspan="3">
							<xsl:for-each select="//CardResolution[1]/Categories/CategoriesRow">
								<xsl:value-of select="@Name"/>
								<xsl:if test="position()!=last()">, </xsl:if>
							</xsl:for-each>
						</td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Types:</td>
						<td colspan="3">
							<xsl:for-each select="//CardResolution[1]/Types/TypesRow">
								<xsl:value-of select="@Name"/>
								<xsl:if test="position()!=last()">, </xsl:if>
							</xsl:for-each>
						</td>
					</tr>
					<tr>
						<td colspan="4" class="fieldheader">Description:</td>
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
				<span class="header2">Performing</span>
				<table border="0" width="100%">
					<tr>
						<td class="fieldheader" width="25%">Start date:</td>
						<td width="25%">
							<xsl:call-template name="convertdatetime">
								<xsl:with-param name="str" select="//CardResolution[1]/MainInfo/@StartDate"/>
							</xsl:call-template>
						</td>
						<td class="fieldheader" width="25%">Expected duration:</td>
						<td width="25%"><xsl:value-of select="//CardResolution[1]/MainInfo/@ExpectedDuration"/></td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Expected end date:</td>
						<td width="25%">
							<xsl:call-template name="convertdatetime">
								<xsl:with-param name="str" select="//CardResolution[1]/MainInfo/@ExpectedEndDate"/>
							</xsl:call-template>
						</td>
						<td class="fieldheader" width="25%">Actual end date:</td>
						<td width="25%">
							<xsl:call-template name="convertdatetime">
								<xsl:with-param name="str" select="//CardResolution[1]/MainInfo/@ActualEndDate"/>
							</xsl:call-template>
						</td>
					</tr>
					<tr>
						<td class="fieldheader" width="25%">Control date:</td>
						<td width="25%">
							<xsl:call-template name="convertdatetime">
								<xsl:with-param name="str" select="//CardResolution[1]/MainInfo/@ControlDate"/>
							</xsl:call-template>
						</td>
					</tr>
					<xsl:if test="//CardResolution[1]/MainInfo/@IsUrgent=1">
					<tr><td class="fieldheader" colspan="4">Is urgent</td></tr>
					</xsl:if>
					<tr>
						<td class="fieldheader" width="25%">Resolution state:</td>
						<td colspan="3">
							<xsl:choose>
								<xsl:when test="//CardResolution[1]/MainInfo/@ResolutionState=0">Inactive</xsl:when>
								<xsl:when test="//CardResolution[1]/MainInfo/@ResolutionState=1">To perform</xsl:when>
								<xsl:when test="//CardResolution[1]/MainInfo/@ResolutionState=2">In process</xsl:when>
								<xsl:when test="//CardResolution[1]/MainInfo/@ResolutionState=3">Completed</xsl:when>
								<xsl:when test="//CardResolution[1]/MainInfo/@ResolutionState=4">Recalled</xsl:when>
							</xsl:choose>
						</td>
					</tr>
				</table>
				<br></br>

				<xsl:for-each select="//CardResolution[1]/Properties/PropertiesRow[(@Hidden=0 or not(@Hidden)) and @ParamType!=19]">
					<xsl:if test="position()=1">
						<xsl:text disable-output-escaping="yes">
							&lt;span class="header2"&gt;Resolution properties&lt;/span&gt;
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

				<xsl:for-each select="//CardResolution[1]/Comments/CommentsRow">
					<xsl:if test="position()=1">
						<xsl:text disable-output-escaping="yes">
							&lt;span class="header2"&gt;Comments&lt;/span&gt;
							&lt;table border="0" cellpadding="0" cellspacing="0" style="BORDER-COLLAPSE: collapse" bordercolor="black" width="100%"&gt;
								&lt;tr&gt;
									&lt;th class="tableheader" align="left"&gt;Comment date&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Created by&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Comment&lt;/th&gt;
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
				In order to change the printing template, edit Print Template for the Resolution card type or create a new one based on this template.
				<br>DocsVision © 2002-2010. All rights reserved.</br>
				</p>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
