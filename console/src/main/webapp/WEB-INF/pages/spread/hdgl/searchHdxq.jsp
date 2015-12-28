<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.modules.spread.console.service.entity.ActivityList"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="com.dimeng.p2p.S63.enums.T6320_F14"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%
	CURRENT_CATEGORY = "TGGL";
	CURRENT_SUB_CATEGORY = "HDGL";
	ActivityList result = ObjectHelper.convert(request.getAttribute("result"), ActivityList.class);
%>
<%@include file="/WEB-INF/include/header.jsp"%> 
<div class="w_main">
  <div class="main clearfix">
    <div class="wrap">
    
      <div class="r_main">
        <div class="home_main">
          <div class="box box1 mb15">
            <div class="atil">
              <h3>活动详情</h3>
            </div>
            <div class="con">
              <div class="clear"></div>
              <ul class="yhxq_li">
                <li>活动主题：<span class="blue"><%StringHelper.filterHTML(out, result.F02); %></span> </li>
              </ul>
              <ul class="yhxq_li">
                <li>总费用：<span class="blue"><%=result.F08 %></span>元 </li>
              </ul>
              <ul class="yhxq_li">
                <li>总受益人数：<span class="blue"><%=result.F07 %></span>人 </li>
              </ul>
              <div class="clear"></div>
            </div>
          </div>
         
         <div class="box box1 mb15">
            	  <div class="con">
            	    <div class="clear"></div>
            	      <ul class="cell xc_jcxx ">
            	        <li>
            	          <div class="til">活动ID ：</div>
            	          <div class="info"><%=result.F01 %></div>
            	          <div class="clear"></div>
          	          </li>
            	        <li>
            	          <div class="til">活动主题 ：</div>
            	          <div class="info"><%StringHelper.filterHTML(out, result.F02); %></div>
            	          <div class="clear"></div>
          	          </li>
            	        <li>
            	          <div class="til">活动时间：</div>
            	          <div class="info"><%=DateTimeParser.format(result.F03) %>至<%=DateTimeParser.format(result.F04) %>

          	            </div>
            	          <div class="clear"></div>
          	          </li>
          	            <li>
            	          <div class="til">优惠券有效时间：</div>
            	          <div class="info"><%=DateParser.format(result.F05) %>至<%=DateParser.format(result.F06) %>

          	            </div>
            	          <div class="clear"></div>
          	          </li>
            	        <li>
            	          <div class="til">最低充值金额：</div>
            	          <div class="info"><%=result.F11 %>元</div>
            	          <div class="clear"></div>
          	          </li>
          	          <li>
            	          <div class="til">最低投资金额：</div>
            	          <div class="info"><%=result.F13 %>元</div>
            	          <div class="clear"></div>
          	          </li>
            	        <li>
            	          <div class="til">状态：</div>
            	          <div class="info"><%StringHelper.filterHTML(out, result.F14.getChineseName()); %></div>
            	          <div class="clear"></div>
          	          </li>
            	        <li>
            	          <div class="til">最低推广人数：</div>
            	          <div class="info"><%=result.F16 %></div>
            	          <div class="clear"></div>
          	          </li>
                      <li>
            	          <div class="til">创建人：</div>
            	          <div class="info">
            	            <div id="u100">
            	              <p><%StringHelper.filterHTML(out, result.F17); %></p>
          	              </div>
            	          </div>
            	          <div class="clear"></div>
          	          </li>
                      <li>
            	          <div class="til">剩余数量：</div>
            	          <div class="info">
            	            <div id="u112">
            	              <p><%=result.F18 %></p>
          	              </div>
            	          </div>
            	          <div class="clear"></div>
          	          </li>
                     
          	        </ul>
            	    <div class="clear"></div>
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
</body>
</html>