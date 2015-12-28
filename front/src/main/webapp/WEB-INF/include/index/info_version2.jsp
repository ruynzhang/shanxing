<%@page import="com.dimeng.p2p.S50.entities.T5015"%>
<%@page import="com.dimeng.p2p.modules.base.front.service.NoticeManage"%>
<%@page import="com.dimeng.p2p.S50.entities.T5011"%>
<%@page import="com.dimeng.p2p.modules.base.front.service.ArticleManage"%>
<%@page import="com.dimeng.p2p.S50.enums.T5011_F02"%>
<%@page import="com.dimeng.p2p.front.servlets.zxdt.Mtbd"%>
<%@page import="com.dimeng.p2p.front.servlets.zxdt.Wdhyzx"%>



        
  

<!-- 媒体报道 -->
 <div class="Parag">
      <div class="cement news_ct">
        <div class="noun">
          <h2>媒体报道</h2>
          <a href="<%=controller.getViewURI(request, Mtbd.class)%>">更多 &gt;&gt;</a> </div>
           <%
			final int currentPage = IntegerParser.parse(request
						.getParameter("paging.current"));
				ArticleManage articleManage = serviceSession.getService(ArticleManage.class);
				PagingResult<T5011> results = articleManage.search(T5011_F02.MTBD, new Paging() {public int getCurrentPage() {return currentPage;}public int getSize() {return 2;}});
				T5011[] articles = results.getItems();
				if (articles != null && articles.length > 0) {
					for (T5011 article : articles) {
			
		%>
        <dl>
          <dt><a target="_blank" href="<%=controller.getPagingItemURI(request, Mtbd.class,article.F01)%>"><img  src="<%=fileStore.getURL(article.F09) %>" width="107" height="27" alt="善林资产" title=""></a></dt>
          <h3><a target="_blank" href="<%=controller.getPagingItemURI(request, Mtbd.class,article.F01)%>">
         <%StringHelper.filterHTML(out, article.F06); %></a></h3>
          <p><%StringHelper.filterHTML(out, article.F08); %></p>
          <br>
        </dl>
        <% } } %>
         </div>
      <div class="cement">
        <div class="noun">
          <h2>行业资讯</h2>
          <a href="<%=controller.getViewURI(request, Wdhyzx.class)%>">更多 &gt;&gt;</a> </div>
          <%
           results = articleManage.search(
					T5011_F02.WDHYZX, new Paging() {public int getCurrentPage() {return currentPage;}public int getSize() {return 5;}});
				articles = results.getItems();
				if (articles != null && articles.length > 0) {
					for (T5011 article : articles) {
			%>
          <p><a target="_blank" href="<%=controller.getPagingItemURI(request, Wdhyzx.class,article.F01 )%>" ><%StringHelper.filterHTML(out, article.F06); %></a></p>
         <%}}%>
         </div>
      <div class="cement">
        <div class="noun">
          <h2>平台公告</h2>
          <a href="<%configureProvider.format(out,URLVariable.WZGG_XQ);%>">更多 &gt;&gt;</a> </div>
          	<%
		PagingResult<T5015> results1 = noticeManage.search(
				new Paging() {
						public int getCurrentPage() {
							return 1;
						}

						public int getSize() {
							return 5;
						}
					});
		T5015[] notices = results1.getItems();
			if (notices != null && notices.length > 0) {
				for (T5015 notice : notices) {%>
          <p><a href="<%configureProvider.format(out,URLVariable.WZGG_XQ);%><%=notice.F01%>.html" target="_blank"><%=notice.F05%></a></p>
         <%		}
			}
		%>
         </div>
      
      <div class="clear"></div>
    </div>
       <%@include file="/WEB-INF/include/index/friendlyLink.jsp"%>
  </div>

