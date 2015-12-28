<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.account.grxx.ShjlList"%>
<%@page import="com.dimeng.p2p.console.servlets.account.grxx.Rzbtg"%>
<%@page import="com.dimeng.p2p.console.servlets.account.grxx.Rztg"%>
<%@page import="com.dimeng.p2p.console.servlets.account.grxx.Open"%>
<%@page import="com.dimeng.p2p.S61.enums.T6120_F05"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.Rzxx"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%
	CURRENT_CATEGORY="YHGL";
	CURRENT_SUB_CATEGORY="GRXX";
	Rzxx[] infos = ObjectHelper.convertArray(request.getAttribute("info"), Rzxx.class);
	int yhid = ObjectHelper.convert(request.getAttribute("yhid"),Integer.class);
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
  <div class="main clearfix">
    <div class="wrap">
      <div class="r_main">
        <div class="home_main">
          <div class="box box1 mb15">
            <div class="atil">
              <h3>审核列表</h3>
            </div>
          </div>
          
          <div class="newsbox">
	          <table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
	            <tr class="hsbg">
	              <td>序号</td>
	              <td>类型名称</td>
	              <td>必要认证</td>
	              <td>分数</td>
	              <td>认证次数</td>
	              <td>认证状态</td>
	              <td>认证时间</td>
	              <td>操作</td>
	            </tr>
	            <%if(infos != null){
	            	int index = 1;
	               for(Rzxx info :infos){	
	            %>
	            <tr class="dhsbg">
	              <td><%=index++ %></td>
	              <td><%StringHelper.filterHTML(out, info.lxmc); %>&nbsp;&nbsp;&nbsp;&nbsp;(<%=info.fs %>)分</td>
	              <td><%=info.mustRz.getChineseName() %></td>
	              <td><%=info.ds %></td>
	              <td><%=info.rzcs %></td>
	              <td><%=info.status.getChineseName() %></td>
	              <td><%=DateTimeParser.format(info.time) %></td>
	              <td>
	              	<%if(info.status == T6120_F05.DSH){ %>
	              	<span class="blue mr10"><a href="javascript:void(0)" onclick="shtg(<%=info.yxjlID%>)">审核通过</a></span>
	              	<span class="blue mr10"><a href="javascript:void(0)"  onclick="shbtg(<%=info.yxjlID%>)">审核不通过</a></span>
	              	<span class="blue mr10"><a href="<%=controller.getURI(request, Open.class)%>?id=<%=info.yxjlID%>" target="_blank">查看</a></span>
	              	<%} %>
	              	<span class="blue mr10"><a href="<%=controller.getURI(request, ShjlList.class)%>?id=<%=info.rzID%>&yhid=<%=yhid%>">审核记录</a></span>
	              </td>
	            </tr>
	            <%}} %>
	          </table>
			<div class="clear"></div>
          </div>
          <div class="box2 clearfix"></div>
        </div>
      </div>
    </div>
	<%@include file="/WEB-INF/include/left.jsp"%>
</div>
</div>


    
    				<div class="wrap" id="shtg" style="display: none">
					<div class="popup_bg"></div>
					<form action="<%=controller.getURI(request, Rztg.class) %>" class="form2" method="post">
					 <input type="hidden" name="id" value="<%StringHelper.filterHTML(out, request.getParameter("id"));%>"/>
					  <input type="hidden" id="tgyx" name="yxid" />
					<div id="sd" class="w440 thickbox thickpos" style="margin:-80px 0 0 -220px;">
				      <div class="tit">
				         <span class="fl pl15">审核通过</span>
				         <span class="fr pr15 close" onclick="javascript:document.getElementById('shtg').style.display='none';return false;"><a href="#">关闭</a></span>
				      </div>
				      <div id="js" class="info clearfix">
				      	<div class="clearfix">
				            <span class="icon_cw" style="display:none;"></span>
				            <span class="icon_yw" style="display:none;"></span>
				            <span class="icon_cg" style="display:none;"></span>							            
				        </div>
				        <div class="cell clearfix mb20">
              			<div class="list01">描述：</div>
               			<div class="list02">
		                <textarea name="desc" cols="" rows="" class="area max-length-30"></textarea>
		                	<p tip></p>
							<p errortip class="" style="display: none"></p>
		                </div>
		                
         			    </div>
         			    <div class="clear"></div>				        
				        <div class="dialog_btn"><input type="submit" fromname="form2" value="提交" class="btn4 ml50 sumbitForme"/></div> 
				      </div>
					</div>
					</form>
			    </div>
			    
			    
			    <div class="wrap" id="shbtg" style="display: none">
					<div class="popup_bg"></div>
					<form action="<%=controller.getURI(request, Rzbtg.class) %>" class="form1" method="post">
			        <input type="hidden" name="id" value="<%StringHelper.filterHTML(out, request.getParameter("id"));%>"/>
			         <input type="hidden" id="btgyx" name="yxid" />
					<div id="sd" class="w440 thickbox thickpos" style="margin:-80px 0 0 -220px;">
				      <div class="tit">
				         <span class="fl pl15">审核不通过</span>
				         <span class="fr pr15 close" onclick="javascript:document.getElementById('shbtg').style.display='none';return false;"><a href="#">关闭</a></span>
				      </div>
				      <div id="js" class="info clearfix">
				      	<div class="clearfix">
				            <span class="icon_cw" style="display:none;"></span>
				            <span class="icon_yw" style="display:none;"></span>
				            <span class="icon_cg" style="display:none;"></span>							            
				        </div>
				        <div class="cell clearfix mb20">
              			<div class="list01">描述：</div>
               			<div class="list02">
		                <textarea name="desc"  cols="" rows="" class="area required max-length-30"></textarea>
		                	<p tip></p>
							<p errortip class="" style="display: none"></p>
		                </div>
		                
         			    </div>
         			    <div class="clear"></div>				        
				        <div class="dialog_btn"><input type="submit" fromname="form1" value="提交" class="btn4 ml50 sumbitForme"/></div> 
				      </div>
					</div>
					</form>
			    </div>
    


	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript"
		src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
	<script type="text/javascript">
		function shtg(yxjlID){
			$("#tgyx").attr("value",yxjlID);
			$("#shtg").show();
		}
		
		function shbtg(yxjlID){
			$("#btgyx").attr("value",yxjlID);
			$("#shbtg").show();
			
		}
	</script>
</body>
</html>