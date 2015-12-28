<%@page import="com.dimeng.p2p.account.user.service.UserInfoManage"%>
<%@page import="com.dimeng.p2p.user.servlets.capital.Mytyjpaperend"%>
<%@page import="com.dimeng.p2p.user.servlets.capital.Mytyjpaper"%>
<%@page import="com.dimeng.p2p.common.Userexpemony"%>
<%@page import="com.dimeng.p2p.common.Expemonyinfo"%>
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
		                        <li><a href="<%=controller.getViewURI(request, Mytyjpaper.class)%>">未使用</a></li>
		                        <li class="hover">已使用</li>
		                        <li style="border-right:1px #d7dfe3 solid;"><a href="<%=controller.getViewURI(request, Mytyjpaperend.class)%>">已过期</a></li> 
		                     </ul>
	                    </div>
                        <div class="clear"></div>
					</div>
                    <form action="" method="post">
               		<div class="bs_bg pt10">
               		 <%
		                     		                    	UserInfoManage manage = serviceSession.getService(UserInfoManage.class);
		                     		                       		                          List<Userexpemony> list= manage.getalerMytyj();
		                     		                       		                  if(list != null && list.size() != 0){
		                     		                       		                	Expemonyinfo beaninfo =manage.getintrepay();
		                         		                        
		                     		                       %>
               		     <h1>体验收益:<%=Formater.formatAmount(beaninfo.borrint)%>元&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;还息日期:<%=DateTimeParser.format(beaninfo.repaymenttime,"yyyy-MM-dd")%></h1>
		                  <div class="no_table user_bolr bot">
		                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="user_table tc">
		                      <tr class="user_lsbg">
		                        <td>体验金</td>
		                        <td>使用日期</td>
		                        <td>体验标的</td>
		                        <td>状态</td>
		                      </tr>
		                      <%	 for(int i=0;i<list.size();i++){
		                        	   Userexpemony  userm =list.get(i) ; %>
		                        <tr>
		                        <td><%=userm.money %>元</td>
		                        <td><%=DateTimeParser.format(userm.regnemetime)%></td>
		                        <td><%=userm.title %></td>
		                        <td><%=userm.estatus %></td>
		                        </tr>
		                        <%
		                        	 }  }else{
		                        %>
		                        <div class="no_table user_bolr bot">
		                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="user_table tc">
		                      <tr class="user_lsbg">
		                        <td>体验金</td>
		                        <td>使用日期</td>
		                        <td>体验标的</td>
		                        <td>状态</td>
		                      </tr>
		                        <tr>
		                        <td colspan="4" style="color:red;">您目前还没有已使用的体验金哟！</td>
		                        </tr>
		                        <%} %>
		                      
		                    </table>
		            	  </div>
		            	   <p class="blue_ls">注册实名认证后只有到第三方开通方能到账</p>
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