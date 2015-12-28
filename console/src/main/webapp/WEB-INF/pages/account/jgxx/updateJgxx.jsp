<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.account.jgxx.UpdateJgxx"%>
<%@page import="com.dimeng.p2p.console.servlets.account.jgxx.fcxx.ListFcxx"%>
<%@page import="com.dimeng.p2p.console.servlets.account.jgxx.ccxx.ListCcxx"%>
<%@page import="com.dimeng.p2p.console.servlets.account.jgxx.lxxx.UpdateLxxx"%>
<%@page import="com.dimeng.p2p.console.servlets.account.jgxx.cwzk.UpdateCwzk"%>
<%@page import="com.dimeng.p2p.console.servlets.account.jgxx.jscl.UpdateJscl"%>
<%@page import="com.dimeng.p2p.S61.entities.T6161"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
	CURRENT_CATEGORY="YHGL";
	CURRENT_SUB_CATEGORY="JG";
	T6161 entity = ObjectHelper.convert(request.getAttribute("t6161"),T6161.class );
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
<div class="main clearfix">
    <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>修改机构信息</h3>
                    </div>
                 </div>
                <div class="newsbox">
                <div class="til clearfix">
					<div class="Menubox">
						<ul>
						<li class="hover">机构信息</li>
						<li><a href="<%=controller.getURI(request, UpdateJscl.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("id"));%>">介绍资料</a></li>
						<li><a href="<%=controller.getURI(request, UpdateCwzk.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("id"));%>">财务状况</a></li>
						<li><a href="<%=controller.getURI(request, UpdateLxxx.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("id"));%>">联系信息</a></li>
						<li><a href="<%=controller.getURI(request, ListCcxx.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("id"));%>">车产信息</a></li>
						<li><a href="<%=controller.getURI(request, ListFcxx.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("id"));%>">房产信息</a></li>
						<%--
						<li><a href="<%=controller.getURI(request, UpdateDgzh.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("id"));%>">对公账户</a></li>
						 --%>
						</ul>
					</div>
				</div>
                  <div class="border p30 Men_bt no_table">
                    <form action="<%=controller.getURI(request, UpdateJgxx.class)%>" method="post" class="form1">
                    <input type="hidden" id="id" name="id" value="<%=request.getParameter("id")%>">
                   <ul class="cell noborder yxjh ">
                    <li>
                        <div class="til"><span class="red">*</span> 企业名称：</div>
                        <div class="info">
                        	<input name="F04" maxlength="20" disabled="disabled"  type="text" class="text yhgl_ser required" value="<%StringHelper.filterHTML(out, entity.F04); %>" />
                        </div>
                        <div class="clear"></div>
                    </li>
                     <li>
                        <div class="til"> 企业简称：</div>
                        <div class="info">
                        	<input name="F18" maxlength="20" type="text" class="text yhgl_ser" value="<%StringHelper.filterHTML(out, entity.F18); %>" />
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span> 营业执照登记注册号：</div>
                        <div class="info">
                        	<input name="F03" maxlength="20"  type="text" class="text yhgl_ser required" value="<%StringHelper.filterHTML(out, entity.F03); %>" />
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                        <li>
                        <div class="til"><span class="red">*</span>企业纳税号：</div>
                        <div class="info">
                        	<input name="F05" maxlength="45"  type="text" class="text yhgl_ser required" value="<%StringHelper.filterHTML(out,  entity.F05);%>" />
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                       <li>
                        <div class="til"><span class="red">*</span>组织机构代码：</div>
                        <div class="info">
                        	<input name="F06" maxlength="45"  type="text" class="text yhgl_ser required max-length-9 min-length-9" value="<%StringHelper.filterHTML(out, entity.F06);%>" />
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                           <li>
                        <div class="til"><span class="red">*</span>注册年份：</div>
                        <div class="info">
                        	<input name="F07" maxlength="4" mtestmsg="必须为数字" mtest="/^\d+$/"  type="text" class="text yhgl_ser required isint" value="<%=entity.F07%>" />年
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    
                             <li>
                        <div class="til"><span class="red">*</span>注册资金：</div>
                        <div class="info">
                        	<input name="F08" maxlength="15" mtest="/^((([1-9][0-9]*)|0)|((([1-9][0-9]*)|0)\.[0-9]{1,2}))$/" mtestmsg="必须为数字格式(且是两位小数)"  type="text" class="text yhgl_ser required" value="<%=entity.F08%>" />万元
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                             <li>
                        <div class="til"><span class="red">*</span>行业：</div>
                        <div class="info">
                        	<input name="F09" maxlength="20"  type="text" class="text yhgl_ser required" value="<%StringHelper.filterHTML(out,  entity.F09);%>" />
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    
                            <li>
                        <div class="til"><span class="red">*</span>企业规模：</div>
                        <div class="info">
                        	<input name="F10" maxlength="9" type="text" class="text yhgl_ser required min-size-1 isint" mtestmsg="必须为数字" mtest="/^\d+$/" value="<%=entity.F10%>" />人
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    
                         <li>
                        <div class="til"><span class="red">*</span>法人：</div>
                        <div class="info">
                        	<input name="F11" maxlength="11"  type="text" class="text yhgl_ser required" value="<%StringHelper.filterHTML(out, entity.F11);%>" />
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                       <li>
                        <div class="til"><span class="red">*</span>法人身份证号：</div>
                        <div class="info">
                        	<input name="F12" maxlength="20"  type="text" class="text yhgl_ser required idcard" value="<%StringHelper.filterHTML(out,StringHelper.decode(entity.F13));%>" />
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                      <li>
                        <div class="til"><span class="red">*</span>资产净值：</div>
                        <div class="info">
                        	<input name="F14" maxlength="15" mtest="/^((([1-9][0-9]*)|0)|((([1-9][0-9]*)|0)\.[0-9]{1,2}))$/" mtestmsg="必须为数字格式(且是两位小数)"  type="text" class="text yhgl_ser" value="<%=entity.F14%>" />万元
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>上年度经营现金流入：</div>
                        <div class="info">
                        	<input name="F15" maxlength="15" mtest="/^((([1-9][0-9]*)|0)|((([1-9][0-9]*)|0)\.[0-9]{1,2}))$/" mtestmsg="必须为数字格式(且是两位小数)"  type="text" class="text yhgl_ser" value="<%=entity.F15%>" />万元
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>担保资质描述：</div>
                        <div class="info">
                             <textarea name="jgjs" cols="" rows="" class="area required max-length-255"><%StringHelper.format(out, entity.jgjs, fileStore); %></textarea>
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>	
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                      <div class="clear"></div>
                    </li>                    
               		</ul>
                    <div class="tc w220">
                    	<input type="submit" class="btn4 mr30 sumbitForme" value="保存并继续" fromname="form1" />
                    	<input type="button" class="btn4" onclick="window.location.href='<%=controller.getURI(request, JgList.class)%>'" value="返回" /></div>
                    <div class="clear"></div>
                    </form>                  
                    </div>
            	<div class="mb15"></div>
                <div class="box2 clearfix"></div>
            </div>
            </div>
        </div>   
    </div>
	<%
		String warringMessage=controller.getPrompt(request, response, PromptLevel.ERROR);
		if(!StringHelper.isEmpty(warringMessage))
		{
	%>
	<div class="w440 thickbox thickpos" style="margin:-80px 0 0 -220px;" id="showDiv">
      <div class="info clearfix">
        <div class="clearfix">
            <span class="fl tips"><%StringHelper.filterHTML(out, warringMessage); %></span>
        </div>
        <div class="dialog_btn"><input type="button" name="button2" onclick="$('#showDiv').hide()" value="确认"  class="btn4 ml50"/></div> 
      </div>
	</div>
	<%} %>
	<%@include file="/WEB-INF/include/left.jsp"%>
</div>
</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
</body>
</html>