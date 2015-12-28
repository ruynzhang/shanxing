<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.spread.tgtj.ExportTgtj"%>
<%@page import="com.dimeng.p2p.console.servlets.spread.tgtj.SearchCxjl"%>
<%@page import="com.dimeng.p2p.console.servlets.spread.tgtj.SearchTgtj"%>
<%@page import="com.dimeng.p2p.modules.spread.console.service.entity.SpreadTotalInfo"%>
<%@page import="com.dimeng.p2p.modules.spread.console.service.entity.SpreadTotalList"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
		CURRENT_CATEGORY = "TGGL";
		CURRENT_SUB_CATEGORY = "TGTJ";
		PagingResult<SpreadTotalList> result = ObjectHelper.convert(request.getAttribute("result"), PagingResult.class);
		SpreadTotalInfo totalInfo = ObjectHelper.convert(request.getAttribute("totalInfo"), SpreadTotalInfo.class);
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<form action="<%=controller.getURI(request, SearchTgtj.class)%>" method="post">
					<div class="r_main">
						<div class="home_main">
							<div class="box box1 mb15">
								<div class="atil">
									<h3>推广奖励概要列表</h3>
								</div>
								<div class="con">
									<div class="clear"></div>
									<ul class="yhxq_li">
										<li>推广人总数：<span class="blue"><%=totalInfo.personNum%></span>人
										</li>
									</ul>
									<ul class="yhxq_li">
										<li>被推广人总数：<span class="blue"><%=totalInfo.spreadPersonNum%></span>人
										</li>
									</ul>
									<ul class="yhxq_li">
										<li>推广返利总额：<span class="blue"><%=totalInfo.returnMoney%></span>元
										</li>
									</ul>
									<div class="clear"></div>
								</div>
							</div>
							<div class="box box1 mb15">
								<div class="con">
									<div class="admin_input admin_pb">
										<div class="table">
											<p>
												<span> 推广人ID：</span>
												<input type="text" name="id" id="textfield" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("id"));%>" />
											</p>
											<p>
												<span>推广人用户名：</span>
												<input type="text" name="userName" id="textfield4" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("userName"));%>" />
											</p>
											<p>
												<span>推广人姓名:</span>
												<input type="text" name="name" id="textfield4" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("name"));%>" />
											</p>
											<div class="clear"></div>
											<div class="mt10">
												<input name="" type="submit" class="btn2 mr10" value="搜索" style="cursor: pointer;" /> 
												<%if (dimengSession.isAccessableResource(ExportTgtj.class)) {%>
													<a onclick="exportList();" style="cursor: pointer;" class="btn3 mr10"><span class="ico"></span>导出</a>
												<%}else{ %>
													<span class="btn3 btn5 mr10"><span class="ico"></span>导出</span>
												<%} %> 
											</div>
											<div class="clear"></div>
										</div>
									</div>
								</div>
							</div>
							<table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
								<tr class="hsbg">
									<td>序号</td>
									<td>推广人ID</td>
									<td>推广人用户名</td>
									<td>推广人姓名</td>
									<td>推广客户数</td>
									<td>连续奖励总计（元）</td>
									<td>有效推广奖励总计（元）</td>
									<td>推广奖励总计（元）</td>
									<td>操作</td>
								</tr>
								<%
									if(result != null && result.getItemCount() >0){
									SpreadTotalList[] lists = result.getItems(); 
									            if(lists != null ){
									            	int index = 1;
									            	for(SpreadTotalList list : lists){
								%>
								<tr class="dhsbg">
									<td><%=index++%></td>
									<td><%=list.personID%></td>
									<td>
										<%
											StringHelper.filterHTML(out, list.userName);
										%>
									</td>
									<td>
										<%
											StringHelper.filterHTML(out, list.name);
										%>
									</td>
									<td><%=list.customNum%></td>
									<td><%=list.seriesRewarMoney%></td>
									<td><%=list.validRewardMoney%></td>
									<td><%=list.rewardTotalMoney%></td>
									<td class="blue">
									<%if (dimengSession.isAccessableResource(SearchCxjl.class)) {%>
										<a href="<%=controller.getURI(request, SearchCxjl.class)%>?id=<%=list.personID%>">查看持续奖励详情</a>
									<%}else{ %>
										<span class="gray6">查看持续奖励详情</span>
									<%} %>
									</td>
								</tr>
								<%
									}}}
								%>
							</table>
							<div class="box2 clearfix"></div>
							<%
								SearchTgtj.rendPagingResult(out, result);
							%>
						</div>
					</div>
				</form>
			</div>
			<%@include file="/WEB-INF/include/left.jsp"%>
		</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript">
		function exportList(){
			var del_url = '<%=controller.getURI(request, ExportTgtj.class)%>';
	   		var form = document.forms[0];
			form.action = del_url;
			form.submit();
			form.action = '<%=controller.getURI(request, SearchTgtj.class)%>';
		}
	</script>
</body>
</html>