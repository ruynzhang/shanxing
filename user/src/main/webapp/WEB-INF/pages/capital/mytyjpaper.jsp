<%@page import="com.dimeng.p2p.user.servlets.capital.Mytyjshpaper"%>
<%@page import="com.dimeng.p2p.user.servlets.capital.Mytyjklpaper"%>
<%@page import="com.dimeng.p2p.account.user.service.UserInfoManage"%>
<%@page import="com.dimeng.p2p.user.servlets.capital.AlerMytyjpaper"%>
<%@page import="com.dimeng.p2p.user.servlets.capital.Mytyjpaperend"%>
<%@page import="com.dimeng.p2p.common.Userexpemony2"%>
<%@page import="java.util.List"%>
<%@page import="com.dimeng.p2p.common.enums.userexpe_source"%>
<%@include file="/WEB-INF/include/authenticatedSession.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>我的<%
	configureProvider.format(out,SystemVariable.SITE_NAME);
%>_体验金
</title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<%
		//CURRENT_CATEGORY = "WDHB";
		CURRENT_SUB_CATEGORY = "WDTYJ";
			//CURRENT_SUB_CATEGORY = "DDCX";
	%>
	
	<div class="contain clearfix">
		<div class="user_top"></div>
		<div class="about">
			<%@include file="/WEB-INF/include/menu.jsp"%>
			<div class="container fr">
			  <div class="sx_tyj_head">
			  <% UserInfoManage manage = serviceSession.getService(UserInfoManage.class); %>
                   <ul>
                     <li>已使用体验金：<b>￥<%=Formater.formatAmount(manage.useexpemoney())%></b></li>
                     <li>未使用体验金：<b>￥<%=Formater.formatAmount(manage.getbalance())%></b></li>
                   </ul>
                   <div class="clear"></div>
			  </div>
				<div class="p15">
					<div class="ln30 Men_bt">
						<div class="Menubox">                   
		                     <ul>
                                <li> <a href="<%=controller.getViewURI(request, AlerMytyjpaper.class)%>">已投标的</a></li>
		                        <li class="hover">体验金来源</li>
                                <%--<li><a href="<%=controller.getViewURI(request, Mytyjklpaper.class)%>">领取体验金</a></li> --%>
		                     </ul>
	                    </div>
                        <div class="clear"></div>
					</div>
                    <form action="" method="post">
               		<div class="bs_bg pt10">
		                  <div class="no_table user_bolr bot">
		                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="user_table tc tableOdd">
		                      <tr class="user_lsbg">
		                        <th>项目</th>
		                        <th>时间</th>
		                        <th>金额</th>
		                      </tr>
		                     
		                      
		                       <%
		                     		                      		                       	
		                     		                      		                       		                          List<Userexpemony2> list= manage.getUserexpemoney();
		                     		                      		                       		                          if(list != null && list.size() != 0){
		                     		                      		                       		                        	 for(int i=0;i<list.size();i++){
		                     		                      		                       		                        	   Userexpemony2  userm =list.get(i) ;
		                     		                      		                       %>
		                        <tr>
		                        <td><%=userm.source.getChineseName() %></td>
		                        <td><%=DateTimeParser.format(userm.gettime) %></td>
		                        <td><%=Formater.formatAmount(userm.money) %>元</td>
		                        </tr>
		                        <%
		                        	 }  }else{
		                        %>
		                        <tr>
		                        <td colspan="3" style="color:red;">您目前还没有体验金哟！</td>
		                        </tr>
		                        <%} %>
		                      
		                    </table>
		            	  </div>
		                    <div class="page">
								<% // AbstractFinancingServlet.rendPagingResult(out, raList); %>
							</div>
                  </div>         
                  </form>
				</div>
			</div>
			<div class="clear"></div>
		</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/charge.js"></script>
</body>
</html>