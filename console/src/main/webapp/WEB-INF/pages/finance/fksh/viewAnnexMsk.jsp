<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.S62.entities.T6232"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
</head>
<body>
	<%
		T6232 t6232 =ObjectHelper.convert(request.getAttribute("t6232"), T6232.class);
	%>
	<img src="<%=fileStore.getURL(t6232.F04)%>" alt="<%StringHelper.filterHTML(out,t6232.F05);%>" />
</body>
</html>