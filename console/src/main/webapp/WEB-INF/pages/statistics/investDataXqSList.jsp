<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.InvestDataXqVO"%>
<%@page import="java.util.List"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%
CURRENT_CATEGORY = "TJGL";
CURRENT_SUB_CATEGORY = "INVESTDATAXQLIST";
List<InvestDataXqVO> list = (List<InvestDataXqVO>)request.getAttribute("list");
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
<div class="main clearfix">
    <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>投资明细</h3>
                    </div>
                   <div class="con">
                    	  <div class="admin_input admin_pb">
								<P>
									<a href="<%=controller.getURI(request, InvestDataXqList.class)%>"  class="btn3"><span style="margin-left: 13px;">返回列表</span></a> 
								</P>
                              <div class="clear"></div>
                    	</div>    
                    </div>
                </div>
              	<div>
                <table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
					<tr class="hsbg">
						<td>序号</td>
						<td>用户名</td>
						<td>姓名</td>
						<td>标的id</td>
						<td>标的名称</td>
						<td>放款时间</td>
						<td>投资金额</td>
						<td>投资期限</td>
						<td>标的收益率</td>
					</tr>
					<%
						int i=1;
						for(InvestDataXqVO vo:list){
					%>
					<tr class="dhsbg">
						<td><%=i++%></td>
						<td><%StringHelper.filterHTML(out, vo.userName);%></td>
						<td><%StringHelper.filterHTML(out, vo.realName);%></td>
						<td><%=vo.bId%></td>
						<td><%StringHelper.filterHTML(out, vo.bdName);%></td>
						<td><%=DateTimeParser.format(vo.fk_date)%></td>
						<td><%=Formater.formatAmount(vo.amount) %></td>
						<td><%=vo.deadline%></td>
						<td><%StringHelper.filterHTML(out, vo.lucre);%></td>
					</tr>
					<%}%>
				</table>
                </div>
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