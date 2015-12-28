<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.finance.xxczgl.AddXxcz"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
		CURRENT_CATEGORY = "CWGL";
		CURRENT_SUB_CATEGORY = "YHYECX";
		
		//UserAcctQueryEntity entity = (UserAcctQueryEntity)request.getAttribute("entity");
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<div class="box box1 mb15">
							<div class="atil">
								<h3>用户余额查询</h3>
							</div>
							<div class="con">
								<ul class="cell noborder yxjh ">
									<li>
										<div class="til">用户账户号：</div>
										<div class="info">
											${entity.nickName}
										</div>
										<div class="clear"></div>
									</li>
									<li>
										<div class="til">账户余额：</div>
										<div class="info">
											${entity.balance}
										</div>
										<div class="clear"></div>
									</li>
									<li>
										<div class="til">可用余额：</div>
										<div class="info">
											${entity.AvlBal}
										</div>
										<div class="clear"></div>
									</li>
									<li>
										<div class="til">冻结余额：</div>
										<div class="info">
											${entity.FrzBal}
										</div>
										<div class="clear"></div>
									</li>
								</ul>
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
</body>
</html>