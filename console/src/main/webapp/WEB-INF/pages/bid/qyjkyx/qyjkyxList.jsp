<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="com.dimeng.p2p.S62.entities.T6211"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.qyjkyx.ViewYclQyjkyx"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.qyjkyx.ViewWclQyjkyx"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.qyjkyx.QyjkyxCl"%>
<%@page import="com.dimeng.p2p.S62.enums.T6281_F14"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.qyjkyx.DcQyjkyx"%>
<%@page import="com.dimeng.p2p.modules.bid.console.service.entity.Qyjkyx"%>
<%@page import="com.dimeng.p2p.S60.enums.T6058_F12"%>
<%@page import="com.dimeng.p2p.common.enums.LoanIntentionState"%>
<%@page import="com.dimeng.p2p.S60.enums.T6058_F18"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%
	CURRENT_CATEGORY="YWGL";
	CURRENT_SUB_CATEGORY="QYJKYX";
	PagingResult<Qyjkyx> loanIntentions = (PagingResult<Qyjkyx>)request.getAttribute("loanIntentions");
	Qyjkyx[] loanIntentionArray = loanIntentions.getItems();
	T6211[] t6211s = ObjectHelper.convertArray(request.getAttribute("t6211s"), T6211.class);
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
  <div class="main clearfix">
    <div class="wrap">
      <div class="r_main">
        <div class="home_main">
          <div class="box box1 mb15">
            <div class="atil">
              <h3>企业借款意向管理</h3>
            </div>
            <div class="con">
             <div class="admin_input admin_pb">
              <div class="clear"></div>
              <form id="form1" action="<%=controller.getURI(request, QyjkyxList.class)%>" method="post">
              		<P>
                    <span>联系人：</span>
                   <input type="text" name="userName" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("userName"));%>" />
                  	</P>
                    <p>
                    <input type="hidden" id="shengId" value="<%String sheng=request.getParameter("sheng"); if(!StringHelper.isEmpty(sheng)){StringHelper.filterHTML(out, sheng.substring(0,2)+"0000");}%>">
					<input type="hidden" id="shiId" value="<%String shi=request.getParameter("shi"); if(!StringHelper.isEmpty(shi)){StringHelper.filterHTML(out, shi.substring(0,4)+"00");}%>">
					<input type="hidden" id="xianId" value="<%String xian=request.getParameter("xian"); if(!StringHelper.isEmpty(xian)){StringHelper.filterHTML(out, xian);}%>">
                    
                  <span>所在城市：</span>
                    <select name="sheng" class="yhgl_sel">
					</select> 
					<select name="shi" class="yhgl_sel">
					</select>
					<select name="xian" class="yhgl_sel">
					</select>
                   </p>
                   <p>
                   <span>时间：</span>
                  <input type="text" readonly="readonly" name="createTimeStart" id="datepicker1" class="yhgl_input date" />至
                 <input type="text" readonly="readonly" name="createTimeEnd" id="datepicker2" class="yhgl_input date" />
                  </p>
                  <P>
                   <span>状态：</span>
                   <select name="loanIntentionState" class="yhgl_sel">
                      <option>全部</option>
                      <%
                      	for (LoanIntentionState loanIntentionState : LoanIntentionState.values()) {
                      %>
						<option value="<%=loanIntentionState.name()%>" <%if (loanIntentionState.name().equals(request.getParameter("loanIntentionState"))) {%> selected="selected" <%}%>><%=loanIntentionState.getName()%></option>
						<%
							}
						%>
                    </select>
                  </P>
                  <div class="clear"></div>   
                    <div class="mt10">   
                    	<input name="input1" type="submit" class="btn2 mr10" value="搜索" />
                    	<%
                    		if (dimengSession.isAccessableResource(DcQyjkyx.class)) {
                    	%>
                    		<a onclick="showExport()" name="input2" style="cursor: pointer;" class="btn3 mr10"><span class="ico"></span>导出</a>
                    	<%
                    		}else{
                    	%>
                    		<span class="btn3 mr10 btn5"><span class="ico"></span>导出</span>
                    	<%
                    		}
                    	%>
                   </div>               
              </form>
              <div class="clear"></div>
            </div>
            </div>
          </div>
          <form>
          <table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc mb10">
            <tr class="hsbg">
              <td><input type="checkbox" id="checkAll" class="mr5" /></td>
              <td width="10">序号</td>
              <td width="250">企业名称</td>
              <td width="40">注册号</td>
              <td width="40">联系人</td>
              <td width="150">手机号码</td>
              <td width="90">融资金额（元）</td>
              <td width="200">所在城市</td>
              <td width="60">筹款期限</td>              
              <td width="200">借款描述</td>
              <td width="150">提交时间</td>
              <td width="80">状态</td>
              <td width="150">操作</td>
            </tr>
            <%
            	if (loanIntentionArray != null) {for (int i =0;i<loanIntentionArray.length;i++){Qyjkyx qyjkyx=loanIntentionArray[i];if (qyjkyx == null) {continue;}
            %>
            <tr class="dhsbg">
              <td><label>
                <input type="checkbox" <%if(T6281_F14.YCL==qyjkyx.F14){%> istrue="true" disabled="true"<%}%> name="clId" value="<%=qyjkyx.F01%>" />
              </label></td>
              <td><%=i+1%></td>
              <td><%StringHelper.filterHTML(out, StringHelper.truncation(qyjkyx.F03,20));%></td>
              <td><%StringHelper.filterHTML(out, qyjkyx.F04);%></td>
              <td><%StringHelper.filterHTML(out, StringHelper.truncation(qyjkyx.F05,10));%></td>
              <td><%StringHelper.filterHTML(out, qyjkyx.F06);%></td>
              <td><%=Formater.formatAmount(qyjkyx.F09)%></td>
              <td><%StringHelper.filterHTML(out, qyjkyx.szcs);%></td>
              <td><%StringHelper.filterHTML(out, qyjkyx.F12);%></td>
              <td title="<%StringHelper.filterHTML(out, qyjkyx.F13);%>"><%
              	StringHelper.filterHTML(out, StringHelper.truncation(qyjkyx.F13, 10));
              %></td>
              <td><%=TimestampParser.format(qyjkyx.F16)%></td>
              <td><%=qyjkyx.F14.getChineseName()%></td>
              <td>
              <%
              	if (T6281_F14.WCL==qyjkyx.F14) {
                                                        		if (dimengSession.isAccessableResource(QyjkyxCl.class)) {
              %>
              		<span class="blue"><a href="javascript:void(0)" onclick="showCl('<%=qyjkyx.F01%>')" class="mr5">处理</a></span>
              		<%
              			}else{
              		%>
              		<span class="disabled">处理</span>
              		<%
              			}
              		              		              		              		              		if (dimengSession.isAccessableResource(ViewWclQyjkyx.class)) {
              		%>
              		<span class="blue"><a href="<%=controller.getURI(request, ViewWclQyjkyx.class)%>?id=<%=qyjkyx.F01%>">详情</a></span>
              		<%
              			}else{
              		%>
              		<span class="disabled">详情</span>
              		<%
              			}
              		              		              		              		              	}else{
              		              		              		              		              		if (dimengSession.isAccessableResource(ViewYclQyjkyx.class)) {
              		%>
              		<span class="blue"><a href="<%=controller.getURI(request, ViewYclQyjkyx.class)%>?id=<%=qyjkyx.F01%>">详情</a></span>
              		<%
              			}else{
              		%>
              		<span class="disabled">详情</span>
              <%
              	}
                                                        	}
              %>
              	</td>
            </tr>
            <%
            	}}
            %>
            
          </table>
          <%
          	AbstractConsoleServlet.rendPagingResult(out, loanIntentions);
          %>
          </form>
          <div class="box2 clearfix"></div>
          
          
          	<div id="cl" style="display: none">
					<div class="popup_bg"></div>
					<div class="w650 thickbox thickpos" style='margin: -110px 0px 0px -325px;'>
				<form action="<%=controller.getURI(request, QyjkyxCl.class)%>" method="post" class="form1">
				<input type="hidden" id="id" name="id"/>
				<div class="tit">
					<span class="fl pl15">处理</span><span class="fr pr15 close"><a href="javascript:document.getElementById('cl').style.display='none';return false;">关闭</a></span>
				</div>
				<div class="info clearfix">
					<div class="tips_con">
						<div class="bigtit mt10 clearfix">
							<span class="fl">处理结果描述 （50字以内）</span>
						</div>
						<div class="tc pt10">
							<textarea name="disposeDesc" cols="" rows="" class="area required max-length-50"></textarea>
							<p tip></p>
							<p errortip class="" style="display: none"></p>
						</div>
						<div class="dialog_btn">
							<input type="submit" value="确定" class="btn4 fl mr10 sumbitForme" fromname="form1" /> 
							<input type="button" class="btn5 fl" value="取消" onclick="document.getElementById('cl').style.display='none'"/>
							<div class="clear"></div>
						</div>
					</div>
				</div>
				</form>
			</div>
			</div>
        </div>
      </div>
    </div>

	<%@include file="/WEB-INF/include/left.jsp"%>
	</div>
	</div>
	
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
	<%@include file="/WEB-INF/include/datepicker.jsp"%>
	<script type="text/javascript"
		src="<%=controller.getStaticPath(request)%>/js/region.js"></script>
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
		
		function showExport()
		{
			document.getElementById("form1").action ="<%=controller.getURI(request, DcQyjkyx.class)%>";
			$("#form1").submit();
			document.getElementById("form1").action ="<%=controller.getURI(request, QyjkyxList.class)%>";
		}
		
		$("#checkAll").click(function(){
			
			if($(this).attr("checked")){
				$("input:checkbox[name='clId']").attr("checked",true);
				var $tj = $("input[istrue]");
				if($tj!= undefined && $tj.attr("istrue")=="true"){
					$tj.attr("checked",false);
				}
			}else{
				$("input:checkbox[name='clId']").attr("checked",false);
			}
		});
		
		$("input:checkbox[name='clId']").click(function(){
			if(!$(this).attr("checked")){
				$("#checkAll").attr("checked",false);
			}else{
				var c1 = $("input:checkbox[name='clId']:checked").length;
				var c2 = $("input:checkbox[name='clId']").length;
				if(c1==c2){
					$("#checkAll").attr("checked",true);
				}
			}
		});
		
		function batchCl()
		{	
			var ckeds = $("input:checkbox[name='clId']:checked");
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
			
			document.getElementById('id').value = ids;
			$("#cl").show();
		}
		
		function showCl(id)
		{
			$("#cl").show();
			document.getElementById('id').value=id;
		}
	</script>
</body>
</html>