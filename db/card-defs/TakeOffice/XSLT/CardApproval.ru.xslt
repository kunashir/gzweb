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
            <title>
               <xsl:value-of select="//CardApproval[1]/MainInfo/@Name"/>
            </title>
         </head>
         <body>
            <span class="header">
               <xsl:value-of select="//CardApproval[1]/MainInfo/@Name"/>
            </span>
            <br></br>
            <span class="header2">Основная информация</span>
            <table border="0" width="100%">
               <tr>
                  <td class="fieldheader" width="8%">Имя:</td>
                  <td colspan="5">
                     <xsl:value-of select="//CardApproval[1]/MainInfo/@Name"/>
                  </td>
               </tr>
               <tr>
                  <td class="fieldheader" width="8%">Вид:</td>
                  <td colspan="5">
                     <xsl:value-of select="//CardApproval[1]/MainInfo/@Type_Name"/>
                  </td>
               </tr>
               <tr>
                  <td class="fieldheader" width="8%">Дата создания:</td>
                  <td colspan="5">
                     <xsl:call-template name="convertdatetime">
                        <xsl:with-param name="str" select="//CardApproval[1]/MainInfo/@CreationDate"/>
                     </xsl:call-template>
                  </td>
               </tr>
               <tr>
                  <td class="fieldheader" width="8%">Кем создано:</td>
                  <td width="32%">
                     <xsl:value-of select="//CardApproval[1]/MainInfo/@Create_LName"/>
                     <xsl:if test="string-length(//CardApproval[1]/MainInfo/@Create_LName)!=0"> </xsl:if>
                     <xsl:value-of select="//CardApproval[1]/MainInfo/@Create_FName"/>
                     <xsl:if test="string-length(//CardApproval[1]/MainInfo/@Create_FName)!=0"> </xsl:if>
                     <xsl:value-of select="//CardApproval[1]/MainInfo/@Create_MName"/>
                  </td>
                  <td class="fieldheader" width="8%">Должность:</td>
                  <td width="22%">
                     <xsl:value-of select="//CardApproval[1]/MainInfo/@CreatedByPosition"/>
                  </td>
                  <td class="fieldheader" width="8%">Подразделение:</td>
                  <td width="22%">
                     <xsl:value-of select="//CardApproval[1]/MainInfo/@CreatedByDepartment"/>
                  </td>
               </tr>
               <tr>
                  <td class="fieldheader">Инициатор:</td>
                  <td>
                     <xsl:value-of select="//CardApproval[1]/MainInfo/@Initiate_LName"/>
                     <xsl:if test="string-length(//CardApproval[1]/MainInfo/@Initiate_LName)!=0"> </xsl:if>
                     <xsl:value-of select="//CardApproval[1]/MainInfo/@Initiate_FName"/>
                     <xsl:if test="string-length(//CardApproval[1]/MainInfo/@Initiate_FName)!=0"> </xsl:if>
                     <xsl:value-of select="//CardApproval[1]/MainInfo/@Initiate_MName"/>
                  </td>
                  <td class="fieldheader">Должность:</td>
                  <td>
                     <xsl:value-of select="//CardApproval[1]/MainInfo/@InitiatedByPosition"/>
                  </td>
                  <td class="fieldheader">Подразделение:</td>
                  <td>
                     <xsl:value-of select="//CardApproval[1]/MainInfo/@InitiatedByDepartment"/>
                  </td>
               </tr>
               <tr>
                  <td class="fieldheader" width="8%">Стадия согласования:</td>
                  <td colspan="5">
                     <xsl:choose>
                        <xsl:when test="//CardApproval[1]/MainInfo/@DocumentState=0">Редактирование</xsl:when>
                        <xsl:when test="//CardApproval[1]/MainInfo/@DocumentState=1">Согласование</xsl:when>
                        <xsl:when test="//CardApproval[1]/MainInfo/@DocumentState=2">Консолидация</xsl:when>
                        <xsl:when test="//CardApproval[1]/MainInfo/@DocumentState=3">Завершено</xsl:when>
                     </xsl:choose>
                  </td>
               </tr>
               <tr>
                  <td class="fieldheader" width="8%">Статус согласования:</td>
                  <td colspan="5">
                     <xsl:choose>
                        <xsl:when test="//CardApproval[1]/MainInfo/@ApprovalState=0">Подготовка</xsl:when>
                        <xsl:when test="//CardApproval[1]/MainInfo/@ApprovalState=1">Согласование</xsl:when>
                        <xsl:when test="//CardApproval[1]/MainInfo/@ApprovalState=2">Согласовано</xsl:when>
                        <xsl:when test="//CardApproval[1]/MainInfo/@ApprovalState=3">Согласовано с замечаниями</xsl:when>
                        <xsl:when test="//CardApproval[1]/MainInfo/@ApprovalState=4">Не согласовано</xsl:when>
                     </xsl:choose>
                  </td>
               </tr>
            </table>
            <span class="header2">Родительский документ</span>
            <table border="0" width="100%">
               <tr>
                  <td class="fieldheader" width="8%">Тема:</td>
                  <td width="32%">
                     <xsl:value-of select="//CardApproval[1]/MainInfo/@ParentName"/>
                  </td>
                  <td class="fieldheader" width="8%">Номер:</td>
                  <td width="22%">
                     <xsl:value-of select="//CardApproval[1]/MainInfo/@ParentNumber"/>
                  </td>
               </tr>
               <tr>
                  <td class="fieldheader" width="8%">Дата регистрации:</td>
                  <td>
							<xsl:call-template name="convertdatetime">
								<xsl:with-param name="str" select="//CardApproval[1]/MainInfo/@ParentRegDate"/>
							</xsl:call-template>
                  </td>
                  <td class="fieldheader" width="8%">Дата создания:</td>
                  <td>
							<xsl:call-template name="convertdatetime">
								<xsl:with-param name="str" select="//CardApproval[1]/MainInfo/@ParentCreationDate"/>
							</xsl:call-template>
                  </td>
               </tr>
            </table>
            <br></br>

            <span class="header2">Циклы согласования</span>
            <xsl:for-each select="//CardApproval[1]/Cycles/CyclesRow">
               <table border="0" width="100%">
                  <tr>
                     <td class="fieldheader" width="8%">Цикл:</td>
                     <td colspan="5">
                        <xsl:value-of select="@Cycle"/>
                     </td>
                  </tr>
                  <tr>
                     <td class="fieldheader" width="8%">Ответственное лицо:</td>
                     <td width="32%">
                        <xsl:value-of select="@Resp_LName"/>
                        <xsl:if test="string-length(@Resp_LName)!=0"> </xsl:if>
                        <xsl:value-of select="@Resp_FName"/>
                        <xsl:if test="string-length(@Resp_FName)!=0"> </xsl:if>
                        <xsl:value-of select="@Resp_MName"/>
                     </td>
                     <td class="fieldheader" width="8%">Должность:</td>
                     <td width="22%">
                        <xsl:value-of select="@ConsolidatorPosition"/>
                     </td>
                     <td class="fieldheader" width="8%">Подразделение:</td>
                     <td width="22%">
                        <xsl:value-of select="@ConsolidatorDepartment"/>
                     </td>
                  </tr>
                  <tr>
                     <td class="fieldheader" width="8%">Дата начала:</td>
                     <td width="32%">
                        <xsl:call-template name="convertdatetime">
                           <xsl:with-param name="str" select="@StartDate"/>
                        </xsl:call-template>
                     </td>
                     <td class="fieldheader" width="8%">Продолжительность:</td>
                     <td width="22%">
                        <xsl:value-of select="@Duration"/>
                     </td>
                  </tr>
                  <tr>
                     <td class="fieldheader" width="8%">Ожидаемая дата завершения:</td>
                     <td width="32%">
                        <xsl:call-template name="convertdatetime">
                           <xsl:with-param name="str" select="@FinishDate"/>
                        </xsl:call-template>
                     </td>
                     <td class="fieldheader" width="8%">Действительная дата завершения:</td>
                     <td width="22%">
                        <xsl:call-template name="convertdatetime">
                           <xsl:with-param name="str" select="@ActualFinishDate"/>
                        </xsl:call-template>
                     </td>
                  </tr>
                  <tr>
                     <td class="fieldheader" width="8%">Согласуемые документы:</td>
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
									&lt;span class="fieldheader"&gt;Согласующие лица&lt;/span&gt;
									&lt;table border="0" cellpadding="0" cellspacing="0" style="BORDER-COLLAPSE: collapse" bordercolor="black" width="100%"&gt;
										&lt;tr&gt;
											&lt;th class="tableheader" align="left"&gt;№&lt;/th&gt;
											&lt;th class="tableheader" align="left"&gt;ФИО&lt;/th&gt;
                                 &lt;th class="tableheader" align="left"&gt;Должность&lt;/th&gt;
                                 &lt;th class="tableheader" align="left"&gt;Подразделение&lt;/th&gt;
                                 &lt;th class="tableheader" align="left"&gt;Документ&lt;/th&gt;
                                 &lt;th class="tableheader" align="left"&gt;Статус&lt;/th&gt;
                                 &lt;th class="tableheader" align="left"&gt;Замечания&lt;/th&gt;
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
                                       <xsl:when test="@FileState=0">К согласованию</xsl:when>
                                       <xsl:when test="@FileState=1">Согласован</xsl:when>
                                       <xsl:when test="@FileState=2">Согласован с замечаниями</xsl:when>
                                       <xsl:when test="@FileState=3">Не согласован</xsl:when>
                                       <xsl:when test="@FileState=4">Отозван</xsl:when>
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
							&lt;span class="header2"&gt;Комментарии к согласованию&lt;/span&gt;
							&lt;table border="0" cellpadding="0" cellspacing="0" style="BORDER-COLLAPSE: collapse" bordercolor="black" width="100%"&gt;
								&lt;tr&gt;
                           &lt;th class="tableheader" align="left"&gt;Цикл&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Дата комментария&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Автор&lt;/th&gt;
									&lt;th class="tableheader" align="left"&gt;Комментарий&lt;/th&gt;
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
               <span class="header2">Итоги согласования</span>
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
									            &lt;span class="fieldheader"&gt;Согласующие лица&lt;/span&gt;
									            &lt;table border="0" cellpadding="0" cellspacing="0" style="BORDER-COLLAPSE: collapse" bordercolor="black" width="100%"&gt;
										            &lt;tr&gt;
											            &lt;th class="tableheader" align="left"&gt;№&lt;/th&gt;
											            &lt;th class="tableheader" align="left"&gt;ФИО&lt;/th&gt;
                                             &lt;th class="tableheader" align="left"&gt;Должность&lt;/th&gt;
                                             &lt;th class="tableheader" align="left"&gt;Подразделение&lt;/th&gt;
                                             &lt;th class="tableheader" align="left"&gt;Документ&lt;/th&gt;
                                             &lt;th class="tableheader" align="left"&gt;Статус&lt;/th&gt;
                                             &lt;th class="tableheader" align="left"&gt;Замечания&lt;/th&gt;
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
                                             <xsl:when test="@FileState=0">К согласованию</xsl:when>
                                             <xsl:when test="@FileState=1">Согласован</xsl:when>
                                             <xsl:when test="@FileState=2">Согласован с замечаниями</xsl:when>
                                             <xsl:when test="@FileState=3">Не согласован</xsl:when>
                                             <xsl:when test="@FileState=4">Отозван</xsl:when>
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
               Для того чтобы изменить вид данного шаблона, Вы можете отредактировать "Стандартный шаблон печати" для карточки "Согласование" или создать новый шаблон на основе данного.
               <br>DocsVision © 2002-2010. Все права защищены.</br>
            </p>
         </body>
      </html>
   </xsl:template>
</xsl:stylesheet>
