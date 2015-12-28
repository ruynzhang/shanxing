<%@page import="com.dimeng.p2p.S50.entities.T5017"%>
<%@page import="com.dimeng.p2p.S50.enums.T5017_F01"%>
<%@page import="com.dimeng.p2p.modules.base.front.service.TermManage"%>
<%
	T5017_F01 termType = T5017_F01.parse(request.getParameter("id"));
	if(termType==null){
		response.setStatus(HttpServletResponse.SC_NOT_FOUND);
		return;
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=termType.getChineseName() %> <%configureProvider.format(out, SystemVariable.SITE_TITLE);%> </title>
<%@include file="/WEB-INF/include/meta.jsp" %>
<%@include file="/WEB-INF/include/style.jsp" %>
</head>
<body style="background:#f4f9fc;">
<%
	TermManage termManage = serviceSession.getService(TermManage.class);
	T5017 term = termManage.get(termType);
%>
<div class="protocol">
  <div class="tit">
     <h2><strong><%configureProvider.format(out, SystemVariable.SITE_NAME);%><%=termType.getChineseName() %></strong></h2>
     <p>最后更新时间：<%if(term!=null){%><%=DateParser.format(term.F06)%><%}%></p>
  </div>
  <div class="con">
    <%if(term!=null){%>
    <%
    	StringHelper.format(out, term.F03, fileStore);
    	termManage.view(termType);
    %>
    <%}%>
  </div>
</div>
</body>
</html>
