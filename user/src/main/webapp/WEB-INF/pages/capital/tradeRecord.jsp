<%@page import="com.dimeng.p2p.modules.capital.user.service.entity.TradeRecordVO"%>
<%@page import="com.dimeng.p2p.user.servlets.capital.TradeRecord"%>
<%@page import="com.dimeng.p2p.user.servlets.financing.AbstractFinancingServlet"%>
<%@page import="com.dimeng.p2p.user.servlets.Index"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@include file="/WEB-INF/include/authenticatedSession.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>线下交易-<%configureProvider.format(out,SystemVariable.SITE_NAME);%></title>
<%@include file="/WEB-INF/include/meta.jsp" %>
<%@include file="/WEB-INF/include/style.jsp" %>
</head>
<%
	CURRENT_CATEGORY = "ZJGL";
	CURRENT_SUB_CATEGORY = "XXJY";
	PagingResult<TradeRecordVO> result= ObjectHelper.convert(request.getAttribute("list"), PagingResult.class);
%>
<body>
<%@include file="/WEB-INF/include/header.jsp" %>
 <form action="<%=controller.getURI(request, TradeRecord.class)%>" method="post">
<div class="contain clearfix">

<div class="user_top"></div>
   <div class="about">
      <%@include file="/WEB-INF/include/menu.jsp"%>
   <div class="w780 fr">       
      <div>
   	    <div class="newsbox">
             
               <div class="bs_bg pt10">
                  <div class="no_table user_bolr bot">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="user_table tc">
                      <tr class="user_lsbg">
                        <td>合同编号</td>
                        <td>产品名称</td>
                        <td>出借金额</td>
                        <td>回款利息</td>
                        <td>出借日期</td>
                        <td>回款日期</td>
                        <td>债权类型</td>
                      </tr>
                      <%
                      if(result != null && result.getItemCount() >0){
				     		for(TradeRecordVO vo :result.getItems()){
				     %>
                      <tr>
                      	<td><%StringHelper.filterHTML(out, vo.num);%></td>
                      	<td><%StringHelper.filterHTML(out, vo.product_Name);%></td>
                      	<td><%=Formater.formatAmount(vo.cj_amount) %></td>
						<td><%=Formater.formatAmount(vo.lx_amount) %></td>
                      	<td><%StringHelper.filterHTML(out, vo.cj_date);%></td>
						<td><%StringHelper.filterHTML(out, vo.hk_date);%></td>
                      	<td><%StringHelper.filterHTML(out, vo.zq_type);%></td>
                      </tr>
                      <%
				     		}}
                      %>
                    </table>
            	  </div>
                    <div class="page">
						<%TradeRecord.rendPagingResult(out, result); %>
					</div>
                  </div>        
                  <div class="clear"></div>
        </div>
         </div>            
       	 </div><div class="clear"></div>
   </div>
</div>
 </form>      
<%@include file="/WEB-INF/include/footer.jsp" %>
<%@include file="/WEB-INF/include/script.jsp" %>
</body>
</html>