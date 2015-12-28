<%@page import="com.dimeng.p2p.account.user.service.entity.Xyjl"%>
<%@page import="com.dimeng.p2p.user.servlets.account.Rzsc"%>
<%@page import="com.dimeng.p2p.account.user.service.entity.XyInfo"%>
<%@page import="com.dimeng.p2p.S61.enums.T6120_F05"%>
<%@page import="com.dimeng.p2p.account.user.service.entity.RzxxInfo"%>
<%@page import="com.dimeng.p2p.account.user.service.RzxxManage"%>
<%@include file="/WEB-INF/include/authenticatedSession.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=configureProvider.getProperty(SystemVariable.SITE_NAME)%></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<%
		CURRENT_CATEGORY = "ZHGL";
		CURRENT_SUB_CATEGORY = "RZXX";
		
		RzxxManage manage = serviceSession.getService(RzxxManage.class);
		RzxxInfo[] rzxx = manage.getInfo();
		RzxxInfo[] mustRz = manage.getMustInfo();
		XyInfo xyInfo = manage.getXyInfo();
		Xyjl xyjl = manage.getXyjl();
		String score="";
	%>
	<div class="w994 pb5">
		<span class="f16"><a href="#">我的<%
			configureProvider.format(out,SystemVariable.SITE_NAME);
		%></a></span> &gt; <a href="#">账户管理</a>
		&gt; 认证信息
	</div>
	<div class="contain clearfix">
		<div class="user_top"></div>
		<div class="about">
			<%@include file="/WEB-INF/include/menu.jsp"%>
			<div class="container fr">
				<div class="p15 border">
					<table width="100%" border="0" cellspacing="0" cellpadding="0"
						class="rz_table" style="position: relative;">
						<tr>
							<td width="24%" align="right"></td>
							<td colspan="3">
							<span >信用额度：<%=xyInfo.xyed %>
							</span></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td width="48%">项目</td>
							<td width="17%" align="center">状态</td>
						</tr>
						<%if(mustRz != null && mustRz.length >0){ 
							for(RzxxInfo info :mustRz){
						%>
						<tr>
							<td align="right">必要信用认证：</td>
							<td><%StringHelper.filterHTML(out, info.name); %></td>
							<td align="center">
							<span>
								<%if(info.type == T6120_F05.WYZ){ 
								%>
									<a href="javascript:void(0)" onclick="tcc(this,'<%=info.id %>','<%=controller.getURI(request, Rzsc.class) %>?id=<%=info.id %>','<%StringHelper.filterHTML(out,info.name);%>')" class="btn01">立即认证</a>
								<%}else if(info.type == T6120_F05.TG){ %>
									<i class="btn btn02">通过</i>
								<%}else if(info.type == T6120_F05.BTG){ %>
									<a href="javascript:void(0)" onclick="tcc(this,'<%=info.id %>','<%=controller.getURI(request, Rzsc.class) %>?id=<%=info.id %>','<%StringHelper.filterHTML(out,info.name);%>')" class="btn04">不通过</a>
								<%}else if(info.type == T6120_F05.DSH){ %>
									<i class="btn btn04">待审核</i>
								<%} %>
							</span>
							</td>
						</tr>
						<%}} %>
						<%if(rzxx != null && rzxx.length >0){ 
							for(RzxxInfo info :rzxx){
						%>
						<tr>
							<td align="right">可选信用认证：</td>
							<td><%StringHelper.filterHTML(out, info.name); %></td>
							<td align="center">
							<span>
								<%if(info.type == T6120_F05.WYZ){ 
								%>
									<a href="javascript:void(0)" onclick="tcc(this,'<%=info.id %>','<%=controller.getURI(request, Rzsc.class) %>?id=<%=info.id %>','<%StringHelper.filterHTML(out,info.name);%>')" class="btn01">立即认证</a>
								<%}else if(info.type == T6120_F05.TG){ %>
									<i class="btn btn02">通过</i>
								<%}else if(info.type == T6120_F05.BTG){ %>
									<a href="javascript:void(0)" onclick="tcc(this,'<%=info.id %>','<%=controller.getURI(request, Rzsc.class) %>?id=<%=info.id %>','<%StringHelper.filterHTML(out,info.name);%>')" class="btn04">不通过</a>
								<%}else if(info.type == T6120_F05.DSH){ %>
									<i class="btn btn04">待审核</i>
								<%} %>
							</span>
							</td>
						</tr>
						<%}} %>
						<%
								score=+(xyjl.hxbs*IntegerParser.parse(configureProvider.getProperty(SystemVariable.YZYQJFCF)))+"";
						%>
						<tr>
							<td rowspan="3" align="right"><%=configureProvider.getProperty(SystemVariable.SITE_NAME) %>记录：</td>
							<td>还清笔数</td>
							<td align="center"><%=xyjl.hxbs%>笔</td>
						</tr>
						<tr>
							<%
								if(xyjl.yqcs>0){score="-"+(xyjl.yqcs*IntegerParser.parse(configureProvider.getProperty(SystemVariable.YZYQJFCF)));}else{score="0";}
							%>
							<td>逾期次数</td>
							<td align="center"><%=xyjl.yqcs%>次</td>
						</tr>
						<tr>
							<%
								if(xyjl.yzyqcs>0){score="-"+(xyjl.yzyqcs*IntegerParser.parse(configureProvider.getProperty(SystemVariable.YZYQJFCF)));}else{score="0";}
							%>
							<td>严重逾期笔数</td>
							<td align="center"><%=xyjl.yzyqcs%>次</td>
						</tr>
					</table>
				</div>
			</div>
			<div class="clear"></div>
		</div>
	</div>
	<script type="text/javascript">
		
	</script>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<%@include file="/WEB-INF/include/dialog.jsp"%>
	<script type="text/javascript">
		function tcc(evn, tid, url, titl) {
			global_art = art.dialog.open(url, {
				id : tid,
				title : titl,
				opacity : 0.1,
				width : 783,
				height : 500,
				lock : true,
				close : function() {
					var iframe = this.iframe.contentWindow;
					window.location.reload();
				}
			}, false);
		}
	</script>
</body>
</html>