<%@page import="com.dimeng.p2p.bbs.client.Client"%>
<%@page import="com.dimeng.p2p.bbs.client.ClientClub"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title></title>
</head>
<body>
<%
ClientClub uc2 =new ClientClub();
String $ucsynlogout2 = uc2.uc_user_synlogout();
dimengSession.removeAttribute("clubrtid");
out.println($ucsynlogout2);

Session session = resourceProvider.getResource(SessionManager.class).getSession(request, response, true);
if (session != null) {
	session.invalidate(request, response);
}
%>
</body>
<script type="text/javascript">
      window.location.href= "/user/mobile/login.html";
</script>
</html>