<%@page import="com.dimeng.p2p.console.servlets.system.jpush.JpushList"%>
<%@page import="com.dimeng.p2p.console.servlets.spread.khgh.Search"%>
<%@page import="com.dimeng.p2p.console.servlets.system.operlog.OperLogList"%>
<%@page import="com.dimeng.p2p.console.servlets.system.constant.ConstantLogList"%>
<%@page import="com.dimeng.p2p.console.servlets.system.skin.SkinList"%>
<%@page import="com.dimeng.p2p.console.servlets.system.constant.ConstantList"%>
<%@page import="com.dimeng.p2p.console.servlets.system.email.EmailList"%>
<%@page import="com.dimeng.p2p.console.servlets.system.sms.SmsList"%>
<%@page import="com.dimeng.p2p.console.servlets.system.smsinfo.SmsinfoList"%>
<%@page import="com.dimeng.p2p.console.servlets.system.letter.LetterList"%>
<%@page import="com.dimeng.p2p.console.servlets.system.userlog.UserLogList"%>
<%@page import="com.dimeng.p2p.console.servlets.system.role.RoleList"%>
<%@page import="com.dimeng.p2p.console.servlets.system.sys.SysUserList"%>
<%if("XTGL".equals(CURRENT_CATEGORY)){%>
<div class="l_main">
  <div class="sidenav admin_lf">
    <h2 class="home_yhgl">系统管理<span class="ico"></span></h2>
    <div>
      <p><a href="javascript:viod(0)" style="cursor: default;">后台帐号</a></p>
      <div>
        <ul class="admin_li">
         	        <%
						if (dimengSession.isAccessableResource(SysUserList.class)) {
					%>
					<li><a href="<%=controller.getURI(request, SysUserList.class)%>" class="<%="GLYGL".equals(CURRENT_SUB_CATEGORY) ? "curr"
								: ""%>">管理员管理</a></li>
					<%
						} else {
					%>
					<li><a href="javascript:viod(0)" class="disabled">管理员管理</a></li>
					<%
						}
					%>
        	        <%
						if (dimengSession.isAccessableResource(RoleList.class)) {
					%>
					<li><a href="<%=controller.getURI(request, RoleList.class)%>" class="<%="YHZGL".equals(CURRENT_SUB_CATEGORY) ? "curr"
								: ""%>">用户组管理</a></li>
					<%
						} else {
					%>
					<li><a href="javascript:void(0)" class="disabled">用户组管理</a></li>
					<%
						}
					%>
        </ul>
      </div>
    </div>
    <div>
      <p><a href="javascript:viod(0)" style="cursor: default;">日志</a></p>
      <div>
        <ul class="admin_li">
    		<li>
    		<%
				if (dimengSession.isAccessableResource(UserLogList.class)) {
			%>
			<a href="<%=controller.getURI(request, UserLogList.class)%>" class="<%="QTDLRZ".equals(CURRENT_SUB_CATEGORY) ? "curr"
								: ""%>">前台日志</a>
			<%
				} else {
			%>
			<a href="javascript:viod(0)" class="disabled">前台日志</a>
			<%
				}
			%></li>
			<li><%
				if (dimengSession.isAccessableResource(OperLogList.class)) {
			%>
			<a href="<%=controller.getURI(request, OperLogList.class)%>" class="<%="HTCZRZ".equals(CURRENT_SUB_CATEGORY) ? "curr"
								: ""%>">后台日志</a>
			<%
				} else {
			%>
			<a href="javascript:viod(0)" class="disabled">后台日志</a>
			<%
				}
			%></li>
			<li><%
				if (dimengSession.isAccessableResource(ConstantLogList.class)) {
			%>
			<a href="<%=controller.getURI(request, ConstantLogList.class)%>" class="<%="PTCLRZ".equals(CURRENT_SUB_CATEGORY) ? "curr"
								: ""%>">平台常量日志</a>
			<%
				} else {
			%>
			<a href="javascript:viod(0)" class="disabled">平台常量日志</a>
			<%
				}
			%></li>
        </ul>
      </div>
    </div>
    
	<div>
	  <p><a href="javascript:viod(0)" style="cursor: default;">业务推广信息</a></p>
	  <div>
	    <ul class="admin_li">
	                    <%
							if (dimengSession.isAccessableResource(LetterList.class)) {
						%>
						<li><a href="<%=controller.getURI(request, LetterList.class)%>" class="<%="ZNXTG".equals(CURRENT_SUB_CATEGORY) ? "curr"
								: ""%>">站内信推广</a></li>
						<%
							} else {
						%>
						<li><a href="javascript:viod(0)" class="disabled">站内信推广</a></li>
						<%
							}
						%>
	                    <%
							if (dimengSession.isAccessableResource(SmsList.class)) {
						%>
						<li><a href="<%=controller.getURI(request, SmsList.class)%>" class="<%="DXTG".equals(CURRENT_SUB_CATEGORY) ? "curr"
								: ""%>">短信推广</a></li>
						<%
							} else {
						%>
						<li><a href="javascript:viod(0)" class="disabled">短信推广</a></li>
						<%
							}
						%>
						   <%
							if (dimengSession.isAccessableResource(JpushList.class)) {
						%>
						<li><a href="<%=controller.getURI(request, JpushList.class)%>" class="<%="JGTS".equals(CURRENT_SUB_CATEGORY) ? "curr"
								: ""%>">APP推送</a></li>
						<%
							} else {
						%>
						<li><a href="javascript:viod(0)" class="disabled">APP推送</a></li>
						<%
							}
						%>
						  <%
							if (dimengSession.isAccessableResource(SmsinfoList.class)) {
						%>
						<li><a href="<%=controller.getURI(request, SmsinfoList.class)%>" class="<%="DXFSGL".equals(CURRENT_SUB_CATEGORY) ? "curr"
								: ""%>">短信发送管理</a></li>
						<%
							} else {
						%>
						<li><a href="javascript:viod(0)" class="disabled">短信发送管理</a></li>
						<%
							}
						%>
	                    <%
							if (dimengSession.isAccessableResource(EmailList.class)) {
						%>
						<li><a href="<%=controller.getURI(request, EmailList.class)%>" class="<%="YJTG".equals(CURRENT_SUB_CATEGORY) ? "curr"
								: ""%>">邮件推广</a></li>
						<%
							} else {
						%>
						<li><a href="javascript:viod(0)" class="disabled">邮件推广</a></li>
						<%
							}
						%>
						 <%
						 	if (dimengSession.isAccessableResource(Search.class)) {
						 %>
						<li><a href="<%=controller.getURI(request, Search.class)%>" class="<%="KHGH".equals(CURRENT_SUB_CATEGORY) ? "curr"
								: ""%>">客户关怀</a></li>
						<%
							} else {
						%>
						<li><a href="javascript:viod(0)" class="disabled">客户关怀</a></li>
						<%
							}
						%>
	    </ul>
	  </div>
	</div>
    <div>
      <p><a href="javascript:viod(0)" style="cursor: default;">参数设置</a></p>
      <div>
        <ul class="admin_li">
          	<li>    <%
						if (dimengSession.isAccessableResource(ConstantList.class)) {
					%>
					<a href="<%=controller
								.getURI(request, ConstantList.class)%>" class="<%="PTCLSZ".equals(CURRENT_SUB_CATEGORY) ? "curr"
								: ""%>">平台常量设置</a>
					<%
						} else {
					%>
					<a href="javascript:viod(0)" class="disabled">平台常量设置</a>
					<%
						}
					%></li>
					<%-- 
          	<li>    <%
						if (dimengSession.isAccessableResource(SkinList.class)) {
					%>
					<a href="<%=controller.getURI(request, SkinList.class)%>" class="<%="QTPFSZ".equals(CURRENT_SUB_CATEGORY) ? "curr"
								: ""%>">前台皮肤设置</a>
					<%
						} else {
					%>
					<a href="javascript:viod(0)" class="disabled">前台皮肤设置</a>
					<%
						}
					%></li>--%>
        	<!--  <li><a <%if("XTXXJL".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="javascript:viod(0)">消息发送记录</a></li>-->
        </ul>
      </div>
    </div>
    <div></div>
  </div>
 </div>
<%}%>
 