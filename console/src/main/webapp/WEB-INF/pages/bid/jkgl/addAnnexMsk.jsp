<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.ViewAuthentication"%>
<%@page import="com.dimeng.p2p.modules.bid.console.service.entity.MskAnnex"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.AnnexMsk"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.AddEnterpriseXq"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.AddUserInfoXq"%>
<%@page import="com.dimeng.p2p.S62.entities.T6232"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.LoanList"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F11"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F13"%>
<%@page import="com.dimeng.p2p.S62.entities.T6230"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F06"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.DelAnnexMsk"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.UpdateProject"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.AddGuaranteeXq"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.AddDyw"%>
<%@page import="com.dimeng.p2p.common.enums.LoanType"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.AddAnnexWz"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.AddAnnexMsk"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.ViewAnnexMsk"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
		CURRENT_CATEGORY="YWGL";
		CURRENT_SUB_CATEGORY="BDGL";
		MskAnnex[] t6232s =ObjectHelper.convertArray(request.getAttribute("t6232s"), MskAnnex.class);
		T6110_F06 userType=EnumParser.parse(T6110_F06.class, request.getAttribute("userType").toString());
		T6230 t6230=ObjectHelper.convert(request.getAttribute("t6230"), T6230.class);
		int loanId=IntegerParser.parse(request.getParameter("loanId"));
		int userId=IntegerParser.parse(request.getParameter("userId"));
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<div class="box box1 mb15">
							<div class="atil">
								<h3>新增/修改附件信息</h3>
							</div>
						</div>
						<div class="newsbox">
							<div class="til clearfix">
								<div class="Menubox">
									<ul>
										<%
											if(loanId>0)
																											{
										%>
										<li><a href="<%=controller.getURI(request, UpdateProject.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">项目信息</a></li>
										<%
											}
										%>
										<%
											if(userType==T6110_F06.ZRR)
																											{
										%>
										<li><a href="<%=controller.getURI(request, AddUserInfoXq.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">个人信息</a></li>
										<li><a href="<%=controller.getURI(request, ViewAuthentication.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">个人认证信息</a></li>
										<%
											}
										%>
										<%
											if(userType==T6110_F06.FZRR)
																											{
										%>
										<li><a href="<%=controller.getURI(request, AddEnterpriseXq.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">企业信息</a></li>
										<%
											}
										%>
										<%
											if(T6230_F13.S==t6230.F13){
										%>
										<li><a href="<%=controller.getURI(request, AddDyw.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">抵押物信息</a></li>
										<%
											}
										%>
										<%
											if(T6230_F11.S==t6230.F11)
																			{
										%>
										<li><a href="<%=controller.getURI(request, AddGuaranteeXq.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">担保信息</a></li>
										<%
											}
										%>
										<li class="hover">附件(马赛克)</li>
										<li><a href="<%=controller.getURI(request, AddAnnexWz.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">附件(完整版)</a></li>
									</ul>
								</div>
							</div>
							<div class="border p30 Men_bt no_table">
								<div class="mb20">
									<div class="mb20">
										<input type="button" class="btn4 mr20" value="上传附件" onclick="tcc(this,'FJ','<%=controller.getURI(request, AnnexMsk.class)%>?loanId=<%=loanId%>&userId=<%=userId%>','上传附件')" />
										<div class="clear"></div>
									</div>
									<div class="yw_jcxx">
										<table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
											<tr class="hsbg">
												<td>序号</td>
												<td>附件名称</td>
												<td>附件大小</td>
												<td>附件格式</td>
												<td>上传人</td>
												<td>附件类型</td>
												<td>上传时间</td>
												<td>操作</td>
											</tr>
											<%
												if(t6232s!=null)
																					{int i=1;
																					for(MskAnnex t6232:t6232s)
																					{	if(t6232==null){continue;}
											%>
											<tr>
												<td><%=i++%></td>
												<td>
													<%
														StringHelper.filterHTML(out, t6232.F05);
													%>
												</td>
												<td><%=t6232.F06/1000%>kb</td>
												<td>
													<%
														StringHelper.filterHTML(out, t6232.F07);
													%>
												</td>
												<td>
													<%
														StringHelper.filterHTML(out, t6232.name);
													%>
												</td>
												<td><%
													StringHelper.filterHTML(out, t6232.annexName);
												%></td>
												<td><%=DateTimeParser.format(t6232.F08)%></td>
												<td><a href="<%=controller.getURI(request, ViewAnnexMsk.class)%>?id=<%=t6232.F01%>" target="_blank">查看</a>&nbsp;<a
													href="<%=controller.getURI(request, DelAnnexMsk.class)%>?loanId=<%=loanId%>&userId=<%=userId%>&id=<%=t6232.F01%>" onclick="return onDelete()">删除</a></td>
											</tr>
											<%}} %>
										</table>
									</div>
								</div>
								<div class="w350">
									<a href="<%=controller.getURI(request, AddAnnexWz.class)%>?loanId=<%=loanId%>&userId=<%=userId%>" class="btn4 mr30 tc">保存并继续</a> <a
										href="<%=controller.getURI(request, LoanList.class)%>" class="btn5 tc">取消</a>
								</div>
								<div class="clear"></div>
							</div>
						</div>
						<div class="clear"></div>
					</div>
				</div>
			</div>
			<%@include file="/WEB-INF/include/left.jsp"%>
		</div>
	</div>
	<%
		String warringMessage=controller.getPrompt(request, response, PromptLevel.WARRING);
			if(!StringHelper.isEmpty(warringMessage))
			{
	%>
	<div class="w440 thickbox thickpos" style="margin: -80px 0 0 -220px;" id="showDiv">
		<div class="info clearfix">
			<div class="clearfix">
				<span class="fl tips">
					<%
						StringHelper.filterHTML(out, warringMessage);
					%>
				</span>
			</div>
			<div class="dialog_btn">
				<input type="button" name="button2" onclick="$('#showDiv').hide()" value="确认" class="btn4 ml50" />
			</div>
		</div>
	</div>
	<%
		}
	%>
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
		function onDelete()
		{
			if(window.confirm("你确认要删除该附件吗?"))
			{
				return true;
			}else
			{
				return false;	
			}
		}
	</script>
</body>
</html>