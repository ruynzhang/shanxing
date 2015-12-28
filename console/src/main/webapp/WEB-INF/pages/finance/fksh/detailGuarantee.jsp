<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.ViewGuarantee"%>
<%@page import="com.dimeng.p2p.S62.entities.T6237"%>
<%@page import="com.dimeng.p2p.S62.entities.T6236"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F13"%>
<%@page import="com.dimeng.p2p.S62.entities.T6230"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F11"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F06"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.Jg"%>
<%@page import="com.dimeng.p2p.modules.bid.console.service.entity.Dbxx"%>
<%@page import="com.dimeng.p2p.common.enums.LoanType"%>
<%@page import="com.dimeng.p2p.S70.entities.T7029"%>
<%@page import="com.dimeng.p2p.S60.entities.T6215"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
		CURRENT_CATEGORY = "CWGL";
		CURRENT_SUB_CATEGORY = "FKGL";
		int loanId = IntegerParser
				.parse(request.getParameter("loanId"));
		int userId = IntegerParser
				.parse(request.getParameter("userId"));
		int id = IntegerParser
				.parse(request.getParameter("id"));
		int type = IntegerParser
				.parse(request.getParameter("type"));
		Dbxx t6236 =ObjectHelper.convert(request.getAttribute("t6236"), Dbxx.class);
		T6237 t6237 =ObjectHelper.convert(request.getAttribute("t6237"), T6237.class);
		String des=ObjectHelper.convert(request.getAttribute("des"), String.class);
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<div class="box box1 mb15">
							<div class="atil">
								<h3>查看抵押物信息</h3>
							</div>
							<div class="con">
								<div class="clear"></div>
									<div class="border p30 Men_bt no_table">
									<div class="f16">风险控制</div>
									<div class="hsxt"></div>
									<div class="mb20">
										<div class="yw_jcxx">
											<ul class="cell noborder">
												<li>
													<div class="til">
														<span class="red">*</span>担保公司：
													</div>
													<div class="info">
														<%StringHelper.filterHTML(out, t6236.F06); %>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">担保资质描述：</div>
													<div class="info">
														<%StringHelper.filterHTML(out, des); %>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">担保情况：</div>
													<div class="info">
														<%StringHelper.filterHTML(out, t6236.F05); %>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">反担保情况：</div>
													<div class="info">
														<%StringHelper.filterHTML(out, t6237.F03); %>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">风险控制综述：</div>
													<div class="info">
														<%StringHelper.filterHTML(out, t6237.F02); %>
													</div>
													<div class="clear"></div>
												</li>
											</ul>
											<div class="tc w220 pt20">
												<a href="<%=controller.getURI(request, ViewGuarantee.class) %>?loanId=<%=loanId %>&userId=<%=userId %>" class="btn4">返回</a>
											</div>
										</div>
									</div>
									</div>
									<div class="clear"></div>
								<div class="clear"></div>
							</div>
						</div>
						<div class="box2 clearfix"></div>
					</div>
				</div>
			</div>
			<%@include file="/WEB-INF/include/left.jsp"%>
		</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
</body>
</html>