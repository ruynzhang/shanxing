<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.variables.P2PConst"%>
<%@page import="com.dimeng.framework.http.service.UserStatisticsManage"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<% 
	java.sql.Date date = SQLDateParser.parse(request.getParameter("date"));
	if(date==null){
		date = new java.sql.Date(System.currentTimeMillis());
	}
	UserStatisticsManage manage = serviceSession.getService(UserStatisticsManage.class);
	int[] onlineDatas = manage.getOnlineHistory(date,P2PConst.DB_USER_SESSION);

	CURRENT_CATEGORY = "TJGL";
	CURRENT_SUB_CATEGORY = "PTZXYHTJ";
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
	<div class="main clearfix">
		<div class="wrap">
			<div class="r_main">
				<div class="home_main">
					<div class="box box1 mb15">
						<div class="atil">
							<h3>平台在线用户统计</h3>
						</div>
						<div class="con">
							<div class="clear"></div>
							<form method="post" action="<%=controller.getURI(request, UserOnline.class) %>">
								<div class="table">
									<span>时间：</span>
									<span><input type="text" class="yhgl_input date" id="datepicker" readonly="readonly" name="date" value="<%=DateParser.format(date) %>" /></span> 
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
							<div class="f16 fB"><%=DateParser.format(date) %>平台在线用户统计曲线图</div>
							<div class="hsxt"></div>
							<div class="clear"></div>
							<div class="tc mb30">
								<div id="container" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
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
<script type="text/javascript">var data = [<%boolean notFirst=false;for(int onlineData : onlineDatas){if(notFirst){out.print(',');}else{notFirst=true;}out.print(Integer.toString(onlineData));}%>]</script>
<%@include file="/WEB-INF/include/footer.jsp"%>
<%@include file="/WEB-INF/include/script.jsp"%>
<%@include file="/WEB-INF/include/datepicker.jsp"%>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/highcharts.js"></script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/userOnline.js"></script>
<script type="text/javascript">
	$("#datepicker").datepicker({inline: true});
	$('#datepicker').datepicker('option', {dateFormat:'yy-mm-dd'});
	$('#datepicker').datepicker('setDate', "<%=DateParser.format(date) %>");
</script>
</body>
</html>