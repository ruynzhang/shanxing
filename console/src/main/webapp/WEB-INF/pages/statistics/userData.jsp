<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.statistics.UserData"%>
<%@page import="com.dimeng.p2p.modules.statistics.console.service.entity.UserMonthData"%>
<%@page import="com.dimeng.p2p.modules.statistics.console.service.entity.UserQuarterData"%>
<%@page import="com.dimeng.p2p.modules.statistics.console.service.UserDataManage"%>
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
		
		UserDataManage manage = serviceSession.getService(UserDataManage.class);
		UserQuarterData[] quarterDatas = manage.getUserQuarterData(year);
		UserMonthData[] monthDatas = manage.getUserMonthData(year);
		
		int[] options = manage.getStatisticedYears();
		
		CURRENT_CATEGORY = "TJGL";
		CURRENT_SUB_CATEGORY = "PTYHSJTJ";
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<div class="box box1 mb15">
							<div class="atil">
								<h3>平台用户数据统计</h3>
							</div>
							<div class="con">
								<div class="clear"></div>
								<form method="post" action="<%=controller.getURI(request, UserData.class) %>">
									<div class="table">
										<span>年份：</span>
										<span><select name="year" class="yhgl_sel yw_w1">
											<%if(options!=null && options.length>0){ 
												for(int option : options){
											%>
												<option value="<%=option %>" <%=year==option?"selected=\"selected\"":"" %>><%=option %>年</option>
											<%}}else{ %>
												<option><%=year %>年</option>
											<%} %>
										</select></span> 
										<input type="submit" class="btn2" value="搜索" />
									</div>
								</form>
								<div class="clear"></div>
							</div>
						</div>
						<div class="mb15">
							<div class="clear"></div>
						</div>
						<div class="box box1 mb15">
							<div class="con">
								<div class="f16 fB"><%=year %>年季度用户数据统计柱形图</div>
								<div class="hsxt"></div>
								<div class="clear"></div>
								<div class="tc mb30">
									<div id="quarter" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
								</div>
								<div class="f16 fB"><%=year %>年月份用户数据统计柱形图</div>
								<div class="hsxt"></div>
								<div class="clear"></div>
								<div class="tc mb30">
									<div id="month" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
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
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
</body>
<script type="text/javascript">
	var q0 = [0,0,0,0];
	var q1 = [0,0,0,0];
	var q2 = [0,0,0,0];
	var q3 = [0,0,0,0];
	<%
		for(UserQuarterData quarterData : quarterDatas){
	%>
		q0[<%=quarterData.quarter-1%>] = <%=quarterData.tbUserCount %>;
		q1[<%=quarterData.quarter-1%>] = <%=quarterData.jkUserCount %>;
		q2[<%=quarterData.quarter-1%>] = <%=quarterData.tbNewUserCount %>;
		q3[<%=quarterData.quarter-1%>] = <%=quarterData.jkNewUserCount %>;
	<%}%>
	var m0 = [0,0,0,0,0,0,0,0,0,0,0,0];
	var m1 = [0,0,0,0,0,0,0,0,0,0,0,0];
	var m2 = [0,0,0,0,0,0,0,0,0,0,0,0];
	var m3 = [0,0,0,0,0,0,0,0,0,0,0,0];
	<%for(UserMonthData monthData : monthDatas){%>
		m0[<%=monthData.month-1 %>] = <%=monthData.tbUserCount %>;
		m1[<%=monthData.month-1 %>] = <%=monthData.jkUserCount %>;
		m2[<%=monthData.month-1 %>] = <%=monthData.tbNewUserCount %>;
		m3[<%=monthData.month-1 %>] = <%=monthData.jkNewUserCount %>;
	<%}%>
</script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/highcharts.js"></script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/userData.js"></script>
</html>