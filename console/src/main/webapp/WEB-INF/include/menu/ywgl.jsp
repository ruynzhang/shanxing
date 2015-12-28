<%@page import="com.dimeng.p2p.console.servlets.bid.hbgl.RedpList"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.hbgl.RedpRecordList"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.sxbaogl.SxbaoTypeList"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.sxbaogl.SxbaoList"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.tyjgl.TotaldhList"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.tyjgl.GamedhList"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.tyjgl.SerialdhList"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.tyjgl.KldhList"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.htgl.QyjkDzxy"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.lcgl.zqzrgl.TransferDshList"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.OfflineLoanList"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.LoanList"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.csgl.dhklb.JsstList"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.lcgl.yxlcjh.PlanMoneyList"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.lcgl.zqzrgl.TransferProceedList"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.lcgl.zqgl.TbzList"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.csgl.csjl.CsList"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.csgl.hmd.HmdList"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.qyjkyx.QyjkyxList"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.grjkyx.GrjkyxList"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.tyjgl.TyjglList"%>
<%
	if("YWGL".equals(CURRENT_CATEGORY)){
%>
<div class="l_main">
	<div class="sidenav admin_lf">
		<h2 class="home_yhgl">业务管理<span class="ico"></span></h2>
		<div>
			<p><a href="javascript:viod(0)" style="cursor: default;">理财管理</a></p>
			<div>
				<ul class="admin_li">
					<%
						if (dimengSession.isAccessableResource(TbzList.class)) {
					%>
					<li><a <%if("ZQGL".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, TbzList.class)%>">债权管理</a></li>
					<%
						} else {
					%>
					<li><a href="javascript:viod(0)" class="disabled">债权管理</a></li>
					<%
						}
					%>
					<%
						if (dimengSession.isAccessableResource(TransferDshList.class)) {
					%>
					<li><a <%if("ZQZRGL".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, TransferDshList.class)%>">线上债权转让管理</a></li>
					<%
						} else {
					%>
					<li><a href="javascript:viod(0)" class="disabled">线上债权转让管理</a></li>
					<%
						}
					%>
					<%-- <%
						if (dimengSession.isAccessableResource(PlanMoneyList.class)) {
					%>
					<li><a <%if("YXLCJH".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, PlanMoneyList.class)%>">优选理财计划</a></li>
					<%
						} else {
					%>
					<!-- <li><a href="javascript:viod(0)" class="disabled">优选理财计划</a></li> -->
					<%
						}
					%> --%>
				</ul>
			</div>
		</div>
		<div>
			<p><a href="javascript:void(0)" style="cursor: default;">借款管理</a></p>
			<div>
				<ul class="admin_li">
					<%
							if (dimengSession.isAccessableResource(GrjkyxList.class)) {
			    	%>
					<li><a <%if("GRJKYX".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, GrjkyxList.class)%>">个人借款意向管理</a></li>
					<%
						} else {
					%>
					<li><a href="javascript:viod(0)" class="disabled">个人借款意向管理</a></li>
					<%
						}
					%>
					<%
							if (dimengSession.isAccessableResource(QyjkyxList.class)) {
			    	%>
					<li><a <%if("QYJKYX".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, QyjkyxList.class)%>">企业借款意向管理</a></li>
					<%
						} else {
					%>
					<li><a href="javascript:viod(0)" class="disabled">企业借款意向管理</a></li>
					<%
						}
					%>
					<%
						if (dimengSession.isAccessableResource(LoanList.class)) {
					%>
					<li><a <%if("BDGL".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, LoanList.class)%>">借款管理</a></li>
					<%
						} else {
					%>
					<li><a href="javascript:viod(0)" class="disabled">借款管理</a></li>
					<%
						}
					%>
				</ul>
			</div>
		</div>
		<div>
			<p><a href="javascript:void(0)" style="cursor: default;">体验金管理</a></p>
			<div>
				<ul class="admin_li">
					<%
						if (dimengSession.isAccessableResource(TyjglList.class)) {
					%>
					<li><a <%if("TYJGL".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, TyjglList.class)%>">体验金管理</a></li>
					<%
						} else {
					%>
					<li><a href="javascript:viod(0)" class="disabled">体验金管理</a></li>
					<%
						}
					%>
					<%
						if (dimengSession.isAccessableResource(TyjglList.class)) {
					%>
					<li><a <%if("KLDH".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, KldhList.class)%>">口令兑换</a></li>
					<%
						} else {
					%>
					<li><a href="javascript:viod(0)" class="disabled">口令兑换</a></li>
					<%
						}
					%>
					<%
						if (dimengSession.isAccessableResource(TyjglList.class)) {
					%>
					<li><a <%if("XHDH".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, SerialdhList.class)%>">序号兑换</a></li>
					<%
						} else {
					%>
					<li><a href="javascript:viod(0)" class="disabled">序号兑换</a></li>
					<%
						}
					%>
						<%
						if (dimengSession.isAccessableResource(TyjglList.class)) {
					%>
					<li><a <%if("YXDH".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, GamedhList.class)%>">游戏兑换</a></li>
					<%
						} else {
					%>
					<li><a href="javascript:viod(0)" class="disabled">游戏兑换</a></li>
					<%
						}
					%>
						<%
						if (dimengSession.isAccessableResource(TyjglList.class)) {
					%>
					<li><a <%if("TYJTJDH".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, TotaldhList.class)%>">体验金兑换统计</a></li>
					<%
						} else {
					%>
					<li><a href="javascript:viod(0)" class="disabled">体验金兑换统计</a></li>
					<%
						}
					%>
				</ul>
			</div>
		</div>
		<div>
			<p><a href="javascript:void(0)" style="cursor: default;">善行宝管理</a></p>
			<div>
				<ul class="admin_li">
					<%
						if (dimengSession.isAccessableResource(SxbaoTypeList.class)) {
					%>
					<li><a <%if("SXBAOTYPEGL".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, SxbaoTypeList.class)%>">善行宝类型管理</a></li>
					<%
						} else {
					%>
					<li><a href="javascript:viod(0)" class="disabled">善行宝类型管理</a></li>
					<%
						}
					%>
					<%
						if (dimengSession.isAccessableResource(SxbaoList.class)) {
					%>
					<li><a <%if("SXBAOGL".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, SxbaoList.class)%>">善行宝管理</a></li>
					<%
						} else {
					%>
					<li><a href="javascript:viod(0)" class="disabled">善行宝管理</a></li>
					<%
						}
					%>
				</ul>
			</div>
		</div>
		<%-- <div>
			<p><a href="javascript:void(0)" style="cursor: default;">线下债权转让管理</a></p>
			<div>
				<ul class="admin_li">
					<%
							if (dimengSession.isAccessableResource(OfflineLoanList.class)) {
			    	%>
					<li><a <%if("XXZQGL".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, OfflineLoanList.class)%>">线下债权转让管理</a></li>
					<%
						} else {
					%>
					<li><a href="javascript:viod(0)" class="disabled">线下债权转让管理</a></li>
					<%
						}
					%>
				</ul>
			</div>
		</div> --%>
		<div>
			<p><a href="javascript:viod(0)" style="cursor: default;">催收管理</a></p>
			<div>
				<ul class="admin_li">
					<%
						if (dimengSession.isAccessableResource(JsstList.class)) {
					%>
					<li><a <%if("DHKLB".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, JsstList.class)%>">待还款列表</a></li>
					<%
						} else {
					%>
					<li><a href="javascript:viod(0)" class="disabled">待还款列表</a></li>
					<%
						}
					%>
					
					<%
						if (dimengSession.isAccessableResource(CsList.class)) {
					%>
					<li><a <%if("CSJL".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, CsList.class)%>">催收记录</a></li>
					<%
						} else {
					%>
					<li><a href="javascript:viod(0)" class="disabled">催收记录</a></li>
					<%
						}
					%>
					
					<%
						if (dimengSession.isAccessableResource(HmdList.class)) {
					%>
					<li><a <%if("HMD".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, HmdList.class)%>">黑名单</a></li>
					<%
						} else {
					%>
					<li><a href="javascript:viod(0)" class="disabled">黑名单</a></li>
					<%
						}
					%>
				</ul>
			</div>
		</div>
		<div>
			<p><a href="javascript:viod(0)" style="cursor: default;">合同管理</a></p>
			<div>
				<ul class="admin_li">
					<%
						if (dimengSession.isAccessableResource(QyjkDzxy.class)) {
					%>
					<li><a <%if("DZXYLB".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, QyjkDzxy.class)%>">平台电子协议</a></li>
					<%
						} else {
					%>
					<li><a href="javascript:viod(0)" class="disabled">平台电子协议</a></li>
					<%
						}
					%>
				</ul>
			</div>
		</div>
		<div>
			<p><a href="javascript:viod(0)" style="cursor: default;">红包管理</a></p>
			<div>
				<ul class="admin_li">
					<%
						if (dimengSession.isAccessableResource(RedpList.class)) {
					%>
					<li><a <%if("REDPLIST".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, RedpList.class)%>">红包配置</a></li>
					<%
						} else {
					%>
					<li><a href="javascript:viod(0)" class="disabled">红包配置</a></li>
					<%
						}
					%>
					<%
						if (dimengSession.isAccessableResource(RedpRecordList.class)) {
					%>
					<li><a <%if("REDPRECORDLIST".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, RedpRecordList.class)%>">红包记录</a></li>
					<%
						} else {
					%>
					<li><a href="javascript:viod(0)" class="disabled">红包记录</a></li>
					<%
						}
					%>
				</ul>
			</div>
		</div>
	</div>
</div>
<%}%>