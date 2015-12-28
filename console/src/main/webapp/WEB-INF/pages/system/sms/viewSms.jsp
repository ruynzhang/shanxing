<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.system.sms.ExportSms"%>
<%@page import="com.dimeng.p2p.console.servlets.system.sms.SmsList"%>
<%@page import="com.dimeng.p2p.modules.systematic.console.service.entity.Sms"%>
<%@page import="com.dimeng.p2p.common.enums.SendType"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
		Sms sms = ObjectHelper.convert(
					request.getAttribute("sms"), Sms.class);
			if (sms == null) {
				response.sendError(HttpServletResponse.SC_NOT_FOUND);
				return;
			}
	%>
	<%
		CURRENT_CATEGORY = "XTGL";
			CURRENT_SUB_CATEGORY = "DXTG";
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<div class="box box1 mb15">
						<div class="atil">
	              				<h3>短信推广</h3>
	           				 </div>
							<div class="con">
								<div class="clear"></div>
								<ul class="cell xc_jcxx ">
									<li>
										<div class="til">
											<span class="red">*</span>管理员：
										</div>
										<div class="info">
											<%
												StringHelper.filterHTML(out, sms.name);
											%>
										</div>
										<div class="clear"></div>
									</li>
									<li>
										<div class="til">
											<span class="red">*</span>创建时间：
										</div>
										<div class="info">
											<%=DateTimeParser.format(sms.createTime)%>
										</div>
										<div class="clear"></div>
									</li>
									<li>
										<div class="til">
											<span class="red">*</span>发送数量：
										</div>
										<div class="info">
											<%=sms.count%>
										</div>
										<div class="clear"></div>
									</li>
									<li>
										<div class="til">
											<span class="red">*</span>手机：
										</div>
										<div class="info">
											<textarea name="mobile" id="textarea" readonly="readonly" cols="45" rows="5" class="border fl mr10 yw_w5"><%if (sms.mobiles != null) {for (String s : sms.mobiles) {%><%=s+"\n"%><%}}%></textarea>
											<a href="<%=controller.getURI(request, ExportSms.class)%>?id=<%=sms.id %>" class="btn3 tc">导出</a>
										</div>
										<div class="clear"></div>
									</li>
									<li>
										<div class="til">
											<span class="red">*</span>短信内容：
										</div>
										<div class="info orange">
											<textarea rows="7" cols="45" class="border" name="content" readonly="readonly"><%StringHelper.filterHTML(out, sms.content);%></textarea>
										</div>
										<div class="clear"></div>
									</li>
								</ul>
								<div class="tc w220 pt20">
									<input type="button" onclick="location.href='<%=controller.getURI(request, SmsList.class)%>'" class="btn4" value="返回" />
								</div>
								<div class="clear"></div>
							</div>
						</div>
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