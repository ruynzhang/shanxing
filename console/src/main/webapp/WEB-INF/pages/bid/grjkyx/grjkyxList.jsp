<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="com.dimeng.p2p.S62.entities.T6211"%>
<%@page import="com.dimeng.p2p.modules.bid.console.service.entity.Grjkyx"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.grjkyx.ViewYclGrjkyx"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.grjkyx.ViewWclGrjkyx"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.grjkyx.GrjkyxCl"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.grjkyx.DcGrjkyx"%>
<%@page import="com.dimeng.p2p.S62.enums.T6282_F11"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%
	CURRENT_CATEGORY="YWGL";
	CURRENT_SUB_CATEGORY="GRJKYX";
	PagingResult<Grjkyx> list = (PagingResult<Grjkyx>)request.getAttribute("loanIntentions");
	Grjkyx[] grjkyxArray = list.getItems();
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
              <h3>个人借款意向管理</h3>
            </div>
            <div class="con">
             <div class="admin_input admin_pb">
              <div class="clear"></div>
              <form id="form1" action="<%=controller.getURI(request, GrjkyxList.class)%>" method="post">
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
                      	for (T6282_F11 t6282_F11 : T6282_F11.values()) {
                      %>
						<option value="<%=t6282_F11.name()%>" <%if (t6282_F11.name().equals(request.getParameter("loanIntentionState"))) {%> selected="selected" <%}%>><%=t6282_F11.getChineseName()%></option>
						<%
							}
						%>
                    </select>
                  </P>
                  <div class="clear"></div>   
                    <div class="mt10">   
                    	<input name="input1" type="submit" class="btn2 mr10" value="搜索" />
                    	<%
                    		if (dimengSession.isAccessableResource(DcGrjkyx.class)) {
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
              <td>序号</td>
              <td>联系人</td>
              <td>手机号码</td>
              <td>融资金额（元）</td>
              <td>所在城市</td>
              <td>筹款期限</td>              
              <td>借款描述</td>
              <td>提交时间</td>
              <td>状态</td>
              <td>操作</td>
            </tr>
            <%
            	if (grjkyxArray != null) {for (int i =0;i<grjkyxArray.length;i++){Grjkyx grjkyx=grjkyxArray[i];if (grjkyx == null) {continue;}
            %>
            <tr class="dhsbg">
              <td><label>
                <input type="checkbox" <%if(T6282_F11.YCL.equals(grjkyx.F11)){%>istrue="true" disabled="true"<%}%> name="clId" value="<%=grjkyx.F01%>" />
              </label></td>
              <td><%=i+1%></td>
              <td><%StringHelper.filterHTML(out, grjkyx.F03);%></td>
              <td><%StringHelper.filterHTML(out, grjkyx.F04);%></td>
              <td><%=Formater.formatAmount(grjkyx.F06)%></td>
              <td><%StringHelper.filterHTML(out, grjkyx.szcs);%></td>
              <td><%StringHelper.filterHTML(out, grjkyx.F09);%></td>
              <td title="<%StringHelper.filterHTML(out, grjkyx.F10);%>"><%StringHelper.filterHTML(out, StringHelper.truncation(grjkyx.F10, 15));%></td>
              <td><%=TimestampParser.format(grjkyx.F13)%></td>
              <td><%=grjkyx.F11.getChineseName()%></td>
              <td>
              <%
              	if (T6282_F11.WCL.equals(grjkyx.F11)) {
                                          		if (dimengSession.isAccessableResource(GrjkyxCl.class)) {
              %>
              		<span class="blue"><a href="javascript:void(0)" onclick="showCl('<%=grjkyx.F01%>')" class="mr5">处理</a></span>
              		<%
              			}else{
              		%>
              		<span class="disabled">处理</span>
              		<%
              			}
              		    if (dimengSession.isAccessableResource(ViewWclGrjkyx.class)) {
              		%>
              		<span class="blue"><a href="<%=controller.getURI(request, ViewWclGrjkyx.class)%>?id=<%=grjkyx.F01%>">详情</a></span>
              		<%
              			}else{
              		%>
              		<span class="disabled">详情</span>
              		<%
              			}
              		    	}else{
              		        if (dimengSession.isAccessableResource(ViewYclGrjkyx.class)) {
              		%>
              		<span class="blue"><a href="<%=controller.getURI(request, ViewYclGrjkyx.class)%>?id=<%=grjkyx.F01%>">详情</a></span>
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
          	AbstractConsoleServlet.rendPagingResult(out, list);
          %>
          </form>
          <div class="box2 clearfix"></div>
          
          
          	<div id="cl" style="display: none">
					<div class="popup_bg"></div>
					<div class="w650 thickbox thickpos" style='margin: -110px 0px 0px -325px;'>
				<form action="<%=controller.getURI(request, GrjkyxCl.class)%>" method="post" class="form1">
				<input type="hidden" id="id" name="id"/>
				<div class="tit">
					<span class="fl pl15">处理</span><span class="fr pr15 close"  onclick="document.getElementById('cl').style.display='none'"></span>
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
			document.getElementById("form1").action ="<%=controller.getURI(request, DcGrjkyx.class)%>";
			$("#form1").submit();
			document.getElementById("form1").action ="<%=controller.getURI(request, GrjkyxList.class)%>";
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