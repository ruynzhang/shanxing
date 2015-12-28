<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.finance.bonus.BonusSonList"%>
<%@page import="java.util.List"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.bonus.BonusExport"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.StaffMap"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.SlBonusVO"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.bonus.BonusList"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%
CURRENT_CATEGORY = "CWGL";
CURRENT_SUB_CATEGORY = "BONUSLIST";
PagingResult<SlBonusVO> list = ObjectHelper.convert(request.getAttribute("list"), PagingResult.class);
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
<div class="main clearfix">
    <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<form action="<%=controller.getURI(request, BonusList.class)%>" method="post" id="searchForm" onsubmit="return onSubmit();">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>佣金提成</h3>
                    </div>
                    <div class="con">
                    	  <div class="admin_input admin_pb">
                    	  		<P>
									<span>人员类别：</span>
									<select id="type" name="type" class="text yhgl_ser input"  style="width: 80px;">
											<option value="0">全部</option>
											<option value="1">内勤</option>
											<option value="2">外勤</option>
									</select>
								</P>
								<P>
									<span>姓名：</span>
									<input type="text" name="realName" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("realName"));%>"/>
								</P>
								<P>
									<span>贷款编号：</span>
									<select id="bId" name="bId" class="text yhgl_ser input"  style="width: 80px;">
											<option value="0">全部</option>
											<%
											List<Integer> bidList=(List<Integer>)request.getAttribute("bidList");
											if(bidList!=null){
												for(Integer bid:bidList){
											%>
												<option value="<%=bid%>"><%=bid%></option>
											<%}} %>
									</select>
								</P>
							     <P>
									<span>开始时间：</span>
									<input type="text" name="staDate" id="datepicker1" readonly="readonly" class="yhgl_input date" value="<%StringHelper.filterHTML(out, request.getParameter("staDate"));%>"/>至
									<input type="text" name="endDate" id="datepicker2" readonly="readonly" class="yhgl_input date" value="<%StringHelper.filterHTML(out, request.getParameter("endDate"));%>"/>
								</P>
								<P>
									<input name="search" type="submit" class="btn2" value="搜索" />
									<%if (dimengSession.isAccessableResource(BonusExport.class)) {%>
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
                          <td>部门</td>
                          <td>人员类别</td>
                          <td>姓名</td>
                          <td>客户</td>
                          <td>贷款编号</td>
                          <td>标的名称</td>
                          <td>出借日期</td>
                          <td>回款日期</td>
                          <td>投资期限</td>
                          <td>标的金额</td>
                          <td>投资金额</td>
                          <td>佣金率</td>
                          <td>佣金奖励</td>
                        </tr>
                        <%
                        	if (list!=null && list.getItems() != null) {
                        		int index = 1;
                        		for (SlBonusVO vo:list.getItems()){
                        %>
                        <tr class="dhsbg">
                          <td><%=index++ %></td>
                          <td><%StringHelper.filterHTML(out, StaffMap.deptName(vo.deptNum));%></td>
                          <td><%StringHelper.filterHTML(out, vo.Per_type);%></td>
                          <td><%StringHelper.filterHTML(out, vo.realName);%></td> 
                          <td><%StringHelper.filterHTML(out, vo.khName);%></td> 
                          <td><%=vo.bId%></td>
                          <td><%StringHelper.filterHTML(out, vo.bdName);%></td>
                          <td><%=DateTimeParser.format(vo.cj_date)%></td>
                          <td><%=DateTimeParser.format(vo.hk_date)%></td>
                          <td><%StringHelper.filterHTML(out, vo.deadLine); %></td>
                          <td><%=Formater.formatAmount(vo.bdAmount) %></td>
                          <td><%=Formater.formatAmount(vo.amount) %></td>
                          <td></td>
                          <td></td>
                        </tr>
                        <%}}%>
                 </table>
                </div>
                <%BonusList.rendPagingResult(out, list); %>
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
	$("#type option[value="+<%=request.getParameter("type")%>+"]").attr("selected",true);
	$("#bId option[value="+<%=request.getParameter("bId")%>+"]").attr("selected",true);
	$(function(){
	    $('#datepicker1').datepicker('option', {dateFormat:'yy-mm-dd'});
	    $("#datepicker2").datepicker({inline: true});
	    $('#datepicker2').datepicker('option', {dateFormat:'yy-mm-dd'});
	    $("#datepicker2").datepicker('option', 'minDate',$("#datepicker1").datepicker().val());
	});
	onSubmit=function(){
	 	var date1=$("#datepicker1").val();
	 	var date2=$("#datepicker2").val();
	 	if(date1>date2 && date2.length>0){
	 		alert("开始时间不能大于结束时间!");
	 		return false;
	 	}
		return true;
	}
	function showExport()
	{
		document.getElementById("searchForm").action ="<%=controller.getURI(request, BonusExport.class)%>";
		$("#searchForm").submit();
		document.getElementById("searchForm").action ="<%=controller.getURI(request, BonusList.class)%>";
	}
	</script>
</body>
</html>