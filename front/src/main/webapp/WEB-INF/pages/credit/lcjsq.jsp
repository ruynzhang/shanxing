<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.S62.enums.T6230_F10"%>
<html>
<head>
<title><%=configureProvider
						.getProperty(SystemVariable.SITE_TITLE)%></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="contain clearfix">
		<div class="contain_main">
			<div class="login">
				<div class="pub_title">理财计算器</div>
				<form action="" method="get" class="form1">
					<div style="width: 700px; margin: 0 auto;">
						<ul class="electric clearfix">
							<li>
								<div class="list_w">出借金额：</div>
								<div>
									<input name="" type="text" class="text jejs required isint"  maxlength="15"/>
									<p tip style="font-size:12px;"></p>
									<p errortip class="" style="display: none"></p>
								</div>
							</li>
							<li style="width:350px;">
								<div class="list_w">年利率：</div>
								<div>
									<input name="rating" type="text" class="text required jejs"  mtest="/^\d+(\d?|(\.[0-9]{1}))$/" mtestmsg="只能有一位小数"  value="0"/>%
									<p tip style="font-size:12px;">利率精确到小数点后一位</p>
									<p id="nll" errortip class="" style="display: none"></p>
								</div>
							</li>
							<li>
								<div class="list_w">借款期限：</div>
								<div>
									 <select name="select" id="select" class="area jejs">
									<%
										for(int i=1;i<=36;i++)
										{
									%>
										<option value="<%=i %>"><%=i %>个月</option>
									<%} %>
                  					 </select>
								</div>
							</li>
							<li>
								<div class="list_w">还款方式：</div>
								<div>
									 <select name="select" id="select" class="area jejs">
									<%for(T6230_F10 f10:T6230_F10.values()){ %>
										<%if(f10 == T6230_F10.DEBX){ %>
										<option value="<%=f10 %>" selected="selected"><%=f10.getChineseName() %></option>
										<%}else{ %>
										<option value="<%=f10 %>"><%=f10.getChineseName() %></option>
										<%} %>
									<%} %>
                  					 </select>
									<!-- <label for="select"></label>等额本息 -->
								</div>
							</li>
						</ul>
						<div class="elect_btn tc">
							<input type="button" class="big_btn big_btn01 f16 jsqks" fromname="form1" value="开始计算" />
						</div>
					</div>
					<div class="elect_info" style="display: none;" id="showjs">
						<p class="pt20 pb20 f18">收益描述</p>
						<table width="85%" border="0" cellspacing="0" class="level_table">
							<tr>
								<td>出借金额</td>
								<td><span id="mtoal">0.0</span>元</td>
								<td>应收利息</td>
								<td><span id="ghbx">0.0</span>元</td>
							</tr>
							<tr>
								<td colspan="2">您将在<span class="red mr5 ml5 f18" id="mthns">3</span>个月后收回全部本息</td>
							</tr>

						</table>
						<p class="pt20 pb20 f18">本息回收时间表</p>
						<table width="85%" border="0" cellspacing="0" class="level_table jstr">
							
						</table>
						<div class="elect_btn tc" style="margin-left: -85px;">
						</div>
					</div>
					<div class="elect_info">
						● 等额本息：等额本息还款法是在每月还款期内，每月偿还同等金额的借款（包括本金和利息）。借款人每月还款额中的本金比重逐月递增，利息比重逐月递减。<br />
						● 按月付息、到期还本：按月付息、到期还本还款法是指每月偿还相同额度的利息，借款到期日一次性归还借款本金。<br /> 
						● 一次还本付息：一次还本付息还款法是指在借款期内不是按月偿还本息，而是借款到期后一次性归还本金和利息。<br /> 
						● 等额本金：等额本金还款法是指在还款期内把借款总额等分，每月偿还同等数额的本金和剩余借款在该月所产生的利息，每月的还款本金额固定，而利息越来越少。<br />  
						●使用利息计算器，能帮您计算每月的本息情况；同时，一份完整的本息偿还时间表，让您 能更直观地了解还款本息详情 。<br />

					</div>
				</form>
			</div>
		</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript"
	src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
	<script type="text/javascript"
	src="<%=controller.getStaticPath(request)%>/js/lcjsq.js"></script>
	<script type="text/javascript">
		onHover=function(){
			$(".sx_menu>a").removeClass("hover");
			$("#nav_1").addClass("hover");
		}
		window.onload=function(){onHover();}
	</script>
</body>
</html>
