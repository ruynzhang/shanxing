<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.bid.hbgl.RedpRecordExport"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.hbgl.AddRedpRecord"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.hbgl.RedpRecordList"%>
<%@page import="com.dimeng.p2p.S10.entities.RedPacketRecord"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%
	CURRENT_CATEGORY="YWGL";
	CURRENT_SUB_CATEGORY="REDPRECORDLIST";
	PagingResult<RedPacketRecord> list = ObjectHelper.convert(request.getAttribute("list"), PagingResult.class);
	RedPacketRecord[] recordArray = list.getItems();
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
<div class="main clearfix">
    <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<form id="searchForm" action="<%=controller.getURI(request, RedpRecordList.class)%>" method="post">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>红包记录</h3>
                    </div>
                    <div class="con">
                    	  <div class="admin_input admin_pb">
                                <p>用户名：<input type="text" name="userName" value="<%StringHelper.filterHTML(out, request.getParameter("userName"));%>" class="yhgl_input mr5" /></p>
                                <p>红包状态：
                                	<select name="state">
                                		<option value="0" <%="0".equals(request.getParameter("state"))?"selected":""%>>全部</option>
                                		<option value="1" <%="1".equals(request.getParameter("state"))?"selected":""%>>未使用</option>
                                		<option value="2" <%="2".equals(request.getParameter("state"))?"selected":""%>>已冻结</option>
                                		<option value="3" <%="3".equals(request.getParameter("state"))?"selected":""%>>已使用</option>
                                		<option value="4" <%="4".equals(request.getParameter("state"))?"selected":""%>>已过期</option>
                                	</select>
                                </p>
                                <p>发放类型：
                                	<select name="source">
                                		<option value="0" <%="0".equals(request.getParameter("source"))?"selected":""%>>全部</option>
                                		<option value="1" <%="1".equals(request.getParameter("source"))?"selected":""%>>手动发放</option>
                                		<option value="2" <%="2".equals(request.getParameter("source"))?"selected":""%>>注册</option>
                                		<option value="3" <%="3".equals(request.getParameter("source"))?"selected":""%>>推广</option>
                                	</select>
                                </p>
                                <P>
									<span>时间：</span>
									<input type="text" name="startTime" id="datepicker1" readonly="readonly" class="yhgl_input date" value="<%StringHelper.filterHTML(out, request.getParameter("startTime"));%>"/>至
									<input type="text" name="endTime" id="datepicker2" readonly="readonly" class="yhgl_input date" value="<%StringHelper.filterHTML(out, request.getParameter("endTime"));%>"/>
								</P>
								<p>起投金额： <input type="text" name="ranges" onblur="checkNum(this);" value="<%StringHelper.filterHTML(out, request.getParameter("ranges"));%>" class="yhgl_input mr5 isint" />以上</p>
                                <input name="" type="submit" class="btn2 mr10" value="搜索" />
                          		<a href="<%=controller.getURI(request,AddRedpRecord.class)%>" class="btn3 mr10"><font style="margin-left: 15px;">发放红包</font></a>
                          		<a href="javascript:void(0)" onclick="showExport();" class="btn3 mr10"><font style="margin-left: 25px;">导出</font></a>
                   				<div class="clear"></div>
                              <div class="clear"></div>
                    	</div>    
                    </div>
                </div>
              	<div>
                <table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
                        <tr class="hsbg">
                          <td>序号</td>
                          <td>用户名</td>
                          <td>红包状态</td>
                          <td>发放类型</td>
                          <td>红包金额</td>
                          <td>发放时间</td>
                          <td>到期时间</td>
                          <td>起投金额</td>
                        </tr>
                        <%
                        	if (recordArray != null) {
                        		int index = 1;
                        		for (RedPacketRecord record:recordArray)
                        		{if (record == null) {continue;}
                        %>
                        <tr class="dhsbg">
                          <td><%=index++ %></td>
                          <td><%=record.userName%></td>
                          <td>
                          	<%if(record.state==1){
                          		out.print("未使用");
                          	}else if(record.state==2){
                          		out.print("已冻结");
                          	}else if(record.state==3){
                          		out.print("已使用");
                          	}else if(record.state==4){
                          		out.print("已过期");
                          	}%>
                          </td>
                          <td><%if(record.source==1){out.print("手动发放");}else if(record.source==2){out.print("注册");}else{out.print("推广");}%></td>
                          <td><%=Formater.formatAmount(record.amount) %></td>
                          <td><%=DateParser.format(record.startTime)%></td>
                          <td><%=DateParser.format(record.endTime)%></td>
                          <td><%=record.ranges.intValue()%></td>
                        </tr>
                        <%
                        	}}
                        %>
                      </table>
                </div>
                <%AbstractConsoleServlet.rendPagingResult(out, list);%>
                </form>       
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
	    $("#datepicker2").datepicker('option', 'minDate',$("#datepicker1").datepicker().val());
	});
	var reg=/^[1-9][0-9]+$/;
	function checkNum(obj){
		var value=obj.value;
		if(value.length>0 && !reg.test(value)){
			obj.value=0;
		}
	}
	function showExport()
	{
		document.getElementById("searchForm").action ="<%=controller.getURI(request, RedpRecordExport.class)%>";
		$("#searchForm").submit();
		document.getElementById("searchForm").action ="<%=controller.getURI(request, RedpRecordList.class)%>";
	}
	</script>
</body>
</html>