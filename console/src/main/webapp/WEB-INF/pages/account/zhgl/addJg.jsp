<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.account.zhgl.AddJg"%>
<%@page import="com.dimeng.p2p.console.servlets.account.zhgl.ZhList"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%
CURRENT_CATEGORY = "YHGL";
CURRENT_SUB_CATEGORY = "ZHGL";
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
<div class="main clearfix">
  
    <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<div class="box box1">
                	<div class="atil">
                    	<h3>添加机构账户</h3>
                    </div>
                    <div class="con">
                    <form action="<%=controller.getURI(request, AddJg.class)%>" method="post" class="form1">
                    <ul class="cell noborder yxjh ">
                    <li>
                        <div class="til"><span class="red">*</span> 营业执照登记注册号：</div>
                        <div class="info">
                        	<input name="F03" maxlength="20"  type="text" class="text yhgl_ser required" value="<%StringHelper.filterHTML(out, request.getParameter("F03")); %>" />
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span> 企业名称：</div>
                        <div class="info">
                        	<input name="F04" maxlength="45"  type="text" class="text yhgl_ser required" value="<%StringHelper.filterHTML(out, request.getParameter("F04")); %>" />
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red"></span> 企业简称：</div>
                        <div class="info">
                        	<input name="F18" maxlength="20"  type="text" class="text yhgl_ser" value="<%StringHelper.filterHTML(out, request.getParameter("F18")); %>" />
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                        <li>
                        <div class="til"><span class="red">*</span>企业纳税号：</div>
                        <div class="info">
                        	<input name="F05" maxlength="45"  type="text" class="text yhgl_ser required" value="<%StringHelper.filterHTML(out, request.getParameter("F05"));%>" />
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                       <li>
                        <div class="til"><span class="red">*</span>组织机构代码：</div>
                        <div class="info">
                        	<input name="F06" maxlength="9"  type="text" class="text yhgl_ser required max-length-9 min-length-9" value="<%StringHelper.filterHTML(out, request.getParameter("F06"));%>" />
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                           <li>
                        <div class="til"><span class="red">*</span>注册年份：</div>
                        <div class="info">
                        	<input name="F07" maxlength="4"  type="text" class="text yhgl_ser required isint" value="<%StringHelper.filterHTML(out, request.getParameter("F07"));%>" />年
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    
                             <li>
                        <div class="til"><span class="red">*</span>注册资金：</div>
                        <div class="info">
                        	<input name="F08" type="text" class="text yhgl_ser" maxlength="15" mtest="/^((([1-9][0-9]*)|0)|((([1-9][0-9]*)|0)\.[0-9]{1,2}))$/" mtestmsg="必须为数字格式(且是两位小数)" value="<%StringHelper.filterHTML(out, request.getParameter("F08"));%>" />万元
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                             <li>
                        <div class="til"><span class="red">*</span>行业：</div>
                        <div class="info">
                        	<input name="F09" maxlength="20"  type="text" class="text yhgl_ser required" value="<%StringHelper.filterHTML(out, request.getParameter("F09"));%>" />
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    
                            <li>
                        <div class="til"><span class="red">*</span>企业规模：</div>
                        <div class="info">
                        	<input name="F10" maxlength="18" type="text" class="text yhgl_ser required isint" value="<%StringHelper.filterHTML(out, request.getParameter("F10"));%>" />人
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    
                         <li>
                        <div class="til"><span class="red">*</span>法人：</div>
                        <div class="info">
                        	<input name="F11" maxlength="11"  type="text" class="text yhgl_ser required" value="<%StringHelper.filterHTML(out, request.getParameter("F11"));%>" />
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                       <li>
                        <div class="til"><span class="red">*</span>法人身份证号：</div>
                        <div class="info">
                        	<input name="F12" maxlength="18"  type="text" class="text yhgl_ser required idcard" value="<%StringHelper.filterHTML(out, request.getParameter("F12"));%>" />
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                      <li>
                        <div class="til"><span class="red">*</span>资产净值：</div>
                        <div class="info">
                        	<input name="F14"  type="text" class="text yhgl_ser" maxlength="15" mtest="/^((([1-9][0-9]*)|0)|((([1-9][0-9]*)|0)\.[0-9]{1,2}))$/" mtestmsg="必须为数字格式(且是两位小数)" value="<%StringHelper.filterHTML(out, request.getParameter("F14"));%>" />万元
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                         <li>
                        <div class="til"><span class="red">*</span>上年度经营现金流入：</div>
                        <div class="info">
                        	<input name="F15" type="text" class="text yhgl_ser" maxlength="15" mtest="/^((([1-9][0-9]*)|0)|((([1-9][0-9]*)|0)\.[0-9]{1,2}))$/" mtestmsg="必须为数字格式(且是两位小数)" value="<%StringHelper.filterHTML(out, request.getParameter("F15"));%>" />万元
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                     <li>
                        <div class="til"><span class="red">*</span>企业联系人：</div>
                        <div class="info">
                        	<input name="realName" maxlength="20"  type="text" class="text yhgl_ser required" value="<%StringHelper.filterHTML(out, request.getParameter("realName"));%>" />
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                     <li>
                        <div class="til"><span class="red">*</span>联系人电话：</div>
                        <div class="info">
                        	<input name="lxTel" maxlength="13"  type="text" class="text yhgl_ser required phonenumber" value="<%StringHelper.filterHTML(out, request.getParameter("lxTel"));%>" />
                       		<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                     <li>
                        <div class="til"><span class="red">*</span>担保资质描述：</div>
                        <div class="info">
                             <textarea name="jgjs" cols="" rows="" class="area required max-length-255" onKeyUp="limitTextArea(this,170)" onkeypress="limitTextArea(this,170)"><%StringHelper.format(out, request.getParameter("jgjs"), fileStore); %></textarea>
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>	
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                      <div class="til">&nbsp;</div>
                      <div class="clear"></div>
                    </li>
                    <li>
                      <div class="clear"></div>
                    </li>                    
               		</ul>
                    <div class="tc w220 pt20">
                    	<input type="submit" class="btn4 mr30 sumbitForme" value="提交" fromname="form1" />
                    	<input type="button" onclick="window.location.href='<%=controller.getURI(request, ZhList.class)%>'" class="btn4" value="返回" />
                    </div>
                	<div class="clear"></div>
                    </form>
                    <div class="clear"></div>
                    </div>
                </div>
              <div class="box2 clearfix"></div>
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
	<script>
		function limitTextArea(field,maxlimit){ 
		    if (field.value.length > maxlimit){
		     field.value = field.value.substring(0, maxlimit); 
		    }
	   }
	</script>
</body>
</html>