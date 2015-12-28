<%@page import="com.dimeng.p2p.S50.entities.T5018"%>
<%@page import="com.dimeng.p2p.modules.base.front.service.PerformanceReportManage"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<title>业绩报告 最新动态</title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="contain clearfix">
   	<div class="about">
  		<%CURRENT_CATEGORY = "ZXDT";CURRENT_SUB_CATEGORY = "YJBG";%>
		<%@include file="/WEB-INF/include/gywm/left.jsp"%>
       <div class="container fr">
         <div class="public_tit">业绩报告</div>
         <div class="info_cont ny_newslist">
            <ul>
            	<%
					final int currentPage = IntegerParser.parse(request.getParameter("paging.current"));
	            	PerformanceReportManage reportManage = serviceSession.getService(PerformanceReportManage.class);
					PagingResult<T5018> results = reportManage.search(
						new Paging() {
							public int getCurrentPage() {
								return currentPage;
							}
		
							public int getSize() {
								return 10;							}
						});
					T5018[] reports = results.getItems();
					if (reports != null && reports.length > 0) {
						int index=1;
						for (T5018 report : reports) {
					%>
                <li><a target="_blank" href="<%=controller.getPagingItemURI(request, Yjbg.class,report.F01)%>"><span class="lbt"><%StringHelper.filterHTML(out, report.F05); %></span><span class="ldt"><%=DateParser.format(report.F09) %></span></a></li>
                <%}}%>
              </ul>
              <%Yjbg.rendPaging(out, results,controller.getPagingURI(request, Yjbg.class)); %>	
         </div>
         
       </div>
   </div>
</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
</body>
</html>