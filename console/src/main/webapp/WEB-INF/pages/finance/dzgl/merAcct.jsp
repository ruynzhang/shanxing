<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.List"%>
<%@page import="com.dimeng.p2p.escrow.huifu.entity.MerAcctItem"%>
<%@page import="com.dimeng.p2p.escrow.huifu.entity.MerAcctQueryEntity"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
		CURRENT_CATEGORY = "CWGL";
		CURRENT_SUB_CATEGORY = "SHZHXXCX";
		
		MerAcctQueryEntity entity = (MerAcctQueryEntity)request.getAttribute("entity");
		List<MerAcctItem> items = entity.AcctDetails;
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<div class="box box1 mb15">
							<div class="atil">
								<h3>商户账户信息查询</h3>
							</div>
							<div class="con">
								<ul class="cell noborder yxjh ">
									<%if(items != null){
										for(MerAcctItem item : items){
									%>
										<li>
											<div class="til">账户类型：</div>
											<div class="info">
												<%
													if("BASEDT".equals(item.AcctType)){
														out.print("基本借记户");
													}else if("MERDT".equals(item.AcctType)){
														out.print("专属借记账户");
													}else{
														out.print("保证金账户");
													}
												%>
											</div>
											<div class="clear"></div>
										</li>
										<li>
												<div class="til">子账户号：</div>
												<div class="info">
													<%=item.SubAcctId %>
												</div>
												<div class="clear"></div>
											</li>
											<li>
											<div class="til">账户余额：</div>
											<div class="info">
												<%=item.AcctBal %>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">可用余额：</div>
											<div class="info">
												<%=item.AvlBal %>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">冻结余额：</div>
											<div class="info">
												<%=item.FrzBal %>
											</div>
											<div class="clear"></div>
										</li>
										<li style="border: solid 1px gray;"></li>
									<%}} %>
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