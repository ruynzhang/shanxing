<%@page import="com.dimeng.p2p.user.servlets.capital.Mytyjklpaper"%>
<%@page import="com.dimeng.p2p.user.servlets.capital.Mytyjshpaper"%>
<%@page import="com.dimeng.p2p.account.user.service.UserInfoManage"%>
<%@page import="com.dimeng.p2p.user.servlets.capital.Mytyjpaperend"%>
<%@page import="com.dimeng.p2p.user.servlets.capital.Mytyjpaper"%>
<%@page import="com.dimeng.p2p.common.Userexpemony"%>
<%@page import="com.dimeng.p2p.common.Expemonyinfo"%>
<%@page import="java.util.List"%>
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
                                <li class="hover">已投标的</li>
		                        <li><a href="<%=controller.getViewURI(request, Mytyjpaper.class)%>">体验金来源</a></li>
                                <%-- <li><a href="<%=controller.getViewURI(request, Mytyjklpaper.class)%>">领取体验金</a></li>--%>
		                     </ul>
	                    </div>
                        <div class="clear"></div>
					</div>

                    <form action="" method="post">
						<div class="bs_bg pt10">

							  <div class="no_table user_bolr bot">
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="user_table tc tableOdd">
								  <tr class="user_lsbg">
									<th>标的名称</th>
									<th>所投金额</th>
									<th>获得利息</th>
									<th>还息日期</th>
								  </tr>
								  <%
									 List<Userexpemony> list= manage.getaltyjloan();
									   if(list != null && list.size() != 0){
										  for(int i=0;i<list.size();i++){
												   Userexpemony  userm =list.get(i) ; %>
									<tr>
									 <td><%=userm.title %></td>
									<td><%=userm.money %>元</td>
									 <td><%=userm.lanint %>元</td>
									<td><%=userm.regnemetime==null?"预计最晚13天到账":DateParser.format(userm.regnemetime)%></td>
									</tr>
									<%
										 }  }else{
									%>
									<tr>
									<td colspan="4" style="color:red;">您目前还没有已使用的体验金哟！</td>
									</tr>
									<%} %>

								</table>
							  </div>

								<div class="page">
									<%//AbstractFinancingServlet.rendPagingResult(out, raList); %>
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