<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.account.sxgl.SxExport"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.ScreeningVO"%>
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
CURRENT_CATEGORY = "YHGL";
CURRENT_SUB_CATEGORY = "SXLIST";
PagingResult<ScreeningVO> list = ObjectHelper.convert(request.getAttribute("list"), PagingResult.class);
ScreeningVO[] voArray=null;
if(list!=null){
voArray = list.getItems();
}
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
<div class="main clearfix">
    <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<form action="<%=controller.getURI(request, SxList.class)%>" method="post" id="searchForm" onsubmit="return onSubmit();">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>筛选管理</h3>
                    </div>
                    <div class="con">
                    	  <div class="admin_input admin_pb">
                    	  		<P>
									<span>实名认证：</span>
									<select id="flag" name="flag" class="text yhgl_ser input"  style="width: 80px;">
											<option value="0">全部</option>
											<option value="1">已实名</option>
											<option value="2">未实名</option>
									</select>
								</P>
                    	  		<P>
									<span>用户名：</span>
									<input type="text" name="userName" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("userName"));%>"/>
								</P>
								<P>
									<span>姓名：</span>
									<input type="text" name="realName" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("realName"));%>"/>
								</P>
							     <P>
									<span>注册时间：</span>
									<input type="text" name="staDate" id="datepicker1" readonly="readonly" class="yhgl_input date" value="<%StringHelper.filterHTML(out, request.getParameter("staDate"));%>"/>至
									<input type="text" name="endDate" id="datepicker2" readonly="readonly" class="yhgl_input date" value="<%StringHelper.filterHTML(out, request.getParameter("endDate"));%>"/>
								</P>
								<P>
									<input name="search" type="submit" class="btn2" value="搜索" />
									<%if (dimengSession.isAccessableResource(SxExport.class)) {%>
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
                          <td>账户余额</td>
                          <td>借款负债</td>
                          <td>净资产</td>
                          <td>理财资产</td>
                          <td>注册时间</td>
                          <td>出生日期</td>
                        </tr>
                        <%
                        	if (voArray != null) {
                        		int index = 1;
                        		for (ScreeningVO vo:voArray)
                        		{if (vo == null) {continue;}
                        %>
                        <tr class="dhsbg">
                          <td><%=index++ %></td>
                          <td><%StringHelper.filterHTML(out, vo.userName); %></td>
                          <td><%StringHelper.filterHTML(out, vo.realName);%></td>
                          <td><%=Formater.formatAmount(vo.zh_Amount) %></td>
                          <td><%=Formater.formatAmount(vo.fz_Amount) %></td>
                          <td><%=Formater.formatAmount(vo.jzc_Amount) %></td>
                          <td><%=Formater.formatAmount(vo.lc_Amount) %></td>
                          <td><%=DateTimeParser.format(vo.zc_Date)%></td>
                          <td><%StringHelper.filterHTML(out, vo.cs_Date); %></td>
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
	$("#flag option[value="+<%=request.getParameter("flag")%>+"]").attr("selected",true);
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
		document.getElementById("searchForm").action ="<%=controller.getURI(request, SxExport.class)%>";
		$("#searchForm").submit();
		document.getElementById("searchForm").action ="<%=controller.getURI(request, SxList.class)%>";
	}
	</script>
</body>
</html>