<%@page import="com.dimeng.p2p.S50.entities.T5011"%>
<%@page import="com.dimeng.p2p.modules.base.front.service.ArticleManage"%>
<%@page import="com.dimeng.p2p.S50.enums.T5011_F02"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>媒体报道 关于我们</title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
                <!--banner-->
<div class="zq_banner">
<div class="banner"></div>
</div>
<%CURRENT_CATEGORY = "ZXDT";CURRENT_SUB_CATEGORY = "MTBD";%>
<%@include file="/WEB-INF/include/gywm/left.jsp"%>
<!--banner-->
	<div class="contain clearfix">
		<div class="about">
			
			<div class="container">
				<div class="public_tit"><%=ArticleType.MTBD.getName()%></div>
				 <div class="info_cont responsibility">
					<%
						final int currentPage = IntegerParser.parse(request
									.getParameter("paging.current"));
							ArticleManage articleManage = serviceSession.getService(ArticleManage.class);
							PagingResult<T5011> results = articleManage.search(T5011_F02.MTBD, new Paging() {public int getCurrentPage() {return currentPage;}public int getSize() {return 10;}});
							T5011[] articles = results.getItems();
							if (articles != null && articles.length > 0) {
								for (T5011 article : articles) {
					%>
					<dl>
		             	<%if(!StringHelper.isEmpty(article.F09)){%><dt style="display:none;"><img src="<%=fileStore.getURL(article.F09)%>" width="240" height="135" /></dt>
		             	<%}else{%><dt style="display:none;"></dt><%}%>
			            <dd>
			               <p class="clearfix"><a target="_blank" href="<%=controller.getPagingItemURI(request, Mtbd.class,article.F01)%>?currentPage=<%=currentPage%>"><%StringHelper.filterHTML(out, article.F06); %></a><span class="fr"><%=DateParser.format(article.F12)%></span></p>
			               <p class="h150" style="display:none;"><%StringHelper.format(out, article.F08, fileStore);%></p>
			            </dd>
		           </dl>
					<%}}%>
					<div class="clear"></div>
					<%Mtbd.rendPaging(out, results,controller.getPagingURI(request, Mtbd.class)); %>	
				</div>
                <div class="clear"></div>
			</div>
		</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
</body>
</html>