<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.bid.tyjgl.TotaldhListExport"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.tyjgl.TotaldhList"%>
<%@page import="com.dimeng.p2p.modules.bid.console.service.entity.ExpemoneyTotal"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.tyjgl.GamedhListExport"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.tyjgl.GamedhList"%>
<%@page import="com.dimeng.p2p.modules.bid.console.service.entity.ExpemoneyGame"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.tyjgl.KldhListExport"%>
<%@page import="com.dimeng.p2p.modules.bid.console.service.entity.ExpemoneyCode"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.czgl.ExportCzgl"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F06"%>
<%@page import="com.dimeng.p2p.S61.enums.T6131_F07"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.UserRecharge"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.Czgl"%>
<%@page import="com.dimeng.util.Formater"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.tyjgl.KldhList"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<%
		//BigDecimal czze = ObjectHelper.convert(request.getAttribute("czze"),BigDecimal.class);
		//BigDecimal czsxf = ObjectHelper.convert(request.getAttribute("czsxf"),BigDecimal.class);
		PagingResult<ExpemoneyTotal> result = (PagingResult<ExpemoneyTotal>) request
				.getAttribute("result");
%>
<%
		CURRENT_CATEGORY = "YWGL";
			CURRENT_SUB_CATEGORY = "TYJTJDH";
	%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<form action="<%controller.getURI(request, TotaldhList.class);%>" method="post" name="form1" id="searchForm">
							<div class="box box1 mb15">
								<div class="atil">
									<h3>体验金统计兑换</h3>
								</div>
								<div class="con">
									<div class="clear"></div>
									<ul class="yhxq_li">
										<li>兑换人数：<span class="blue"><%=request.getAttribute("totaldlnum") %></span>
										</li>
									</ul>
									<ul class="yhxq_li">
										<li>兑换总额 ：<span class="blue"><%=request.getAttribute("ertotalamount") %></span>
										</li>
									</ul>
									<ul class="yhxq_li">
										<li>未兑换总额 ：<span class="blue"><%=request.getAttribute("tnotdhmoney") %></span>
										</li>
									</ul>
									<ul class="yhxq_li">
										<li>实名人数 ：<span class="blue"><%=request.getAttribute("reltotalname") %></span>
										</li>
									</ul>
									<div class="clear"></div>
								</div>
							</div>
							<div class="box box1 mb15">
								<div class="con">
									<div class="admin_input admin_pb">
             							<div class="table top3">
             							   <p>
												<span>用户账号：</span>
												<input type="text" name="userName" value="<%StringHelper.filterHTML(out, request.getParameter("userName")); %>" class="yhgl_input" />
											</p>
											<P>
												<input name="search" type="submit" class="btn2" value="搜索" />
												<%if (dimengSession.isAccessableResource(TotaldhListExport.class)) {%>
													<a href="javascript:void(0)" onclick="showExport()" class="btn3 mr10"><span class="ico"></span>导出</a>
												<%}else{ %>
													<span class="btn3 btn5 mr10"><span class="ico"></span>导出</span>
												<%} %> 
											</P>
									<div class="clear"></div>
								</div>
								</div>
								</div>
							</div>
							<table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
								<tr class="hsbg">
									<td>序号</td>
									<td>用户账号</td>
									<td>总额</td>
									<td>投标金额</td>
									<td>游戏金额</td>
									<td>口令金额</td>
									<td>序号金额</td>
									<td>注册金额</td>
									<td>实名认证金额</td>
									<td>老用户金额</td>
								</tr>
								<%
								ExpemoneyTotal[] items = result.getItems();
										if (items != null) {
											int i=1;
											for (ExpemoneyTotal exgame: items) {
												if (exgame == null) {
													continue;
												}
								%>
								<tr class="dhsbg">
									<td><%=i++%></td>
									<td><% StringHelper.filterHTML(out,exgame.username);%></td>
									<td><%=Formater.formatAmount(exgame.summoney)%></td>
									<td><%=Formater.formatAmount(exgame.tbmoney)%></td>
									<td><%=Formater.formatAmount(exgame.yxmoney)%></td>
									<td><%=Formater.formatAmount(exgame.klmoney)%></td>
									<td><%=Formater.formatAmount(exgame.xhmoney)%></td>
									<td><%=Formater.formatAmount(exgame.zcmoney)%></td>
									<td><%=Formater.formatAmount(exgame.smrzmoney)%></td>
									<td><%=Formater.formatAmount(exgame.lyhmoney)%></td>
								</tr>
								<%
									}
										}
								%>
							</table>
							<%
							    TotaldhList.rendPagingResult(out, result);
							%>
							<div class="box2 clearfix"></div>
						</form>
					</div>
				</div>
			</div>
			<%@include file="/WEB-INF/include/left.jsp"%>
		</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<%@include file="/WEB-INF/include/datepicker.jsp"%>
	<script type="text/javascript">
	function showExport()
	{
		document.getElementById("searchForm").action ="<%=controller.getURI(request, TotaldhListExport.class)%>";
		$("#searchForm").submit();
		document.getElementById("searchForm").action ="<%=controller.getURI(request, TotaldhList.class)%>";
	}
	</script>
</body>
</html>
