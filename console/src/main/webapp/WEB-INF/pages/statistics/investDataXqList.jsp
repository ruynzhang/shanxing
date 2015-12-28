<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.statistics.InvestDataXqSList"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.StaffMap"%>
<%@page import="com.dimeng.p2p.console.servlets.statistics.InvestDataXqExport"%>
<%@page import="com.dimeng.p2p.console.servlets.statistics.InvestDataXqList"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.InvestDataXqVO"%>
<%@page import="java.util.List"%>
<%@page import="com.dimeng.util.Formater"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<%
CURRENT_CATEGORY = "TJGL";
CURRENT_SUB_CATEGORY = "INVESTDATAXQLIST";
PagingResult<InvestDataXqVO> list = (PagingResult<InvestDataXqVO>)request.getAttribute("list");
int mapSize=StaffMap.deptMap.size();
Object s[] = StaffMap.deptMap.keySet().toArray();
%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<form action="<%controller.getURI(request, InvestDataXqList.class);%>" method="post" name="form1" id="searchForm" onsubmit="return onSubmit();">
							<div class="box box1 mb15">
								<div class="con">
									<div class="admin_input admin_pb">
             							<div class="table top3">
             								<P>
             									<span>部门：</span>
												<select id="deptNum" name="deptNum" class="yhgl_input" style="width: 135px;">
					                        	 <option value="0">全部</option>
					                        	<%for(int i = 0; i < mapSize; i++) {%>
					                            <option value="<%=s[i]%>"><%=StaffMap.deptMap.get(s[i])%></option>
					                    		<%}%>
					                        	</select>
											</P>
											<P>
												<span>开始时间：</span>
												<input type="text" name="staDate" id="datepicker1" readonly="readonly" class="yhgl_input date" value="<%StringHelper.filterHTML(out, request.getParameter("staDate"));%>"/>至
												<input type="text" name="endDate" id="datepicker2" readonly="readonly" class="yhgl_input date" value="<%StringHelper.filterHTML(out, request.getParameter("endDate"));%>"/>
											</P>
											<P>
												<input name="search" type="submit" class="btn2" value="搜索" />
												<%if (dimengSession.isAccessableResource(InvestDataXqExport.class)) {%>
												<a href="javascript:void(0)" onclick="showExport()" class="btn3 mr10" style="margin-left: 10px;"><span class="ico"></span>导出</a> 
				                          		<%}else{%>
												<span class="btn3 btn5 mr10" style="margin-top: -0px;margin-left: 10px;"><span class="ico"></span>导出</span>
												<%}%>
											</P>
									<div class="clear"></div>
								</div>
								</div>
								</div>
							</div>
							<table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
								<tr class="hsbg">
									<td>序号</td>
									<td>部门</td>
									<td>用户名</td>
									<td>姓名</td>
									<td>客户用户名</td>
									<td>客户姓名</td>
									<td>标的id</td>
									<td>标的名称</td>
									<td>放款时间</td>
									<td>投资金额</td>
									<td>投资期限</td>
									<td>标的收益率</td>
								</tr>
								<%
									if(list.getItems()!=null){
										int i=1;
										for(InvestDataXqVO vo:list.getItems()){
								%>
								<tr class="dhsbg">
									<td><%=i++%></td>
									<td><%StringHelper.filterHTML(out, StaffMap.deptName(vo.deptNum));%></td>
									<td><%StringHelper.filterHTML(out, vo.userName);%></td>
									<td><%StringHelper.filterHTML(out, vo.realName);%></td>
									<td><%StringHelper.filterHTML(out, vo.khUname);%></td>
									<td><%StringHelper.filterHTML(out, vo.khname);%></td>
									<td><%=vo.bId%></td>
									<td><%StringHelper.filterHTML(out, vo.bdName);%></td>
									<td><%=DateTimeParser.format(vo.fk_date)%></td>
									<td><%=Formater.formatAmount(vo.amount) %></td>
									<td><%=vo.deadline%></td>
									<td><%StringHelper.filterHTML(out, vo.lucre);%></td>
								</tr>
								<%}}%>
							</table>
							<div class="box2 clearfix"></div>
							 <%InvestDataXqExport.rendPagingResult(out, list); %>
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
	$("#deptNum option[value="+<%=request.getParameter("deptNum")%>+"]").attr("selected",true);
	$(function() {
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
		document.getElementById("searchForm").action ="<%=controller.getURI(request, InvestDataXqExport.class)%>";
		$("#searchForm").submit();
		document.getElementById("searchForm").action ="<%=controller.getURI(request, InvestDataXqList.class)%>";
	}
	</script>
</body>
</html>
