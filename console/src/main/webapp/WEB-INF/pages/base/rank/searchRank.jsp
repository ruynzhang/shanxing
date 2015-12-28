<%@page import="com.dimeng.p2p.console.servlets.base.rank.EnableRank"%>
<%@page import="com.dimeng.p2p.console.servlets.base.rank.DisableRank"%>
<%@page import="com.dimeng.p2p.console.servlets.base.rank.UpdateRank"%>
<%@page import="com.dimeng.p2p.console.servlets.base.rank.AddRank"%>
<%@page import="com.dimeng.p2p.S51.enums.T5127_F06"%>
<%@page import="com.dimeng.p2p.S51.enums.T5127_F02"%>
<%@page import="com.dimeng.p2p.console.servlets.base.rank.SearchRank"%>
<%@page import="com.dimeng.p2p.S51.entities.T5127"%>
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
	CURRENT_SUB_CATEGORY = "DJSZ";
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
<div class="main clearfix">
	 <%
	 	PagingResult<T5127> result = ObjectHelper.convert(request.getAttribute("result"), PagingResult.class);
	 %>
	 <form action="<%=controller.getURI(request, SearchRank.class)%>" method="post">
  	 <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>等级列表</h3>
                  </div>
                    <div class="con">
                     <div class="admin_input admin_pb">
                    <div class="clear"></div>
                    
                    <p>等级类型：
						<select name="F02" class="yhgl_sel">
	                    	<option value="">全部</option>
	                    	<%
                        	for (T5127_F02 status : T5127_F02.values()) {
                        	%>
							<option value="<%=status.name()%>" <%if (status.name().equals(request.getParameter("F02"))) {%> selected="selected" <%}%>><%=status.getChineseName()%></option>
							<%
							}
							%>
	                    </select>
					</p>      	
                    <p>状态：
						<select name="F06" class="yhgl_sel">
	                    	<option value="">全部</option>
	                    	<%
                        	for (T5127_F06 status : T5127_F06.values()) {
                        	%>
							<option value="<%=status.name()%>" <%if (status.name().equals(request.getParameter("F06"))) {%> selected="selected" <%}%>><%=status.getChineseName()%></option>
							<%
							}
							%>
	                    </select>
					</p>      	
                    <div class="clear"></div>                    
	                <div class="mt10">
	                	<input name="input" type="submit" class="btn2 fl mr10" value="搜索" />
	                	<%if (dimengSession.isAccessableResource(AddRank.class)) {%>                    
	                    	<a href="<%=controller.getURI(request, AddRank.class)%>" class="btn3 mr10"><span class="ico3"></span>添加</a>
	                    <%}else{ %>
							<span class="btn3 mr10 btn5"><span class="ico1"></span>添加</span>
						<%} %>
	                </div>
	                <div class="clear"></div>
                  </div>
                  </div>
                </div>
                
                
                <div>
                  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
                        <tr class="hsbg">
                          <td>序号</td>
                          <td>等级类型</td>
                          <td>等级</td>
                          <td>上限</td>   
                          <td>下限</td>   
                          <td>状态</td>   
                          <td>操作</td>   
                        </tr>
                        <%
                        	T5127[] ranks = result.getItems();
                            	if(ranks != null){
                                 	int index = 1;
                                 	for(T5127 rank : ranks){
                        %>
                        <tr class="dhsbg">
                          <td><%=index++%></td>
                          <td><%=rank.F02.getChineseName() %></td>
                          <td><%=rank.F03.getChineseName() %></td>
                          <td><%=rank.F04 %></td>
                          <td><%=rank.F05 %></td>
                          <td><%=rank.F06.getChineseName() %></td>
                          <td>
                          	<%if (dimengSession.isAccessableResource(UpdateRank.class)) {%>
                          		<a href="<%=controller.getURI(request, UpdateRank.class)%>?id=<%=rank.F01%>" class="blue">修改</a>
                          	<%}else{ %>
								<span class="diabled mr10">修改</span>
							<%} %>
							<%if(rank.F06 ==  T5127_F06.TY){ %>
		                   	<%if (dimengSession.isAccessableResource(EnableRank.class)) {%>
			              	<span class="blue"><a href="<%=controller.getURI(request,EnableRank.class)%>?id=<%=rank.F01%>">启用</a></span>
			              	<%}else{ %>
		                   	<span class="disabled">启用</span>
		                   	<%} %>
		                   	<%}else{ %>
			                   	<%if (dimengSession.isAccessableResource(DisableRank.class)) {%>
				              	<span class="blue"><a href="<%=controller.getURI(request,DisableRank.class)%>?id=<%=rank.F01%>">停用</a></span>
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