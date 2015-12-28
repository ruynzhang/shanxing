<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.front.servlets.AbstractFrontServlet"%>
<%@page import="com.dimeng.p2p.front.servlets.financing.yxlc.Yxxq"%>
<%@page import="com.dimeng.p2p.S64.enums.T6410_F07"%>
<%@page import="com.dimeng.p2p.modules.financial.front.service.entity.YxxqEntity"%>
<%@page import="com.dimeng.p2p.modules.financial.front.service.entity.YxlcCount"%>
<%@page import="com.dimeng.p2p.front.servlets.financing.yxlc.Yxlb"%>
<%@page import="com.dimeng.p2p.modules.financial.front.service.entity.YxlbEntity"%>
<%@page import="com.dimeng.util.http.URLParameter"%>
<%@page import="com.dimeng.p2p.modules.financial.front.service.FinancialManage"%>
<html>
<head>
<title>优选理财计划<%=configureProvider.getProperty(SystemVariable.SITE_TITLE)%></title>
<%@include file="/WEB-INF/include/meta.jsp" %>
<%@include file="/WEB-INF/include/style.jsp" %>
</head>
<body>
<%@include file="/WEB-INF/include/header.jsp" %>
<%
	FinancialManage service = serviceSession.getService(FinancialManage.class);
	final HttpServletRequestWrapper requestWrapper = new  HttpServletRequestWrapper(request);
	YxlcCount fpCount=service.getStatistics();
	URLParameter parameter = new URLParameter(request,controller.getViewURI(request, Yxlb.class));
	PagingResult<YxlbEntity> result = service.search(
	 new Paging() {
		public int getCurrentPage() {
	return IntegerParser.parse(requestWrapper.getParameter("paging.current"));
		}
		public int getSize() {
	return 10;
		}
	});
	YxxqEntity caInfo= service.getNewPlan();
%>
<div class="contain clearfix">
   <div class="w1002 top_title">
      <span class="fl"><a href="<%=controller.getViewURI(request, com.dimeng.p2p.front.servlets.financing.Index.class)%>">我要理财</a> &gt;   <a href="<%=controller.getViewURI(request, com.dimeng.p2p.front.servlets.financing.yxlc.Index.class)%>">优选理财计划</a>&gt;往期优选理财计划列表</span>
      <span class="fr">
      	</span>
   </div>
   
   <div class="financial">
   <div class="title">
   	<a href="<%=controller.getPagingItemURI(request, Yxlb.class,caInfo.F01)%>"><%
   		StringHelper.filterHTML(out, caInfo.F02);
   	%></a></div>
	<%
		if(caInfo.F07 == T6410_F07.YFB && caInfo.F09.after(caInfo.currentTime)){
	%>			
   			<div class="time"> 				
   			</div>
   <%
   	}else if(caInfo.F07 == T6410_F07.YSX){
   %>
	   <div class="plan-progress-container">
	      <a class="ui-progressbar-circle ui-progressbar-circle-ready">已满额</a>
	   </div>
    <%
    	}else if(caInfo.F07 == T6410_F07.YFB && !caInfo.F09.after(caInfo.currentTime)){
    %>
	   <div class="plan-progress-container">
	      <span class="ui-progressbar-large ui-progressbar-large-<%=new BigDecimal(caInfo.proess*100).intValue()%>"><em>申请中</em><br/>
	      </span>
	   </div>
    <%
    	}else if(caInfo.F07 == T6410_F07.YJZ){
    %>
	   <div class="plan-progress-container" >
	      <a class="ui-progressbar-circle ui-progressbar-circle-ready">已截止</a>
	   </div>
   <%
   	}
   %>
   <div class="condition">
     <table width="100%" border="0">
        <tr>
          <td><i></i>加入条件：<span class="f18 orange"><b><%=caInfo.F22%></b></span>元</td>
          <td><i></i>计划总额：<span class="f18 orange"><b><%=caInfo.F03%></b></span>元</td>
          <td>预期收益：<span class="f18 orange"><b><%=Formater.formatRate(caInfo.F05,false)%></b></span>%</td>
        </tr>
     </table>
   </div>
</div>
   
   <div class="contain_main clearfix">
       		<div class="pub_title clearfix">
				<span class="fl">投资效果</span> 
			</div>
			<div class="targeting">
				<%
					if(fpCount != null ){
				%>			
				<ul>
					<li>
						<p>
							<i class="icons_bj iterm_ico01"></i>累计总金额
						</p>
						<p>
						<%
							if(fpCount.totleMoney.doubleValue()>=100000000){
						%>
			        	   <em class="f20"><%=Formater.formatAmount(fpCount.totleMoney.doubleValue()/100000000)%></em>亿元
			        	<%
			        	   	}else if(fpCount.totleMoney.doubleValue()>=10000 && fpCount.totleMoney.doubleValue() <100000000){
			        	   %>
			        		<em class="f20"><%=Formater.formatAmount(fpCount.totleMoney.doubleValue()/10000)%></em>万元
			        	<%
			        			}else{
			        		%>
			        		<em class="f20"><%=Formater.formatAmount(fpCount.totleMoney)%></em>元
			        	<%
			        			}
			        		%>
						</p>
					</li>
					<li>
						<p>
							<i class="icons_bj iterm_ico02"></i>加入总人次
						</p>
						<p>
							<em class="f20"><%=fpCount.joinCount%></em>次
						</p>
					</li>
					<li>
						<p>
							<i class="icons_bj iterm_ico03"></i>资金利用率
						</p>
						<p>
							<em class="f20"><%=Formater.formatRate(fpCount.moneyUse)%></em>
						</p>
					</li>
					<li>
						<p>
							<i class="icons_bj iterm_ico05"></i>为用户累计赚取
						</p>
						<p>
							<%
								if(fpCount.userEarnMoney.doubleValue()>=100000000){
							%>
				        	   <em class="f20"><%=Formater.formatAmount(fpCount.userEarnMoney.doubleValue()/100000000)%></em>亿元
				        	<%
				        	   	}else if(fpCount.userEarnMoney.doubleValue()>=10000 && fpCount.userEarnMoney.doubleValue() <100000000){
				        	   %>
				        		<em class="f20"><%=Formater.formatAmount(fpCount.userEarnMoney.doubleValue()/10000)%></em>万元
				        	<%
				        			}else{
				        		%>
				        		<em class="f20"><%=Formater.formatAmount(fpCount.userEarnMoney)%></em>元
				        	<%
				        			}
				        		%>
						</p>
					</li>
				</ul>
				<%
					}else{
				%>
				<ul>
					<li>
						<p>
							<i class="icons_bj iterm_ico01"></i>累计总金额
						</p>
						<p><em class="f20">0</em>元
						</p>
					</li>
					<li>
						<p>
							<i class="icons_bj iterm_ico02"></i>加入总人次
						</p>
						<p>
							<em class="f20">0</em>次
						</p>
					</li>
					<li>
						<p>
							<i class="icons_bj iterm_ico03"></i>资金利用率
						</p>
						<p>
							<em class="f20">0%</em>
						</p>
					</li>
					<li>
						<p>
							<i class="icons_bj iterm_ico05"></i>为用户累计赚取
						</p>
						<p>
							<em class="f20">
							<em class="f20">0</em>元
							</em>
						</p>
					</li>
				</ul>
				<%
					}
				%>
			</div>
   </div>
   
   <div class="contain_main clearfix">
       <div class="pub_title">往期计划列表</div>
       <div class="pt10">
          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tc overdue">
              <tr class="tit_bj">
                <td>计划名称</td>
                <td>计划金额</td>
                <td>加入人数</td>
                <td>资金利用率</td>
                <td>收益率</td>
                <td>累计赚取</td>
                <td>发布时间</td>
              </tr>
             <%
             	YxlbEntity[] financingPlans=result.getItems();if(financingPlans!=null){for (YxlbEntity financingPlan : financingPlans) {if (financingPlan == null) {continue;}
             %>
              <tr class="all_bj">
                <td><em class="f16 blue"><a href="<%=controller.getPagingItemURI(request, Yxxq.class,financingPlan.F01)%>"><%=financingPlan.F02%></a></em></td>
                <td><em class="f16"><%=financingPlan.F03%></em><em class="f12">元</em></td>
                <td><em class="f16"><%=financingPlan.jrrc%></em><em class="f12">人</em></td>
                <td><em class="f16"><%=Formater.formatRate(financingPlan.pjsyl)%></em><em class="f12"></em></td>
                <td><em class="f16"><%=Formater.formatRate(financingPlan.F05)%></em><em class="f12"></em></td>
                <td><em class="f16"><%=Formater.formatAmount(financingPlan.yzje)%></em><em class="f12">元</em></td>
                <td><em class="f14"><%=DateParser.format(financingPlan.F09)%></em></td>
              </tr>
              <%
              	}}
              %>
</table>

       </div>
         <%
         	AbstractFrontServlet.rendPaging(out, result,controller.getPagingURI(request, Yxlb.class));
         %>
   </div>
</div>
<%@include file="/WEB-INF/include/footer.jsp" %>
<%@include file="/WEB-INF/include/script.jsp" %>
<script type="text/javascript">
		var endTime =<%=caInfo.F09.getTime()- System.currentTimeMillis()%>;
		var clearTime = null;
		function time() {
			var leftsecond = parseInt(endTime / 1000);
			var day = Math.floor(leftsecond/ (60 * 60 * 24)) < 0 ? 0 : Math.floor(leftsecond / (60 * 60 * 24));
			var hour = Math.floor((leftsecond - day * 24 * 60 * 60) / 3600) < 0 ? 0: Math.floor((leftsecond - day * 24 * 60 * 60) / 3600);
			var minute = Math.floor((leftsecond - day* 24 * 60 * 60 - hour * 3600) / 60) < 0 ? 0: Math.floor((leftsecond - day* 24 * 60 * 60 - hour * 3600) / 60);
			var second = Math.floor(leftsecond - day* 24 * 60 * 60 - hour * 3600- minute * 60) < 0 ? 0 : Math.floor(leftsecond - day * 24 * 60* 60 - hour * 3600 - minute* 60);
			if(hour<10)
			{
				hour="0"+hour;	
			}
			if(minute<10)
			{
				minute="0"+minute;	
			}
			if(second<10)
			{
				second="0"+second;	
			}
			$(".time").html("还有<span class=\"f24\">"+hour+"小时"+minute+"分"+second+"秒</span>开始发售");
			if (leftsecond <= 0) {
				clearInterval(clearTime);
			}
		}
		<%if((caInfo.F07 == T6410_F07.YFB && caInfo.F09.after(caInfo.currentTime))){%>
			clearTime = setInterval(function() {
			endTime = endTime - 1000;
			time();
		}, 1000);
		<%}else{%>
			clearInterval(clearTime);
		<%}%>
</script>
</body>
</html>

