<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.S61.entities.T6161"%>
<%@page import="com.dimeng.p2p.console.servlets.statistics.RiskFundsExport"%>
<%@page import="com.dimeng.util.Formater"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.dimeng.p2p.console.servlets.statistics.RiskFunds"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.dimeng.p2p.modules.statistics.console.service.entity.YearRiskFunds"%>
<%@page import="com.dimeng.p2p.modules.statistics.console.service.entity.QuarterFunds"%>
<%@page import="com.dimeng.p2p.modules.statistics.console.service.RiskFundsManage"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
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
int orgId = request.getParameter("org")==null?-1:IntegerParser.parse(request.getParameter("org"));
RiskFundsManage manage = serviceSession.getService(RiskFundsManage.class);
QuarterFunds[] quarterFunds = manage.getQuarterFunds(orgId ,year);
YearRiskFunds yearRiskFunds = manage.getYearRiskFunds(orgId ,year);
BigDecimal inTotal = new BigDecimal(0);
BigDecimal outTotal = new BigDecimal(0);
BigDecimal sumTotal = new BigDecimal(0);
for(QuarterFunds funds : quarterFunds){
	inTotal=inTotal.add(funds.amountIn);
	outTotal=outTotal.add(funds.amountOut);
	sumTotal=sumTotal.add(funds.sum);
}

int[] options = manage.getStatisticedYear();
T6161[] orgList = manage.selectT6161();

CURRENT_CATEGORY = "TJGL";
CURRENT_SUB_CATEGORY = "FXBZJTJ";
%>
<%@include file="/WEB-INF/include/header.jsp" %>
<div class="w_main">
  <div class="main clearfix">
  	<div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>风险保证金统计</h3>
                  </div>
                    <div class="con">
                    <div class="clear"></div>
                    <form action="<%=controller.getURI(request,RiskFunds.class) %>" method="post">
                    <div class="table">
                    <span>平台/机构：</span>
                    <span>
                    	<select name="org" class="yhgl_sel yw_w1">
                    		<option value="-1" <%=-1==orgId?"selected=\"selected\"":"" %>>全部</option>
                    		<% 
                    			if(orgList!=null){
                    			for(T6161 org : orgList){ 
                    			if(org == null){
                    				continue;
                    			}
                    			%>
                    			<option value="<%=org.F01 %>" <%=org.F01==orgId?"selected=\"selected\"":"" %>><%StringHelper.filterHTML(out, org.F04); %></option>
                    		<%}} %>
                    	</select>
                    </span>
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
                    	<input name="input" type="submit" class="btn2 mr10" value="搜索" />
                    	<%if(dimengSession.isAccessableResource(RiskFundsExport.class)){ %>
                    	<a href="<%=controller.getURI(request, RiskFundsExport.class) %>?orgId=<%=orgId %>&year=<%=year %>" class="btn3"><span class="ico"></span>导出</a>
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
                    <div class="f16 fB"><%=year %>年季度平台风险保证金统计折线图</div>
                    <div class="hsxt"></div>
                    <div class="clear"></div>
                    <p>
                    <ul>
                    <li><span class="tj_zc"></span></li>
                    </ul>
                    <div class="tc mb30">
						<div id="line" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
					</div>
                    <%-- <div class="f16 fB"><%=year %>年平台风险保证金统计柱形图</div>
                    <div class="hsxt"></div>
                    <div class="clear"></div>
                    <div class="tc mb30">
                    	<!-- <div id="column" style="min-width: 310px; height: 400px; margin: 0 auto"></div> -->
                    </div>
                     <div class="clear"></div> --%>
                  </div>
              </div>
              <div class="box2 clearfix"></div>
            </div>
        </div>   
    </div>
  	<%@include file="/WEB-INF/include/left.jsp" %>
  </div>
</div>

<%@include file="/WEB-INF/include/footer.jsp"%>
<%@include file="/WEB-INF/include/script.jsp" %>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/highcharts.js"></script>

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
var data = [{name: '垫付',data:[<%=yearRiskFunds.df %>]},
            {name: '垫付返还',data:[<%=yearRiskFunds.dffh %>]},
            {name: '借款成交服务费',data:[<%=yearRiskFunds.jkcjfwf %>]},
            {name: '手动增加保证金',data:[<%=yearRiskFunds.sdzjbzj %>]},
            {name: '手动扣除保证金',data:[<%=yearRiskFunds.sdkcbzj %>]}];
            
$(function(){
	  $('#line').highcharts({
        title: {
            text: '',
            x: -20 
        },
        subtitle: {
            text: '',
            x: -20
        },
        xAxis: {
            categories: ['一季度','二季度','三季度','四季度']
        },
        yAxis: {
            title: {
                text: '金额（元）'
            },
            plotLines: [{
                value: 0,
                width: 1,
                color: '#808080'
            }]
        },
        credits: {
            enabled: false
        },
        tooltip: {
            valueSuffix: '元'
        },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'middle',
            borderWidth: 0
        },
        series: [{
            name: '支出',
            data: amountIn
        }, {
            name: '收入',
            data: amountOut
        }, {
            name: '盈亏',
            data: amountSum
        }, {
            name: '余额',
            data: amountBalance
        }]
    });
});
            
</script>

</body>
</html>