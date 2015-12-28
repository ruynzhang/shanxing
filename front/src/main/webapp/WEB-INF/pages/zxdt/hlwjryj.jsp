<%@page import="com.dimeng.p2p.S50.entities.T5011"%>
<%@page import="com.dimeng.p2p.modules.base.front.service.ArticleManage"%>
<%@page import="com.dimeng.p2p.S50.enums.T5011_F02"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>互联网金融研究 最新动态</title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="contain clearfix">
	<div class="about">
  		<%CURRENT_CATEGORY = "ZXDT";CURRENT_SUB_CATEGORY = "HLWJRYJ";%>
		<%@include file="/WEB-INF/include/gywm/left.jsp"%>
       	<div class="container fr">
         <div class="public_tit"><%=ArticleType.HLWJRYJ.getName()%></div>
         <div class="info_cont ny_newslist">
            <ul>
          	<%
				final int currentPage = IntegerParser.parse(request.getParameter("paging.current"));
				ArticleManage articleManage = serviceSession.getService(ArticleManage.class);
				PagingResult<T5011> results = articleManage.search(T5011_F02.HLWJRYJ, new Paging() {public int getCurrentPage() {return currentPage;}public int getSize() {return 10;}});
				T5011[] articles = results.getItems();
				if (articles != null && articles.length > 0) {
					for (T5011 article : articles) {
			%>
            <li><a target="_blank" href="<%=controller.getPagingItemURI(request, Hlwjryj.class,article.F01)%>"><span class="lbt"><%StringHelper.filterHTML(out, article.F06); %></span><span class="ldt"><%=Formater.formatDate(article.F12)%></span></a></li>
            <%}}%>
            </ul>
            <%Hlwjryj.rendPaging(out, results,controller.getPagingURI(request, Hlwjryj.class)); %>	
         </div>
       </div>
   </div>
</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
</body>
</html>