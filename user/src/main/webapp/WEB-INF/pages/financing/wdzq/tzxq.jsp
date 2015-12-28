<%@page import="com.dimeng.p2p.S62.entities.T6231"%>
<%@page import="com.dimeng.p2p.S62.entities.T6252"%>
<%@page import="java.util.List"%>
<%@page import="com.dimeng.p2p.S62.entities.T6251"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.BidManage"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.entity.Bdxq"%>
<%@page import="java.util.Map"%>
<%@page import="com.dimeng.util.http.URLParameter"%>
<%@page import="com.dimeng.p2p.utlis.JfUtil"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F13"%>
<%@page import="com.dimeng.p2p.user.servlets.financing.zqzr.Transfer"%>
<%@page import="com.dimeng.p2p.user.servlets.financing.AbstractFinancingServlet"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F20"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.entity.ZqxxEntity"%>
<%@page import="com.dimeng.p2p.user.servlets.financing.wdzq.BackMoney"%>
<%@page import="com.dimeng.p2p.user.servlets.Index"%>
<%@include file="/WEB-INF/include/authenticatedSession.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>我的投资-
<%configureProvider.format(out,SystemVariable.SITE_NAME); %>
</title>
<%@include file="/WEB-INF/include/meta.jsp" %>
<%@include file="/WEB-INF/include/style.jsp" %>
</head>
<%
	CURRENT_CATEGORY = "LCGL";
%>
<body>
<%@include file="/WEB-INF/include/header.jsp" %>
<% 
int id = IntegerParser.parse(request.getParameter("id"));
WdzqManage wdzqManage = serviceSession.getService(WdzqManage.class);
Map<String, Object> map=wdzqManage.getXqByZqId(id);
BidManage bidManage = serviceSession.getService(BidManage.class);
Bdxq bdxq =bidManage.get((int)map.get("bId")); 	
T6231 t6231 =bidManage.getExtra((int)map.get("bId"));
T6251 t6251 =(T6251)map.get("t6251"); 
List<T6252> list=(List<T6252>)map.get("hk_list");

UserInfoManage uManage1 = serviceSession.getService(UserInfoManage.class);
T6110 user1= uManage1.getUserInfo(bdxq.F02);

%>
<div class="contain clearfix">
  <div class="user_top"></div>
  <div class="about">
    <%@include file="/WEB-INF/include/menu.jsp"%>
    <%@include file="/WEB-INF/include/wdzq/header.jsp"%>
    <div class="w780 fr">
    <div id="funds" class="mainDiv">
      <p class="title1"><b>项目详情</b><a class="btnlsty" href="javascript:;;" onclick="history.back();">返回</a></p>
      <div class="tb-list">
        <table class="tableOdd ">
          <tbody>
            <tr>
              <th>项目名称|编号</th>
              <th>收款期</th>
              <th>项目本金（元）</th>
              <th>剩余本金（元）</th>
              <th>项目状态</th>
            </tr>
            <tr class="tdColor">
              <td><p><%=bdxq.F03%></p>
                <p>
                <%if(T6230_F13.F==bdxq.isSxbao){%>
                <a href="<%configureProvider.format(out, URLVariable.FINANCING_SBTZ_XQ); %><%=t6251.F03 + rewriter.getViewSuffix()%>"><%=t6251.F02%></a>
               	<%}else{out.print(t6251.F02);}%>
                </p>
              </td>
              <td><%=map.get("hk_date")%></td>
              <td>￥<%=t6251.F05%></td>
              <td>￥<%=t6251.F07%></td>
              <td><%=bdxq.F20.getChineseName()%></td>
            </tr>
          </tbody>
        </table>
      </div> 
      <h3 class="f16 font3 mt20">收款详情</h3>
      <p class="txt">收款总额： <span>￥<%=map.get("hk_total")%>元</span></p>
      <p class="txt">本金：<span>￥<%=map.get("hk_bj")%>元</span></p>
      <p class="txt">利息：<span>￥<%=map.get("hk_lx")%>元</span></p>
      <h3 class="f16 font3 mt20 clear">各期明细</h3>
      <div class="tb-list">
        <table class="tableOdd">
          <tbody>
            <tr>
              <th>期数</th>
              <th>收款日</th>
              <th>科目</th>
              <th>应收金额（元）</th>
              <th>备注</th>
            </tr>
            <%
            	BigDecimal total=BigDecimal.ZERO;
            	int i=0;
            	for(T6252 vo:list){ 
            		total=total.add(vo.F07);
            		i++;
            %>
            <tr class="<%=i%2==1?"tdColor":""%>"> 
              <td width="50" align="center"><%=vo.F06%></td> 
              <td width="80" align="center"><%=vo.F08%></td>
              <td width="100" align="center">
              <%if(vo.F05==7001){
            	  	out.print("本金");
            	 } else if(vo.F05==7002){
               	  	out.print("利息");
               	 } else{
               		out.print("逾期罚息");
               	 }  %>
              </td>
              <td width="100" align="center">￥<%=vo.F07%></td>
              <td width="100" align="center"> <%=vo.F09.getChineseName() %> </td>
            </tr>
            <%} %>
            <tr class="tdColor">
              <td colspan="2">共计</td>
              <td>--</td>
              <td>￥<%=total%></td>
              <td>--</td>
            </tr>
          </tbody>
        </table>
      </div>
      <%if(T6230_F13.F==bdxq.isSxbao){%>
      <h3 class="f16 font3 mt20">借款人信息</h3>
      <div class="tb-list">
        <table class="tableOdd">
          <tbody>
            <tr>
              <th>借款人姓名</th>
              <th>性别</th>
              <th>身份证</th>
            </tr>
            <tr class="tdColor">
              <td><%=map.get("hk_name")%></td>
              <td><%=map.get("hk_sex")%></td>
              <td><%=map.get("hk_identity")%></td>
            </tr>
          </tbody>
        </table>
      </div>
      <h3 class="f16 font3 mt20">项目内容</h3>
      <div class="tb-list">
        <table class="tableOdd">
          <tbody>
            <tr>
              <th>用途</th>
              <th>期限</th>
              <th>还款方式</th>
              <th>项目说明</th>
            </tr>
            <tr class="tdColor">
              <td width="150"><%=bdxq.F03%></td>
              <td width="120"><%=bdxq.F09>0?bdxq.F09+"个月":t6231.F22+"天" %></td>
              <td width="120"><%=bdxq.F10.getChineseName()%></td>
              <td align="left" class="ptb10">【借款人信息】：<br>
               <%=t6231.F09 %><br>
                【借款用途】：<br>
       <%StringHelper.filterHTML(out, t6231.F08);%><br>
                【还款来源及还款能力】：<br>
       <%StringHelper.filterHTML(out, t6231.F16); %><br>
            </tr>
          </tbody>
        </table>
      </div>
     <%}%> 
    </div>
    </div>
    <div class="clear"></div>
  </div>
</div>
<div id="info"></div>
<%@include file="/WEB-INF/include/footer.jsp" %>
<%@include file="/WEB-INF/include/script.jsp" %>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/financing/zqkzc.js"></script> 
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/validation.js"></script> 
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/wdzq.js"></script> 
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/dialog.js"></script>
</body>
</html>