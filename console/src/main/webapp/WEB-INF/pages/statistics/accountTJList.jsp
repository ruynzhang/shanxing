<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.modules.account.console.service.utils.CommUtils"%>
<%@page import="com.dimeng.p2p.console.servlets.statistics.AccountTJListExport"%>
<%@page import="com.dimeng.p2p.console.servlets.statistics.AccountTJList"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.AccountTJVO"%>
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
CURRENT_SUB_CATEGORY = "ACCOUNTTJLIST";
List<AccountTJVO> list = (List<AccountTJVO>)request.getAttribute("list");
AccountTJVO tjVO=(AccountTJVO)request.getAttribute("vo");
int mapSize=CommUtils.monthMap().size();
Object s[] = CommUtils.monthMap().keySet().toArray();
%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<form action="<%controller.getURI(request, AccountTJList.class);%>" method="post" name="form1" id="searchForm" onsubmit="return onSubmit();">
							<div class="box box1 mb15">
								<div class="atil">
			                    	<h3>平台会员统计</h3>
			                    </div>
								<div class="con">
									<div class="admin_input admin_pb">
										<div class="table top3">
										   <table border="0" width="80%" style="margin: 0px 0px 20px 0px; text-align: center;">
										     <tr>
										      <td width="10%" height="10">汇总</td>
										      <td width="20%">注册人数</td>
										      <td width="20%">安全认证人数</td>
										      <td width="20%">充值人数</td>
										      <td width="20%">投标人数</td>
										     </tr>
										     <tr>
										      <td height="10"></td>
										      <td><%=tjVO.registerNum%>个</td>
										      <td><%=tjVO.safeNum%>个</td>
										      <td><%=tjVO.czNum%>个</td>
										      <td><%=tjVO.tbNum%>个</td>
										     </tr>
										   </table>
             								
											<div class="clear"></div>
										</div>										
             							<div class="table top3">
             								<P>
												<span>月：</span>
												<select name="monthDate" class="yhgl_input" id="monthDate">
													<option value="0">请选择</option>
													<%for(int i = 0; i < mapSize; i++) {%>
						                            <option value="<%=s[i]%>"><%=CommUtils.monthMap().get(s[i])%></option>
						                    		<%}%>
												</select>
											</P>
											<P>
												<input name="search1" type="submit" class="btn2" value="搜索" onclick="setFlag(1);"/>
												<%if (dimengSession.isAccessableResource(AccountTJListExport.class)) {%>
												<a href="javascript:void(0)" onclick="showExport(1)" class="btn3 mr10" style="margin-left: 10px;"><span class="ico"></span>导出</a> 
				                          		<%}else{%>
												<span class="btn3 btn5 mr10" style="margin-top: -0px;margin-left: 10px;"><span class="ico"></span>导出</span>
												<%}%>
											</P>
											<P>
												<span>日：</span>
												<input type="text" name="staDate" id="datepicker1" readonly="readonly" class="yhgl_input date" value="<%StringHelper.filterHTML(out, request.getParameter("staDate"));%>"/>至
												<input type="text" name="endDate" id="datepicker2" readonly="readonly" class="yhgl_input date" value="<%StringHelper.filterHTML(out, request.getParameter("endDate"));%>"/>
											</P>
											<P>
												<input name="search2" type="submit" class="btn2" value="搜索" onclick="setFlag(2);"/>
												<%if (dimengSession.isAccessableResource(AccountTJListExport.class)) {%>
												<a href="javascript:void(0)" onclick="showExport(2)" class="btn3 mr10" style="margin-left: 10px;"><span class="ico"></span>导出</a> 
				                          		<%}else{%>
												<span class="btn3 btn5 mr10" style="margin-top: -0px;margin-left: 10px;"><span class="ico"></span>导出</span>
												<%}%>
											</P>
											<div class="clear"><input type="hidden" name="flag" id="flag" value="<%=request.getParameter("flag")%>"/></div>
										</div>
									</div>
								</div>
							</div>
							<table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
								<tr class="hsbg">
									<td>时间</td>
									<td>注册人数</td>
									<td>安全认证人数</td>
									<td>充值人数</td>
									<td>充值新增人数</td>
									<td>投标人数</td>
									<td>新增投标人数</td>
								</tr>
								<%
									if(list!=null){
										for(AccountTJVO vo:list){
								%>
								<tr class="dhsbg">
									<td><%StringHelper.filterHTML(out, vo.date);%></td>
									<td><%=vo.registerNum%></td>
									<td><%=vo.safeNum%></td>
									<td><%=vo.czNum%></td>
									<td><%=vo.newCzNum%></td>
									<td><%=vo.tbNum%></td>
									<td><%=vo.newTbNum%></td>
									
								</tr>
								<%}}%>
							</table>
							<div class="box2 clearfix"></div>
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
	$("#monthDate option[value="+<%=request.getParameter("monthDate")%>+"]").attr("selected",true);
	$(function() {
		$('#datepicker1').datepicker({dateFormat:'yy-mm-dd'});
	    $('#datepicker2').datepicker({dateFormat:'yy-mm-dd'});
	    $("#datepicker1").datepicker({inline: true});
	    $("#datepicker2").datepicker({inline: true});
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
	setFlag=function(val){
		$("#flag").val(val);
	}	
	function showExport(val)
	{
		document.getElementById("searchForm").action ="<%=controller.getURI(request, AccountTJListExport.class)%>";
		setFlag(val);
		$("#searchForm").submit();
		document.getElementById("searchForm").action ="<%=controller.getURI(request, AccountTJList.class)%>";
	}
	</script>
</body>
</html>
