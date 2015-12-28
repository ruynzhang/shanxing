<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.escrow.huifu.entity.TransStatQueryEntity"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
		CURRENT_CATEGORY = "CWGL";
		CURRENT_SUB_CATEGORY = "JYZTCX";
		
		TransStatQueryEntity entity = (TransStatQueryEntity)request.getAttribute("entity");
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<div class="box box1 mb15">
							<div class="atil">
								<h3>订单<%=entity.OrdId %>交易状态</h3>
							</div>
							<div class="con">
								<ul class="cell noborder yxjh ">
									<li>
										<div class="til">订单号：</div>
										<div class="info">
											<%=entity.OrdId %>
										</div>
										<div class="clear"></div>
									</li>
									<li>
										<div class="til">订单类型：</div>
										<div class="info">
											<%="REPAYMENT".equals(entity.QueryTransType)?"还款定单":"放款订单" %>
										</div>
										<div class="clear"></div>
									</li>
									<li>
										<div class="til">订单时间：</div>
										<div class="info">
											<%=entity.OrdDate %>
										</div>
										<div class="clear"></div>
									</li>
									<li>
										<div class="til">订单状态：</div>
										<div class="info">
											<%
												if("S".equals(entity.TransStat)){
													out.print("成功");
												}else if("F".equals(entity.TransStat)){
													out.print("失败");
												}else if("I".equals(entity.TransStat)){
													out.print("初始");
												}else if("P".equals(entity.TransStat)){
													out.print("部分成功");
												}else if("H".equals(entity.TransStat)){
													out.print("经办");
												}else if("R".equals(entity.TransStat)){
													out.print("拒绝");
												}
											%>
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