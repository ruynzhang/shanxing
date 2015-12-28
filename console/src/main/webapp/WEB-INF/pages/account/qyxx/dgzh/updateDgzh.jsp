<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.account.qyxx.dgzh.UpdateDgzh"%>
<%@page import="com.dimeng.p2p.S50.entities.T5020"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.QyManage"%>
<%@page import="com.dimeng.p2p.console.servlets.account.qyxx.lxxx.UpdateLxxx"%>
<%@page import="com.dimeng.p2p.console.servlets.account.qyxx.fcxx.ListFcxx"%>
<%@page import="com.dimeng.p2p.console.servlets.account.qyxx.ccxx.ListCcxx"%>
<%@page import="com.dimeng.p2p.console.servlets.account.qyxx.cwzk.UpdateCwzk"%>
<%@page import="com.dimeng.p2p.console.servlets.account.qyxx.jscl.UpdateJscl"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="com.dimeng.p2p.S61.entities.T6114"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
		CURRENT_CATEGORY = "YHGL";
		CURRENT_SUB_CATEGORY = "QY";
		QyManage manage = serviceSession.getService(QyManage.class);
		T6114 entity = ObjectHelper.convert(request.getAttribute("info"), T6114.class);
		T5020[] banks = ObjectHelper.convertArray(request.getAttribute("bank"), T5020.class);
			int shengId=0;
			int shiId=0;
			int xianId=0;
			final int regionId = entity.F04;
			if (regionId % 10000 < 100) {
		            shengId = regionId;
		        } else if (regionId % 100 < 1) {
		            shengId = regionId / 10000 * 10000;
		            shiId = regionId;
		        } else {
		            shengId = regionId / 10000 * 10000;
		            shiId = regionId / 100 * 100;
		            xianId = regionId;
		       }
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<div class="box box1 mb15">
							<div class="atil">
								<h3>修改企业信息</h3>
							</div>
						</div>
						<div class="newsbox">
							<div class="til clearfix">
								<div class="Menubox">
									<ul>
										<li><a href="<%=controller.getURI(request, UpdateJscl.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("id"));%>">介绍资料</a></li>
										<li><a href="<%=controller.getURI(request, UpdateCwzk.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("id"));%>">财务状况</a></li>
										<li><a href="<%=controller.getURI(request, UpdateLxxx.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("id"));%>">联系信息</a></li>
										<li><a href="<%=controller.getURI(request, ListCcxx.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("id"));%>">车产信息</a></li>
										<li><a href="<%=controller.getURI(request, ListFcxx.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("id"));%>">房产信息</a></li>
										<li class="hover">对公账户</li>
									</ul>
								</div>
							</div>
							<div class="border p30 Men_bt no_table">
								<input id="shengId" value="<%=shengId%>" type="hidden" /> 
								<input id="shiId" value="<%=shiId%>" type="hidden" /> 
								<input id="xianId" value="<%=xianId%>" type="hidden" />
								<form action="<%=controller.getURI(request, UpdateDgzh.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("id"));%>"
									method="post" class="form1">
									<ul class="cell noborder no_wi">
										<li>
											<div class="til">
												<span class="red">*</span>开户名：
											</div>
											<div class="info">
											<%StringHelper.filterHTML(out, manage.getName(IntegerParser.parse(request.getParameter("id")))); %>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">
												<span class="red">*</span>选择银行：
											</div>
											<div class="info">
												 <select name="F03" class="text yhgl_ser">
												 	<%
												 	if(banks != null){
												 		for(T5020 bank :banks){
												 	%>
												 	<option value="<%=bank.F01%>"><%StringHelper.filterHTML(out, bank.F02); %></option>
												 	<%} }%>
         			 							</select>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">
												<span class="red">*</span>开户行所在地：
											</div>
											<div class="F04">
												<select name="sheng" class="sel01"></select> 
												<select name="shi" class="sel01"></select> 
												<select name="xian" class="sel01 required"></select>
												<p tip></p>
												<p errortip class="" style="display: none"></p>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">
												<span class="red">*</span>开户行：
											</div>
											<div class="info">
												<input name="F05" maxlength="20" type="text"
													class="text yhgl_ser required" value="<%StringHelper.filterHTML(out, entity.F05); %>" />
												<p tip></p>
												<p errortip class="" style="display: none"></p>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">
												<span class="red">*</span>银行卡卡号：
											</div>
											<div class="info">
												<input name="F06" maxlength="20" type="text"
													class="text yhgl_ser  required isint textv-a" value="<%StringHelper.filterHTML(out,StringHelper.decode(entity.F07)); %>" />
												<p tip></p>
												<p errortip class="" style="display: none"></p>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">
												<span class="red">*</span>确认卡号：
											</div>
											<div class="info">
												<input name="F07" maxlength="20" type="text"
													class="text yhgl_ser required isint textv-b"  onpaste="return false"  value="<%StringHelper.filterHTML(out, entity.F06); %>" />
												<p tip></p>
												<p errortip class="" style="display: none"></p>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="info">
												<input type="hidden" name="F01" value="<%=entity.F01%>" />
												<input type="hidden" name="F02" value="<%StringHelper.filterHTML(out, request.getParameter("id"));%>" />
											</div>
										</li>
										<li>
											<div class="clear"></div>
										</li>
									</ul>
									<div class="tc w220">
										<input type="submit" class="btn4 mr30 sumbitForme" value="确认"
											fromname="form1" /> <input type="button" class="btn4"
											onclick="window.location.href='<%=controller.getURI(request, QyList.class)%>'"
											value="返回" />
									</div>
									<div class="clear"></div>
								</form>
							</div>
							<div class="mb15"></div>
							<div class="box2 clearfix"></div>
						</div>
					</div>
				</div>
			</div>
			<%
				String warringMessage = controller.getPrompt(request, response,
							PromptLevel.ERROR);
					if (!StringHelper.isEmpty(warringMessage)) {
			%>
			<div class="w440 thickbox thickpos" style="margin: -80px 0 0 -220px;"
				id="showDiv">
				<div class="info clearfix">
					<div class="clearfix">
						<span class="fl tips">
							<%
								StringHelper.filterHTML(out, warringMessage);
							%>
						</span>
					</div>
					<div class="dialog_btn">
						<input type="button" name="button2" onclick="$('#showDiv').hide()"
							value="确认" class="btn4 ml50" />
					</div>
				</div>
			</div>
			<%
				}
			%>
			<%@include file="/WEB-INF/include/left.jsp"%>
		</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/region.js"></script>
	<script type="text/javascript">
		function fncKeyStop(evt)
		{
    			if(!window.event)
   		{
        var keycode = evt.keyCode;
        var key = String.fromCharCode(keycode).toLowerCase();
        if(evt.ctrlKey && key == "v")
        {
          evt.preventDefault();
          evt.stopPropagation();
        		}
   			 }
		}
	</script>
</body>
</html>