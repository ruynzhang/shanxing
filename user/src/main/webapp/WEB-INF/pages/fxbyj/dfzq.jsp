
<%@page import="com.dimeng.p2p.user.servlets.fxbyj.Dfzq"%>
<%@page import="com.dimeng.p2p.S62.entities.T6230"%>
<%@page import="com.dimeng.p2p.S62.entities.T6231"%>
<%@page import="com.dimeng.p2p.account.user.service.entity.Dfxxmx"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.BidManage"%>
<%@page import="com.dimeng.p2p.user.servlets.financing.AbstractFinancingServlet"%>
<%@page import="com.dimeng.p2p.user.servlets.fxbyj.Dbywmx"%>
<%@page import="com.dimeng.p2p.account.user.service.entity.Dbxxmx"%>
<%@page import="com.dimeng.p2p.user.servlets.Index"%>
<%@page import="com.dimeng.p2p.account.user.service.FxbyjManage"%>
<%@include file="/WEB-INF/include/authenticatedSession.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>垫付债权-<%configureProvider.format(out,SystemVariable.SITE_NAME); %></title>
<%@include file="/WEB-INF/include/meta.jsp" %>
<%@include file="/WEB-INF/include/style.jsp" %>
</head>
<%
	final int currentPage = IntegerParser.parse(request.getParameter("paging.current"));
	FxbyjManage service=serviceSession.getService(FxbyjManage.class);
	Paging paging=new Paging(){
		public int getCurrentPage(){
			return currentPage;
		}
		
		public int getSize(){
			return 10;
		}
	};
	PagingResult<Dfxxmx> result=service.searchDf(paging);
	CURRENT_CATEGORY = "JGDB";
	CURRENT_SUB_CATEGORY = "DFZQ";
%>
<body>
<%@include file="/WEB-INF/include/header.jsp" %>

<div class="w994 pb5"><span class="f16"><a href="<%=controller.getViewURI(request, Index.class) %>">我的<%=configureProvider.getProperty(SystemVariable.SITE_NAME) %></a></span> &gt; 担保机构 &gt; 垫付债权</div>
<div class="contain clearfix">
<div class="user_top"></div>
   <div class="about">
      <%@include file="/WEB-INF/include/menu.jsp"%>
   <div class="w780 fr">       
      <div>
   	    <div class="newsbox">
               <form action="<%=controller.getViewURI(request, Dfzq.class)%>"method="post">
               <div class="bs_bg pt10">
                  <div class="no_table user_bolr bot">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="user_table tc">
                      <tr class="user_lsbg">
                        <td>序号</td>
                        <td>借款标题</td>
                        <td>用户名</td>
                        <td>垫付时间</td>
                        <td>垫付金额</td>
                        <td>垫付返回金额</td>
                        <td>状态</td>
                      </tr>
                      <%
                      BidManage bidManage2 = serviceSession.getService(BidManage.class);
                      UserInfoManage userInfoManage2 = serviceSession.getService(UserInfoManage.class);
                      if(result != null && result.getItemCount() >0){
				     			int i=1;
				     		for(Dfxxmx ibf :result.getItems()){
				     			if(ibf == null){
				     				continue;
				     			}
				     			//T6231 t6231 =  bidManage2.getExtra(ibf.F03);
				     			//T6230 t6230 =  bidManage2.get(ibf.F03);
				     			
				     %>
                      <tr>
                      	<td><%=i++ %></td>
                      	<td title="<%StringHelper.filterHTML(out, ibf.title);%>"><%StringHelper.filterHTML(out, StringHelper.truncation(ibf.title, 10));%></td>
                      	<td><%StringHelper.filterHTML(out, ibf.userName);%></td>
                      	<td><%=DateTimeParser.format(ibf.F07)%></td>
                      	<td><%=Formater.formatAmount(ibf.F05) %></td>
                      	<td><%=Formater.formatAmount(ibf.F06)%></td>
                      	<td><%=ibf.status.getChineseName()%></td>
                      </tr>
                      <%
				     		}}
                      %>
                    </table>
            	  </div>
                    <div class="page">
						<%AbstractFinancingServlet.rendPagingResult(out, result); %>
					</div>
                  </div>         </form>      
                  <div class="clear"></div>
        </div>
         </div>            
       	 </div><div class="clear"></div>
   </div>
</div>
<%@include file="/WEB-INF/include/footer.jsp" %>
<%@include file="/WEB-INF/include/script.jsp" %>
</body>
</html>