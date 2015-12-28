<%@page import="com.dimeng.p2p.utlis.BdUtil"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.entity.ZqxxEntity"%>
<%@page import="com.dimeng.p2p.utlis.JfUtil"%>
<%@page import="com.dimeng.util.http.URLParameter"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F13"%>
<%@page import="com.dimeng.p2p.S62.enums.T6231_F21"%>
<%@page import="com.dimeng.p2p.user.servlets.financing.AbstractFinancingServlet"%>
<%@page import="com.dimeng.p2p.modules.base.front.service.CreditLevelManage"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.entity.Tbzdzq"%>
<%@page import="com.dimeng.p2p.user.servlets.financing.wdzq.BackMoney"%>
<%@include file="/WEB-INF/include/authenticatedSession.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>我的投资-<%configureProvider.format(out,SystemVariable.SITE_NAME); %></title>
<%@include file="/WEB-INF/include/meta.jsp" %>
<%@include file="/WEB-INF/include/style.jsp" %>
</head>
<%
	CURRENT_CATEGORY = "LCGL";
	CURRENT_SUB_CATEGORY = "WDZQ";
%>
<body>
<%@include file="/WEB-INF/include/header.jsp" %>
<% 
boolean multiSelect = "1".equals(request.getParameter("w"));
URLParameter parameter = new URLParameter(request,controller.getViewURI(request, com.dimeng.p2p.user.servlets.financing.wdzq.Ysbzdzq.class),multiSelect,SORT);
	String str=request.getParameter(SORT);
	int sort=0;
	if(str!=null && JfUtil.matches(str, "[0-9]*")){
		   sort=Integer.parseInt(str);
	}
%>
	<div class="contain clearfix">
		<div class="user_top"></div>
   		<div class="about">
     		<%@include file="/WEB-INF/include/menu.jsp"%>
            <%@include file="/WEB-INF/include/wdzq/header.jsp"%>
			<div class="container fr">
            <div class="mainDiv bor1">
            <!--理财管理 S-->
			  <div class="tb-state">
			  投标状态： <a class="butStyle no" avalue="huikuan" href="/user/financing/wdzq/hszdzq.html">回款中</a>
				     <a class="butStyle no" avalue="toubiaozhong" href="/user/financing/wdzq/tbzdzq.html">投标中</a>
				     <a class="butStyle no" avalue="yiwancheng" href="/user/financing/wdzq/yjqdzq.html">已完成</a>
				     <a class="butStyle " avalue="toubiaoshibai">投标失败</a>
			  </div>
		    </div>
            </div>
       	    <div class="w780 fr">       
         		<div>
   	    		<div class="newsbox">
                  	<div class="til clearfix Men_bt2">
                  	  <div class="tabtit">我的投资</div>                      
               		</div>
               		<form action="<%=controller.getViewURI(request, com.dimeng.p2p.user.servlets.financing.wdzq.Ysbzdzq.class)%>" method="post">
               		<div class="bs_bg pt20">
		                  <div class="no_table user_bolr bot">
		                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="user_table tc tableOdd">
		                      <tr class="user_lsbg tb_th">
		                        <th>项目名称<a href="/user/financing/wdzq/ysbzdzq.html?s=1"><span class="<%=sort==1?"tip-down":"tip-up"%>"></span></a></th>
		                        <th>开投时间<a href="/user/financing/wdzq/ysbzdzq.html?s=2"><span class="<%=sort==2?"tip-down":"tip-up"%>"></span></a></th>
		                        <th>截止时间</th>
		                        <th>投资金额（元）<a href="/user/financing/wdzq/ysbzdzq.html?s=3"><span class="<%=sort==3?"tip-down":"tip-up"%>"></span></a></th>
		                        <th>项目收益（元）</th>
		                      </tr>
		                       <%
		                       PagingResult<Tbzdzq> list=service.getFailureAssests(sort,paging);
						     	if(list != null && list.getItemCount() >0){
						     		for(Tbzdzq vo :list.getItems()){
						     			if(vo == null){
						     				continue;
						     			}
						     %>
		                      <tr>
		                        <td><%=vo.F02%><br><%=vo.F16%></td>
		                        <td><%=Formater.formatDate(vo.F10)%></td>
		                        <td><%=Formater.formatDate(BdUtil.getTime(vo.F10, vo.F08, vo.F22))%></td>
		                        <td>￥<%=Formater.formatAmount(vo.F13)%></td>
		                        <td>￥<%=Formater.formatAmount(BdUtil.calcIt(vo.F13, vo.F05, vo.F08>0?vo.F08:vo.F22, vo.F08>0?true:false))%></td>
		                      </tr>
		                      <%}}else{%>
		                      <tr><td colspan="5"></td></tr>
		                      <%}%>
		                    </table>
		            	  </div>
		                    <div class="page">
								<%AbstractFinancingServlet.rendPaging(out, list,controller.getPagingURI(request,com.dimeng.p2p.user.servlets.financing.wdzq.Ysbzdzq.class),parameter.getQueryString()); %>
							</div>
		            	  
                  </div>         
                  </form>      
                  <div class="clear"></div>
              </div>
           	</div>            
       	 </div>
       		<div class="clear"></div>
   		</div>
	</div>
<%@include file="/WEB-INF/include/footer.jsp" %>
<%@include file="/WEB-INF/include/script.jsp" %>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/wdzq.js"></script>
</body>
</html>