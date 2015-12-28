<%@page import="com.dimeng.p2p.S50.entities.T5011"%>
<%@page import="com.dimeng.p2p.modules.base.front.service.ArticleManage"%>
<%@page import="com.dimeng.p2p.S50.enums.T5011_F02"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>专家顾问 关于我们</title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="contain clearfix">
		<div class="about">
			<%
				CURRENT_CATEGORY = "GYWM";
				CURRENT_SUB_CATEGORY = "ZJGW";
			%>
			<%@include file="/WEB-INF/include/gywm/left.jsp"%>
			<div class="container fr">
				<div class="public_tit"><%=ArticleType.ZJGW.getName()%></div>
				<div class="info_cont team_manage">
					<%
						final int currentPage = IntegerParser.parse(request.getParameter("paging.current"));
						ArticleManage articleManage = serviceSession.getService(ArticleManage.class);
						PagingResult<T5011> results = articleManage.search(
								T5011_F02.ZJGW, new Paging() {
							public int getCurrentPage() {
								return currentPage;
							}

							public int getSize() {
								return 10;
							}
						});
						T5011[] articles = results.getItems();
						if (articles != null && articles.length > 0) {
							for (T5011 article : articles) {
					%>
					<dl>
						<dt><%if(!StringHelper.isEmpty(article.F09)){%><img src="<%=fileStore.getURL(article.F09)%>" /><%}%></dt>
						<dd>
							<p class="tit"><%StringHelper.filterHTML(out, article.F06);%></p>
							<p class="clearfix">
							
								<span class="fl"><%StringHelper.filterHTML(out, article.F07);%></span>
								<span class="fr"><%=TimestampParser.format(article.F12)%></span>
							</p>
							<p class="h150" id="connent"><%StringHelper.format(out, articleManage.getContent(article.F01), fileStore);%></p>
						</dd>
					</dl>
					<%}}%>
				</div>
				<%Zjgw.rendPaging(out, results,controller.getPagingURI(request, Zjgw.class)); %>
			</div>
		</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript">
	$(function(){
	     var element = $("#connent");
	     var temp =  element.text().replace(/\n/g,'<br/>');
	     element.html(temp);
	});
	</script>
</body>
</html>