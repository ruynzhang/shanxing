<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.account.jgxx.ViewJgxx"%>
<%@page import="com.dimeng.p2p.console.servlets.account.jgxx.UpdateJgxx"%>
<%@page import="com.dimeng.p2p.console.servlets.account.jgxx.jscl.ViewJscl"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F07"%>
<%@page import="com.dimeng.p2p.console.servlets.account.jgxx.jscl.UpdateJscl"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.Organization"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%
	CURRENT_CATEGORY="YHGL";
	CURRENT_SUB_CATEGORY="JG";
	PagingResult<Organization> list = (PagingResult<Organization>)request.getAttribute("list");
	
	Organization[] enterpriseArray =null;
	if(list!=null){
		enterpriseArray=list.getItems();
	}
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
<div class="main clearfix">
   <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<form id="form1" action="<%=controller.getURI(request, JgList.class)%>" method="post">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>机构信息</h3>
                    </div>
                    <div class="con">
                    	  <div class="admin_input admin_pb">
                                <p>机构名称：<input type="text" name="userName" value="<%StringHelper.filterHTML(out, request.getParameter("userName"));%>" class="yhgl_input mr5" /></p>
                                <p>联系人姓名：<input type="text" name="realName" value="<%StringHelper.filterHTML(out, request.getParameter("realName"));%>" class="yhgl_input mr5" /></p>
                                <p>联系人电话：<input type="text" name="msisdn" value="<%StringHelper.filterHTML(out, request.getParameter("msisdn"));%>" class="yhgl_input" /><input type="hidden" name="lhUserId" /></p>
                       	    	<p>注册时间：<input type="text" name="createTimeStart" readonly="readonly" id="datepicker1" class="yhgl_input date" />
                                <span class="pr10">至</span><input readonly="readonly" type="text" name="createTimeEnd" id="datepicker2" class="yhgl_input date" /></p>
                              <p>状态：
                                	<select name="userState" class="yhgl_sel">
                                  	<option value="">全部</option>
                                  	<%
                                  		for (T6110_F07 userState : T6110_F07.values()) {
                                  	%>
									<option value="<%=userState.name()%>" <%if (userState.name().equals(request.getParameter("userState"))) {%> selected="selected" <%}%>><%=userState.getChineseName()%></option>
									<%
										}
									%>                                
                                  </select>
                                </p>
                              <div class="clear"></div>
                              <div class="mt10">
                              	<input name="" type="submit" class="btn2 mr10" value="搜索" />
                   				<div class="clear"></div>
                              </div>
                    	</div>    
                    </div>
                </div>
  				
              	<div>
                <table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
                        <tr class="hsbg">
                          <td>序号</td>
                          <td>机构账号</td>
                          <td>机构名称</td>
                          <td>联系人姓名</td>
                          <td>联系人电话</td>
                          <td>注册时间</td>
                          <td>状态</td>
                          <td>操作</td>
                        </tr>
                        <%
                        	if (enterpriseArray != null) {for (int i =0;i<enterpriseArray.length;i++){Organization enterprise=enterpriseArray[i];if (enterprise == null) {continue;}
                        %>
                        <tr class="dhsbg">
                          <td><%=i+1%></td>
                          <td><%=enterprise.F02%></td>
                          <td><%StringHelper.filterHTML(out, enterprise.F10);%></td>
                          <td><%StringHelper.filterHTML(out, enterprise.lxr);%></td>
                          <td><%StringHelper.filterHTML(out, enterprise.lxrPhone);%></td>
                          <td><%=TimestampParser.format(enterprise.F07)%></td>
                           <td><%=enterprise.F06.getChineseName()%></td>
                          <td>
                          	<span class="blue"><a href="<%=controller.getURI(request,ViewJgxx.class)%>?id=<%=enterprise.F01%>" class="mr10">查看</a></span>
                          	<%if (dimengSession.isAccessableResource(UpdateJgxx.class)) {%>
                          	<span class="blue"><a href="<%=controller.getURI(request,UpdateJgxx.class)%>?id=<%=enterprise.F01%>" class="mr10">修改</a></span>
                          	<%}else{ %>
                          	<span class="disabled">修改</span>
                          	<%} %>
                         
                          </td>
                        </tr>
                        <%
                        	}}
                        %>
                      </table>
                </div>
                
                <%
                	AbstractConsoleServlet.rendPagingResult(out, list);
                %>
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
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
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