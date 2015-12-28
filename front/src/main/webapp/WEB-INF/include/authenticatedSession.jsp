<%@page import="com.dimeng.p2p.front.servlets.Logout"%>
<%@page import="com.dimeng.p2p.S61.entities.T6110"%>
<%@page import="com.dimeng.p2p.account.front.service.UserInfoManage"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F07"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="com.dimeng.framework.http.session.Session"%>
<%
	if (dimengSession == null || !dimengSession.isAuthenticated()) {
		controller.redirectLogin(request, response, configureProvider.format(URLVariable.LOGIN));
		return;
	}else 
	{
		UserInfoManage userInfoManage=serviceSession.getService(UserInfoManage.class);
		T6110 t6110=userInfoManage.getUserInfo(serviceSession.getSession().getAccountId());
		if(t6110.F07==T6110_F07.HMD||t6110.F07==T6110_F07.SD)
		{
			controller.redirectLogin(request, response, controller.getURI(request, Logout.class));
			return;
		}
	}
%>