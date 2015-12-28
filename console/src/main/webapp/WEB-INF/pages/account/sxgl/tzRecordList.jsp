<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.Map"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.TzRecordVO"%>
<%@page import="com.dimeng.p2p.console.servlets.account.sxgl.TzRecordExport"%>
<%@page import="java.util.List"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<style>
.minWidth{width:50px; }
</style>
<body>
<%
CURRENT_CATEGORY = "YHGL";
CURRENT_SUB_CATEGORY = "TZRECORDLIST";
PagingResult<TzRecordVO> list = ObjectHelper.convert(request.getAttribute("list"), PagingResult.class);
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
<div class="main clearfix">
    <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<form action="<%=controller.getURI(request, TzRecordList.class)%>" method="post" id="searchForm" onsubmit="return onSubmit();">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>投资记录</h3>
                    </div>
                    <div class="con">
                    	  <div class="admin_input admin_pb">
                    	  		<P>
									<span>用户名：</span>
									<input type="text" name="userName" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("userName"));%>"/>
								</P>
								<P>
									<span>手机号码：</span>
									<input type="text" name="phone" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("phone"));%>"/>
								</P>
								<P>
									<span>标的名称：</span>
									<select id="bId" name="bId" class="text yhgl_ser input" style="width: 210px;">
											<option value="0">全部</option>
											<%
											Map<Integer, String> bidList=(Map<Integer, String>)request.getAttribute("bidList");
											if(bidList!=null){
												int mapSize=bidList.size();
												Object s[] = bidList.keySet().toArray();
												for(int i = 0; i < mapSize; i++) {
											%>
												<option value="<%=s[i]%>"><%=bidList.get(s[i])%></option>
											<%}} %>
									</select>
								</P>
								<P>
									<span>利息：</span>
									<input type="text" name="staRate" id="staRate" class="yhgl_input minWidth" value="<%StringHelper.filterHTML(out, request.getParameter("staRate"));%>"/>至
									<input type="text" name="endRate" id="endRate" class="yhgl_input minWidth" value="<%StringHelper.filterHTML(out, request.getParameter("endRate"));%>"/>
								</P>
								 <P>
									<span>投标时间：</span>
									<input type="text" name="staDate" id="datepicker1" readonly="readonly" class="yhgl_input date" value="<%StringHelper.filterHTML(out, request.getParameter("staDate"));%>"/>至
									<input type="text" name="endDate" id="datepicker2" readonly="readonly" class="yhgl_input date" value="<%StringHelper.filterHTML(out, request.getParameter("endDate"));%>"/>
								</P>
								<P>
									<input name="search" type="submit" class="btn2" value="搜索" />
									<%if (dimengSession.isAccessableResource(TzRecordExport.class)) {%>
									<a href="javascript:void(0)" onclick="showExport();" class="btn3 mr10" style="margin-left: 10px;"><span class="ico"></span>导出</a> 
	                          		<%}else{%>
									<span class="btn3 btn5 mr10" style="margin-top: -0px;margin-left: 10px;"><span class="ico"></span>导出</span>
									<%}%>
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
                          <td>手机号码</td>
                          <td>标的号</td>
                          <td>标的名称</td>
                          <td>投标金额</td>
                          <td>借款年利率</td>
                          <td>借款期限</td>
                          <td>投标时间</td>
                        </tr>
                        <%
                        	if (list != null && null!=list.getItems()) {
                        		int index = 1;
                        		for (TzRecordVO vo:list.getItems()){
                        %>
                        <tr class="dhsbg">
                          <td><%=index++ %></td>
                          <td><%StringHelper.filterHTML(out, vo.userName); %></td>
                          <td><%StringHelper.filterHTML(out, vo.realName);%></td>
                          <td><%StringHelper.filterHTML(out, vo.phone);%></td>
                          <td><%=vo.bId%></td>
                          <td><%StringHelper.filterHTML(out, vo.bdName);%></td>
                          <td><%=Formater.formatAmount(vo.amount) %></td>
                          <td><%StringHelper.filterHTML(out, vo.rate);%></td>
                          <td><%StringHelper.filterHTML(out, vo.tzqx);%></td>
                          <td><%=DateTimeParser.format(vo.tb_date)%></td>
                        </tr>
                        <%
                        	}}
                        %>
                 </table>
                </div>
                <%SxList.rendPagingResult(out, list); %>
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
	$("#bId option[value="+<%=request.getParameter("bId")%>+"]").attr("selected",true);
	$(function(){
	    $('#datepicker1').datepicker('option', {dateFormat:'yy-mm-dd'});
	    $("#datepicker2").datepicker({inline: true});
	    $('#datepicker2').datepicker('option', {dateFormat:'yy-mm-dd'});
	    $("#datepicker2").datepicker('option', 'minDate',$("#datepicker1").datepicker().val());
	});
	onSubmit=function(){
		var reg=/^[1-9][0-9]?$/;
	 	var date1=$("#datepicker1").val();
	 	var date2=$("#datepicker2").val();
	 	if(date1>date2 && date2.length>0){
	 		alert("开始时间不能大于结束时间!");
	 		return false;
	 	}
	 	var staRate=$("#staRate").val();
	 	var endRate=$("#endRate").val();
	 	if(staRate.length>0 && !reg.test(staRate)){
	 		alert("利息输入有误!");
	 		return false;
	 	}
	 	if(endRate.length>0 && !reg.test(endRate)){
	 		alert("利息输入有误!");
	 		return false;
	 	}
		return true;
	}
	function showExport()
	{
		document.getElementById("searchForm").action ="<%=controller.getURI(request, TzRecordExport.class)%>";
		$("#searchForm").submit();
		document.getElementById("searchForm").action ="<%=controller.getURI(request, TzRecordList.class)%>";
	}
	</script>
</body>
</html>