<%@page import="com.dimeng.p2p.modules.account.pay.service.MobileSafetyManage"%>
<%@page import="com.dimeng.p2p.common.KeepParam"%>
<%@page import="com.dimeng.p2p.pay.servlets.Mregister"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="com.dimeng.p2p.pay.servlets.AwardRegister"%>
<%@page import="com.dimeng.p2p.pay.servlets.MobileRegister"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<meta name="mobile-agent" content="format=html5;url=http://www.jz96.com/3g/">  
     <%
     
     	String userAgent = request.getHeader("User-Agent");
     	String code = request.getParameter("code");
     	String partId = request.getParameter("partId");
     	if(userAgent != null && (
     			userAgent.indexOf("Android") != -1               
     			|| userAgent.indexOf("iPhone") != -1             
     			|| userAgent.indexOf("Windows Phone") != -1      
     			|| userAgent.indexOf("iPod") != -1          
     			|| userAgent.indexOf("MicroMessenger") != -1          
     			)){
     		int pid = 0;
     		if(code != null){
		     	MobileSafetyManage msm = serviceSession.getService(MobileSafetyManage.class);
     			pid = msm.getUserIdByCode(code);
     		}
     		controller.sendRedirect(request, response, configureProvider.format(URLVariable.M_REGISTERWEB)+(code != null?"?code="+code:"")+(partId != null?"?partId="+partId:""));
     	}else{
     		controller.sendRedirect(request, response, configureProvider.format(URLVariable.REGISTER)+(code != null?"?code="+code:"")+(partId != null?"?partId="+partId:""));
     	}
     	
     %>
