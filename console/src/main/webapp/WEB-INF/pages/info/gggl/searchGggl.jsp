<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="com.dimeng.p2p.modules.base.console.service.entity.AdvertisementRecord"%>
<%@page import="com.dimeng.p2p.console.servlets.info.gggl.*"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<%
	CURRENT_CATEGORY = "XCGL";
	CURRENT_SUB_CATEGORY = "GGGL";
%>
<%
	PagingResult<AdvertisementRecord> result = ObjectHelper.convert(request.getAttribute("result"), PagingResult.class);
%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
			<form action="<%=controller.getURI(request, SearchGggl.class) %>" method="post">
				<div class="r_main">
					<div class="home_main">
						<div class="box box1 mb15">
							<div class="atil">
                    		<h3>广告管理</h3>
                  			</div>
							<div class="clear"></div>
						  <div class="con">
						<div class="mt10">
						<%if (dimengSession.isAccessableResource(AddGggl.class)) {%>
							<a href="<%=controller.getURI(request, AddGggl.class) %>" class="btn3 mr10"><span class="ico3"></span>添加</a>
						<%}else{ %>
							<span class="btn3 btn5 mr10"><span class="ico3"></span>添加</span>
						<%} %> 
						 <div class="clear"></div>
						</div>
						</div>
						</div>
						<div>
							<table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
								<tr class="hsbg">
									<td>序号</td>
									<td>广告图片标题</td>
									<td>广告图片</td>
									<td>广告类型</td>
									<td>图片链接</td>
									<td>状态</td>
									<td>发布者</td>
									<td>排序值</td>
									<td>上架时间/下架时间</td>
									<td>操作</td>
								</tr>
								<%
									AdvertisementRecord[] items = result.getItems();
									if (items != null) {int index = 1;for (AdvertisementRecord item : items) {
								%>
								<tr class="dhsbg">
									<td><%=index++%></td>
									<td title="<%StringHelper.filterHTML(out, item.title);%>"><%StringHelper.filterHTML(out,StringHelper.truncation(item.title, 15));%></td>
									<td><img src="<%=fileStore.getURL(item.imageCode)%>"  width="158" height="51"/></td>
                                    <td><%if(item.advType.equals("0")){%>Web<%}%><% else{%>手机<% }%></td>
									<td><%if(!StringHelper.isEmpty(item.url)){%><a href="<%=item.url %>" target="_blank"><%StringHelper.filterHTML(out, item.url);%></a><%}%></td>
									<td><%=item.status.getName()%></td>
									<td><%=item.publisherName%></td>
									<td><%=item.sortIndex%></td>
									<td><%=DateTimeParser.format(item.showTime) %><br/><%=DateTimeParser.format(item.unshowTime) %></td>
									<td>
										<span class="blue">
										<%if (dimengSession.isAccessableResource(UpdateGggl.class)) {%>
											<a href="<%=controller.getURI(request,UpdateGggl.class)%>?id=<%=item.id %>" class="mr10">修改</a>
										<%}else{ %>
											<span class="gray6">修改</span>
										<%} %>
										<%if (dimengSession.isAccessableResource(DeleteGggl.class)) {%> 
											<a href="<%=controller.getURI(request,DeleteGggl.class)%>?id=<%=item.id %>" class="mr10">删除</a>
										<%}else{ %>
											<span class="gray6">删除</span>
										<%} %>
										</span>
									</td>
								</tr>
								<%}}%>
							</table>
						</div>
							<%SearchGggl.rendPagingResult(out, result);%>
						<div class="box2 clearfix"></div>
					</div>
				</div>
				</form>
			</div>
			<%@include file="/WEB-INF/include/left.jsp" %>
		</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
</body>
</html>