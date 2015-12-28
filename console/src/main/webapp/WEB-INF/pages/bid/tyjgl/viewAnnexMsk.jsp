<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.S62.entities.MortFile"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
</head>
<body>
	<%
		MortFile mortFile = ObjectHelper.convert(request.getAttribute("mortFile"), MortFile.class);
	%>
	<img src="<%=fileStore.getURL(mortFile.F04)%>" alt="<%StringHelper.filterHTML(out,mortFile.F05);%>" />
</body>
</html>