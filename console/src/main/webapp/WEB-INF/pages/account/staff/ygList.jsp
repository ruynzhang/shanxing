<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.StaffMap"%>
<%@page import="com.dimeng.p2p.console.servlets.account.staff.AddStaff"%>
<%@page import="com.dimeng.p2p.console.servlets.account.staff.AddYg"%>
<%@page import="com.dimeng.p2p.console.servlets.account.staff.DeleteYg"%>
<%@page import="com.dimeng.p2p.console.servlets.account.staff.UpdateYg"%>
<%@page import="com.dimeng.p2p.console.servlets.account.staff.YgList"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.Staff"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%
	CURRENT_CATEGORY="YHGL";
	CURRENT_SUB_CATEGORY="YGXX";
	PagingResult<Staff> list = ObjectHelper.convert(request.getAttribute("list"), PagingResult.class);
	Staff[] userArray = list.getItems();
	int mapSize=StaffMap.deptMap.size();
	Object s[] = StaffMap.deptMap.keySet().toArray();
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
<div class="main clearfix">
    <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<form id="form1" action="<%=controller.getURI(request, com.dimeng.p2p.console.servlets.account.staff.YgList.class)%>" method="post">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>员工信息</h3>
                    </div>
                    <div class="con">
                    	  <div class="admin_input admin_pb">
                                <p>用户名称：<input type="text" name="userName" value="<%StringHelper.filterHTML(out, request.getParameter("userName"));%>" class="yhgl_input mr5" /></p>
                                <p>手机号码：<input type="text" name="moblie" value="<%StringHelper.filterHTML(out, request.getParameter("moblie"));%>" class="yhgl_input mr5" /></p>
                                <P>
         						<span>部门：</span>
								<select id="deptNum" name="deptNum" class="yhgl_input" style="width: 200px;">
	                        	 <option value="0">全部</option>
	                        	<%for(int i = 0; i < mapSize; i++) {%>
	                            <option value="<%=s[i]%>"><%=StaffMap.deptMap.get(s[i])%></option>
	                    		<%}%>
	                        	</select>
								</P>
                                <input name="" type="submit" class="btn2 mr10" value="搜索" />
                          		<%--if (dimengSession.isAccessableResource(AddStaff.class)) {%>
                          		<a href="<%=controller.getURI(request,AddStaff.class)%>" class="btn3 mr10"><font style="margin-left: 20px;">新增员工</font></a>
                          		<%} --%>
                   				<div class="clear"></div>
                              <div class="clear"></div>
                    	</div>    
                    </div>
                </div>
              	<div>
                <table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
                        <tr class="hsbg">
                          <td>序号</td>
                          <td>用户名称</td>
                          <td>真实姓名</td>
                          <td>手机</td>
                          <td>邮箱</td>
                          <td>内外勤</td>
                          <td>部门</td>
                          <td>员工编号</td>
                          <td>操作</td>
                        </tr>
                        <%
                        	if (userArray != null) {
                        		int index = 1;
                        		for (Staff user:userArray)
                        		{if (user == null) {continue;}
                        %>
                        <tr class="dhsbg">
                          <td><%=index++ %></td>
                          <td><%StringHelper.filterHTML(out, user.userName);%></td>
                          <td><%StringHelper.filterHTML(out, user.realName);%></td>
                          <td><%StringHelper.filterHTML(out, user.moblie); %></td>
                          <td><%StringHelper.filterHTML(out, user.email);%></td>
                          <td><%StringHelper.filterHTML(out, user.inSign==1?"内勤":"外勤");%></td>
                          <td><%StringHelper.filterHTML(out, user.getDeptName());%></td>
                          <td><%StringHelper.filterHTML(out, user.empNo);%></td>
                          <td>
                           <%if (dimengSession.isAccessableResource(UpdateYg.class)) {%>
                          	<span class="blue"><a href="<%=controller.getURI(request,UpdateYg.class)%>?id=<%=user.id%>" class="mr10">查看</a></span>
                          	<%}else{ %>
                          	<span class="disabled">查看</span>
                          	<%} %>
                          	<%--if (dimengSession.isAccessableResource(DeleteYg.class)) {%>
                          	<span class="blue"><a href="javascript:deleteYg(<%=user.id%>);" class="mr10">删除</a></span>
                          	<%}else{ %>
                          	<span class="disabled">删除</span>
                          	<%} --%>
                          </td>
                        </tr>
                        <%
                        	}}
                        %>
                      </table>
                </div>
                <%YgList.rendPagingResult(out, list); %>
                </form>       
            </div>
        </div>   
    </div>
    <%@include file="/WEB-INF/include/left.jsp"%>
</div>
</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	 <div> <input type="hidden"  id="post_url" value="<%=controller.getURI(request,DeleteYg.class)%>"/> </div>
	<script type="text/javascript">
	$("#deptNum option[value="+<%=request.getParameter("deptNum")%>+"]").attr("selected",true);
	function deleteYg(id){
		if(confirm("确定要删除此员工信息吗？")){
			location.href=$("#post_url").val()+"?id="+id;
		}
	}
	</script>
</body>
</html>