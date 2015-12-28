<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.S62.enums.T6231_F21"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.lcgl.zqgl.YjqList"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.lcgl.zqgl.YfkList"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.lcgl.zqgl.TbzList"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.lcgl.zqgl.YzcList"%>
<%@page import="com.dimeng.p2p.modules.financial.console.service.entity.Creditor"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%
	CURRENT_CATEGORY="YWGL";
	CURRENT_SUB_CATEGORY="ZQGL";
	PagingResult<Creditor> creditors = (PagingResult<Creditor>)request.getAttribute("creditors");
	Creditor[] creditorArray = creditors.getItems();
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
  <div class="main clearfix">
    <div class="wrap">
      <div class="r_main">
        <div class="home_main">
          <div class="box box1 mb15">
            <div class="atil">
              <h3>债权管理</h3>
            </div>
          </div>
          <form id="form1" action="<%=controller.getURI(request, YzcList.class)%>" method="post">
          <div class="box box1 mb15">
            <div class="con">
                <div class="admin_input admin_pb">
                    <p>债权ID：<input type="text" name="creditorId" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("creditorId"));%>"/></p>
                    <p>时间：<input type="text" name="createTimeStart" readonly="readonly"  id="datepicker1" class="yhgl_input date" />至<input type="text" readonly="readonly" name="createTimeEnd" id="datepicker2" class="yhgl_input date" /></p>
                    <p><input name="input" type="submit" class="btn2" value="搜索" /></p>
             	</div>
              <div class="clear"></div>
            </div>
          </div>
          <div class="newsbox">
	          <div class="til clearfix">
	             <div class="Menubox">
	               <ul>
	                 <li id="one1" onclick="window.location.href='<%=controller.getURI(request, TbzList.class)%>'">投标中</li>
	                 <li id="one2" onclick="window.location.href='<%=controller.getURI(request, YfkList.class)%>'">回收中</li>
	                 <li id="one3" onclick="window.location.href='<%=controller.getURI(request, YjqList.class)%>'" >已结清</li>
	                 <li id="one4" class="hover" style="border-right:1px #d7dfe3 solid;" >已转出</li>
	               </ul>
	             </div>
	          </div>
	          <div class="border p15 Men_bt no_table" id="con_one_2">
	          <table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table">
	            <tr class="hsbg">
	              <td align="center">序号</td>
	              <td align="center">债权ID</td>
	              <td align="center">借款标题</td>
	              <td align="center">卖出者</td>
	              <td align="center">买入者</td>
	              <td align="center">年利率</td>
	              <td align="center">期限</td>
	              <td align="center">债权价值（元）</td>
	              <td align="center">受让价格（元）</td>
	              <td align="center">投资时间</td>
	            </tr>
	            <%
	            	if (creditorArray != null) {for (int i =0;i<creditorArray.length;i++){Creditor creditor=creditorArray[i];if (creditor == null) {continue;}
	            %>
	            <tr class="dhsbg">
	              <td align="center"><%=i+1%></td>
	              <td align="center"><%StringHelper.filterHTML(out, creditor.creditorId);%></td>
	              <td>
					<%
           				StringHelper.filterHTML(out, creditor.jkbt);
           			%>
           		  </td>
	              <td align="center"><%
	              	StringHelper.filterHTML(out, creditor.userName);
	              %></td>
	              <td align="center"><%
	              	StringHelper.filterHTML(out, creditor.mrzName);
	              %></td>
	              <td align="center"><%=Formater.formatRate(creditor.yearRate)%></td>
	              <td align="center"><%if(creditor.f21 == T6231_F21.S){%><%=creditor.day%>天<%}else{%><%=creditor.deadline%>个月<%} %></td>
	              <td align="center"><%=Formater.formatAmount(creditor.gmjg)%></td>
	              <td align="center"><%=Formater.formatAmount(creditor.srjg)%></td>
	              <td align="center"><%=DateTimeParser.format(creditor.tenderTime)%></td>
	            </tr>
	            <%
	            	}}
	            %>
	          </table>
          <%
          	AbstractConsoleServlet.rendPagingResult(out, creditors);
          %>
          </div>
          </div>
          </form>
          <div class="box2 clearfix"></div>
        </div>
      </div>
    </div>
 	
	<%@include file="/WEB-INF/include/left.jsp"%>
</div>
</div>

	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<%@include file="/WEB-INF/include/datepicker.jsp"%>
	<script type="text/javascript">
		$(function() {
			$("#datepicker1").datepicker({inline: true,
				onSelect : function(selectedDate) {
		            $("#datepicker2").datepicker("option", "minDate", selectedDate); 
		        }
			});
		    $('#datepicker1').datepicker('option', {dateFormat:'yy-mm-dd'});
		    $("#datepicker2").datepicker({inline: true});
		    $('#datepicker2').datepicker('option', {dateFormat:'yy-mm-dd'});
		    $("#datepicker1").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("createTimeStart"));%>");
		    $("#datepicker2").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("createTimeEnd"));%>");
		    $("#datepicker2").datepicker('option', 'minDate',$("#datepicker1").datepicker().val());
		});
	</script>
</body>
</html>