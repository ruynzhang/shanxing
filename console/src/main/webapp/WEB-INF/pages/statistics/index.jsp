<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%CURRENT_CATEGORY = "TJGL";%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
	<div class="main clearfix">
		<div class="wrap">
	        <div class="r_main">
	            <div class="home_main">
	              <div class="box box1 mb15">
	                <div class="con">
	                  <ul class="yw_li">
	                    <li>
	                      <p class="f18">用户统计</p>
	                      <span class="dian"></span>统计平台用户数据，可实现投资人和借款人当前数量和新增等。统计平台在线用户每天每个整点时刻的在线人数。</li>
	                    <li>
	                      <p class="f18">资金统计</p>
	                      <span class="dian"></span>统计平台资金的收益和支出及其明细，统计风险保证金的收益和支出及其明细，统计用户充值和提现的金额。</li>
	                    <li>
	                      <p class="f18">业务统计</p>
	                      <span class="dian"></span>统计平台每个产品的成交量，根据地域时间进行不同分析。</li>
	                    <li>             
	                  </ul>
	                  <div class="clear"></div>
	                </div>
	              </div>
	              <div class="box2 clearfix"></div>
	            </div>
	        </div>   
	    </div>
		<%@include file="/WEB-INF/include/left.jsp" %>
	</div>
</div>
<%@include file="/WEB-INF/include/footer.jsp" %>
<%@include file="/WEB-INF/include/script.jsp" %>
</body>
</html>