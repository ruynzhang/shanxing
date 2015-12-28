<%@page import="com.dimeng.p2p.bbs.client.Client"%>
<%@page import="com.dimeng.p2p.bbs.client.ClientClub"%>
<%@page import="com.dimeng.p2p.front.servlets.Logout"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title></title>


</head>
<body>
<div  style="display: none" >
	<%@include file="/WEB-INF/include/header.jsp"%>
</div>
<%
ClientClub uc2 =new ClientClub();
String $ucsynlogout2 = uc2.uc_user_synlogout();
dimengSession.removeAttribute("clubrtid");
out.println($ucsynlogout2);

%>
</body>
</html>
<script type="text/javascript">
      window.location.href= "<%=controller.getURI(request, Logout.class) %>";
</script>