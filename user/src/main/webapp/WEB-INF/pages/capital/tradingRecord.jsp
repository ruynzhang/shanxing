<%@page import="com.dimeng.p2p.user.servlets.capital.OrderServlet"%>
<%@page import="com.dimeng.p2p.modules.base.front.service.TradeTypeManage"%>
<%@page import="com.dimeng.p2p.S51.entities.T5122"%>
<%@page import="com.dimeng.p2p.FeeCode"%>
<%@page import="com.dimeng.p2p.account.user.service.entity.CapitalLs"%>
<%@page import="com.dimeng.p2p.S61.enums.T6101_F03"%>
<%@page import="com.dimeng.p2p.account.user.service.ZjlsManage"%>
<%@page import="com.dimeng.p2p.user.servlets.capital.TradingRecordExport"%>
<%@page import="com.dimeng.p2p.user.servlets.Index"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.dimeng.p2p.common.enums.TradeType"%>
<%@page import="java.util.Date"%>
<%@page import="com.dimeng.p2p.user.servlets.AbstractUserServlet"%>
<%@page import="com.dimeng.p2p.common.enums.TradingType"%>
<%@page import="com.dimeng.p2p.user.servlets.capital.Withdraw"%>
<%@page import="com.dimeng.p2p.user.servlets.capital.Charge"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.dimeng.p2p.user.servlets.capital.TradingRecord"%>
<%@include file="/WEB-INF/include/authenticatedSession.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>我的
<%
	configureProvider.format(out,SystemVariable.SITE_NAME);
%>
_交易记录</title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%@include file="/WEB-INF/include/header.jsp"%>
<%
		int tradingType = IntegerParser.parse(request.getParameter("tradingType"));
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String zhlx = StringHelper.isEmpty(request.getParameter("zhlx"))?"WLZH":request.getParameter("zhlx") ;
		final int currentPage = IntegerParser.parse(request.getParameter("paging.current"));
		
		Date sTime = DateParser.parse(startTime);
		Date eTime = DateParser.parse(endTime);
		Paging paging = new Paging() {
			
			@Override
			public int getSize() {
				return 10;
			}
			
			@Override
			public int getCurrentPage() {
				return currentPage;
			}
		};
		
		ZjlsManage manage = serviceSession.getService(ZjlsManage.class);
		
		T6101_F03 f03 = null;
		if(!StringHelper.isEmpty(zhlx)){
			f03 = T6101_F03.valueOf(zhlx);
		}else{
			f03 = T6101_F03.WLZH;
		}
		
		PagingResult<CapitalLs> tradingRecords = manage.searchLs(tradingType, sTime, eTime,f03, paging);
		
		CURRENT_CATEGORY = "ZJGL";
		CURRENT_SUB_CATEGORY = "JYJL";
	%>
<div class="contain clearfix">
  <div class="user_top"></div>
  <form action="<%=controller.getViewURI(request, TradingRecord.class)%>" method="post">
    <div class="about">
      <%@include file="/WEB-INF/include/menu.jsp"%>
      <div class="container fr mb10">
        <div class="mainDiv bor1"> 
          <!--理财管理 S-->
          <div class="tb-state"> <span>
            <select class="inputStyle" id="tradingType" name="tradingType">
              <option selected="selected" value="0">--全部--</option>
              <option value="1001" >充值</option>
				<option value="1002" >充值手续费</option>
				<option value="1003" >充值成本</option>
				<option value="1201" >成交服务费</option>
				<option value="1202" >理财管理费</option>
				<option value="1203" >借款管理费</option>
				<option value="1701" >平台划拨</option>
				<option value="2001" >提现</option>
				<option value="2003" >提现成本</option>
				<option value="3001" >投标</option>
				<option value="3002" >投标撤销</option>
				<option value="4001" >债权转让手续费</option>
				<option value="4002" >卖出债权</option>
				<option value="4003" >买入债权</option>
				<option value="6001" >借款</option>
				<option value="7001" >本金</option>
				<option value="7002" >利息</option>
				<option value="7003" >逾期管理费</option>
				<option value="7004" >逾期罚息</option>
				<option value="7005" >提前还款违约金</option>
				<option value="7008" >惊喜奖返现</option>
				<option value="9003" >体验利息</option>
            </select>
            </span> <span>
            <input type="text" id="startDate" name="startTime" readonly class="date w100 yhgl_ser" />
            </span> <span>
            <input type="text" id="endDate" name="endTime" readonly class="date w100 yhgl_ser" />
            </span>
            <input type="submit" id="querybutton" name="" value="查询" class="butStyle editquestion">
            &nbsp;&nbsp; 
            <!-- 	<input type="button" value="报表导出" id="exprot" class="butStyle editquestion"/> --> 
          </div>
        </div>
        <div id="funds" class="mainDiv bor1 min400">
          <p class="title1"> <b>资金明细</b> </p>
          <div class="tb-list">
            <table class="tableOdd">
              <tbody>
                <tr>
                  <th width="15%">时间</th>
                  <th width="10%">类型</th>
                  <th width="10%">收入（元）</th>
                  <th width="10%">支出（元）</th>
                  <th width="15%">结余（元）</th>
                  <th width="40%">备注</th>
                </tr>
                <%
                TradeTypeManage tradeTypeManage = serviceSession.getService(TradeTypeManage.class);
						if(tradingRecords!=null){
							CapitalLs[] entities = tradingRecords.getItems();
							if(entities!=null && entities.length>0){
								for(CapitalLs entity : entities){
									if(entity == null){
										continue;
									}
				%>
                <tr class="tab6TD">
                  <td><%=DateTimeParser.format(entity.F05,"yyyy-MM-dd HH:mm") %></td>
                  <td><%=tradeTypeManage.get(entity.F03) %></td>
                  <td style="color: green;"><%=entity.F06.compareTo(BigDecimal.ZERO)==1?"￥"+Formater.formatAmount(entity.F06):"" %></td>
                  <td style="color: red;"><%=entity.F07.compareTo(BigDecimal.ZERO)==1?"￥"+Formater.formatAmount(entity.F07):"" %></td>
                  <td>￥<%=Formater.formatAmount(entity.F08) %></td>
                  <td><span class="remark"><%StringHelper.filterHTML(out, entity.F09);%></span></td>
                </tr>
                <%}}} %>
              </tbody>
            </table>
          </div>
                    <div class="page">
							<%AbstractUserServlet.rendPagingResult(out, tradingRecords); %>
					</div>
        </div>
      </div>
      <div class="clear"></div>
    </div>
  </form>
</div>
<%@include file="/WEB-INF/include/footer.jsp"%>
<%@include file="/WEB-INF/include/script.jsp"%>
<%@include file="/WEB-INF/include/datepicker.jsp"%>
<script type="text/javascript">
$("#tradingType option[value="+<%=request.getParameter("tradingType")%>+"]").attr("selected",true);
		$(function() {
			$("#startDate").datepicker({inline: true,
				onSelect : function(selectedDate) {
		            $("#endDate").datepicker("option", "minDate", selectedDate); 
		        }
		});
		    $('#startDate').datepicker('setDate', "<%StringHelper.filterQuoter(out, startTime); %>");
		    $("#endDate").datepicker({inline: true});
		    $('#endDate').datepicker('setDate', "<%StringHelper.filterQuoter(out, endTime); %>");
		    $("#endDate").datepicker('option', 'minDate',$("#startDate").datepicker().val());
		});
	</script>
</body>
</html>