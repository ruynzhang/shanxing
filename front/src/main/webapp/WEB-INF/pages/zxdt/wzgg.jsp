<%@page import="com.dimeng.p2p.S50.enums.T5015_F02"%>
<%@page import="com.dimeng.p2p.S50.enums.T5015_F04"%>
<%@page import="com.dimeng.p2p.S50.entities.T5015"%>
<%@page import="com.dimeng.p2p.modules.base.front.service.NoticeManage"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>网站公告 关于我们</title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
    <!--banner-->
<div class="zq_banner">
<div class="banner"></div>
</div>
<!--banner-->
<%CURRENT_CATEGORY = "ZXDT";CURRENT_SUB_CATEGORY = "WZGG";%>
<%@include file="/WEB-INF/include/gywm/left.jsp"%>
	<div class="contain clearfix">
		<div class="about">
			
			<div class="container">
				<div class="public_tit">平台公告</div>
				<div class="info_cont ny_newslist">
					<ul>
					<%
						final int currentPage = IntegerParser.parse(request
									.getParameter("paging.current"));
						NoticeManage noticeManage = serviceSession.getService(NoticeManage.class);
						PagingResult<T5015> results = noticeManage.search(
								new Paging() {
										public int getCurrentPage() {
											return currentPage;
										}

										public int getSize() {
											return 10;
										}
									});
						T5015[] notices = results.getItems();
							if (notices != null && notices.length > 0) {
								int index=1;
								for (T5015 notice : notices) {
					%>
		             <li>
		             <%--
		             <span <%if(notice.F02 == T5015_F02.HD){ %>class="a_btn"<%}else if(notice.F02 == T5015_F02.XT){ %>class="b_btn"<%}%>>
		             <%=notice.F02.getChineseName()%>
		             </span>
		              --%>
		             <a target="_blank" href="<%=controller.getPagingItemURI(request, Wzgg.class,notice.F01)%>?currentPage=<%=currentPage%>">
		             <span class="lbt"><%StringHelper.filterHTML(out,StringHelper.truncation(notice.F05, 20));%></span> 
		             </a>
		             <span class="ldt fr"><%=Formater.formatDate(notice.F09) %></span>
		             </li>
					<%}}%>
					</ul>
					<div class="clear"></div>
					<%Wzgg.rendPaging(out, results,controller.getPagingURI(request, Wzgg.class)); %>	
				</div>
			</div>
		</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
</body>
</html>