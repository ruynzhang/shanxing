<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.S50.entities.T5011"%>
<%@page import="com.dimeng.p2p.modules.base.front.service.ArticleManage"%>
<%@page import="com.dimeng.p2p.S50.enums.T5011_F02"%>
<html>
<head>
<title>社会责任 关于我们</title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="contain clearfix">
		<div class="about">
			<%CURRENT_CATEGORY = "ZXDT";CURRENT_SUB_CATEGORY = "SHZR";%>
			<%@include file="/WEB-INF/include/gywm/left.jsp"%>
			<div class="container fr">
				<div class="public_tit"><%=ArticleType.SHZR.getName()%></div>
				 <div class="info_cont responsibility">
					<%
						final int currentPage = IntegerParser.parse(request
									.getParameter("paging.current"));
						ArticleManage articleManage = serviceSession.getService(ArticleManage.class);
						PagingResult<T5011> results = articleManage.search(T5011_F02.SHZR, new Paging() {public int getCurrentPage() {return currentPage;}public int getSize() {return 10;}});
						T5011[] articles = results.getItems();
						if (articles != null && articles.length > 0) {
							for (T5011 article : articles) {
					%>
					<dl>
		             	<dt><%if(!StringHelper.isEmpty(article.F09)){%><img src="<%=controller.getStaticPath(request)%><%=fileStore.getURL(article.F09)%>" width="280" height="190"/></dt><%}%>
			            <dd>
			               <p class="tit"><a target="_blank" href="<%=controller.getPagingItemURI(request, Shzr.class,article.F01 )%>"><%StringHelper.filterHTML(out, article.F06); %></a></p>
			               <p class="clearfix"><span class="fl"><%StringHelper.filterHTML(out, article.F07);%></span><span class="fr"><%=DateParser.format(article.F12)%></span></p>
			               <p class="h150"><%StringHelper.format(out, article.F08, fileStore);%></p>
			               <p><a target="_blank" href="<%=controller.getPagingItemURI(request, Shzr.class,article.F01 )%>" class="btn btn01 mt10">查看详情</a></p>
			            </dd>
		           </dl>
					<%}}%>
				</div>
				<%Shzr.rendPaging(out, results,controller.getPagingURI(request, Shzr.class)); %>
			</div>
		</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
</body>
</html>