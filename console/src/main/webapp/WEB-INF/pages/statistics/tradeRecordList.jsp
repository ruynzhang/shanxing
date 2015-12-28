<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.statistics.AddTradeRecord"%>
<%@page import="com.dimeng.p2p.modules.statistics.console.service.entity.TradeRecordVO"%>
<%@page import="java.util.List"%>
<%@page import="com.dimeng.util.Formater"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<%
CURRENT_CATEGORY = "TJGL";
CURRENT_SUB_CATEGORY = "TRADERECORDLIST";
PagingResult<TradeRecordVO> list = (PagingResult<TradeRecordVO>)request.getAttribute("list");
%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<form action="<%controller.getURI(request, TradeRecordList.class);%>" method="post" name="form1" id="searchForm" onsubmit="return onSubmit();">
							<div class="box box1 mb15">
								<div class="con">
									<div class="admin_input admin_pb">
             							<div class="table top3">
             								<P>
												<span>合同编号：</span>
												<input type="text" name="num" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("num"));%>"/>
											</P>
											<P>
												<span>姓名：</span>
												<input type="text" name="name" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("name"));%>"/>
											</P>
											<P>
												<span>产品名称：</span>
												<input type="text" name="product_Name" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("product_Name"));%>"/>
											</P>
											<input name="search" type="submit" class="btn2" value="搜索" />
             								<P>
             									<%if (dimengSession.isAccessableResource(AddTradeRecord.class)) {%>
				                          		<a href="<%=controller.getURI(request,AddTradeRecord.class)%>" class="btn3" style="margin-left: 10px;"><font style="margin-left: 13px;">添加记录</font></a>
				                          		<%}else{%>
												<span class="btn5" style="margin-left: 10px;"><font style="margin-left: 13px;">添加记录</font></span>
												<%}%>
											</P>
											<div class="clear"></div>
										</div>
									</div>
								</div>
							</div>
							<table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
								<tr class="hsbg">
									<td>序号</td>
									<td>合同编号</td>
									<td>姓名</td>
									<td>员工编号</td>
									<td>性别</td>
									<td>身份证号码</td>
									<td>产品名称</td>
									<td>产品期限</td>
									<td>出借金额</td>
									<td>回款利息</td>
									<td>本息和</td>
									<td>出借日期</td>
									<td>回款日期</td>
									<td>开户行</td>
									<td>回款账号</td>
									<td>债权类型</td>
								</tr>
								<%
									if(list.getItems()!=null){
										int i=1;
										for(TradeRecordVO vo:list.getItems()){
								%>
								<tr class="dhsbg">
									<td><%=i++%></td>
									<td><%StringHelper.filterHTML(out, vo.num);%></td>
									<td><%StringHelper.filterHTML(out, vo.name);%></td>
									<td><%StringHelper.filterHTML(out, vo.empNo);%></td>
									<td><%StringHelper.filterHTML(out, vo.sex);%></td>
									<td><%StringHelper.filterHTML(out, vo.idcard);%></td>
									<td><%StringHelper.filterHTML(out, vo.product_Name);%></td>
									<td><%StringHelper.filterHTML(out, vo.product_qx);%></td>
									<td><%=Formater.formatAmount(vo.cj_amount) %></td>
									<td><%=Formater.formatAmount(vo.lx_amount) %></td>
									<td><%=Formater.formatAmount(vo.sum_amount) %></td>
									<td><%StringHelper.filterHTML(out, vo.cj_date);%></td>
									<td><%StringHelper.filterHTML(out, vo.hk_date);%></td>
									<td><%StringHelper.filterHTML(out, vo.branch);%></td>
									<td><%StringHelper.filterHTML(out, vo.cardNum);%></td>
									<td><%StringHelper.filterHTML(out, vo.zq_type);%></td>
								</tr>
								<%}}%>
							</table>
							<div class="box2 clearfix"></div>
							 <%TradeRecordList.rendPagingResult(out, list); %>
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
</body>
</html>
