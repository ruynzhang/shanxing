<%@page import="com.dimeng.p2p.console.servlets.base.rank.SearchRank"%>
<%@page import="com.dimeng.p2p.console.servlets.base.xymb.XymbList"%>
<%@page import="com.dimeng.p2p.console.servlets.base.dywsx.DywsxList"%>
<%@page import="com.dimeng.p2p.console.servlets.base.dywlx.DywlxList"%>
<%@page import="com.dimeng.p2p.console.servlets.base.bfjlx.BfjlxList"%>
<%@page import="com.dimeng.p2p.console.servlets.base.blx.BlxList"%>
<%@page import="com.dimeng.p2p.console.servlets.base.bank.SearchBank"%>
<%@page import="com.dimeng.p2p.console.servlets.base.jylx.JylxList"%>
<%@page import="com.dimeng.p2p.console.servlets.base.region.RegionList"%>
<%@page import="com.dimeng.p2p.console.servlets.base.xyrzx.XyrzxList"%>
<%@page import="com.dimeng.p2p.console.servlets.base.xydj.XydjList"%>
<%
	if ("JCXXGL".equals(CURRENT_CATEGORY)) {
%>
<div class="l_main">
	<div class="sidenav admin_lf">
		<h2 class="home_yhgl">
			基础信息管理<span class="ico"></span>
		</h2>
		<div>
			<div>
				<ul class="admin_li">
					<%
						if (dimengSession.isAccessableResource(SearchRank.class)) {
					%>
					<li><a <%if ("DJSZ".equals(CURRENT_SUB_CATEGORY)) {%> class="curr" <%}%> href="<%=controller.getURI(request, SearchRank.class)%>">等级管理</a></li>
					<%
						} else {
					%>
					<li><a href="javascript:viod(0)" class="disabled">等级管理</a></li>
					<%
						}
					%>
				</ul>
				<ul class="admin_li">
					<%
						if (dimengSession.isAccessableResource(XydjList.class)) {
					%>
					<li><a <%if ("XYDJGL".equals(CURRENT_SUB_CATEGORY)) {%> class="curr" <%}%> href="<%=controller.getURI(request, XydjList.class)%>">信用等级管理</a></li>
					<%
						} else {
					%>
					<li><a href="javascript:viod(0)" class="disabled">信用等级管理</a></li>
					<%
						}
					%>
				</ul>
				<ul class="admin_li">
					<%
						if (dimengSession.isAccessableResource(XyrzxList.class)) {
					%>
					<li><a <%if ("XYRZX".equals(CURRENT_SUB_CATEGORY)) {%> class="curr" <%}%> href="<%=controller.getURI(request, XyrzxList.class)%>">信用认证项管理</a></li>
					<%
						} else {
					%>
					<li><a href="javascript:viod(0)" class="disabled">信用认证项管理</a></li>
					<%
						}
					%>
				</ul>
				<ul class="admin_li">
					<%
						if (dimengSession.isAccessableResource(JylxList.class)) {
					%>
					<li><a <%if ("JYLX".equals(CURRENT_SUB_CATEGORY)) {%> class="curr" <%}%> href="<%=controller.getURI(request, JylxList.class)%>">交易类型管理</a></li>
					<%
						} else {
					%>
					<li><a href="javascript:viod(0)" class="disabled">交易类型管理</a></li>
					<%
						}
					%>
				</ul>
				<ul class="admin_li">
					<%
						if (dimengSession.isAccessableResource(RegionList.class)) {
					%>
					<li><a <%if ("QYGL".equals(CURRENT_SUB_CATEGORY)) {%> class="curr" <%}%> href="<%=controller.getURI(request, RegionList.class)%>">区域管理</a></li>
					<%
						} else {
					%>
					<li><a href="javascript:viod(0)" class="disabled">区域管理</a></li>
					<%
						}
					%>
				</ul>
				<ul class="admin_li">
					<%
						if (dimengSession.isAccessableResource(SearchBank.class)) {
					%>
					<li><a <%if ("YHSZ".equals(CURRENT_SUB_CATEGORY)) {%> class="curr" <%}%> href="<%=controller.getURI(request, SearchBank.class)%>">银行设置</a></li>
					<%
						} else {
					%>
					<li><a href="javascript:viod(0)" class="disabled">银行设置</a></li>
					<%
						}
					%>
				</ul>
				<ul class="admin_li">
					<%
						if (dimengSession.isAccessableResource(BlxList.class)) {
					%>
					<li><a <%if ("BLX".equals(CURRENT_SUB_CATEGORY)) {%> class="curr" <%}%> href="<%=controller.getURI(request, BlxList.class)%>">标类型管理</a></li>
					<%
						} else {
					%>
					<li><a href="javascript:viod(0)" class="disabled">标类型管理</a></li>
					<%
						}
					%>
				</ul>
				<ul class="admin_li">
					<%
						if (dimengSession.isAccessableResource(BfjlxList.class)) {
					%>
					<li><a <%if ("BFJLX".equals(CURRENT_SUB_CATEGORY)) {%> class="curr" <%}%> href="<%=controller.getURI(request, BfjlxList.class)%>">标附件类型管理</a></li>
					<%
						} else {
					%>
					<li><a href="javascript:viod(0)" class="disabled">标附件类型管理</a></li>
					<%
						}
					%>
				</ul>
				<ul class="admin_li">
					<%
						if (dimengSession.isAccessableResource(DywlxList.class)) {
					%>
					<li><a <%if ("DYWLX".equals(CURRENT_SUB_CATEGORY)) {%> class="curr" <%}%> href="<%=controller.getURI(request, DywlxList.class)%>">抵押物类型管理</a></li>
					<%
						} else {
					%>
					<li><a href="javascript:viod(0)" class="disabled">抵押物类型管理</a></li>
					<%
						}
					%>
				</ul>
				<ul class="admin_li">
					<%
						if (dimengSession.isAccessableResource(DywsxList.class)) {
					%>
					<li><a <%if ("DYWSX".equals(CURRENT_SUB_CATEGORY)) {%> class="curr" <%}%> href="<%=controller.getURI(request, DywsxList.class)%>">抵押物属性管理</a></li>
					<%
						} else {
					%>
					<li><a href="javascript:viod(0)" class="disabled">抵押物属性管理</a></li>
					<%
						}
					%>
				</ul>
				<ul class="admin_li">
					<%
						if (dimengSession.isAccessableResource(XymbList.class)) {
					%>
					<li><a <%if ("XYMBSZ".equals(CURRENT_SUB_CATEGORY)) {%> class="curr" <%}%> href="<%=controller.getURI(request, XymbList.class)%>">协议模板设置</a></li>
					<%
						} else {
					%>
					<li><a href="javascript:viod(0)" class="disabled">协议模板设置</a></li>
					<%
						}
					%>
				</ul>
			</div>
		</div>
	</div>
</div>
<%
	}
%>