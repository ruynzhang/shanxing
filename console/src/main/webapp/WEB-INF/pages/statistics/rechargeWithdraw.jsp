<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.statistics.RecWitExport"%>
<%@page import="com.dimeng.util.Formater"%>
<%@page import="com.dimeng.p2p.modules.statistics.console.service.entity.RecWitTotal"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<%@page import="com.dimeng.p2p.console.servlets.statistics.RechargeWithdraw"%>
<%@page import="com.dimeng.p2p.modules.statistics.console.service.entity.RecWit"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.dimeng.p2p.modules.statistics.console.service.RechargeWithdrawManage"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
		int year = IntegerParser.parse(request.getParameter("year"));
		if(year <= 0){
			Calendar calendar = Calendar.getInstance();
			year = calendar.get(Calendar.YEAR);
		}
		RechargeWithdrawManage manage = serviceSession.getService(RechargeWithdrawManage.class);
		int[] options = manage.getStatisticedYear();
		RecWit[] rws = manage.getRechargeWithdraws(year); 
		RecWitTotal recWitTotal = manage.getRecWitTotal(year);
		
		DecimalFormat format = new DecimalFormat("#,##0.00");
		
		CURRENT_CATEGORY = "TJGL";
		CURRENT_SUB_CATEGORY = "CZTXSJTJ";
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<div class="box box1 mb15">
							<div class="atil">
								<h3>充值提现数据统计</h3>
							</div>
							<div class="con">
								<div class="clear"></div>
								<form action="<%=controller.getURI(request, RechargeWithdraw.class)%>" method="post">
									<div class="table">
										<span>年份：</span> 
										<span>
											<select name="select" class="yhgl_sel yw_w1">
												<%if(options!=null && options.length>0){
					                    			for(int option : options){
					                    		%>
					                    			<option value="<%=option %>" <%=year==option?"selected=\"selected\"":"" %>><%=option %>年</option>
					                    		<%}}else{ %>
					                    			<option><%=year %>年</option>
					                    		<%} %>
											</select>
										</span>
										 <div class="clear"></div>   
					                    <div class="mt10">   
					                    	<input type="submit" class="btn2 mr10" value="搜索" />
					                    	<%if(dimengSession.isAccessableResource(RecWitExport.class)){ %>
												<a href="<%=controller.getURI(request, RecWitExport.class) %>?year=<%=year %>" class="btn3"><span class="ico"></span>导出</a>
											<%} else {%>
											 <span class="btn3 mr10 btn5"><span class="ico"></span>导出</span>
											<%} %>
					                   </div>               
										
										
										 
										
									</div>
								</form>
								<div class="clear"></div>
							</div>
						</div>
						<div class="mb15">
							<table width="100%" border="0" cellspacing="0" cellpadding="3"
								class="yhgl_table tc">
								<tr class="hsbg">
									<td>&nbsp;</td>
									<td>充值（元）</td>
									<td>提现（元）</td>
									<td>充值笔数</td>
									<td>提现笔数</td>
								</tr>
								<tr class="dhsbg">
									<td>一月份</td>
									<td><%=Formater.formatAmount(rws[0].recharge) %></td>
									<td><%=Formater.formatAmount(rws[0].withdraw) %></td>
									<td><%=rws[0].rechargeCount %></td>
									<td><%=rws[0].withdrawCount %></td>
								</tr>
								<tr class="dhsbg">
									<td>二月份</td>
									<td><%=Formater.formatAmount(rws[1].recharge) %></td>
									<td><%=Formater.formatAmount(rws[1].withdraw) %></td>
									<td><%=rws[1].rechargeCount %></td>
									<td><%=rws[1].withdrawCount %></td>
								</tr>
								<tr class="dhsbg">
									<td>三月份</td>
									<td><%=Formater.formatAmount(rws[2].recharge) %></td>
									<td><%=Formater.formatAmount(rws[2].withdraw) %></td>
									<td><%=rws[2].rechargeCount %></td>
									<td><%=rws[2].withdrawCount %></td>
								</tr>
								<tr class="dhsbg">
									<td>四月份</td>
									<td><%=Formater.formatAmount(rws[3].recharge) %></td>
									<td><%=Formater.formatAmount(rws[3].withdraw) %></td>
									<td><%=rws[3].rechargeCount %></td>
									<td><%=rws[3].withdrawCount %></td>
								</tr>
								<tr class="dhsbg">
									<td>五月份</td>
									<td><%=Formater.formatAmount(rws[4].recharge) %></td>
									<td><%=Formater.formatAmount(rws[4].withdraw) %></td>
									<td><%=rws[4].rechargeCount %></td>
									<td><%=rws[4].withdrawCount %></td>
								</tr>
								<tr class="dhsbg">
									<td>六月份</td>
									<td><%=Formater.formatAmount(rws[5].recharge) %></td>
									<td><%=Formater.formatAmount(rws[5].withdraw) %></td>
									<td><%=rws[5].rechargeCount %></td>
									<td><%=rws[5].withdrawCount %></td>
								</tr>
								<tr class="dhsbg">
									<td>七月份</td>
									<td><%=Formater.formatAmount(rws[6].recharge) %></td>
									<td><%=Formater.formatAmount(rws[6].withdraw) %></td>
									<td><%=rws[6].rechargeCount %></td>
									<td><%=rws[6].withdrawCount %></td>
								</tr>
								<tr class="dhsbg">
									<td>八月份</td>
									<td><%=Formater.formatAmount(rws[7].recharge) %></td>
									<td><%=Formater.formatAmount(rws[7].withdraw) %></td>
									<td><%=rws[7].rechargeCount %></td>
									<td><%=rws[7].withdrawCount %></td>
								</tr>
								<tr class="dhsbg">
									<td>九月份</td>
									<td><%=Formater.formatAmount(rws[8].recharge) %></td>
									<td><%=Formater.formatAmount(rws[8].withdraw) %></td>
									<td><%=rws[8].rechargeCount %></td>
									<td><%=rws[8].withdrawCount %></td>
								</tr>
								<tr class="dhsbg">
									<td>十月份</td>
									<td><%=Formater.formatAmount(rws[9].recharge) %></td>
									<td><%=Formater.formatAmount(rws[9].withdraw) %></td>
									<td><%=rws[9].rechargeCount %></td>
									<td><%=rws[9].withdrawCount %></td>
								</tr>
								<tr class="dhsbg">
									<td>十一月份</td>
									<td><%=Formater.formatAmount(rws[10].recharge) %></td>
									<td><%=Formater.formatAmount(rws[10].withdraw) %></td>
									<td><%=rws[10].rechargeCount %></td>
									<td><%=rws[10].withdrawCount %></td>
								</tr>
								<tr class="dhsbg">
									<td>十二月份</td>
									<td><%=Formater.formatAmount(rws[11].recharge) %></td>
									<td><%=Formater.formatAmount(rws[11].withdraw) %></td>
									<td><%=rws[11].rechargeCount %></td>
									<td><%=rws[11].withdrawCount %></td>
								</tr>
								<tr class="dhsbg">
									<td>总计</td>
									<td><%=Formater.formatAmount(recWitTotal.recharge) %></td>
									<td><%=Formater.formatAmount(recWitTotal.withdraw) %></td>
									<td><%=recWitTotal.rechargeCount %></td>
									<td><%=recWitTotal.withdrawCount %></td>
								</tr>
							</table>
						</div>
						<div class="box box1 mb15">
							<div class="con" style="position: relative">
								<div class="f16 fB"><%=year %>年充值提现金额数据折线图</div>
								<div class="hsxt"></div>
								<div class="clear"></div>
								<div class="tc mb30">
									<div id="line1" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
								</div>
								<div class="f16 fB"><%=year %>年充值提现笔数数据折线图</div>
								<div class="hsxt"></div>
								<div class="clear"></div>
								<div class="tc mb30">
									<div id="line2" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
								</div>
							</div>
						</div>
						<div class="box2 clearfix"></div>
					</div>
				</div>
			</div>
			<%@include file="/WEB-INF/include/left.jsp"%>
		</div>
	</div>
	<script type="text/javascript">
		var d1 = [0,0,0,0,0,0,0,0,0,0,0,0];
		var d2 = [0,0,0,0,0,0,0,0,0,0,0,0];
		<%for(RecWit rw : rws){if(rw.month>0){%>
			d1[<%=rw.month-1 %>] = <%=rw.recharge %>;
			d2[<%=rw.month-1 %>] = <%=rw.withdraw %>;
		<%}}%>
		var dd1 = [0,0,0,0,0,0,0,0,0,0,0,0];
		var dd2 = [0,0,0,0,0,0,0,0,0,0,0,0];
		<%for(RecWit rw : rws){if(rw.month>0){%>
			dd1[<%=rw.month-1 %>] = <%=rw.rechargeCount %>;
			dd2[<%=rw.month-1 %>] = <%=rw.withdrawCount %>;
		<%}}%>
	</script>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/highcharts.js"></script>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/rechargeWithdraw.js"></script>
</body>
</html>