<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.bid.hbgl.OpState"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.hbgl.DelRedP"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.hbgl.OpRedp"%>
<%@page import="com.dimeng.p2p.S10.entities.RedPacket"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%
	CURRENT_CATEGORY="YWGL";
	CURRENT_SUB_CATEGORY="REDPLIST";
	PagingResult<RedPacket> list = ObjectHelper.convert(request.getAttribute("list"), PagingResult.class);
	RedPacket[] recordArray = list.getItems();
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
<div class="main clearfix">
    <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<form id="form1" action="<%=controller.getURI(request, RedpList.class)%>" method="post">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>红包配置</h3>
                    </div>
                    <div class="con">
                    	  <div class="admin_input admin_pb">
                                <p>发放类型：
                                	<select name="source">
                                		<option value="0" <%="0".equals(request.getParameter("source"))?"selected":""%>>全部</option>
                                		<option value="2" <%="2".equals(request.getParameter("source"))?"selected":""%>>注册</option>
                                		<option value="3" <%="3".equals(request.getParameter("source"))?"selected":""%>>推广</option>
                                	</select>
                                </p>
                                <p>状态：
                                	<select name="state">
                                		<option value="0" <%="0".equals(request.getParameter("state"))?"selected":""%>>全部</option>
                                		<option value="1" <%="1".equals(request.getParameter("state"))?"selected":""%>>开启</option>
                                		<option value="2" <%="2".equals(request.getParameter("state"))?"selected":""%>>关闭</option>
                                	</select>
                                </p>
                                <p>有效天数： <input type="text" name="effectiveDays" onblur="checkNum(this);" value="<%StringHelper.filterHTML(out, request.getParameter("effectiveDays"));%>" class="yhgl_input mr5 isint" />以上</p>
                                <p>起投金额： <input type="text" name="ranges" onblur="checkNum(this);" value="<%StringHelper.filterHTML(out, request.getParameter("ranges"));%>" class="yhgl_input mr5 isint" />以上</p>
                                <input name="" type="submit" class="btn2 mr10" value="搜索" />
                          		<%if (dimengSession.isAccessableResource(OpRedp.class)) {%>
                          		<a href="<%=controller.getURI(request,OpRedp.class)%>" class="btn3 mr10"><font style="margin-left: 30px;">添加</font></a>
                          		<%} %>
                   				<div class="clear"></div>
                              <div class="clear"></div>
                    	</div>    
                    </div>
                </div>
              	<div>
                <table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
                        <tr class="hsbg">
                          <td>序号</td>
                          <td>发放类型</td>
                          <td>红包类型</td>
                          <td>红包金额</td>
                          <td>有效天数</td>
                          <td>起投金额</td>
                          <td>状态</td>
                          <td>创建时间</td>
                          <td>操作</td>
                        </tr>
                        <%
                        	if (recordArray != null) {
                        		int index = 1;
                        		for (RedPacket record:recordArray)
                        		{if (record == null) {continue;}
                        %>
                        <tr class="dhsbg">
                          <td><%=index++ %></td>
                          <td><%=record.source==2?"注册":"推广"%></td>
                          <td><%=record.type==1?"投资红包":"现金红包"%></td>
                          <td><%=Formater.formatAmount(record.amount) %></td>
                          <td><%=record.effectiveDays%></td>
                          <td><%=record.ranges.intValue()%></td>
                          <td><%=record.state==1?"启用":"关闭"%></td>
                          <td><%=DateTimeParser.format(record.createTime)%></td>
                          <td>
                          		<span class="blue"><a href="<%=controller.getURI(request, OpState.class)%>?id=<%=record.id%>&isOpen=<%=record.state==2?"T":"F"%>"  class="mr10"><%=record.state==2?"启用":"关闭"%></a></span>
                           		<span class="blue"><a href="<%=controller.getURI(request, OpRedp.class)%>?id=<%=record.id%>" class="mr10">修改</a></span>
                          		<span class="blue"><a href="javascript:;;" onclick="delById(<%=record.id%>);" class="mr10">删除</a></span>
                          </td>
                        </tr>
                        <%
                        	}}
                        %>
                      </table>
                </div>
                <%AbstractConsoleServlet.rendPagingResult(out, list);%>
                </form>       
            </div>
        </div>   
    </div>
    <%@include file="/WEB-INF/include/left.jsp"%>
</div>
</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript">
	var post_url="<%=controller.getURI(request, DelRedP.class)%>";
	function delById(id){
		if(confirm("确定删除此记录？")){
			location.href=post_url+"?id="+id;
		}
	}
	var reg=/^[1-9][0-9]+$/;
	function checkNum(obj){
		var value=obj.value;
		if(value.length>0 && !reg.test(value)){
			obj.value=0;
		}
	}
	</script>
</body>
</html>