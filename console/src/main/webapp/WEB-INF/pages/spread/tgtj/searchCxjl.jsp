<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.modules.spread.console.service.entity.SeriesDetailList"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%
	CURRENT_CATEGORY = "TGGL";
	CURRENT_SUB_CATEGORY = "TGTJ";
	PagingResult<SeriesDetailList> result = ObjectHelper.convert(request.getAttribute("result"), PagingResult.class);
	String name = ObjectHelper.convert(request.getAttribute("name"), String.class);
%>
<%@include file="/WEB-INF/include/header.jsp"%> 
<div class="w_main">
  <div class="main clearfix">
    <div class="wrap">
      <div class="r_main">
        <div class="home_main">
          <div class="box box1 mb15">
            <div class="atil">
              <h3>推广持续奖励详情 - <%StringHelper.filterHTML(out, name); %></h3>
            </div>
          </div>
          <table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
            <tr class="hsbg">
              <td>序号</td>
              <td>被推广人ID</td>
              <td>被推广人用户名</td>
              <td>被推广人姓名</td>
              <td>推广投资金额</td>
              <td>连续奖励（元）</td>
              <td>投资时间</td>              
            </tr>
            <% 
            	SeriesDetailList[] lists = result.getItems(); 
	            if(lists != null ){
	            	int index = 1;
	            	for(SeriesDetailList list : lists){
            %>
            <tr class="dhsbg">
              <td><%=index++ %></td>
              <td><%=list.id %></td>
              <td><%StringHelper.filterHTML(out, list.userName); %></td>
              <td><%StringHelper.filterHTML(out, list.name); %></td>
              <td><%=list.money %> </td>
              <td><%=list.rewarMoney %></td>
              <td><%=DateParser.format(list.investTime) %></td>
            </tr>
           <%}}%>
          </table>
          <div class="box2 clearfix"></div>
        </div>
      </div>
    </div>
	<%@include file="/WEB-INF/include/left.jsp"%>
  </div>
</div>
<%@include file="/WEB-INF/include/footer.jsp"%>
<%@include file="/WEB-INF/include/script.jsp"%>
</body>
</html>