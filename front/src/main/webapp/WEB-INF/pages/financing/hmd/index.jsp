<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.S61.entities.T6144"%>
<%@page import="com.dimeng.p2p.account.front.service.entity.UserInfo"%>
<%@page import="com.dimeng.p2p.account.front.service.UserInfoManage"%>
<%@page import="com.dimeng.p2p.front.servlets.AbstractFrontServlet"%>
<%@page import="com.dimeng.p2p.variables.defines.SystemVariable"%>
<html>
<head>
<title>黑名单-<%=configureProvider.getProperty(SystemVariable.SITE_TITLE)%></title>
<%@include file="/WEB-INF/include/meta.jsp" %>
<%@include file="/WEB-INF/include/style.jsp" %>
</head>
<%
	UserInfoManage service = serviceSession.getService(UserInfoManage.class);
	final HttpServletRequestWrapper requestWrapper = new  HttpServletRequestWrapper(request);
%>
<body>
<%@include file="/WEB-INF/include/header.jsp" %>
<div class="contain clearfix">
   <div class="w1002 top_title">
      <span class="fl"><a href="<%=controller.getViewURI(request, com.dimeng.p2p.front.servlets.financing.Index.class)%>">我要理财</a> &gt;  还款黑名单</span>
  </div>
   
   <div class="contain_main clearfix">
      <div class="blacklist">
         <table width="100%" border="0" align="left" cellspacing="0">
              <tr class="blue_tit">
                <td>头像/用户名 </td>
                <td>个人资料</td>
                <td>联系方式</td>
                <td>信用档案</td>
              </tr>
              <%
              		PagingResult<UserInfo> result = service.search(new Paging() {public int getCurrentPage() {return IntegerParser.parse(requestWrapper.getParameter("paging.current"));}public int getSize() {return 10;}});
                       UserInfo[] userBlacklist=result.getItems();if(userBlacklist!=null){for (UserInfo userBlack : userBlacklist) {if (userBlack == null) {continue;}
                              UserInfoManage infoManage = serviceSession.getService(UserInfoManage.class);
                              UserInfo uiInfo =  infoManage.getAgeSex(userBlack.F17);
              %>
              
              <tr>
                <td valign="top" class="w150">
                  <span class="pic"><img src="<%if(StringHelper.isEmpty(userBlack.F15)){%><%=controller.getStaticPath(request)%>/images/tx.jpg<%}else{%><%=fileStore.getURL(userBlack.F15) %><%}%>" width="127" height="125" class="pic_img"/></span>
                  <p class="tc"><%StringHelper.filterHTML(out, userBlack.F02); %></p>
                </td>
				<td valign="top">真实姓名：<%StringHelper.filterHTML(out, userBlack.F12); %><br />
			                  性别：<%=uiInfo.sex == 1?"男":"女" %><br />
			                  身份证号：<%StringHelper.filterHTML(out, userBlack.F16); %><br />
			     </td>
			                <td valign="top">手机号码：<%StringHelper.filterHTML(out, userBlack.F04); %><br />
			                  电子邮箱：<%StringHelper.filterHTML(out, userBlack.F05); %><br />
			                  <br /></td>
			       <%T6144 entity = service.getXyjl(userBlack.F01); %>           
			      <td valign="top">逾期次数（次）：<%=entity.F02 %>次<br />
			                  严重逾期（笔）：<%=entity.F03 %>笔<br />
			                  最长逾期（天）：<%=entity.F04 %>天<br />
			                  待还金额（元）：<%=service.getDhje(userBlack.F01) %>元</td>
              </tr>
              <%}} %>
		</table>
   </div>  
   <%AbstractFrontServlet.rendPaging(out, result,controller.getPagingURI(request, com.dimeng.p2p.front.servlets.financing.hmd.Index.class));%>
</div>   
</div>
<%@include file="/WEB-INF/include/footer.jsp" %>
<%@include file="/WEB-INF/include/script.jsp" %>
</body>
</html>