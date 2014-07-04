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
				<title><xsl:value-of select="//CardReport[1]/MainInfo/@Subject"/></title>
			</head>
			<body>
				<span class="header2">Report</span>
				<table border="0" width="100%">
               <tr>
                  <td class="fieldheader" width="25%">Name:</td>
                  <td colspan="3">
                     <xsl:value-of select="//CardReport[1]/MainInfo/@Name"/>
                  </td>
               </tr>
					<tr>
						<td class="fieldheader" width="25%">Created by:</td>
						<td colspan="3">
                     <xsl:value-of select="//CardReport[1]/MainInfo/@Create_LName"/>
                     <xsl:if test="string-length(//CardReport[1]/MainInfo/@Create_LName)!=0"> </xsl:if>
                     <xsl:value-of select="//CardReport[1]/MainInfo/@Create_FName"/>
                     <xsl:if test="string-length(//CardReport[1]/MainInfo/@Create_FName)!=0"> </xsl:if>
                     <xsl:value-of select="//CardReport[1]/MainInfo/@Create_MName"/>
						</td>
					</tr>
               <tr>
						<td class="fieldheader" width="25%">Creation date:</td>
						<td colspan="3">
						<xsl:call-template name="convertdatetime">
							<xsl:with-param name="str" select="//CardReport[1]/MainInfo/@CreationDate"/>
						</xsl:call-template>
						</td>
					</tr>
               <tr>
                  <td class="fieldheader" width="25%">Controlled by:</td>
                  <td colspan="3">
                     <xsl:value-of select="//CardReport[1]/MainInfo/@Contr_LName"/>
                     <xsl:if test="string-length(//CardReport[1]/MainInfo/@Contr_LName)!=0"> </xsl:if>
                     <xsl:value-of select="//CardReport[1]/MainInfo/@Contr_FName"/>
                     <xsl:if test="string-length(//CardReport[1]/MainInfo/@Contr_FName)!=0"> </xsl:if>
                     <xsl:value-of select="//CardReport[1]/MainInfo/@Contr_MName"/>
                  </td>
               </tr>
               <tr>
						<td class="fieldheader" width="25%">Report state:</td>
						<td colspan="3">
                     <xsl:choose>
                        <xsl:when test="//CardReport[1]/MainInfo/@ReportState=-1">Error</xsl:when>
                        <xsl:when test="//CardReport[1]/MainInfo/@ReportState=0">Inactive</xsl:when>
                        <xsl:when test="//CardReport[1]/MainInfo/@ReportState=1">Prepared to control</xsl:when>
                        <xsl:when test="//CardReport[1]/MainInfo/@ReportState=2">On control</xsl:when>
                        <xsl:when test="//CardReport[1]/MainInfo/@ReportState=3">Accepted</xsl:when>
                        <xsl:when test="//CardReport[1]/MainInfo/@ReportState=4">Rejected</xsl:when>
                     </xsl:choose>
                  </td>
					</tr>
               <tr>
                  <td class="fieldheader" width="25%">Parent task:</td>
                  <td colspan="3">
                     <xsl:value-of select="//CardReport[1]/MainInfo/@ParentDescription"/>
                  </td>
               </tr>
               <tr>
                  <td class="fieldheader" width="25%">Planned date:</td>
                  <td>
                     <xsl:call-template name="convertdatetime">
                        <xsl:with-param name="str" select="//CardReport[1]/MainInfo/@PlannedDate"/>
                     </xsl:call-template>
                  </td>
                  <td class="fieldheader" width="25%">Actual date:</td>
                  <td>
                     <xsl:call-template name="convertdatetime">
                        <xsl:with-param name="str" select="//CardReport[1]/MainInfo/@ActualDate"/>
                     </xsl:call-template>
                  </td>
               </tr>
               <tr>
                  <td class="fieldheader" width="25%">Control date:</td>
                  <td>
                     <xsl:call-template name="convertdatetime">
                        <xsl:with-param name="str" select="//CardReport[1]/MainInfo/@ControlDate"/>
                     </xsl:call-template>
                  </td>
                  <td class="fieldheader" width="25%">Accept date:</td>
                  <td>
                     <xsl:call-template name="convertdatetime">
                        <xsl:with-param name="str" select="//CardReport[1]/MainInfo/@AcceptDate"/>
                     </xsl:call-template>
                  </td>
               </tr>
               <tr>
                  <td colspan="4" class="fieldheader">
                     <xsl:if test="//CardReport[1]/MainInfo/@Confidential=1">Confidential</xsl:if>
                  </td>
               </tr>
               <tr>
						<td colspan="4" class="fieldheader">Description:</td>
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
							&lt;span class="header2"&gt;Report properties&lt;/span&gt;
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

            <xsl:for-each select="//CardReport[1]/Comments/CommentsRow">
               <xsl:if test="position()=1">
                  <xsl:text disable-output-escaping="yes">
							&lt;span class="header2"&gt;Report comments&lt;/span&gt;
							&lt;table border="0" cellpadding="0" cellspacing="0" style="BORDER-COLLAPSE: collapse" bordercolor="black" width="100%"&gt;
								&lt;tr&gt;
									&lt;th class="tableheader" align="left"&gt;Created by&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Comment date&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Comment&lt;/th&gt;
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
				In order to change the printing template, edit Print Template for the Report card type or create a new one based on this template.
				<br>DocsVision © 2002-2010. All rights reserved.</br>
				</p>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
