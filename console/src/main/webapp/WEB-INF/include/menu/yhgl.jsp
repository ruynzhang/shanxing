<%@page import="com.dimeng.p2p.console.servlets.account.staff.UpUsers"%>
<%@page import="com.dimeng.p2p.console.servlets.account.sxgl.JkRecordList"%>
<%@page import="com.dimeng.p2p.console.servlets.account.sxgl.TzRecordList"%>
<%@page import="com.dimeng.p2p.console.servlets.account.sxgl.SxList"%>
<%@page import="com.dimeng.p2p.console.servlets.account.staff.YgList"%>
<%@page import="com.dimeng.p2p.console.servlets.account.kfxx.KfList"%>
<%@page import="com.dimeng.p2p.console.servlets.account.jgxx.JgList"%>
<%@page import="com.dimeng.p2p.console.servlets.account.qyxx.QyList"%>
<%@page import="com.dimeng.p2p.console.servlets.account.grxx.GrList"%>
<%@page import="com.dimeng.p2p.console.servlets.account.zhgl.ZhList"%>
<%@page import="com.dimeng.p2p.console.servlets.account.ptgl.PtglList"%>
<%if("YHGL".equals(CURRENT_CATEGORY)){%>
<div class="l_main">
	<div class="sidenav admin_lf">
	    <h2 class="home_yhgl">用户管理<span class="ico"></span></h2>
		<div>
			<p><a href="javascript:viod(0)" style="cursor: default;">账号管理</a></p>
			<div>
				<ul class="admin_li">
					<%
						if (dimengSession.isAccessableResource(ZhList.class)) {
					%>
					<li><a <%if("ZHGL".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, ZhList.class)%>">账号管理</a></li>
					<%
						} else {
					%>
					<li><a href="javascript:viod(0)" class="disabled">账号管理</a></li>
					<%
						}
					%>
				</ul>
				<ul class="admin_li">
					<%
						if (dimengSession.isAccessableResource(YgList.class)) {
					%>
					<li><a <%if("YGXX".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, YgList.class)%>">人事管理</a></li>
					<%
						} else {
					%>
					<li><a href="javascript:viod(0)" class="disabled">人事管理</a></li>
					<%
						}
					%>
				</ul>
				<%--批量注册用户 
				<ul class="admin_li">
					<%
						if (dimengSession.isAccessableResource(UpUsers.class)) {
					%>
					<li><a <%if("UPUSERS".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, UpUsers.class)%>">上传用户</a></li>
					<%
						} else {
					%>
					<li><a href="javascript:viod(0)" class="disabled">上传用户</a></li>
					<%
						}
					%>
				</ul>--%>
				<ul class="admin_li">
					<%
						if (dimengSession.isAccessableResource(GrList.class)) {
					%>
					<li><a <%if("GRXX".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, GrList.class)%>">个人基础信息</a></li>
					<%
						} else {
					%>
					<li><a href="javascript:viod(0)" class="disabled">个人基础信息</a></li>
					<%
						}
					%>
				</ul>
				<ul class="admin_li">
					<%
						if (dimengSession.isAccessableResource(QyList.class)) {
					%>
					<li><a <%if("QY".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, QyList.class)%>">企业基础信息</a></li>
					<%
						} else {
					%>
					<li><a href="javascript:viod(0)" class="disabled">企业基础信息</a></li>
					<%
						}
					%>
				</ul>
				<ul class="admin_li">
					<%
						if (dimengSession.isAccessableResource(JgList.class)) {
					%>
					<li><a <%if("JG".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, JgList.class)%>">机构基础信息</a></li>
					<%
						} else {
					%>
					<li><a href="javascript:viod(0)" class="disabled">机构基础信息</a></li>
					<%
						}
					%>
				</ul>
				<%-- <ul class="admin_li">
					<%
						if (dimengSession.isAccessableResource(KfList.class)) {
					%>
					<li><a <%if("KFXX".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, KfList.class)%>">客户信息</a></li>
					<%
						} else {
					%>
					<li><a href="javascript:viod(0)" class="disabled">客户信息</a></li>
					<%
						}
					%>
				</ul> --%>
				<ul class="admin_li">
					<%
						if (dimengSession.isAccessableResource(PtglList.class)) {
					%>
					<li><a <%if("PT".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, PtglList.class)%>">平台管理</a></li>
					<%
						} else {
					%>
					<li><a href="javascript:viod(0)" class="disabled">平台管理</a></li>
					<%
						}
					%>
				</ul>
			</div>
		</div>
		<div>
			<p><a href="javascript:viod(0)" style="cursor: default;">筛选管理</a></p>
			<div>
				<ul class="admin_li">
					<%
						if (dimengSession.isAccessableResource(SxList.class)) {
					%>
					<li><a <%if("SXLIST".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, SxList.class)%>">筛选管理</a></li>
					<%
						} else {
					%>
					<li><a href="javascript:viod(0)" class="disabled">筛选管理</a></li>
					<%
						}
					%>
					<%
						if (dimengSession.isAccessableResource(TzRecordList.class)) {
					%>
					<li><a <%if("TZRECORDLIST".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, TzRecordList.class)%>">投资记录</a></li>
					<%
						} else {
					%>
					<li><a href="javascript:viod(0)" class="disabled">投资记录</a></li>
					<%
						}
					%>
					<%
						if (dimengSession.isAccessableResource(JkRecordList.class)) {
					%>
					<li><a <%if("JKRECORDLIST".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, JkRecordList.class)%>">借款记录</a></li>
					<%
						} else {
					%>
					<li><a href="javascript:viod(0)" class="disabled">借款记录</a></li>
					<%
						}
					%>
				</ul>
			</div>
		</div>
	</div>
</div>
<%}%>