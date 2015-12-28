<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.S64.enums.T6410_F07"%>
<%@page import="com.dimeng.p2p.modules.financial.console.service.entity.PlanMoney"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="com.dimeng.p2p.common.enums.PlanState"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.lcgl.yxlcjh.*"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%
	CURRENT_CATEGORY="YWGL";
	CURRENT_SUB_CATEGORY="YXLCJH";
	PagingResult<PlanMoney> pagingResult = (PagingResult<PlanMoney>)request.getAttribute("planMoneys");
	PlanMoney[] planMoneyArray = pagingResult.getItems();
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
  <div class="main clearfix">
    <div class="wrap">
      <div class="r_main">
        <div class="home_main">
          <form id="form1" action="<%=controller.getURI(request, PlanMoneyList.class)%>" method="post">
          <div class="box box1 mb15">
          	<div class="atil">
              <h3>优选理财计划</h3>
            </div>
          
            <div class="con">
              <div class="admin_input admin_pb">  
                <P> 
                  	<span>计划名称：</span>
                   <input type="text" name="planName" id="textfield" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("planName"));%>"/>
                </P>
                <p>   
                   	<span>状态：</span>
                    <select name="state" class="yhgl_sel">
                      <option value="">全部</option>
                      	<option value="DSQ" <%if ("DSQ".equals(request.getParameter("state"))) {%> selected="selected" <%}%>>预售中</option>
						<option value="SQZ" <%if ("YFB".equals(request.getParameter("state"))) {%> selected="selected" <%}%>>申请中</option>
						<option value="YSX" <%if ("YSX".equals(request.getParameter("state"))) {%> selected="selected" <%}%>>已满额</option>
						<option value="YJZ" <%if ("YJZ".equals(request.getParameter("state"))) {%> selected="selected" <%}%>>已截止</option>
                    </select>
                 </p>
                  <div class="clear"></div>   
                    <div class="mt10">   
                    	<input name="input" type="submit" class="btn2 mr10" value="搜索" />
                    	<%if (dimengSession.isAccessableResource(AddPlanMoney.class)) {%>
                    		<a href="javascript:void(0)" name="input" onclick="window.location.href='<%=controller.getURI(request, AddPlanMoney.class)%>'" class="btn3 "><span class="ico1"></span>新增</a>
                    	<%}else{%>
                    	<span class="btn3 mr10 btn5"><span class="ico1"></span>新增</span>
                    	<%} %>
                   </div>               
              <div class="clear"></div>
            </div>
            </div>
          </div>
          <table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
            <tr class="hsbg">
              <td>序号</td>
              <td>计划名称</td>
              <td>总金额</td>
              <td>可投余额</td>
              <td>收益率</td>
              <td>加入人数</td>
              <td>发布时间</td>            
              <td>状态</td>
              <td>操作</td>
            </tr>
            <%if (planMoneyArray != null) {for (int i =0;i<planMoneyArray.length;i++){PlanMoney planMoney=planMoneyArray[i];if (planMoney == null) {continue;}%>
            <tr class="dhsbg">
              <td><%=i+1%></td>
              <td><%StringHelper.filterHTML(out, planMoney.planName);%></td>
              <td><%=Formater.formatAmount(planMoney.zje)%></td>
              <td><%=Formater.formatAmount(planMoney.ktye)%></td>
              <td><%=Formater.formatRate(planMoney.earningsRate)%></td>
              <td><%=planMoney.joinNumber %></td>
              <td><%=TimestampParser.format(planMoney.issueTime) %></td>
              <td>
              <%if(planMoney.state == T6410_F07.YFB && planMoney.startTime.after(planMoney.currentTime)){%>
				预售中
			<%}else if(planMoney.state == T6410_F07.YFB && !planMoney.startTime.after(planMoney.currentTime)){%>
				申请中
			<%}else if(planMoney.state == T6410_F07.YSX){%>
				已满额
			<%}else if(planMoney.state == T6410_F07.YJZ){%>
				已截止
			<%}%>
              </td>
              <td>
              <%if (dimengSession.isAccessableResource(ViewPlanMoney.class)) {%>
              	<span class="blue"><a href="<%=controller.getURI(request,ViewPlanMoney.class)%>?planMoneyId=<%=planMoney.planMoneyId%>" class="mr10">查看详情</a></span>
              <%}else{ %>
              	<span class="disabled">查看详情</span>
              <%} %>
              </td>
            </tr>
            <%}} %>
          </table>
          <%AbstractConsoleServlet.rendPagingResult(out, pagingResult);%>
          </form>
          <div class="box2 clearfix"></div>
        </div>
      </div>
    </div>

	<%@include file="/WEB-INF/include/left.jsp"%>
	</div>
	</div>
	
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	
	<%
		Object str = request.getAttribute("isExist");
		if(str != null){
		boolean isExist = ObjectHelper.convert(request.getAttribute("isExist"), Boolean.class);
		if (isExist) {
	%>
	
	<script type="text/javascript">
		alert("已存在待申请和申请中的优选理财，不能新增！");
	</script>
	<%
		}}
	%>
	
</body>
</html>