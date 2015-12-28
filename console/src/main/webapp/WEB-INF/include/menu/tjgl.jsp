<%@page import="com.dimeng.p2p.console.servlets.statistics.TradeRecordList"%>
<%@page import="com.dimeng.p2p.console.servlets.statistics.CwTJList"%>
<%@page import="com.dimeng.p2p.console.servlets.statistics.AccountTJList"%>
<%@page import="com.dimeng.p2p.console.servlets.statistics.InvestDataXqList"%>
<%@page import="com.dimeng.p2p.console.servlets.statistics.InvestDataList"%>
<%@page import="com.dimeng.p2p.console.servlets.statistics.Volume"%>
<%@page import="com.dimeng.p2p.console.servlets.statistics.RechargeWithdraw"%>
<%@page import="com.dimeng.p2p.console.servlets.statistics.RiskFunds"%>
<%@page import="com.dimeng.p2p.console.servlets.statistics.Funds"%>
<%@page import="com.dimeng.p2p.console.servlets.statistics.UserOnline"%>
<%@page import="com.dimeng.p2p.console.servlets.statistics.UserData"%>
<%if("TJGL".equals(CURRENT_CATEGORY)){%>
<div class="l_main">
	<div class="sidenav admin_lf">
		<h2 class="home_yhgl">统计管理<span class="ico"></span></h2>
		<div>
      		<p><a href="javascript:void(0)" style="cursor: default;">用户统计</a></p>
	      	<div>
	      		<ul class="admin_li">
	      			<%if(dimengSession.isAccessableResource(AccountTJList.class)){ %>
	      			<li><a <%if("ACCOUNTTJLIST".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, AccountTJList.class) %>">平台会员统计</a></li>
	      			<%}else{ %>
          			<li><a href="javascript:viod(0)" class="disabled">平台会员统计</a></li>
          			<%} %>
          			<%if(dimengSession.isAccessableResource(CwTJList.class)){ %>
	      			<li><a <%if("CWTJLIST".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, CwTJList.class) %>">平台财务统计</a></li>
	      			<%}else{ %>
          			<li><a href="javascript:viod(0)" class="disabled">平台财务统计</a></li>
          			<%} %>
	      			<%if(dimengSession.isAccessableResource(UserData.class)){ %>
	      			<li><a <%if("PTYHSJTJ".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, UserData.class) %>">平台用户数据统计</a></li>
	      			<%}else{ %>
          			<li><a href="javascript:viod(0)" class="disabled">平台用户数据统计</a></li>
          			<%} %>
	      			<%if(dimengSession.isAccessableResource(UserOnline.class)){ %>
	      			<li><a <%if("PTZXYHTJ".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, UserOnline.class) %>">平台在线用户统计</a></li>
	      			<%}else{ %>
          			<li><a href="javascript:viod(0)" class="disabled">平台在线用户统计</a></li>
          			<%} %>
	      		</ul>
	      	</div>
      	</div> 
      	<div>
      		<p><a href="javascript:void(0)" style="cursor: default;">资金统计</a></p>
	      	<div>
	      		<ul class="admin_li">
	      			<%if(dimengSession.isAccessableResource(Funds.class)){ %>
	      			<li><a <%if("PTZJTJ".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, Funds.class) %>">平台资金统计</a></li>
	      			<%}else{ %>
          			<li><a href="javascript:viod(0)" class="disabled">平台资金统计</a></li>
          			<%} %>
	      			
	      			<%if(dimengSession.isAccessableResource(RiskFunds.class)){ %>
	      			<li><a <%if("FXBZJTJ".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, RiskFunds.class) %>">风险保证金统计</a></li>
	      			<%}else{ %>
          			<li><a href="javascript:viod(0)" class="disabled">风险保证金统计</a></li>
          			<%} %>
	      			
	      			<%if(dimengSession.isAccessableResource(RechargeWithdraw.class)){ %>
	      			<li><a <%if("CZTXSJTJ".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, RechargeWithdraw.class) %>">充值提现数据统计</a></li>
	      			<%}else{ %>
          			<li><a href="javascript:viod(0)" class="disabled">充值提现数据统计</a></li>
          			<%} %>
	      		</ul>
	      	</div>
      	</div>  
      	<div>
      		<p><a href="javascript:void(0)" style="cursor: default;">业务统计</a></p>
	      	<div>
	      		<ul class="admin_li">
	      			<%if(dimengSession.isAccessableResource(Volume.class)){ %>
	      			<li><a <%if("CJSJTJ".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, Volume.class) %>">成交数据统计</a></li>
	      			<%}else{ %>
          			<li><a href="javascript:viod(0)" class="disabled">成交数据统计</a></li>
          			<%} %>
          			<%if(dimengSession.isAccessableResource(InvestDataList.class)){ %>
	      			<li><a <%if("INVESTDATALIST".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, InvestDataList.class) %>">投资数据</a></li>
	      			<%}else{ %>
          			<li><a href="javascript:viod(0)" class="disabled">投资数据</a></li>
          			<%} %>
          			<%if(dimengSession.isAccessableResource(InvestDataXqList.class)){ %>
	      			<li><a <%if("INVESTDATAXQLIST".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, InvestDataXqList.class) %>">投资数据明细</a></li>
	      			<%}else{ %>
          			<li><a href="javascript:viod(0)" class="disabled">投资数据明细</a></li>
          			<%} %>
          			<%if(dimengSession.isAccessableResource(TradeRecordList.class)){ %>
	      			<li><a <%if("TRADERECORDLIST".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, TradeRecordList.class) %>">线下交易记录</a></li>
	      			<%}else{ %>
          			<li><a href="javascript:viod(0)" class="disabled">线下交易记录</a></li>
          			<%} %>
	      		</ul>
	      	</div>
      	</div>       
	</div>
	<div></div>
</div>
<%}%>
 