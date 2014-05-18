<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<html>
			<head>
				<link rel="stylesheet" type="text/css" href="%ServerUrl%/StorageServer/File.axd?BaseName=%BaseName%&amp;TransformID=B5344DA1-D28F-4024-8798-3FC3992C94B7"/>
				<title><xsl:value-of select="//CardOrd/MainInfo/@DocType_Name"/>:<xsl:value-of select="//CardOrd/MainInfo/@Name"/></title>
			</head>
			<body>
				<table>
				<td width="70%" valign="top">
					<span class="fieldheader" style='font-family:"Times New Roman";font-size:12.0pt'>
						<xsl:if test="string-length(//CardOrd/MainInfo/@Recip_DepFullName)!=0">
							<xsl:value-of select="//CardOrd/MainInfo/@Recip_DepFullName"/>
						</xsl:if>
						<xsl:if test="string-length(//CardOrd/MainInfo/@Recip_DepFullName)=0">
							<xsl:value-of select="//CardOrd/MainInfo/@Recip_DepName"/>
						</xsl:if>
					</span>
				</td>
				<td><span class="fieldheader" style='font-family:"Times New Roman";font-size:12.0pt'>Получатель документа:
					<br></br>
					<xsl:value-of select="//CardOrd/MainInfo/@Resp_Position"/>
					<br></br>
					<xsl:if test="string-length(//CardOrd/MainInfo/@Resp_DepFullName)!=0">
						<xsl:value-of select="//CardOrd/MainInfo/@Resp_DepFullName"/>
					</xsl:if>
					<xsl:if test="string-length(//CardOrd/MainInfo/@Resp_DepFullName)=0">
						<xsl:value-of select="//CardOrd/MainInfo/@Resp_DepName"/>
					</xsl:if>
					<br></br>
					<xsl:value-of select="//CardOrd/MainInfo/@Resp_LName"/><xsl:if test="string-length(//CardOrd/MainInfo/@Resp_LName)!=0"> </xsl:if><xsl:value-of select="//CardOrd/MainInfo/@Resp_FName"/><xsl:if test="string-length(//CardOrd/MainInfo/@Resp_FName)!=0"> </xsl:if><xsl:value-of select="//CardOrd/MainInfo/@Resp_MName"/>
					</span>
				</td>
				</table>
				<br></br>
				<br></br>
				<span class="fieldheader" style='font-family:"Times New Roman";font-size:12.0pt'>
					<xsl:value-of select="//CardOrd/MainInfo/@DocType_Name"/>
				</span>
				<br></br>
				<br></br>
				<span>
					<xsl:value-of select="substring(translate(//CardOrd/MainInfo/@CreationDate, 'T', ' '),1,10)"/>                      № <xsl:value-of select="//CardOrd/MainInfo/@NumberPrefix"/><xsl:if test="string-length(//CardOrd/MainInfo/@NumberPrefix)!=0">-</xsl:if><xsl:value-of select="//CardOrd/MainInfo/@Number"/><xsl:if test="string-length(//CardOrd/MainInfo/@NumberSuffix)!=0">-</xsl:if><xsl:value-of select="//CardOrd/MainInfo/@NumberSuffix"/>
				</span>
				<br></br>
				<br></br>
				<span class="text" style='font-family:"Times New Roman";font-size:12.0pt'>
					<xsl:value-of select="//CardOrd/MainInfo/@Name"/>
				</span>
				<br></br>
				<br></br>
				<span class="text" style='font-family:"Times New Roman";font-size:12.0pt'>
					<xsl:value-of select="//CardOrd/MainInfo/@Digest"/>
				</span>
				<br></br>
				<br></br>
				<table>
				<td width="70%" valign="bottom">
					<span class="fieldheader" style='font-family:"Times New Roman";font-size:12.0pt'>
						<xsl:value-of select="//CardOrd/MainInfo/@Recip_Position"/>
						<br></br>
						<xsl:value-of select="//CardOrd/MainInfo/@Recip_DepName"/>
					</span>
				</td>
				<td valign="bottom">
					<span class="fieldheader" style='font-family:"Times New Roman";font-size:12.0pt'>
						<xsl:value-of select="//CardOrd/MainInfo/@Recip_LName"/><xsl:if test="string-length(//CardOrd/MainInfo/@Recip_LName)!=0"> </xsl:if><xsl:value-of select="//CardOrd/MainInfo/@Recip_FName"/><xsl:if test="string-length(//CardOrd/MainInfo/@Recip_FName)!=0"> </xsl:if><xsl:value-of select="//CardOrd/MainInfo/@Recip_MName"/>
					</span>
				</td>
				</table>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
