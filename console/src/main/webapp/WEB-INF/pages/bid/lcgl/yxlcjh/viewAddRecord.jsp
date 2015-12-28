<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.lcgl.yxlcjh.ViewPlanMoney"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.lcgl.yxlcjh.ViewAddRecord"%>
<%@page import="com.dimeng.p2p.S64.enums.T6410_F07"%>
<%@page import="com.dimeng.p2p.modules.financial.console.service.entity.PlanAddRecord"%>
<%@page import="com.dimeng.p2p.modules.financial.console.service.entity.PlanMoneyView"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%
	CURRENT_CATEGORY="YWGL";
	CURRENT_SUB_CATEGORY="YXLCJH";
	PlanMoneyView planMoneyView = (PlanMoneyView)request.getAttribute("planMoneyView");
	PagingResult<PlanAddRecord> pagingResult = (PagingResult<PlanAddRecord>)request.getAttribute("planAddRecords");
	PlanAddRecord[] pagingResultArray = pagingResult.getItems();
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
  <div class="main clearfix">
    <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<div class="box box1 mb15">
          <div class="atil">
            <h3>优选理财计划</h3>
          </div>
          <div class="con">
            <div class="clear"></div>
            <div class="contain_main clearfix">
              <div class="pub_title clearfix"> <span class="fl"><span class="f16 fB"><%StringHelper.filterHTML(out, planMoneyView.planName);%></span></span></div>
              <div class="hsxt"></div>
              <div class="plan_given clearfix">
                <ul class="cend w490 fl clearfix">
                  <li><div>计划金额：<%=Formater.formatAmount(planMoneyView.planMoneys) %>元</div><div>预期收益：<%=Formater.formatRate(planMoneyView.expectEarnings) %> 每年</div></li>
                  <li><div><span class="fl">投标范围：</span><%StringHelper.filterHTML(out, planMoneyView.tblxmc); %></div><div>保障方式：<%=planMoneyView.safeguardWay.getChineseName() %></div></li>
                  <li class="mb10">
                  	<div>计划状态：
	              		<%if(planMoneyView.state == T6410_F07.YFB && planMoneyView.planStart.after(planMoneyView.currentTime)){%>
							预售中
						<%}else if(planMoneyView.state == T6410_F07.YFB && !planMoneyView.planStart.after(planMoneyView.currentTime)){%>
							申请中
						<%}else if(planMoneyView.state == T6410_F07.YSX){%>
							已满额
						<%}else if(planMoneyView.state == T6410_F07.YJZ){%>
							已截止
						<%}%>
                  	</div>
                  
                  
                  <%
                  if(planMoneyView.state == T6410_F07.YFB && planMoneyView.planStart.after(planMoneyView.currentTime)){
                	  							long hm=1000*3600*24;
												long time =planMoneyView.planStart.getTime() -	planMoneyView.currentTime.getTime();
												long day=time/hm;
												long hour=(time-day*hm)/(1000*3600);
												long min=(time-day*hm-hour*1000*3600)/(1000*60);
						%>
						<div>距离发售：<%=day%>天<%=hour%>小时<%=min%>分</div>
						<%
							}else if(planMoneyView.state == T6410_F07.YSX || planMoneyView.state == T6410_F07.YJZ){	
												long hm=3600*24;
												long time =	planMoneyView.fullTime;
												long day=time/hm;
												long hour=(time-day*hm)/3600;
												long min=(time-day*hm-hour*3600)/60;
												long ss=time-day*hm-hour*3600-min*60;
						%>
					<div>满额用时：<%=day%>天<%=hour%>时<%=min%>分<%=ss%>秒</div>
						<%
							}else if(planMoneyView.state == T6410_F07.YFB && !(planMoneyView.planStart.after(planMoneyView.currentTime))){
												long hm=1000*3600*24;
												long time =	planMoneyView.planEnd.getTime()-planMoneyView.currentTime.getTime();
												long day=time/hm;
												long hour=(time-day*hm)/(1000*3600);
												long min=(time-day*hm-hour*1000*3600)/(1000*60);
						%>
						<div>距离截止：<%=day%>天<%=hour%>小时<%=min%>分</div>
						<%
							}
						%>
                  
                  
                  </li>                  
                  <li class="mb10"><div>锁定期限：<%=planMoneyView.lockTime %>个月</div>
                  	<div>锁定结束：<%=DateParser.format(planMoneyView.lockEndTime) %></div></li>
                  <div class="cass"><div>收益处理：<%=planMoneyView.earningsWay.getChineseName()%></div><div>费率说明：本期计划费用如下</div></div>
                  <li class="mb10" style="border:0"><div>&nbsp;</div> 
                  <div>                 
                  <p class="cen_d">加入费率 <%=Formater.formatRate(planMoneyView.addRate)%><br />
                  	服务费率  <%=Formater.formatRate(planMoneyView.serveRate)%><br />
                 	 退出费率 <%=Formater.formatRate(planMoneyView.quitRate)%></p>
                  </div>
                 <li>
                </ul>
                <div class="fr submission mt15">
                  
                    <div class="text">
                      <ul class="text_li">
                      <li>剩余金额：<span class="f18 gray3"><%=Formater.formatAmount(planMoneyView.residueMoney) %>元</span></li>
                      <li>每人可加入金额上限：<br /><span class="f18 gray3"><%=Formater.formatAmount(planMoneyView.investCeiling) %>元</span></li>
                      <li>每人可加入金额下限：<br /><span class="f18 gray3"><%=Formater.formatAmount(planMoneyView.investFloor) %>元</span></li>
                      </ul>
                     </div>
                 
                </div>
              </div>
            </div>
            <div class="clear"></div>
          </div>
        </div>
        	<form id="form1" name="form1" method="post" action="<%=controller.getURI(request, ViewAddRecord.class)%>">
        		<input type="hidden" name="planMoneyId" value="<%=planMoneyView.planMoneyId%>"/>
           	  <div class="newsbox">
           	    <div class="til clearfix">
           	      <div class="Menubox">
           	        <ul>
           	          <li id="one1" onclick="window.location.href='<%=controller.getURI(request, ViewPlanMoney.class)%>?planMoneyId=<%=planMoneyView.planMoneyId%>'" >计划介绍</li>
           	          <li id="one2" class="hover">加入记录</li>          	         
       	            </ul>
       	          </div>
       	        </div>
           	    <div class="border p15-30 Men_bt li30" id="con_one_2">
           	    	<div class="fr mb10"> <span class="mr10">加入总人次<em class="f18 orange"><%=pagingResult == null?0:pagingResult.getItemCount() %></em>人次</span></div>
           	    	<table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
			            <tr class="hsbg">
			              <td>投资人</td>
			              <td>投资金额 </td>
			              <td>投资时间</td>
			            </tr>
			            <%if (pagingResultArray != null) {for (int i =0;i<pagingResultArray.length;i++){PlanAddRecord planAddRecord=pagingResultArray[i];if (planAddRecord == null) {continue;}%>
			            <tr class="dhsbg">
			              <td><%StringHelper.filterHTML(out, planAddRecord.userName);%></td>
			              <td><%=Formater.formatAmount(planAddRecord.addMoney)%></td>
			              <td><%=TimestampParser.format(planAddRecord.investTime) %></td>
			            </tr>
			            <%}} %>
			          </table>
           	    </div>       	   
			          <%AbstractConsoleServlet.rendPagingResult(out, pagingResult);%>
           	    <div class="clear"></div>
       	      </div>
       	       </form>
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
</html>