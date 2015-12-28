	<%@page import="com.dimeng.p2p.account.user.service.UserInfoManage"%>
		<%@page import="com.dimeng.p2p.user.servlets.capital.AlerRedpaper"%>
		<%@page import="com.dimeng.p2p.user.servlets.capital.Redpaperend"%>
		<%@page import="com.dimeng.p2p.user.servlets.capital.Redpaper"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>我的<%configureProvider.format(out,SystemVariable.SITE_NAME);%>_红包
</title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<%
		//CURRENT_CATEGORY = "WDHB";
	CURRENT_SUB_CATEGORY = "WDHB";
		//CURRENT_SUB_CATEGORY = "DDCX";
	%>
	<div class="w994 pb5">
		<span class="f16">
		<a href="<%=controller.getViewURI(request, com.dimeng.p2p.user.servlets.Index.class)%>">我的<%
			configureProvider.format(out,SystemVariable.SITE_NAME);
		%></a>
		</span> &gt; <a href="javascript:void(0)">资金管理</a>&gt; 我的红包
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
		                        <li> <a href="<%=controller.getViewURI(request, AlerRedpaper.class)%>">已使用</a></li>
		                        <li style="border-right:1px #d7dfe3 solid;"><a href="<%=controller.getViewURI(request, Redpaperend.class)%>">已过期</a></li>
		                     </ul>
	                    </div>
                        <div class="clear"></div>
					</div>
                    <form action="" method="post">
               		<div class="bs_bg pt10">
		                  <div class="no_table user_bolr bot">
		                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="user_table tc">
		                      <tr class="user_lsbg">
		                        <td>红包</td>
		                        <td>个数</td>
		                        <td>有效期</td>
		                      </tr>
		                      <tr>
		                        <td>20元红包优惠券</td>
		                        <td><%  UserInfoManage manage = serviceSession.getService(UserInfoManage.class);
		                          int msaward = manage.getWardpapCount();
		                           out.print(msaward);
		                        %></td>
		                        <td>上线起规定时间内有效</td>
		                      </tr>
		                    </table>
		            	  </div>
		                    <div class="page">
								<% // AbstractFinancingServlet.rendPagingResult(out, raList); %>
							</div>
                  </div>
                  </form>
                    <div class="ln30 pl20 mb40">
						<p class="blue f16">红包使用规则：</p>
						 具体红包使用规则在上线时再作公布<br>
					    *本规则最终的解析权归善行创投所有

					</div>
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