<%@page import="com.dimeng.p2p.S50.entities.T5011"%>
<%@page import="com.dimeng.p2p.S50.entities.T5014"%>
<%@page import="com.dimeng.p2p.modules.base.front.service.ArticleManage"%>
<%@page import="com.dimeng.p2p.modules.base.front.service.FriendlyLinkManage"%>
<%@page import="com.dimeng.p2p.S50.enums.T5011_F02"%>
<%@page import="com.dimeng.p2p.front.servlets.AbstractFrontServlet"%>
<%@page import="com.dimeng.p2p.front.servlets.zxdt.Mtbd"%>
<%@page import="com.dimeng.p2p.front.servlets.zxdt.Hlwjryj"%>
<%@page import="com.dimeng.p2p.front.servlets.zxdt.Wdhyzx"%>
<%@page import="com.dimeng.p2p.common.enums.ArticleType"%>
<div class="clear"></div>


<div class="sx_infobox">
    <div class="sx_normal_box sx_media mt22">
    <div class="sx_box_title"><a href="<%=controller.getViewURI(request, Mtbd.class)%>" class="sx_info_more">更多&gt;&gt;</a>媒体报道</div>
        <ul class="sx_infoList">
        <%
			final int currentPage = IntegerParser.parse(request
						.getParameter("paging.current"));
				ArticleManage articleManage = serviceSession.getService(ArticleManage.class);
				PagingResult<T5011> results = articleManage.search(T5011_F02.MTBD, new Paging() {public int getCurrentPage() {return currentPage;}public int getSize() {return 5;}});
				T5011[] articles = results.getItems();
				if (articles != null && articles.length > 0) {
					for (T5011 article : articles) {
		%>
           <li><p><a target="_blank" href="<%=controller.getPagingItemURI(request, Mtbd.class,article.F01)%>"><%StringHelper.filterHTML(out, article.F06); %></a></p><span><%=DateParser.format(article.F12)%></span></li>

		<%}}%>
        </ul>
        <div class="clear"></div>
    </div>
    <div class="sx_normal_box sx_news mt22">
       <div class="sx_box_title"><a href="<%=controller.getViewURI(request, Wdhyzx.class)%>" class="sx_info_more">更多&gt;&gt;</a>行业资讯</div>
        <ul class="sx_infoList">
          <%
          	results = articleManage.search(
					T5011_F02.WDHYZX, new Paging() {public int getCurrentPage() {return currentPage;}public int getSize() {return 5;}});
				articles = results.getItems();
				if (articles != null && articles.length > 0) {
					for (T5011 article : articles) {
			%>
           <li><p><a target="_blank" href="<%=controller.getPagingItemURI(request, Wdhyzx.class,article.F01 )%>"><%StringHelper.filterHTML(out, article.F06); %></a></p><span><%=DateParser.format(article.F12) %></span></li>
           <%}}%>
        </ul>
        <div class="clear"></div>
    </div>
    <%--
    <div class="clear"></div>
    <div class="sx_partner">
      <h1 class="sx_t2 sx_tc2">合作伙伴<a href="#" class="sx_info_more">更多&gt;&gt;</a></h1>
      <ul>
        <li><a href="<%=controller.getStaticPath(request)%>/gywm/hzjg.html"><img src="images/partner_01.png" alt="" /></a></li>
        <li><a href="<%=controller.getStaticPath(request)%>/gywm/hzjg.html"><img src="images/partner_02.png" alt="" /></a></li>
        <li><a href="<%=controller.getStaticPath(request)%>/gywm/hzjg.html"><img src="images/partner_03.png" alt="" /></a></li>
        <li><a href="<%=controller.getStaticPath(request)%>/gywm/hzjg.html"><img src="images/partner_04.png" alt="" /></a></li>
        <li class="last"><a href="<%=controller.getStaticPath(request)%>/gywm/hzjg.html"><img src="images/partner_05.png" alt="" /></a></li>
      </ul>
      <div class="clear"></div>
    </div>
    <div class="clear"></div>
     --%>
    <div class="clear"></div>
</div>
<div class="sx_normal_box">
       <div class="sx_box_title f16 sx_grey">友情链接<a href="#" class="sx_info_more">更多&gt;&gt;</a></div>
      <div class="sx_friendlink_list">
        <%
      FriendlyLinkManage friendlyLinkManage = serviceSession.getService(FriendlyLinkManage.class);
      T5014[] t5014s = friendlyLinkManage.getAll();
      if(t5014s != null){
    	  for(T5014 t5014 : t5014s){%>
    	<a target="_blank" href="<%=t5014.F05%>" <%="T".equals(t5014.nofollow)?"rel=\"nofollow\"":""%>><%=t5014.F04%></a>
    <%	  }
      }
      %>
      </div>
      <div class="clear"></div>
    </div>
