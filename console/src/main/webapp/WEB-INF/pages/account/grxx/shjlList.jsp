<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.modules.account.console.service.UserManage"%>
<%@page import="com.dimeng.p2p.console.servlets.account.grxx.Open"%>
<%@page import="com.dimeng.p2p.S61.entities.T6121"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%
	CURRENT_CATEGORY="YHGL";
	CURRENT_SUB_CATEGORY="GRXX";
	T6121[]  info = ObjectHelper.convertArray(request.getAttribute("info"), T6121.class);
	UserManage manage = serviceSession.getService(UserManage.class);
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
  <div class="main clearfix">
    <div class="wrap">
      <div class="r_main">
        <div class="home_main">
          <div class="box box1 mb15">
            <div class="atil">
              <h3>审核记录列表</h3>
            </div>
          </div>
          
          <div class="newsbox">
	          <table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
	            <tr class="hsbg">
	              <td>序号</td>
	              <td>认证内容</td>
	              <td>认证结果</td>
	              <td>认证人</td>
	              <td>认证时间</td>
	              <td>操作</td>
	            </tr>
	            <%if(info != null){ 
	            	int index = 1;
	            	for(T6121 entity :info){
	            %>
	            <tr class="dhsbg">
	              <td><%=index++ %></td>
	              <td><%StringHelper.filterHTML(out, entity.F04); %></td>
	              <td><%=entity.F05.getChineseName() %></td>
	              <td><%StringHelper.filterHTML(out, manage.getAccountName(entity.F06)); %></td>
	              <td><%=DateTimeParser.format(entity.F07) %></td>
	              <td>
	              	<span class="blue mr10"><a href="<%=controller.getURI(request, Open.class)%>?id=<%=entity.F01%>" target="_blank">查看</a></span>
	              </td>
	            </tr>
	            <%} }%>
	          </table>
			<div class="clear"></div>
          </div>
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