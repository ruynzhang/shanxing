<%@page import="com.dimeng.p2p.S62.enums.T6230_F13"%>
<%@page import="com.dimeng.p2p.user.servlets.Index"%>
<%@page import="com.dimeng.p2p.user.servlets.credit.Apply"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F20"%>
<%@page import="com.dimeng.p2p.S62.entities.T6230"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.JksqcxManage"%>
<%@page import="com.dimeng.p2p.common.enums.CreditType"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.dimeng.p2p.common.enums.CreditStatus"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.dimeng.p2p.user.servlets.AbstractUserServlet"%>
<%@include file="/WEB-INF/include/authenticatedSession.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%configureProvider.format(out,SystemVariable.SITE_NAME); %></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<%
		final int currentPage=IntegerParser.parse(request.getParameter(AbstractUserServlet.PAGING_CURRENT));
		Paging paging = new Paging() {
			
			@Override
			public int getSize() {
				return 10;
			}
	
			@Override
			public int getCurrentPage() {
				return currentPage;
			}
		};
		JksqcxManage manage = serviceSession.getService(JksqcxManage.class);
		PagingResult<T6230> applyLoans = manage.getApplyLoans(paging);
		CURRENT_CATEGORY = "JKGL";
		CURRENT_SUB_CATEGORY = "JKSQCX";
	%>
	<div class="contain clearfix">
		<div class="user_top"></div>
		<div class="about">
			<%@include file="/WEB-INF/include/menu.jsp"%>
			<form action="<%=controller.getViewURI(request, Apply.class)%>" method="post">
			<div class="container fr">
			  	<div id="funds" class="mainDiv bor1">
			<p class="title1" style="margin:0"><b>我的借款</b><a class="btnlsty" href="/user/credit/repaying.html">我要还款</a></p>
				<div class="tb-list">
				<div style="border-radius:0" class="newinfo">
				
					<table class="tableOdd mb10">
					  <tr>
						<th>项目名称 / 还款方式</th>
                        <th>借款总额</th>
						<th>借款年利率</th>
						<th>借款期限</th>
						<th>状态</th>
                        <th>操作</th>
					  </tr>
					  <%
						T6230[] ApplyLoanArr = applyLoans.getItems();
						if(ApplyLoanArr != null && ApplyLoanArr.length > 0){
							StringBuilder url = new StringBuilder();
							for(T6230 applyLoan : ApplyLoanArr){
								url.setLength(0);
								url.append(configureProvider.format(URLVariable.FINANCING_SBTZ_XQ));
								url.append(applyLoan.F01);
								url.append(rewriter.getViewSuffix());
								
						%>
						<tr> 
							<td>
								<%StringHelper.filterHTML(out, applyLoan.F03); %>/<%=applyLoan.F10.getChineseName() %>
							</td>
							<td><%=applyLoan.isSxbao == T6230_F13.F?Formater.formatAmount(applyLoan.F05):Formater.formatAmount(applyLoan.F05.subtract(applyLoan.F07))%></td>
							<td><%=Formater.formatRate(applyLoan.F06.doubleValue()) %></td>
							<td><%=applyLoan.F09>0?applyLoan.F09+"个月":applyLoan.F28.F22+"天"%></td>
							<td><%=applyLoan.F20.getChineseName() %></td>
							<td>
								<%if((applyLoan.F20 == T6230_F20.TBZ ||applyLoan.F20 == T6230_F20.YFB 
									||applyLoan.F20 == T6230_F20.DFK ||applyLoan.F20 == T6230_F20.HKZ 
									||applyLoan.F20 == T6230_F20.YJQ ||applyLoan.F20 == T6230_F20.YDF) && applyLoan.isSxbao == T6230_F13.F){ %>
								<a href="<%=url.toString() %>" target="_blank" class="blue">查看</a>
								<%} %>
							</td>
						</tr>
						<%}} %>
				   </table>
                </div>
             </div>   
<div class="page p15">
	<%AbstractUserServlet.rendPagingResult(out, applyLoans);%>
</div>

          </div>
        </div>    
			</form>
			<div class="clear"></div>
		</div>
	</div>
	
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
</body>
</html>