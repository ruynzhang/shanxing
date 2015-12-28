<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.statistics.FundsExport"%>
<%@page import="com.dimeng.util.Formater"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.dimeng.p2p.modules.statistics.console.service.entity.YearFunds"%>
<%@page import="com.dimeng.p2p.console.servlets.statistics.Funds"%>
<%@page import="com.dimeng.p2p.modules.statistics.console.service.entity.QuarterFunds"%>
<%@page import="com.dimeng.p2p.modules.statistics.console.service.FundsManage"%>
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
	FundsManage manage = serviceSession.getService(FundsManage.class);
	QuarterFunds[] quarterFunds = manage.getQuarterFunds(year);
 	BigDecimal inTotal = new BigDecimal(0);
	BigDecimal outTotal = new BigDecimal(0);
	BigDecimal sumTotal = new BigDecimal(0);
	for(QuarterFunds funds : quarterFunds){
		inTotal=inTotal.add(funds.amountIn);
		outTotal=outTotal.add(funds.amountOut);
		sumTotal=sumTotal.add(funds.sum);
	}
	
	YearFunds yearFunds = manage.getYearFunds(year);
	int[] options = manage.getStatisticedYear();
	
	
	DecimalFormat format = new DecimalFormat("#,##0.00");

	CURRENT_CATEGORY = "TJGL";
	CURRENT_SUB_CATEGORY = "PTZJTJ";
%>
<%@include file="/WEB-INF/include/header.jsp" %>
<div class="w_main">
  <div class="main clearfix">
  	<div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>平台资金统计</h3>
                  </div>
                    <div class="con">
                    <div class="clear"></div>
                    <form action="<%=controller.getURI(request, Funds.class) %>" method="post">
                    <div class="table">
                    <span>年份：</span>
                    <span>
                    	<select name="year" class="yhgl_sel yw_w1">
                    		<%if(options!=null && options.length>0){
                    			for(int option : options){
                    		%>
                    			<option value="<%=option %>" <%=year==option?"selected=\"selected\"":"" %>><%=option %>年</option>
                    		<%}}else{ %>
                    			<option><%=year %>年</option>
                    		<%} %>
                    	</select>
                    </span>
                     <div class="clear"></div>   
                    <div class="mt10">   
                    	 <input name="input" type="button" class="btn2 mr10" value="搜索" />
                    	 <%if(dimengSession.isAccessableResource(FundsExport.class)){ %>
                    	<a href="<%=controller.getURI(request, FundsExport.class) %>?year=<%=year %>" class="btn3"><span class="ico"></span>导出</a>
                 		<%} else {%>
						 <span class="btn3 mr10 btn5"><span class="ico"></span>导出</span>
						<%} %>
                   </div>               
                    </div>                    	 
                    </form>
                    <div class="clear"></div>               
                  </div>
                </div>
              <div class="mb15">
              <table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
                <tr class="hsbg">
                  <td>&nbsp;</td>
                  <td>一季度</td>
                  <td>二季度</td>
                  <td>三季度</td>
                  <td>四季度</td>
                  <td>合计</td>
                </tr>
                <tr class="dhsbg">
                  <td>收入</td>
                  <td><%=Formater.formatAmount(quarterFunds[0].amountIn) %></td>
                  <td><%=Formater.formatAmount(quarterFunds[1].amountIn) %></td>
                  <td><%=Formater.formatAmount(quarterFunds[2].amountIn) %></td>
                  <td><%=Formater.formatAmount(quarterFunds[3].amountIn) %></td>
                  <td><%=Formater.formatAmount(inTotal) %></td>
                </tr>
                <tr class="dhsbg">
                  <td>支出</td>
                  <td><%=Formater.formatAmount(quarterFunds[0].amountOut) %> </td>
                  <td><%=Formater.formatAmount(quarterFunds[1].amountOut) %></td>
                  <td><%=Formater.formatAmount(quarterFunds[2].amountOut) %></td>
                  <td><%=Formater.formatAmount(quarterFunds[3].amountOut) %></td>
                  <td><%=Formater.formatAmount(outTotal) %></td>
                </tr>
                <tr class="dhsbg">
                  <td>盈亏</td>
                  <td><%=Formater.formatAmount(quarterFunds[0].sum) %> </td>
                  <td><%=Formater.formatAmount(quarterFunds[1].sum) %></td>
                  <td><%=Formater.formatAmount(quarterFunds[2].sum) %></td>
                  <td><%=Formater.formatAmount(quarterFunds[3].sum) %></td>
                  <td><%=Formater.formatAmount(sumTotal) %></td>
                </tr>
              </table>
              </div>
              <div class="box box1 mb15">
                  <div class="con">
                    <div class="f16 fB"><%=year %>年季度平台资金统计折线图</div>
                    <div class="hsxt"></div>
                    <div class="clear"></div>
                    <p>
                    <ul>
                    <li><span class="tj_zc"></span></li>
                    </ul>
                    <div class="tc mb30">
						<div id="line" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
					</div>
                    <div class="f16 fB"><%=year %>年平台资金统计柱形图</div>
                    <div class="hsxt"></div>
                    <div class="clear"></div>
                    <div class="tc mb30">
                    	<div id="column" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
                    </div>
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
<script type="text/javascript">
	var amountIn = [0,0,0,0];
	var amountOut = [0,0,0,0];
	var amountSum = [0,0,0,0];
	var amountBalance = [0,0,0,0];
	<%for(QuarterFunds funds : quarterFunds){
		if(funds.quarter == 0) continue;
	%>
		amountIn[<%=funds.quarter-1%>] = <%=funds.amountOut%>;
		amountOut[<%=funds.quarter-1%>] = <%=funds.amountIn%>;
		amountSum[<%=funds.quarter-1%>] = <%=funds.sum%>;
	<%}%>
	var data = [{name:'充值手续费',data:[<%=yearFunds.czsxf %>]},
	            {name:'提现手续费',data:[<%=yearFunds.txsxf %>]},
	            {name:'充值成本',data:[-<%=yearFunds.czcb %>] },
	            {name:'提现成本',data:[-<%=yearFunds.txcb %>] },
	            {name:'逾期管理费',data:[<%=yearFunds.yqglf %>] },
	            {name:'债权转让费用',data:[<%=yearFunds.zqzrf %>] }
	            ];
</script>
<%@include file="/WEB-INF/include/footer.jsp"%>
<%@include file="/WEB-INF/include/script.jsp" %>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/highcharts.js"></script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/funds.js"></script>
</html>