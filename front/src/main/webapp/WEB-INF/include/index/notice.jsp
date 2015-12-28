<%@page import="com.dimeng.p2p.S50.enums.T5015_F02"%>
<%@page import="com.dimeng.p2p.S50.entities.T5015"%>
<%@page import="com.dimeng.p2p.modules.base.front.service.NoticeManage"%>
<%@page import="com.dimeng.p2p.front.servlets.AbstractFrontServlet"%>
<%@page import="com.dimeng.p2p.front.servlets.zxdt.Wzgg"%>
<%@page import="com.dimeng.p2p.common.enums.*"%>
<div class="clear"></div>
<%{
	NoticeManage noticeManage = serviceSession.getService(NoticeManage.class);
	PagingResult<T5015> noticeResult = noticeManage.search(AbstractFrontServlet.INDEX_PAGING);
	T5015[] notices = noticeResult.getItems();
	
%>
<div class="notice clearfix">
	<div class="s_icon">
		<img src="<%=controller.getStaticPath(request)%>/images/news_icons.gif" width="28" height="28" />
	</div>
	<div class="txtScroll-top">
		<div class="bd">
			<ul class="infoList">
				<%if (notices != null) {for (T5015 notice : notices) {%>
				<li><a href="<%=controller.getPagingItemURI(request, Wzgg.class,notice.F01)%>" title="<%StringHelper.filterHTML(out, notice.F05);%>"><span 
				<%if(notice.F02==T5015_F02.HD){ %>class="a_btn fl"<%}%>
		        <%if(notice.F02==T5015_F02.XT){ %>class="b_btn fl"<%}%>
				><%=notice.F02.getChineseName()%></span><span class="lbt"><%StringHelper.filterHTML(out, notice.F05);%>
				</span><span class="ldt"><%=DateParser.format(notice.F08)%></span></a></li>
				<%}}%>
			</ul>
		</div>
	</div>
	<div class="fr btn">
		<a href="<%=controller.getViewURI(request, Wzgg.class)%>" class="s_btn">更多公告</a>
	</div>
</div>
<%}%>