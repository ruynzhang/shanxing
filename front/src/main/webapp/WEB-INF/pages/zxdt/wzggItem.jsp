<%@page import="com.dimeng.p2p.S50.entities.T5015"%>
<%@page import="com.dimeng.p2p.S50.enums.T5015_F02"%>
<%@page import="com.dimeng.p2p.modules.base.front.service.NoticeManage"%>
<%@page import="java.util.List"%>
<%
NoticeManage noticeManage = serviceSession.getService(NoticeManage.class);
T5015 notice = noticeManage.get(IntegerParser.parse(request.getParameter("id")));
if(notice==null){
	response.sendError(HttpServletResponse.SC_NOT_FOUND);
	return;
}
noticeManage.view(notice.F01);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%if(notice!=null)StringHelper.filterHTML(out,notice.html_title);%></title>
<meta http-equiv="Content-Type" content="text/html; charset=<%=resourceProvider.getCharset() %>" />
<meta name="keywords" content="<%if(notice!=null)StringHelper.filterHTML(out, notice.html_keywords); %>"/>
<meta name="description" content="<%if(notice!=null)StringHelper.filterHTML(out, notice.html_description); %>"/>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/>
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
       
       <div class="container fr">
         <div class="public_detail" style="text-align:center;">
           <span style="float:left; font-size:16px;"><a class="blueLink" href="/zxdt/wzgg/<%=request.getParameter("currentPage") == null? 1 : request.getParameter("currentPage")%>">返回列表</a></span>
         <%if(notice!=null)StringHelper.filterHTML(out,notice.F05);%><span class="tr fr f14"><%=notice==null?"":DateParser.format(notice.F09)%></span></div>
         <div class="bdsharebuttonbox" style="text-align:right; padding:10px 0px;"><a href="#" data-cmd="more"></a><a href="#" class="bds_qzone" data-cmd="qzone"></a><a href="#" class="bds_tsina" data-cmd="tsina"></a><a href="#" class="bds_tqq" data-cmd="tqq"></a><a href="#" class="bds_renren" data-cmd="renren"></a><a href="#" class="bds_weixin" data-cmd="weixin"></a></div>
         <div class="info_cont detail">
           <p><%if(notice!=null)StringHelper.format(out, notice.F06,fileStore); %></p>
           <%
               T5015  befor5015 = noticeManage.selectBeforT5015(notice.F09);
		       T5015  next5015 = noticeManage.selectAfterT5015(notice.F09);
						
					%>
			<p align="center">
			<%if(befor5015!=null){ %>
			上一篇:&nbsp;<a class="blueLink" href="<%=controller.getPagingItemURI(request, Wzgg.class,befor5015.F01)%>"><%=befor5015.F05 %></a><%} %>&nbsp;
		   <%if(next5015!=null){ %>
		            下一篇:&nbsp;<a class="blueLink" href="<%=controller.getPagingItemURI(request,Wzgg.class,next5015.F01)%>"><%=next5015.F05 %></a><%} %></p>
          
         </div>
       </div>
   	</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
<script>window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"","bdMini":"2","bdPic":"","bdStyle":"0","bdSize":"16"},"share":{},"image":{"viewList":["qzone","tsina","tqq","renren","weixin"],"viewText":"分享到：","viewSize":"16"},"selectShare":{"bdContainerClass":null,"bdSelectMiniList":["qzone","tsina","tqq","renren","weixin"]}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];</script>
</body>
</html>
