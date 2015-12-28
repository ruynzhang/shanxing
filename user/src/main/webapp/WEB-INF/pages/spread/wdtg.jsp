<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.account.user.service.entity.SpreadEntity"%>
<%@page import="com.dimeng.p2p.account.user.service.entity.SpreadTotle"%>
<%@page import="com.dimeng.p2p.account.user.service.SpreadManage"%>
<%@page import="com.dimeng.p2p.user.servlets.spread.Wdtg"%>
<%@page import="com.dimeng.p2p.user.servlets.Index"%>
<%@page import="com.dimeng.p2p.user.servlets.spread.AbstractSpreadServlet"%>
<%@include file="/WEB-INF/include/authenticatedSession.jsp" %>
<html>
<head>
<title>我的推广-<%configureProvider.format(out,SystemVariable.SITE_NAME); %></title>
<%@include file="/WEB-INF/include/meta.jsp" %>
<%@include file="/WEB-INF/include/style.jsp" %>
</head>
<%
	CURRENT_CATEGORY = "TGGL";
	CURRENT_SUB_CATEGORY = "WDTG";
	
	final int currentPage=IntegerParser.parse(request.getParameter("paging.current"));
	Paging paging = new Paging() {
		@Override
		public int getSize() {
			return 10;
		}
		
		@Override
		public int getCurrentPage() {
			return currentPage;
		}
	};
	SpreadManage manage= serviceSession.getService(SpreadManage.class);
	SpreadTotle spreadTotle =  manage.search();
%>
<body>
<%@include file="/WEB-INF/include/header.jsp" %>
<div class="contain clearfix">
<div class="user_top"></div>
   <div class="about">
	 <%@include file="/WEB-INF/include/menu.jsp"%>
	  <form action="<%=controller.getViewURI(request, Wdtg.class)%>"method="post">	
     <div class="container fr bor1">
         <div class="p15">
           <p class="title1 titleTab mt20"><span><a href="<%=controller.getViewURI(request, com.dimeng.p2p.user.servlets.spread.Wytg.class) %>">邀请好友</a></span><b>我的好友</b></p>
       	     <%--<div class="user_lsjt mb20">邀请好友统计</div>
       	  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="user_table tc mb20">
       	     <tr class="user_lsbg">
       	       <td width="19%">推广客户数（个）</td>
       	       <%-- 
       	       <td width="16%">持续奖励总计（元）</td>
       	       <td width="18%">有效推广奖励总计（元）</td>    
       	       <td width="18%">收益总计（元）</td>
   	         </tr>
       	     <tr>
       	       <td><%=spreadTotle.yqCount %></td>
       	        <td><%=spreadTotle.rewardCxtg %></td>
       	       <td><%=spreadTotle.rewardYxtg %></td>
       	       <td><%=Formater.formatAmount(spreadTotle.rewardTotle)%></td>
   	         </tr>
   	       </table>--%>
   	       <div class="user_lsjt mb20">邀请好友注册详情</div>
       	   <table width="100%" border="0" cellspacing="0" cellpadding="0" class="user_table tc">
       	     <tr class="user_lsbg">
       	       <td width="19%">您推荐好友的用户名</td>
       	       <td width="18%">注册时间</td>
       	       <td width="15%">实名认证</td>
       	       <td width="15%">手机号码</td>
       	       <td width="15%">是否投资</td>
   	         </tr>
   	         <%
   	      		PagingResult<SpreadEntity> pgList= manage.getAllReward(paging);
   	      		if(pgList != null && pgList.getItemCount()>0){
   	      			for(SpreadEntity spreadEntity :pgList.getItems() ){
   	      				if(spreadEntity == null){
   	      					continue;
   	      				}
   	         %>
       	     <tr>
       	       <td><%=spreadEntity.userName%></td>
       	       <td><%=TimestampParser.format(spreadEntity.zcTime, "yyyy-MM-dd HH:mm")%></td>
       	       <td><%=spreadEntity.realName==null?"":spreadEntity.realName%></td>
       	       <td><%=spreadEntity.mobile%></td>
       	       <td><%=spreadEntity.total>0?"是":"否"%></td>
   	         </tr>
   	         <%}
   	      		} %>
   	       </table>
          <div class="page p15">
          	<%
          		AbstractSpreadServlet.rendPagingResult(out, pgList);
          	%>
          	</div>
         </div>          
       	 </div>
       	 </form>  
       	 <div class="clear"></div>
   </div>
</div>
<%@include file="/WEB-INF/include/footer.jsp" %>
<%@include file="/WEB-INF/include/script.jsp" %>
</body>
</html>