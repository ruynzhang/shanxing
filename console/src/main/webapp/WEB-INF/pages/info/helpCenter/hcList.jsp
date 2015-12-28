<%@page import="com.dimeng.p2p.console.servlets.info.helpCenter.DelHc"%>
<%@page import="com.dimeng.p2p.console.servlets.info.helpCenter.OpHc"%>
<%@page import="com.dimeng.p2p.modules.base.console.service.entity.HelpCenterVO"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>

</head>

<body>
<%
	CURRENT_CATEGORY = "XCGL";
	CURRENT_SUB_CATEGORY = "HCLIST";
	PagingResult<HelpCenterVO> list = ObjectHelper.convert(request.getAttribute("list"), PagingResult.class); 
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
<div class="main clearfix">
	 <form action="<%=controller.getURI(request, HcList.class)%>" method="post">
  	 <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>帮助中心</h3>
                  </div>
                    <div class="con">
                    <div class="clear"></div>
					<div class="admin_input admin_pb">
					<p>
                    <span>一级：</span><span><input type="text" name="l1Name" id="l1Name" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("l1Name"));%>"/></span>
                    </p>
                    <p>
                    <span>二级：</span><span><input type="text" name="l2Name" id="l2Name" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("l2Name"));%>"/></span>
                    </p>
                   	<p>
                    <span>标题：</span><span><input type="text" name="title" id="title" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("title"));%>"/></span>
                    </p>
                    <div class="mt10">   
                    	<input name="" type="submit" class="btn2 mr10" value="搜索" style="cursor: pointer;"/>
                    	<%if (dimengSession.isAccessableResource(OpHc.class)) {%>
                   			<a href="<%=controller.getURI(request, OpHc.class)%>" class="btn3 mr10"><span class="ico3"></span>添加</a>
                   		<%}else{ %>
							<span class="btn3 btn5 mr10"><span class="ico3"></span>添加</span>
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
                          <td>一级</td>
                          <td>二级</td>
                          <td>标题</td>
                          <td>内容</td>
                          <td>发布时间</td>
                          <td>最后修改时间</td>
                          <td>操作</td>                          
                        </tr>
                        <%
                        	if(list != null && list.getItems()!=null){
                        		int index = 1;
                        		for(HelpCenterVO record : list.getItems()){
                        %>
                        <tr class="dhsbg">
                          <td><%=index++ %></td>
                          <td><%StringHelper.filterHTML(out, record.l1Name); %></td>
                          <td><%StringHelper.filterHTML(out, record.l2Name); %></td>
                          <td title="<%StringHelper.filterHTML(out, record.title); %>"><%StringHelper.filterHTML(out,StringHelper.truncation(record.title, 15)); %></td>
                          <td title="<%StringHelper.filterHTML(out, record.content); %>"><%StringHelper.filterHTML(out,StringHelper.truncation(record.content, 15)); %></td>
                          <td><%=DateTimeParser.format(record.createTime) %></td>
                          <td><%=DateParser.format(record.updateTime) %></td>
                          <td class="blue">
                          	<%if (dimengSession.isAccessableResource(OpHc.class)) {%>
                          		<a href="<%=controller.getURI(request, OpHc.class)%>?id=<%=record.id %>">修改</a>
                          	<%}else{ %>
								<span class="gray6">修改</span>
							<%} %> 
							<%if (dimengSession.isAccessableResource(DelHc.class)) {%>  
                          		<a href="javascript:delHc(<%=record.id %>);">删除</a>
                          	<%}else{ %>
								<span class="gray6">删除</span>
							<%} %> 
                        	</td>                          
                        </tr>
                   <%	}}%>
                      </table>
              </div>
               <% HcList.rendPagingResult(out, list);%>
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


<script type="text/javascript">
   		var del_url = '<%=controller.getURI(request, HcList.class) %>';
</script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/checkAll.js"></script>
<%@include file="/WEB-INF/include/datepicker.jsp"%>
	<script type="text/javascript">
	delHc=function(id){
		 if(confirm("确定要删除此数据吗？")){
			 location.href="<%=controller.getURI(request, DelHc.class)%>?id="+id;
		 }
	}
	</script>
	
</body>
</html>