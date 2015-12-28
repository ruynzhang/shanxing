<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.S61.entities.T6141"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.GrManage"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.htgl.Index"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.htgl.ZqzrDzxy"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.htgl.GrjkDzxy"%>
<%@page import="com.dimeng.p2p.modules.bid.console.service.entity.Qyjkxy"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%
	CURRENT_CATEGORY="YWGL";
	CURRENT_SUB_CATEGORY="DZXY";
	PagingResult<Qyjkxy> result = (PagingResult<Qyjkxy>)request.getAttribute("result");
	Qyjkxy[] qyjkxys = result.getItems();
%>
<%@include file="/WEB-INF/include/header.jsp"%>

<div class="w_main">
  <div class="main clearfix">
    <div class="wrap">
      <div class="r_main">
        <div class="home_main">
        <form action="<%=controller.getURI(request, GrjkDzxy.class)%>" method="post">
          <div class="box box1 mb15">
            <div class="atil">
              <h3>个人电子协议管理</h3>
            </div>
          </div>
          <div class="box box1 mb15">
            <div class="con">
              <div class="table">
            	<span>借款账号：</span>
				<span> <input type="text" name="name" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("name"));%>"/>
              </span>
              <span>签订日期：</span>
              <span><input type="text" readonly="readonly" name="createTimeStart" id="datepicker1" class="yhgl_input date" /></span>
              <span>至</span>
              <span><input type="text" readonly="readonly" name="createTimeEnd" id="datepicker2" class="yhgl_input date" /></span>
              <input name="input" type="submit" class="btn2" value="搜索" />
              </div>                
              <div class="clear"></div>
            </div>
          </div>
          <div class="newsbox">
            <div class="til clearfix">
              <div class="Menubox">
                <ul>
                  <li onclick="window.location.href='<%=controller.getURI(request, QyjkDzxy.class)%>'" >企业借款协议</li>
                  <li class="hover">个人借款协议</li>	
                  <li onclick="window.location.href='<%=controller.getURI(request, ZqzrDzxy.class)%>'" style="border-right:1px #d7dfe3 solid;" >债权转让协议</li>
                </ul>
              </div>
            </div>
            <div class="border p15 Men_bt no_table" id="con_one_2">
              <table width="100%" border="0" cellspacing="0" cellpadding="0" class="yhgl_table mb10">
                <tr class="hsbg">
                  <td align="center">序号</td>
                  <td align="center">借款标题</td>
                  <td align="center">借款账号</td>
                  <td align="center">姓名</td>
                  <td align="center">身份证</td>
                  <td align="center">签订日期</td>
                  <td align="center">操作</td>
                </tr>
                <%
                GrManage grManage = serviceSession.getService(GrManage.class);
                if (qyjkxys != null && qyjkxys.length>0) {
                	int i=1;
                	for (Qyjkxy qyjkxy :qyjkxys){
                		if (qyjkxy == null) {continue;}
                
                		T6141 t6141 = grManage.getPersonal(qyjkxy.F02);
                %>
			       <tr class="bom">
			         <td align="center"><%=i++%></td>
			         <td align="center" title="<%StringHelper.filterHTML(out, qyjkxy.F03); %>"><%StringHelper.filterHTML(out, StringHelper.truncation(qyjkxy.F03, 15)); %></td>
			         <td align="center"><%StringHelper.filterHTML(out, qyjkxy.jkLoginName);%></td>
			         <td align="center"><%StringHelper.filterHTML(out, t6141.F02);%></td>
			         <td align="center"><%StringHelper.filterHTML(out, t6141.F06);%></td>
			         <td align="center"><%=TimestampParser.format(qyjkxy.F22) %></td>
			         <td align="center">
			         <a target="_blank" href="<%=controller.getURI(request, Index.class) %>?id=<%=qyjkxy.F01 %>"  class="blue">合同</a>
			       </tr>
			     <%}} %>
              </table>
              
              <%AbstractConsoleServlet.rendPagingResult(out, result);%>
            </div>
            <div class="clear"></div>
          </div>
          </form>
          <div class="box2 clearfix"></div>
        </div>
      </div>
    </div>
    
    <%@include file="/WEB-INF/include/left.jsp"%>
  </div>
</div>


<div id="info"></div>

	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<%@include file="/WEB-INF/include/datepicker.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/dialog.js"></script>
	<script type="text/javascript">
		$(function() {
			$("#datepicker1").datepicker({inline: true});
		    $('#datepicker1').datepicker('option', {dateFormat:'yy-mm-dd'});
		    $("#datepicker2").datepicker({inline: true});
		    $('#datepicker2').datepicker('option', {dateFormat:'yy-mm-dd'});
		    $("#datepicker1").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("createTimeStart"));%>");
		    $("#datepicker2").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("createTimeEnd"));%>");
		});
		
	</script>
	
</body>
</html>