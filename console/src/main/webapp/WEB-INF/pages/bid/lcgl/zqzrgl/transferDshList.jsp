<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.bid.lcgl.zqzrgl.TransferFinishList"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.lcgl.zqzrgl.UnIssueManage"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.lcgl.zqzrgl.IssueManage"%>
<%@page import="com.dimeng.p2p.S62.entities.T6231"%>
<%@page import="com.dimeng.p2p.S62.entities.T6230"%>
<%@page import="com.dimeng.p2p.modules.bid.console.service.BidManage"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.lcgl.zqzrgl.TransferDshList"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.lcgl.zqzrgl.TransferDshList"%>
<%@page import="com.dimeng.p2p.modules.financial.console.service.entity.TransferDsh"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%
	CURRENT_CATEGORY="YWGL";
	CURRENT_SUB_CATEGORY="ZQZRGL";
	PagingResult<TransferDsh> transferDshs = (PagingResult<TransferDsh>)request.getAttribute("transferDshs");
	TransferDsh[] TransferDshArray = transferDshs.getItems();
%>
<%@include file="/WEB-INF/include/header.jsp"%>

<div class="w_main">
  <div class="main clearfix">
    <div class="wrap">
      <div class="r_main">
        <div class="home_main">
        <form action="<%=controller.getURI(request, TransferDshList.class)%>" method="post">
          <div class="box box1 mb15">
            <div class="atil">
              <h3>债权转让管理</h3>
            </div>
          </div>
          <div class="box box1 mb15">
            <div class="con">
              <div class="table">
              <span>创建时间：</span>
              <span><input type="text" readonly="readonly" name="createTimeStart" id="datepicker1" class="yhgl_input date" /></span>
              <span>至</span>
              <span><input type="text" readonly="readonly" name="createTimeEnd" id="datepicker2" class="yhgl_input date" /></span>
              <input name="input" type="submit" class="btn2" value="搜索" />
              </div>                
              <div class="clear"></div>
            </div>
          </div>
          <div class="newsbox">
            <div class="til clearfix">
              <div class="Menubox">
                <ul>
                  <li class="hover">待转让</li>	
                  <li onclick="window.location.href='<%=controller.getURI(request, TransferProceedList.class)%>'" >转让中</li>
                  <li onclick="window.location.href='<%=controller.getURI(request, TransferFinishList.class)%>'" style="border-right:1px #d7dfe3 solid;" >已结束</li>
                </ul>
              </div>
            </div>
            <div class="border p15 Men_bt no_table" id="con_one_2">
              <table width="100%" border="0" cellspacing="0" cellpadding="0" class="yhgl_table mb10">
                <tr class="hsbg">
                  <td><input type="checkbox" id="checkAll" class="mr5" /></td>
                  <td align="center">序号</td>
                  <td align="center">债权编码</td>
                  <td align="center">债权卖出者</td>
                  <td align="center">剩余期数</td>
                  <td align="center">年利率</td>
                  <td align="center">债权价值</td>
                  <td align="center">转让价格</td>
                  <td align="center">转让费率</td>
                  <td align="center">申请时间</td>
                  <td align="center">操作</td>
                </tr>
                <%
                BidManage bidManage = serviceSession.getService(BidManage.class);
                if (TransferDshArray != null && TransferDshArray.length>0) {
                	int i=1;
                	for (TransferDsh transferDsh :TransferDshArray){
                		if (transferDsh == null) {continue;}
                
			      T6230 t6230 =   bidManage.get(transferDsh.t6251.F03);
			      T6231 t6231 =   bidManage.getExtra(transferDsh.t6251.F03);
                %>
			       <tr class="bom">
			         <td><input type="checkbox" name="zqId" value="<%=transferDsh.F01%>" /></td>
			         <td align="center"><%=i++%></td>
			         <td align="center"><%StringHelper.filterHTML(out, transferDsh.t6251.F02); %></td>
			         <td align="center"><%StringHelper.filterHTML(out, transferDsh.t6110.F02);%></td>
			         <td align="center"><%=t6231.F03 %>/<%=t6231.F02 %></td>
			         <td align="center"><%=Formater.formatRate(t6230.F06)%></td>
			         <td align="center"><%=Formater.formatAmount(transferDsh.t6251.F07)%></td>
			         <td align="center"><%=Formater.formatAmount(transferDsh.F03)%></td>
			         <td align="center"><%=Formater.formatRate(transferDsh.F08)%></td>
			         <td align="center"><%=TimestampParser.format(transferDsh.F05) %></td>
			         <td align="center">
			         <a href="javascript:void(0)" onclick="fbZqzr('<%=transferDsh.F01 %>','<%=controller.getURI(request, IssueManage.class) %>?ids=<%=transferDsh.F01%>')" class="blue">通过</a>
			         <a href="javascript:void(0)" onclick="bfbZqzr('<%=transferDsh.F01 %>','<%=controller.getURI(request, UnIssueManage.class) %>?ids=<%=transferDsh.F01%>')" class="blue">不通过</a></td>    
			       </tr>
			     <%}} %>
              </table>
              <%if (dimengSession.isAccessableResource(IssueManage.class)) {%>
              <input type="button" style="cursor: pointer;" class="btn4 mr10" value="批量发布" onclick="batchPlfb()"/>
              <%}else{%>
              <input type="button" class="btn5 mr10" value="批量发布" />
              <%} %>
              
              <%AbstractConsoleServlet.rendPagingResult(out, transferDshs);%>
            </div>
            <div class="clear"></div>
          </div>
          </form>
          <div class="box2 clearfix"></div>
        </div>
      </div>
    </div>
    
    <%@include file="/WEB-INF/include/left.jsp"%>
  </div>
</div>

<form action="<%=controller.getURI(request, IssueManage.class)%>" method="post" class="form1">
   
<input type="text" name="ids" id="ids" value="">
<div class="popup_bg"  style="display: none;"></div>
<div class="dialog d_error w380 thickpos" style="margin:-150px 0 0 -190px;display: none;">
  <div class="dialog_close fr"><a href="#"></a></div>
  <div class="con clearfix">
    <div class="clearfix">
      <table width="100%" border="0" cellspacing="0" >
        <tr>
          <td>转让价格：</td>
          <td><input type="text" name="zrValue" id="zrValue"/><span class="ml5">元</span>
       		  <p tip></p>
			  <p errortip class="" style="display: none"></p>
          </td>
        </tr>
      </table>
    </div>
    <div class="clear"></div>
    <div class="dialog_btn">
    	<input type="submit" class="btn001 sumbitForme" fromname="form1" style="cursor: pointer;" value="转让">
    	<input type="button" id="cancel" class="btn05" style="cursor: pointer;" value="取消">
    </div>
  </div>
</div>
</form>
<div id="info"></div>

	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<%@include file="/WEB-INF/include/datepicker.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/dialog.js"></script>
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
		
		$("#checkAll").click(function(){
			
			if($(this).attr("checked")){
				$("input:checkbox[name='zqId']").attr("checked",true);
			}else{
				$("input:checkbox[name='zqId']").attr("checked",false);
			}
		});
		
		function fbZqzr(zqId,url){
			if(confirm("确认审核通过？")){
				location.href=url;
			}else{
				return;
			}
		}
		
		function bfbZqzr(zqId,url){
			if(confirm("确认审核不通过？")){
				location.href=url;
			}else{
				return;
			}
		}
		
		function batchPlfb()
		{	
			var ckeds = $("input:checkbox[name='zqId']:checked");
			if (ckeds == null || ckeds.length <= 0) {
				alert("请选择要处理的记录!");
				return;
			}
			
			var ids="";
			for ( var i = 0; i < ckeds.length; i++) {
				var val = $(ckeds[i]).val();
				if (i == 0) {
					ids += val;
				} else {
					ids += "," + val;
				}
			}
			
			//document.getElementById('ids').value = ids;
			
			if(confirm("确认批量审核通过？")){
				location.href="<%=controller.getURI(request,IssueManage.class)%>?ids="+ ids;
			}else{
				return;
			}
		}
	</script>
	
	
	<%
		String message = controller.getPrompt(request, response , PromptLevel.INFO);
			if (!StringHelper.isEmpty(message)) {
	%>
	<script type="text/javascript">
		$("#info").html(showSuccInfo("<%=message%>","succeed",$("#sbSucc").val()));	
		$("div.popup_bg").show();
	</script>
	<%
		}
	%>
	
	<%
		String errorMessage = controller.getPrompt(request, response , PromptLevel.ERROR);
			if (!StringHelper.isEmpty(errorMessage)) {
				
	%>
	<script type="text/javascript">
		$("#info").html(showDialogInfo("<%=errorMessage%>","error"));	
		$("div.popup_bg").show();
	</script>
	<%
		}
	%>
	
	<%
		String warnMessage = controller.getPrompt(request, response , PromptLevel.WARRING);
			if (!StringHelper.isEmpty(warnMessage)) {
	%>
	<script type="text/javascript">
		$("#info").html(showDialogInfo("<%=warnMessage%>","perfect"));	
		$("div.popup_bg").show();
	</script>
	<%
		}
	%>
</body>
</html>