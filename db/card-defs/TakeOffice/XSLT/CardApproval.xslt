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
            <title>
               <xsl:value-of select="//CardApproval[1]/MainInfo/@Name"/>
            </title>
         </head>
         <body>
            <span class="header">
               <xsl:value-of select="//CardApproval[1]/MainInfo/@Name"/>
            </span>
            <br></br>
            <span class="header2">Main info</span>
            <table border="0" width="100%">
               <tr>
                  <td class="fieldheader" width="8%">Name:</td>
                  <td colspan="5">
                     <xsl:value-of select="//CardApproval[1]/MainInfo/@Name"/>
                  </td>
               </tr>
               <tr>
                  <td class="fieldheader" width="8%">Type:</td>
                  <td colspan="5">
                     <xsl:value-of select="//CardApproval[1]/MainInfo/@Type_Name"/>
                  </td>
               </tr>
               <tr>
                  <td class="fieldheader" width="8%">Creation date:</td>
                  <td colspan="5">
                     <xsl:call-template name="convertdatetime">
                        <xsl:with-param name="str" select="//CardApproval[1]/MainInfo/@CreationDate"/>
                     </xsl:call-template>
                  </td>
               </tr>
               <tr>
                  <td class="fieldheader" width="8%">Created by:</td>
                  <td width="32%">
                     <xsl:value-of select="//CardApproval[1]/MainInfo/@Create_LName"/>
                     <xsl:if test="string-length(//CardApproval[1]/MainInfo/@Create_LName)!=0"> </xsl:if>
                     <xsl:value-of select="//CardApproval[1]/MainInfo/@Create_FName"/>
                     <xsl:if test="string-length(//CardApproval[1]/MainInfo/@Create_FName)!=0"> </xsl:if>
                     <xsl:value-of select="//CardApproval[1]/MainInfo/@Create_MName"/>
                  </td>
                  <td class="fieldheader" with="8%">Position:</td>
                  <td width="22%">
                     <xsl:value-of select="//CardApproval[1]/MainInfo/@CreatedByPosition"/>
                  </td>
                  <td class="fieldheader" with="8%">Department:</td>
                  <td width="22%">
                     <xsl:value-of select="//CardApproval[1]/MainInfo/@CreatedByDepartment"/>
                  </td>
               </tr>
               <tr>
                  <td class="fieldheader">Initiated by:</td>
                  <td>
                     <xsl:value-of select="//CardApproval[1]/MainInfo/@Initiate_LName"/>
                     <xsl:if test="string-length(//CardApproval[1]/MainInfo/@Initiate_LName)!=0"> </xsl:if>
                     <xsl:value-of select="//CardApproval[1]/MainInfo/@Initiate_FName"/>
                     <xsl:if test="string-length(//CardApproval[1]/MainInfo/@Initiate_FName)!=0"> </xsl:if>
                     <xsl:value-of select="//CardApproval[1]/MainInfo/@Initiate_MName"/>
                  </td>
                  <td class="fieldheader">Position:</td>
                  <td>
                     <xsl:value-of select="//CardApproval[1]/MainInfo/@InitiatedByPosition"/>
                  </td>
                  <td class="fieldheader">Department:</td>
                  <td>
                     <xsl:value-of select="//CardApproval[1]/MainInfo/@InitiatedByDepartment"/>
                  </td>
               </tr>
               <tr>
                  <td class="fieldheader" width="8%">Document state:</td>
                  <td colspan="5">
                     <xsl:choose>
                        <xsl:when test="//CardApproval[1]/MainInfo/@DocumentState=0">Creation</xsl:when>
                        <xsl:when test="//CardApproval[1]/MainInfo/@DocumentState=1">Approving</xsl:when>
                        <xsl:when test="//CardApproval[1]/MainInfo/@DocumentState=2">Consolidation</xsl:when>
                        <xsl:when test="//CardApproval[1]/MainInfo/@DocumentState=3">Completed</xsl:when>
                     </xsl:choose>
                  </td>
               </tr>
               <tr>
                  <td class="fieldheader" width="8%">Approval state:</td>
                  <td colspan="5">
                     <xsl:choose>
                        <xsl:when test="//CardApproval[1]/MainInfo/@ApprovalState=0">Creation</xsl:when>
                        <xsl:when test="//CardApproval[1]/MainInfo/@ApprovalState=1">Approving</xsl:when>
                        <xsl:when test="//CardApproval[1]/MainInfo/@ApprovalState=2">Approved OK</xsl:when>
                        <xsl:when test="//CardApproval[1]/MainInfo/@ApprovalState=3">Approved with remarks</xsl:when>
                        <xsl:when test="//CardApproval[1]/MainInfo/@ApprovalState=4">Not approved</xsl:when>
                     </xsl:choose>
                  </td>
               </tr>
            </table>
            <span class="header2">Parent card</span>
            <table border="0" width="100%">
               <tr>
                  <td class="fieldheader" width="8%">Name:</td>
                  <td width="32%">
                     <xsl:value-of select="//CardApproval[1]/MainInfo/@ParentName"/>
                  </td>
                  <td class="fieldheader" width="8%">Number:</td>
                  <td width="22%">
                     <xsl:value-of select="//CardApproval[1]/MainInfo/@ParentNumber"/>
                  </td>
               </tr>
               <tr>
                  <td class="fieldheader" width="8%">Registration date:</td>
                  <td>
							<xsl:call-template name="convertdatetime">
								<xsl:with-param name="str" select="//CardApproval[1]/MainInfo/@ParentRegDate"/>
							</xsl:call-template>
						</td>
                  <td class="fieldheader" width="8%">Creation date:</td>
                  <td>
							<xsl:call-template name="convertdatetime">
								<xsl:with-param name="str" select="//CardApproval[1]/MainInfo/@ParentCreationDate"/>
							</xsl:call-template>
						</td>
               </tr>
            </table>
            <br></br>

            <span class="header2">Approval cycles</span>
            <xsl:for-each select="//CardApproval[1]/Cycles/CyclesRow">
               <table border="0" width="100%">
                  <tr>
                     <td class="fieldheader" width="8%">Cycle:</td>
                     <td colspan="3">
                        <xsl:value-of select="@Cycle"/>
                     </td>
                  </tr>
                  <tr>
                     <td class="fieldheader" width="8%">Consolidator:</td>
                     <td width="22%">
                        <xsl:value-of select="@Resp_LName"/>
                        <xsl:if test="string-length(@Resp_LName)!=0"> </xsl:if>
                        <xsl:value-of select="@Resp_FName"/>
                        <xsl:if test="string-length(@Resp_FName)!=0"> </xsl:if>
                        <xsl:value-of select="@Resp_MName"/>
                     </td>
                     <td class="fieldheader" with="8%">Position:</td>
                     <td width="22%">
                        <xsl:value-of select="@ConsolidatorPosition"/>
                     </td>
                     <td class="fieldheader" with="8%">Department:</td>
                     <td width="22%">
                        <xsl:value-of select="@ConsolidatorDepartment"/>
                     </td>
                  </tr>
                  <tr>
                     <td class="fieldheader" width="8%">Start date:</td>
                     <td width="32%">
                        <xsl:call-template name="convertdatetime">
                           <xsl:with-param name="str" select="@StartDate"/>
                        </xsl:call-template>
                     </td>
                     <td class="fieldheader" width="8%">Duration:</td>
                     <td width="22%">
                        <xsl:value-of select="@Duration"/>
                     </td>
                  </tr>
                  <tr>
                     <td class="fieldheader" width="8%">Expecting end date:</td>
                     <td width="32%">
                        <xsl:call-template name="convertdatetime">
                           <xsl:with-param name="str" select="@FinishDate"/>
                        </xsl:call-template>
                     </td>
                     <td class="fieldheader" width="8%">Actual end date:</td>
                     <td width="22%">
                        <xsl:call-template name="convertdatetime">
                           <xsl:with-param name="str" select="@ActualFinishDate"/>
                        </xsl:call-template>
                     </td>
                  </tr>
                  <tr>
                     <td class="fieldheader" width="8%">Approval documents:</td>
                     <td colspan="5">
                        <xsl:for-each select="Files/FilesRow">
                           <xsl:if test="@FileType=0">
                              <xsl:value-of select="@FileName"/>
										<xsl:value-of select="@Description"/>
                              <xsl:if test="position()!=last()">; </xsl:if>
                           </xsl:if>
                        </xsl:for-each>
                     </td>
                  </tr>
                  <tr>
                     <td colspan="6">
                        <xsl:for-each select="Approvers/ApproversRow">
                           <xsl:sort select="@Order" data-type="number" order="ascending"></xsl:sort>
                           <xsl:if test="position()=1">
                              <xsl:text disable-output-escaping="yes">
									&lt;span class="fieldheader"&gt;Approvers&lt;/span&gt;
									&lt;table border="0" cellpadding="0" cellspacing="0" style="BORDER-COLLAPSE: collapse" bordercolor="black" width="100%"&gt;
										&lt;tr&gt;
											&lt;th class="tableheader" align="left"&gt;#&lt;/th&gt;
											&lt;th class="tableheader" align="left"&gt;Name&lt;/th&gt;
                                 &lt;th class="tableheader" align="left"&gt;Position&lt;/th&gt;
                                 &lt;th class="tableheader" align="left"&gt;Department&lt;/th&gt;
                                 &lt;th class="tableheader" align="left"&gt;Document&lt;/th&gt;
                                 &lt;th class="tableheader" align="left"&gt;State&lt;/th&gt;
                                 &lt;th class="tableheader" align="left"&gt;Remarks&lt;/th&gt;
										&lt;/tr&gt;
								</xsl:text>
                           </xsl:if>
                           <tr>
                              <td class="field" width="5%">
                                 <xsl:value-of select="@Order"/>
                              </td>
                              <td class="field" width="20%">
                                 <xsl:value-of select="@ApproverName"/>
                              </td>
                              <td class="field" width="8%">
                                 <xsl:value-of select="@ApproverPosition"/>
                              </td>
                              <td class="field" width="10%">
                                 <xsl:value-of select="@ApproverDepartment"/>
                              </td>
                              <td colspan="3"></td>
                           </tr>
                           <xsl:variable name="AppRowID">
                              <xsl:value-of select="@RowID"/>
                           </xsl:variable>
                           <xsl:for-each select="//CardApproval[1]/Cycles/CyclesRow/Files/FilesRow[@ApproverRowID=$AppRowID and (@FileType=1 or @FileType=2 or @FileType=4)]">
                              <xsl:sort select="@OriginalFileName" order="ascending"/>
                              <tr>
                                 <td colspan="4"></td>
                                 <td class="field" width="20%">
                                    <xsl:value-of select="@OriginalFileName"/>
                                 </td>
                                 <td class="field" width="8%">
                                    <xsl:choose>
                                       <xsl:when test="@FileState=0">To approve</xsl:when>
                                       <xsl:when test="@FileState=1">Approved OK</xsl:when>
                                       <xsl:when test="@FileState=2">Approved with remarks</xsl:when>
                                       <xsl:when test="@FileState=3">Not approved</xsl:when>
                                       <xsl:when test="@FileState=4">Recalled</xsl:when>
                                    </xsl:choose>
                                 </td>
                                 <td class="field" width="8%">
                                    <xsl:value-of select="@FileRemarks"/>
                                 </td>
                              </tr>
                           </xsl:for-each>
                           <xsl:if test="position()=last()">
                              <xsl:text disable-output-escaping="yes">
									&lt;/table&gt;
									&lt;br/&gt;
								</xsl:text>
                           </xsl:if>
                        </xsl:for-each>
                     </td>
                  </tr>
               </table>
            </xsl:for-each>

            <xsl:for-each select="//CardApproval[1]/Comments/CommentsRow">
               <xsl:if test="position()=1">
                  <xsl:text disable-output-escaping="yes">
							&lt;span class="header2"&gt;Approval comments&lt;/span&gt;
							&lt;table border="0" cellpadding="0" cellspacing="0" style="BORDER-COLLAPSE: collapse" bordercolor="black" width="100%"&gt;
								&lt;tr&gt;
                           &lt;th class="tableheader" align="left"&gt;Cycle&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Comment date&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Author&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Comment&lt;/th&gt;
								&lt;/tr&gt;
						</xsl:text>
               </xsl:if>
               <tr>
                  <td class="field" width="8%">
                     <xsl:value-of select="@Cycle"/>
                  </td>
                  <td class="field" width="20%">
                     <xsl:call-template name="convertdatetime">
                        <xsl:with-param name="str" select="@CreationDate"/>
                     </xsl:call-template>
                  </td>
                  <td class="field" width="30%">
                     <xsl:value-of select="@LastName"/>
                     <xsl:if test="string-length(@LastName)!=0"> </xsl:if>
                     <xsl:value-of select="@FirstName"/>
                     <xsl:if test="string-length(@FirstName)!=0"> </xsl:if>
                     <xsl:value-of select="@MiddleName"/>
                  </td>
                  <td class="field" width="42%">
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

            <xsl:if test="//CardApproval[1]/MainInfo/@DocumentState=3">
               <span class="header2">Approval results</span>
               <xsl:for-each select="//CardApproval[1]/Cycles/CyclesRow">
                  <xsl:sort select="@Cycle" data-type="number" order="descending"/>
                  <xsl:if test="position()=1">
                     <table border="0" width="100%">
                        <tr>
                           <td colspan="4">
                              <xsl:for-each select="Approvers/ApproversRow">
                                 <xsl:sort select="@Order" data-type="number" order="ascending"></xsl:sort>
                                 <xsl:if test="position()=1">
                                    <xsl:text disable-output-escaping="yes">
									            &lt;span class="fieldheader"&gt;Approvers&lt;/span&gt;
									            &lt;table border="0" cellpadding="0" cellspacing="0" style="BORDER-COLLAPSE: collapse" bordercolor="black" width="100%"&gt;
										            &lt;tr&gt;
											            &lt;th class="tableheader" align="left"&gt;#&lt;/th&gt;
											            &lt;th class="tableheader" align="left"&gt;Name&lt;/th&gt;
                                             &lt;th class="tableheader" align="left"&gt;Position&lt;/th&gt;
                                             &lt;th class="tableheader" align="left"&gt;Department&lt;/th&gt;
                                             &lt;th class="tableheader" align="left"&gt;Document&lt;/th&gt;
                                             &lt;th class="tableheader" align="left"&gt;State&lt;/th&gt;
                                             &lt;th class="tableheader" align="left"&gt;Remarks&lt;/th&gt;
										            &lt;/tr&gt;
								            </xsl:text>
                                 </xsl:if>
                                 <tr>
                                    <td class="field" width="5%">
                                       <xsl:value-of select="@Order"/>
                                    </td>
                                    <td class="field" width="20%">
                                       <xsl:value-of select="@ApproverName"/>
                                    </td>
                                    <td class="field" width="8%">
                                       <xsl:value-of select="@ApproverPosition"/>
                                    </td>
                                    <td class="field" width="10%">
                                       <xsl:value-of select="@ApproverDepartment"/>
                                    </td>
                                 </tr>
                                 <xsl:variable name="AppRowID">
                                    <xsl:value-of select="@RowID"/>
                                 </xsl:variable>
                                 <xsl:for-each select="//CardApproval[1]/Cycles/CyclesRow/Files/FilesRow[@ApproverRowID=$AppRowID and (@FileType=1 or @FileType=2 or @FileType=4)]">
                                    <xsl:sort select="@OriginalFileName" order="ascending"/>
                                    <tr>
                                       <td colspan="4"></td>
                                       <td class="field" width="20%">
                                          <xsl:value-of select="@OriginalFileName"/>
                                       </td>
                                       <td class="field" width="8%">
                                          <xsl:choose>
                                             <xsl:when test="@FileState=0">To approve</xsl:when>
                                             <xsl:when test="@FileState=1">Approved OK</xsl:when>
                                             <xsl:when test="@FileState=2">Approved with remarks</xsl:when>
                                             <xsl:when test="@FileState=3">Not approved</xsl:when>
                                             <xsl:when test="@FileState=4">Recalled</xsl:when>
                                          </xsl:choose>
                                       </td>
                                       <td class="field" width="8%">
                                          <xsl:value-of select="@FileRemarks"/>
                                       </td>
                                    </tr>
                                 </xsl:for-each>
                                 <xsl:if test="position()=last()">
                                    <xsl:text disable-output-escaping="yes">
									            &lt;/table&gt;
									            &lt;br/&gt;
								            </xsl:text>
                                 </xsl:if>
                              </xsl:for-each>
                           </td>
                        </tr>
                     </table>
                  </xsl:if>
               </xsl:for-each>
            </xsl:if>

            <p class="smalltext">
               In order to change the printing template, edit Print Template for the Approval card type or create a new one based on this template.
               <br>DocsVision © 2002-2010. All rights reserved.</br>
            </p>
         </body>
      </html>
   </xsl:template>
</xsl:stylesheet>
