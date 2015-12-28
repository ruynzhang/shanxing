<%@page import="com.dimeng.p2p.console.servlets.base.bank.DisableBank"%>
<%@page import="com.dimeng.p2p.console.servlets.base.bank.EnableBank"%>
<%@page import="com.dimeng.p2p.S50.enums.T5020_F03"%>
<%@page import="com.dimeng.p2p.S50.entities.T5020"%>
<%@page import="com.dimeng.p2p.console.servlets.base.bank.UpdateBank"%>
<%@page import="com.dimeng.p2p.console.servlets.base.bank.AddBank"%>
<%@page import="com.dimeng.p2p.console.servlets.base.bank.SearchBank"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html > 
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>

<body>
<%
	CURRENT_CATEGORY = "JCXXGL";
	CURRENT_SUB_CATEGORY = "YHSZ";
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
<div class="main clearfix">
	 <%
	 	PagingResult<T5020> result = ObjectHelper.convert(request.getAttribute("result"), PagingResult.class);
	 %>
	 <form action="<%=controller.getURI(request, SearchBank.class)%>" method="post">
  	 <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>银行设置</h3>
                  </div>
                    <div class="con">
                    <div class="clear"></div>
                    
                    <div class="table top3">
                    <span>银行名称：</span><span><input type="text" name="name" id="textfield4" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("name"));%>"/></span>
                    </div>
                        <p>状态：
						<select name="status" class="yhgl_sel">
	                    	<option value="">全部</option>
	                    	<%
                        	for (T5020_F03 status : T5020_F03.values()) {
                        	%>
							<option value="<%=status.name()%>" <%if (status.name().equals(request.getParameter("status"))) {%> selected="selected" <%}%>><%=status.getChineseName()%></option>
							<%
							}
							%>
	                    </select>
					</p>      	
                    <div class="clear"></div>                    
	                <div class="mt10">
	                	<input name="input" type="submit" class="btn2 fl mr10" value="搜索" />
	                	<%if (dimengSession.isAccessableResource(AddBank.class)) {%>                    
	                    	<a href="<%=controller.getURI(request, AddBank.class)%>" class="btn3 mr10"><span class="ico3"></span>添加</a>
	                    <%}else{ %>
							<span class="btn3 mr10 btn5"><span class="ico1"></span>添加</span>
						<%} %>
	                </div>
	                <div class="clear"></div>
                  </div>
                </div>
                
                
                <div>
                  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
                        <tr class="hsbg">
                          <td>序号</td>
                          <td>银行名称</td>
                          <td>银行简拼</td>
                          <td>状态</td>
                          <td>操作</td>                          
                        </tr>
                        <%
                        	T5020[] banks = result.getItems();
                            	if(banks != null){
                                 	int index = 1;
                                 	for(T5020 bank : banks){
                        %>
                        <tr class="dhsbg">
                          <td><%=index++%></td>
                          <td><%
                          	StringHelper.filterHTML(out, bank.F02);
                          %></td>
                          <td><%
                          	StringHelper.filterHTML(out, bank.F04);
                          %></td>
                          <td><%=bank.F03.getChineseName() %></td>
                          <td>
                          	<%if (dimengSession.isAccessableResource(UpdateBank.class)) {%>
                          		<a href="<%=controller.getURI(request, UpdateBank.class)%>?id=<%=bank.F01%>" class="blue">修改</a>
                          	<%}else{ %>
								<span class="diabled mr10">修改</span>
							<%} %>
							<%if(bank.F03 ==  T5020_F03.TY){ %>
		                   	<%if (dimengSession.isAccessableResource(EnableBank.class)) {%>
			              	<span class="blue"><a href="<%=controller.getURI(request,EnableBank.class)%>?id=<%=bank.F01%>">启用</a></span>
			              	<%}else{ %>
		                   	<span class="disabled">启用</span>
		                   	<%} %>
		                   	<%}else{ %>
			                   	<%if (dimengSession.isAccessableResource(DisableBank.class)) {%>
				              	<span class="blue"><a href="<%=controller.getURI(request,DisableBank.class)%>?id=<%=bank.F01%>">停用</a></span>
				              	<%}else{ %>
			                   	<span class="disabled">停用</span>
			                   	<%} %>
		                	 <%} %> 
                        </td>                          
                        </tr>
                   <%	}}%>
                      </table>
              </div>
               <% 
               SearchBank.rendPagingResult(out, result);%>
              <div class="box2 clearfix"></div>
            </div>
        </div>   
    </div>
   </form>
   <%@include file="/WEB-INF/include/left.jsp" %>
   </div>
   </div>
   
<%@include file="/WEB-INF/include/footer.jsp"%>
<%@include file="/WEB-INF/include/script.jsp"%>

</body>
</html>