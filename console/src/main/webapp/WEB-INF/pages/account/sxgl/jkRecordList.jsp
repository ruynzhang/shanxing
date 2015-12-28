<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.JkRecordVO"%>
<%@page import="com.dimeng.p2p.console.servlets.account.sxgl.JkRecordExport"%>
<%@page import="com.dimeng.p2p.console.servlets.account.sxgl.JkRecordList"%>
<%@page import="java.util.Map"%>
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
CURRENT_SUB_CATEGORY = "JKRECORDLIST";
PagingResult<JkRecordVO> list = ObjectHelper.convert(request.getAttribute("list"), PagingResult.class);
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
<div class="main clearfix">
    <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<form action="<%=controller.getURI(request, JkRecordList.class)%>" method="post" id="searchForm" onsubmit="return onSubmit();">
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
									<span>借款时间：</span>
									<input type="text" name="staDate" id="datepicker1" readonly="readonly" class="yhgl_input date" value="<%StringHelper.filterHTML(out, request.getParameter("staDate"));%>"/>至
									<input type="text" name="endDate" id="datepicker2" readonly="readonly" class="yhgl_input date" value="<%StringHelper.filterHTML(out, request.getParameter("endDate"));%>"/>
								</P>
								<P>
									<input name="search" type="submit" class="btn2" value="搜索" />
									<%if (dimengSession.isAccessableResource(JkRecordExport.class)) {%>
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
                          <td>借款年利率</td>
                          <td>借款期限</td>
                          <td>借款金额</td>
                          <td>借款时间</td>
                          <td>逾期状态</td>
                          <td>借款状态</td>
                        </tr>
                        <%
                        	if (list != null && null!=list.getItems()) {
                        		int index = 1;
                        		for (JkRecordVO vo:list.getItems()){
                        %>
                        <tr class="dhsbg">
                          <td><%=index++ %></td>
                          <td><%StringHelper.filterHTML(out, vo.userName); %></td>
                          <td><%StringHelper.filterHTML(out, vo.realName);%></td>
                          <td><%StringHelper.filterHTML(out, vo.phone);%></td>
                          <td><%=vo.bId%></td>
                          <td><%StringHelper.filterHTML(out, vo.bdName);%></td>
                          <td><%StringHelper.filterHTML(out, vo.rate);%></td>
                          <td><%StringHelper.filterHTML(out, vo.tzqx);%></td>
                          <td><%=Formater.formatAmount(vo.jk_amount) %></td>
                          <td><%=DateTimeParser.format(vo.jk_time)%></td>
                          <td><%StringHelper.filterHTML(out, vo.yq_status.getChineseName());%></td>
                          <td><%StringHelper.filterHTML(out, vo.jk_status.getChineseName());%></td>
                        </tr>
                        <%
                        	}}
                        %>
                 </table>
                </div>
                <%JkRecordList.rendPagingResult(out, list); %>
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
		document.getElementById("searchForm").action ="<%=controller.getURI(request, JkRecordExport.class)%>";
		$("#searchForm").submit();
		document.getElementById("searchForm").action ="<%=controller.getURI(request, JkRecordList.class)%>";
	}
	</script>
</body>
</html>