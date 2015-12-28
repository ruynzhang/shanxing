<%@page import="com.dimeng.p2p.S50.entities.T5018"%>
<%@page import="com.dimeng.p2p.modules.base.front.service.PerformanceReportManage"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="com.dimeng.framework.http.upload.FileInformation"%>
<%
PerformanceReportManage reportManage = serviceSession.getService(PerformanceReportManage.class);
T5018 report = reportManage.get(IntegerParser.parse(request.getParameter("id")));
if(report==null){
	response.sendError(HttpServletResponse.SC_NOT_FOUND);
	return;
}
reportManage.view(report.F01);
String fileName=report.F05;
FileInformation info=fileStore.getFileInformation(report.F06);
String suffix = info.getSuffix();
if(!StringHelper.isEmpty(suffix)){
	fileName+='.'+suffix;
}
response.addHeader("Content-Disposition", "attachment; filename="+URLEncoder.encode(fileName,resourceProvider.getCharset()));
fileStore.read(info, response.getOutputStream());
%>