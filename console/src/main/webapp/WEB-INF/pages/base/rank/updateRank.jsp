<%@page import="com.dimeng.p2p.S51.enums.T5127_F06"%>
<%@page import="com.dimeng.p2p.S51.enums.T5127_F03"%>
<%@page import="com.dimeng.p2p.S51.enums.T5127_F02"%>
<%@page import="com.dimeng.p2p.console.servlets.base.rank.UpdateRank"%>
<%@page import="com.dimeng.p2p.S51.entities.T5127"%>
<%@page import="com.dimeng.p2p.console.servlets.base.rank.SearchRank"%>
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
	T5127 rank = ObjectHelper.convert(request.getAttribute("rank"),T5127.class);
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
<div class="main clearfix">
	 <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>修改等级信息</h3>
                  </div>
                    <div class="con">
                    <div class="clear"></div>
                    <form action="<%=controller.getURI(request, UpdateRank.class) %>" onsubmit="return check()"  method="post" class="form1">
                    <input type="hidden" name="F01" value="<%=rank.F01%>">
                    <ul class="cell yw_jcxx">
                     <li>
                        <div class="til"><span class="red">*</span>等级类型：</div>
                        <div class="info">
                        	<span class="tir required">
                          		<select name="F02" class="yhgl_sel" style="width:300px;">
                            		<%for (T5127_F02 entity : T5127_F02.values()) {%>
									<option value="<%=entity.name()%>"  <%if(rank.F02 == entity){%> selected="selected" <%} %>><%=entity.getChineseName()%></option>
									<%}%>
                          		</select>
                        	</span>
						</div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>等级：</div>
                        <div class="info">
                        	<span class="tir required">
                          		<select name="F03" class="yhgl_sel" style="width:300px;">
                            		<%for (T5127_F03 entity : T5127_F03.values()) {%>
									<option value="<%=entity.name()%>" <%if(rank.F03 == entity){%> selected="selected" <%} %>><%=entity.getChineseName()%></option>
									<%}%>
                          		</select>
                        	</span>
						</div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>上限：</div>
                        <div class="info">
                        	<input name="F04" type="text" class="text yhgl_ser" maxlength="18" mtest="/^((([1-9][0-9]*)|0)|((([1-9][0-9]*)|0)\.[0-9]{1,2}))$/" mtestmsg="必须为数字格式(且是两位小数)" value="<%=rank.F04%>"/>
                        	<p tip></p>
							<p errortip class="fl" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>  
                     <li>
                        <div class="til"><span class="red">*</span>下限：</div>
                        <div class="info">
                        	<input name="F05" type="text" class="text yhgl_ser" maxlength="18" mtest="/^((([1-9][0-9]*)|0)|((([1-9][0-9]*)|0)\.[0-9]{1,2}))$/" mtestmsg="必须为数字格式(且是两位小数)"  value="<%=rank.F05%>"/>
                        	<p tip></p>
							<p errortip class="fl" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li> 
                    <li>
                        <div class="til"><span class="red">*</span>状态：</div>
                        <div class="info">
                        	<span class="tir required">
                          		<select name="F06" class="yhgl_sel" style="width:300px;">
                            		<%for (T5127_F06 entity : T5127_F06.values()) {%>
									<option value="<%=entity.name()%>" <%if(rank.F06 == entity){%> selected="selected" <%} %>><%=entity.getChineseName()%></option>
									<%}%>
                          		</select>
                        	</span>
						</div>
                        <div class="clear"></div>
                    </li>                       
                    <li>
                      <div class="clear"></div>
                    </li>                
               		</ul>
                    <div class="tc w220 pt20">
                    	<input type="submit" class="btn4 mr30 sumbitForme" style="cursor: pointer;" fromname="form1" value="确认" />
                    	<a href="<%=controller.getURI(request, SearchRank.class) %>" class="btn4">返回</a>
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
		String warringMessage=controller.getPrompt(request, response, PromptLevel.WARRING);
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
    <%@include file="/WEB-INF/include/left.jsp" %>
    </div>
    </div>
<%@include file="/WEB-INF/include/footer.jsp"%>
<%@include file="/WEB-INF/include/script.jsp"%>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
<script type="text/javascript">
	function check(){
		var sx = $("input[name='F04']").val();
		var xx = $("input[name='F05']").val();
		if(parseFloat(xx) >parseFloat(sx)){
			alert("下限不能大于上限");
			return false;
		}
	}
</script>
</body>
</html>