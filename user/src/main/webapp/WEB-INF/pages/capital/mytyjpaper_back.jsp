<%@page import="com.dimeng.p2p.account.user.service.UserInfoManage"%>
<%@page import="com.dimeng.p2p.user.servlets.capital.AlerMytyjpaper"%>
<%@page import="com.dimeng.p2p.user.servlets.capital.Mytyjpaperend"%>
<%@page import="com.dimeng.p2p.common.Userexpemony"%>
<%@page import="java.util.List"%>


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
	<div class="w994 pb5">
		<span class="f16">
		<a href="<%=controller.getViewURI(request, com.dimeng.p2p.user.servlets.Index.class)%>">我的<%
			configureProvider.format(out,SystemVariable.SITE_NAME);
		%></a>
		</span> &gt; <a href="javascript:void(0)">资金管理</a>&gt; 我的体验金
	</div>
	<div class="contain clearfix">
		<div class="user_top"></div>
		<div class="about">
			<%@include file="/WEB-INF/include/menu.jsp"%>
			<div class="container fr">
				<div class="p15">
					<div class="ln30 Men_bt">
						<div class="Menubox">                   
		                     <ul>
		                        <li class="hover">未使用</li>
		                        <li> <a href="<%=controller.getViewURI(request, AlerMytyjpaper.class)%>">已使用</a></li>
		                        <li style="border-right:1px #d7dfe3 solid;"><a href="<%=controller.getViewURI(request, Mytyjpaperend.class)%>">已过期</a></li> 
		                     </ul>
	                    </div>
                        <div class="clear"></div>
					</div>
                    <form action="" method="post">
               		<div class="bs_bg pt10">
		                  <div class="no_table user_bolr bot">
		                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="user_table tc">
		                      <tr class="user_lsbg">
		                        <td>体验金</td>
		                        <td>有效期</td>
		                        <td>获得日期</td>
		                      </tr>
		                     
		                      
		                       <%
		                     		                      		                       	UserInfoManage manage = serviceSession.getService(UserInfoManage.class);
		                     		                      		                       		                          List<Userexpemony> list= manage.getUserMytyj();
		                     		                      		                       		                          if(list != null && list.size() != 0){
		                     		                      		                       		                        	 for(int i=0;i<list.size();i++){
		                     		                      		                       		                        	   Userexpemony  userm =list.get(i) ;
		                     		                      		                       %>
		                        <tr>
		                        <td><%=userm.money %>元</td>
		                        <td>体验活动结束之日</td>
		                        <td><%=DateTimeParser.format(userm.regnemetime) %></td>
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