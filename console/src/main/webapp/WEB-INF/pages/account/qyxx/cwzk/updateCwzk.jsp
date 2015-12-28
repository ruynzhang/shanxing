<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.account.qyxx.UpdateQyxx"%>
<%@page import="com.dimeng.p2p.console.servlets.account.qyxx.dgzh.UpdateDgzh"%>
<%@page import="com.dimeng.p2p.console.servlets.account.qyxx.cwzk.UpdateCwzk"%>
<%@page import="com.dimeng.p2p.console.servlets.account.qyxx.ccxx.ListCcxx"%>
<%@page import="com.dimeng.p2p.S61.entities.T6163"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="com.dimeng.p2p.console.servlets.account.qyxx.fcxx.ListFcxx"%>
<%@page import="com.dimeng.p2p.console.servlets.account.qyxx.lxxx.UpdateLxxx"%>
<%@page import="com.dimeng.p2p.console.servlets.account.qyxx.jscl.UpdateJscl"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
		CURRENT_CATEGORY = "YHGL";
		CURRENT_SUB_CATEGORY = "QY";
		T6163[] entitys = ObjectHelper.convertArray(request.getAttribute("info"), T6163.class); 	
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
									<li><a href="<%=controller.getURI(request, UpdateQyxx.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("id"));%>">企业信息</a></li>
									<li><a href="<%=controller.getURI(request, UpdateJscl.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("id"));%>">介绍资料</a></li>
									<li class="hover">财务状况</li>
									<li><a href="<%=controller.getURI(request, UpdateLxxx.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("id"));%>">联系信息</a></li>
									<li ><a href="<%=controller.getURI(request, ListCcxx.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("id"));%>">车产信息</a></li>
									<li><a href="<%=controller.getURI(request, ListFcxx.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("id"));%>">房产信息</a></li>
									<%--
									<li><a href="<%=controller.getURI(request, UpdateDgzh.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("id"));%>">对公账户</a></li>
									 --%>
								</ul>
							</div>
							</div>
							 <div class="border p30 Men_bt no_table">
								<form action="<%=controller.getURI(request, UpdateCwzk.class)%>" method="post" class="form1">
								<input type="hidden" id="id" name="id" value="<%=request.getParameter("id")%>">	
									<div>
										<table width="100%" border="0" cellspacing="0" cellpadding="3"
											class="yhgl_table tc">
											<tr class="hsbg">
												<td width="10%">年份</td>
												<td width="15%">主营收入（万元）</td>
												<td width="15%">净利润（万元）</td>
												<td width="15%">总资产（万元）</td>
												<td width="15%">净资产（万元）</td>
												<td width="15%">备注</td>
											</tr>
											<%
												int i=0;
												for(T6163 entity:entitys){
											%>
											<tr>
												<td>
													<input type="hidden" value="<%=entity.F01 %>" name="t6163s[<%=i%>].F01"/>
													<input type="hidden" value="<%=entity.F02 %>" name="t6163s[<%=i%>].F02"/>
													<%=entity.F02 %>年
												</td>
												<td><input name="t6163s[<%=i%>].F03" type="text" mtest="/^((([1-9][0-9]*)|0)|((([1-9][0-9]*)|0)\.[0-9]{1,2}))$/" mtestmsg="必须为数字" maxlength="18"
													class="text yhgl_ser w100 required"  value="<%=entity.F03 %>" />
													<p tip></p>
													<p errortip class="" style="display: none"></p>	
												</td>
												<td><input name="t6163s[<%=i%>].F05" type="text" mtest="/^((([1-9][0-9]*)|0)|((([1-9][0-9]*)|0)\.[0-9]{1,2}))$/" mtestmsg="必须为数字" maxlength="18"
													class="text yhgl_ser w100 required"   value="<%=entity.F05 %>" />
													<p tip></p>
													<p errortip class="" style="display: none"></p>	
												</td>
												<td><input name="t6163s[<%=i%>].F06" type="text" mtest="/^((([1-9][0-9]*)|0)|((([1-9][0-9]*)|0)\.[0-9]{1,2}))$/" mtestmsg="必须为数字" maxlength="18"
													class="text yhgl_ser w100 required" value="<%=entity.F06 %>" />
													<p tip></p>
													<p errortip class="" style="display: none"></p>	
												</td>
												<td><input name="t6163s[<%=i%>].F07" type="text" mtest="/^((([1-9][0-9]*)|0)|((([1-9][0-9]*)|0)\.[0-9]{1,2}))$/" mtestmsg="必须为数字"  maxlength="18"
													class="text yhgl_ser w100 required"  value="<%=entity.F07 %>" />
													<p tip></p>
													<p errortip class="" style="display: none"></p>	
												</td>
												<td><input name="t6163s[<%=i%>].F08" type="text" maxlength="200"
													class="text yhgl_ser w100 " value="<%StringHelper.filterHTML(out, entity.F08); %>" />
													<p tip></p>
													<p errortip class="" style="display: none"></p>	
												</td>
											</tr>
											<%i++;} %>
										</table>
									</div>

									<div class="tc w220 pt20">
										<input type="submit" class="btn4 mr30 sumbitForme" value="保存并继续"
											fromname="form1" /> <input type="button"
											onclick="window.location.href='<%=controller.getURI(request, QyList.class)%>'"
											class="btn4" value="取消" />
									</div>
									<div class="clear"></div>
								</form>
							</div>
						<div class="box2 clearfix"></div>
						</div>
					</div>
				</div>
			</div>
			<%@include file="/WEB-INF/include/left.jsp"%>
		</div>
	</div>

	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript"
		src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
</body>
</html>