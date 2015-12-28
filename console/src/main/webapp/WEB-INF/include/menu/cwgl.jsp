<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.SxbaofkList"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.trade.TradeList"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.dzgl.UserReveinfo"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.dzgl.PlayBidinfo"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.dzgl.PlayReveinfo"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.TyjCountList"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.TyjAchieveList"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.TyjInterestList"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.TyjshList"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.bonus.BonusList"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.dzgl.TransList"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.dzgl.TrfQuery"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.dzgl.MerAcct"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.dzgl.UserList"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.dzgl.WithdrawQuery"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.dzgl.ChargeQuery"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.order.OrderExceptionList"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.order.OrderList"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.xxczgl.XxczglList"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.ptfxbyjgl.DfsdzqList"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.jgbyj.JgbyjList"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.ptzjgl.PtzjglList"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.ptfxbyjgl.PtfxbyjglList"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.FkshList"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.ExpemoIntList"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.yhzjgl.YhzjglList"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.txgl.TxglList"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.czgl.CzglList"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.zjgl.ZjList"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.zjgl.ByZjList"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.zjgl.XyList"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.zjgl.TjBbList"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.order.TxOrderList" %>
<%@page import="com.dimeng.p2p.console.servlets.finance.order.ChargeOrderList" %>
<%@page import="com.dimeng.p2p.console.servlets.finance.order.FKOrderList" %>
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.TybshList"%>
<%
	if ("CWGL".equals(CURRENT_CATEGORY)) {
%>
<div class="l_main">
	<div class="sidenav admin_lf">
		<h2 class="home_yhgl">
			财务管理<span class="ico"></span>
		</h2>
		<div>
			<p>
				<a href="javascript:void(0)" style="cursor: default;">资金管理</a>
			</p>
			<div>
				<ul class="admin_li">
					<li>
						<%
							if(dimengSession.isAccessableResource(TradeList.class)){
						%>
						<a <%if ("TRADELIST".equals(CURRENT_SUB_CATEGORY)) {%> class="curr" <%}%> href="<%=controller.getURI(request, TradeList.class)%>">转账管理</a>
						<%
							}else{
						%>
						<a href="javascript:void(0)" class="disabled">转账管理</a>
						<%
							}
						%>
					</li>
					<li>
						<%
							if(dimengSession.isAccessableResource(BonusList.class))
											{
						%>
						<a <%if ("BONUSLIST".equals(CURRENT_SUB_CATEGORY)) {%> class="curr" <%}%> href="<%=controller.getURI(request, BonusList.class)%>">佣金提成</a>
						<%
							}else{
						%>
						<a href="javascript:void(0)" class="disabled">佣金提成</a>
						<%
							}
						%>
					</li>
					<li>
						<%
							if(dimengSession.isAccessableResource(CzglList.class))
											{
						%>
						<a <%if ("CZGL".equals(CURRENT_SUB_CATEGORY)) {%> class="curr" <%}%> href="<%=controller.getURI(request, CzglList.class)%>">充值管理</a>
						<%
							}else{
						%>
						<a href="javascript:void(0)" class="disabled">充值管理</a>
						<%
							}
						%>
					</li>
					<%-- <li>
						<%
							if(dimengSession.isAccessableResource(XxczglList.class))
							{
						%>
						<a <%if ("XXCZGL".equals(CURRENT_SUB_CATEGORY)) {%> class="curr" <%}%> href="<%=controller.getURI(request, XxczglList.class)%>">线下充值管理</a>
						<%}else{ %>
						<a href="javascript:void(0)" class="disabled">线下充值管理</a>
						<%} %>
					</li> --%>
					<li>
						<%
							if(dimengSession.isAccessableResource(TxglList.class))
											{
						%>
						<a <%if ("TXGL".equals(CURRENT_SUB_CATEGORY)) {%> class="curr" <%}%> href="<%=controller.getURI(request, TxglList.class)%>">提现管理</a>
						<%
							}else{
						%>
						<a href="javascript:void(0)" class="disabled">提现管理</a>
						<%
							}
						%>
					</li>
					<li>
						<%
							if(dimengSession.isAccessableResource(FkshList.class))
											{
						%>
						<a <%if ("FKGL".equals(CURRENT_SUB_CATEGORY)) {%> class="curr" <%}%> href="<%=controller.getURI(request, FkshList.class)%>">放款审核</a>
						<%
							}else{
						%>
						<a href="javascript:void(0)" class="disabled">放款审核</a>
						<%
							}
						%>
					</li>
					<li>
						<%
							if(dimengSession.isAccessableResource(SxbaofkList.class))
											{
						%>
						<a <%if ("SXBAOFKGL".equals(CURRENT_SUB_CATEGORY)) {%> class="curr" <%}%> href="<%=controller.getURI(request, SxbaofkList.class)%>">善行宝放款审核</a>
						<%
							}else{
						%>
						<a href="javascript:void(0)" class="disabled">善行宝放款审核</a>
						<%
							}
						%>
					</li>
					<%--
					<li>
					    <%
					    	if(dimengSession.isAccessableResource(TybshList.class))
					    					{
					    %>
						<a <%if ("TYBGL".equals(CURRENT_SUB_CATEGORY)) {%> class="curr" <%}%> href="<%=controller.getURI(request, TybshList.class)%>">体验标审核</a>
						<%}else{ %>
						  <a href="javascript:void(0)" class="disabled">体验标审核</a>
						<%} %>
					
					</li> --%>
					<li>
					    <%
					    	if(dimengSession.isAccessableResource(TyjshList.class))
					    					{
					    %>
						<a <%if ("TYJGLNEW".equals(CURRENT_SUB_CATEGORY)) {%> class="curr" <%}%> href="<%=controller.getURI(request, TyjshList.class)%>">体验金审核</a>
						<%}else{ %>
						  <a href="javascript:void(0)" class="disabled">体验金审核</a>
						<%} %>
					
					</li>
					<%--
					<li>
						<%
							if(dimengSession.isAccessableResource(ExpemoIntList.class))
											{
						%>
						<a <%if ("TYLX".equals(CURRENT_SUB_CATEGORY)) {%> class="curr" <%}%> href="<%=controller.getURI(request, ExpemoIntList.class)%>">体验利息</a>
						<%
							}else{
						%>
						<a href="javascript:void(0)" class="disabled">体验利息</a>
						<%
							}
						%>
					</li>--%>
					<li>
						<%
							if(dimengSession.isAccessableResource(TyjInterestList.class))
											{
						%>
						<a <%if ("TYJINTERESTNEW".equals(CURRENT_SUB_CATEGORY)) {%> class="curr" <%}%> href="<%=controller.getURI(request, TyjInterestList.class)%>">体验金利息</a>
						<%
							}else{
						%>
						<a href="javascript:void(0)" class="disabled">体验金利息</a>
						<%
							}
						%>
					</li>
					<li>
						<%
							if(dimengSession.isAccessableResource(TyjAchieveList.class))
											{
						%>
						<a <%if ("TYJACHIEVENEW".equals(CURRENT_SUB_CATEGORY)) {%> class="curr" <%}%> href="<%=controller.getURI(request, TyjAchieveList.class)%>">已领取体验金统计</a>
						<%
							}else{
						%>
						<a href="javascript:void(0)" class="disabled">已领取体验金统计</a>
						<%
							}
						%>
					</li>
					<li>
						<%
							if(dimengSession.isAccessableResource(TyjCountList.class))
											{
						%>
						<a <%if ("TYJCOUNTNEW".equals(CURRENT_SUB_CATEGORY)) {%> class="curr" <%}%> href="<%=controller.getURI(request, TyjCountList.class)%>">体验标统计</a>
						<%
							}else{
						%>
						<a href="javascript:void(0)" class="disabled">体验标统计</a>
						<%
							}
						%>
					</li>
					<li><%
						if(dimengSession.isAccessableResource(ZjList.class))
						{
						%>
						<a <%if ("ZJGL".equals(CURRENT_SUB_CATEGORY)) {%> class="curr" <%}%> href="<%=controller.getURI(request, ZjList.class)%>">用户资金管理</a>
						<%}else{ %>
						<a href="javascript:void(0)" class="disabled">用户资金管理</a>
						<%} %>
					</li>
						<li><%
						if(dimengSession.isAccessableResource(ByZjList.class))
						{
						%>
						<a <%if ("BYZJGL".equals(CURRENT_SUB_CATEGORY)) {%> class="curr" <%}%> href="<%=controller.getURI(request, ByZjList.class)%>">备用资金管理</a>
						<%}else{ %>
						<a href="javascript:void(0)" class="disabled">备用资金管理</a>
						<%} %>
					</li>
					<li><%
						if(dimengSession.isAccessableResource(XyList.class))
						{
						%>
						<a <%if ("XYGL".equals(CURRENT_SUB_CATEGORY)) {%> class="curr" <%}%> href="<%=controller.getURI(request, XyList.class)%>">用户信用管理</a>
						<%}else{ %>
						<a href="javascript:void(0)" class="disabled">用户信用管理</a>
						<%} %>
					</li>
					<li><%
						if(dimengSession.isAccessableResource(TjBbList.class))
						{
						%>
						<a <%if ("TJBBLIST".equals(CURRENT_SUB_CATEGORY)) {%> class="curr" <%}%> href="<%=controller.getURI(request, TjBbList.class)%>">用户资金总表</a>
						<%}else{ %>
						<a href="javascript:void(0)" class="disabled">用户资金总表</a>
						<%} %>
					</li>
				</ul>
			</div>
		</div>
		<%
			Boolean tg = BooleanParser.parseObject(configureProvider.getProperty(SystemVariable.SFZJTG));
			if(tg)
			{
		%>
		<div>
			<p>
				<a href="javascript:void(0)" style="cursor: default;">对账管理</a>
			</p>
			<div>
				<ul class="admin_li">
					<li>
						<%
							if(dimengSession.isAccessableResource(ChargeQuery.class))
							{
						%>
						<a <%if ("CZDZ".equals(CURRENT_SUB_CATEGORY)) {%> class="curr" <%}%> href="<%=controller.getURI(request, ChargeQuery.class)%>">充值对账</a>
						<%}else{ %>
						<a href="javascript:void(0)" class="disabled">充值对账</a>
						<%} %>
					</li>
					<li>
						<%
							if(dimengSession.isAccessableResource(WithdrawQuery.class))
							{
						%>
						<a <%if ("TXDZ".equals(CURRENT_SUB_CATEGORY)) {%> class="curr" <%}%> href="<%=controller.getURI(request, WithdrawQuery.class)%>">提现对账</a>
						<%}else{ %>
						<a href="javascript:void(0)" class="disabled">提现对账</a>
						<%} %>
					</li>
					<li>
						<%
							if(dimengSession.isAccessableResource(UserList.class))
							{
						%>
						<a <%if ("YHYECX".equals(CURRENT_SUB_CATEGORY)) {%> class="curr" <%}%> href="<%=controller.getURI(request, UserList.class)%>">用户余额查询</a>
						<%}else{ %>
						<a href="javascript:void(0)" class="disabled">用户余额查询</a>
						<%} %>
					</li>
					<%-- <li>
						<%
							if(dimengSession.isAccessableResource(MerAcct.class))
							{
						%>
						<a <%if ("SHZHXXCX".equals(CURRENT_SUB_CATEGORY)) {%> class="curr" <%}%> href="<%=controller.getURI(request, MerAcct.class)%>">商户账户信息</a>
						<%}else{ %>
						<a href="javascript:void(0)" class="disabled">商户账户信息</a>
						<%} %>
					</li>
					<li>
						<%
							if(dimengSession.isAccessableResource(TrfQuery.class))
							{
						%>
						<a <%if ("SHKKDZ".equals(CURRENT_SUB_CATEGORY)) {%> class="curr" <%}%> href="<%=controller.getURI(request, TrfQuery.class)%>">商户扣款对账</a>
						<%}else{ %>
						<a href="javascript:void(0)" class="disabled">商户扣款对账</a>
						<%} %>
					</li> --%>
					<li>
						<%
							if(dimengSession.isAccessableResource(TransList.class))
							{
						%>
						<a <%if ("JYZTCX".equals(CURRENT_SUB_CATEGORY)) {%> class="curr" <%}%> href="<%=controller.getURI(request, TransList.class)%>">交易状态查询</a>
						<%}else{ %>
						<a href="javascript:void(0)" class="disabled">交易状态查询</a>
						<%} %>
					</li>
					<li>
						<%
							if(dimengSession.isAccessableResource(PlayReveinfo.class))
							{
						%>
						<a <%if ("PLAYREVEINFO".equals(CURRENT_SUB_CATEGORY)) {%> class="curr" <%}%> href="<%=controller.getURI(request, PlayReveinfo.class)%>">平台收益明细</a>
						<%}else{ %>
						<a href="javascript:void(0)" class="disabled">平台收益明细</a>
						<%} %>
					</li>
					<li>
						<%
							if(dimengSession.isAccessableResource(UserReveinfo.class))
							{
						%>
						<a <%if ("USERREVEINFO".equals(CURRENT_SUB_CATEGORY)) {%> class="curr" <%}%> href="<%=controller.getURI(request, UserReveinfo.class)%>">用户收益明细</a>
						<%}else{ %>
						<a href="javascript:void(0)" class="disabled">用户收益明细</a>
						<%} %>
					</li>
					<li>
						<%
							if(dimengSession.isAccessableResource(PlayBidinfo.class))
							{
						%>
						<a <%if ("PLAYBIDINFO".equals(CURRENT_SUB_CATEGORY)) {%> class="curr" <%}%> href="<%=controller.getURI(request, PlayBidinfo.class)%>">标的支出表</a>
						<%}else{ %>
						<a href="javascript:void(0)" class="disabled">标的支出表</a>
						<%} %>
					</li>
				</ul>
			</div>
		</div>
		<%} %>
		<div>
			<p>
				<a href="javascript:void(0)" style="cursor: default;">订单管理</a>
			</p>
			<div>
				<ul class="admin_li">
					<li>
						<%
							if(dimengSession.isAccessableResource(OrderList.class))
							{
						%>
						<a <%if ("DDGL".equals(CURRENT_SUB_CATEGORY)) {%> class="curr" <%}%> href="<%=controller.getURI(request, OrderList.class)%>">订单管理</a>
						<%}else{ %>
						<a href="javascript:void(0)" class="disabled">订单管理</a>
						<%} %>
					</li>
					<li>
						<%
							if(dimengSession.isAccessableResource(TxOrderList.class))
							{
						%>
						<a <%if ("TXDZGL".equals(CURRENT_SUB_CATEGORY)) {%> class="curr" <%}%> href="<%=controller.getURI(request, TxOrderList.class)%>">提现对账管理</a>
						<%}else{ %>
						<a href="javascript:void(0)" class="disabled">提现对账管理</a>
						<%} %>
					</li>
					<li>
						<%
							if(dimengSession.isAccessableResource(FKOrderList.class))
							{
						%>
						<a <%if ("FKDZGL".equals(CURRENT_SUB_CATEGORY)) {%> class="curr" <%}%> href="<%=controller.getURI(request, FKOrderList.class)%>">放款对账管理</a>
						<%}else{ %>
						<a href="javascript:void(0)" class="disabled">放款对账管理</a>
						<%} %>
					</li>
					<li>
						<%
							if(dimengSession.isAccessableResource(OrderExceptionList.class))
							{
						%>
						<a <%if ("DDYCRZ".equals(CURRENT_SUB_CATEGORY)) {%> class="curr" <%}%> href="<%=controller.getURI(request, OrderExceptionList.class)%>">订单异常日志</a>
						<%}else{ %>
						<a href="javascript:void(0)" class="disabled">订单异常日志</a>
						<%} %>
					</li>
				</ul>
			</div>
		</div>
	</div>
	<div>
	</div>
</div>
<%
	}
%>