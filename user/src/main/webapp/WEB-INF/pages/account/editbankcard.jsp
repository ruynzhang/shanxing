<%@page import="com.dimeng.p2p.account.user.service.entity.Safety"%>
<%@page import="com.dimeng.p2p.account.user.service.SafetyManage"%>
<%@page import="com.dimeng.p2p.account.user.service.entity.Bank"%>
<%@page import="com.dimeng.p2p.account.user.service.entity.BankCard"%>
<%@page import="com.dimeng.p2p.account.user.service.BankCardManage"%>
<%@page import="com.dimeng.p2p.user.servlets.account.Editbankcard"%>
<%@page import="com.dimeng.p2p.common.enums.AttestationState"%>
<%@include file="/WEB-INF/include/authenticatedSession.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=configureProvider.getProperty(SystemVariable.SITE_NAME)%></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/jquery-1.11.0.min.js"></script>
</head>
<%
	BankCardManage bankCardManage = serviceSession.getService(BankCardManage.class);
	Bank[] bank = bankCardManage.getBank();
	int id = IntegerParser.parse(request.getParameter("id"));
	BankCard bcd = bankCardManage.getBankCar(id);
	SafetyManage userManage = serviceSession.getService(SafetyManage.class);
	Safety data = userManage.get();
	if(data.isIdCard.equals(AttestationState.WYZ.name()) || StringHelper.isEmpty(data.txpassword) || request.getAttribute("close") != null){
		%>
		<script type="text/javascript">
			var list=parent.art.dialog.list;
			for(var i in list){
				list[i].close();
			}
		</script>
	<%
		return;
	}
	
	CURRENT_CATEGORY = "ZHGL";
	CURRENT_SUB_CATEGORY = "YHKXX";
%>
<body>
<form action="<%=controller.getURI(request, Editbankcard.class)%>" class="form1" method="post">
  <div class="clear"></div>
<div class="dialog_pak d_error">
  <div class="con clearfix">
    <div class="clearfix">
    <div class="f20 gray33 mb10">编辑银行卡</div>
      <table width="100%" border="0" cellspacing="0" class="ta_lin">
        <tr>
          <td width="25%" valign="top"><span class="red">*</span>开户名：</td>
          <td width="75%"><span class="red"></span><%=data.name%></td>
        </tr>
        <tr>
          <td width="25%" valign="top"><span class="red">*</span>银行卡号：</td>
          <td width="75%"><span class="red"></span><%StringHelper.filterHTML(out, bcd.BankNumber.substring(0, 4)+" *** *** "+bcd.BankNumber.substring(bcd.BankNumber.length()-4,bcd.BankNumber.length()));%></td>
          
        </tr>
        <tr>
          <td valign="top"><span class="red">*</span>选择银行：</td>
          <td>
          <select name="bankname" class="yhgl_ser jy_w1">
          	<%if(bank!=null && bank.length>0)for(Bank b:bank){ %>
          		<option value="<%=b.id%>" <%if(bcd.BankID==b.id){%> selected="selected" <%}%> ><%StringHelper.filterHTML(out, b.name);%></option>
          	<%}%>
          </select></td>
        </tr>
        <tr>
          <td valign="top"><span class="red">*</span>开户行所在地：</td>
          <td>
          <input type="hidden" id="shengId" value="<%if(!StringHelper.isEmpty(bcd.City)){StringHelper.filterHTML(out, bcd.City.substring(0,2)+"0000");}%>">
		<input type="hidden" id="shiId" value="<%if(!StringHelper.isEmpty(bcd.City)){StringHelper.filterHTML(out, bcd.City.substring(0,4)+"00");}%>">
		<input type="hidden" id="xianId" value="<%if(!StringHelper.isEmpty(bcd.City)){StringHelper.filterHTML(out, bcd.City);}%>">
			<select name="sheng" class="yhgl_ser jy_w1">
			</select> 
			<select name="shi" class="yhgl_ser jy_w1">
			</select>
			<select name="xian" class="yhgl_ser jy_w1">
			</select>
        </tr>
        <tr>
          <td valign="top"><span class="red">*</span>开户行：</td>
          <td><input type="hidden" value="<%=id%>" name="id"/><input type="text" name="subbranch" value="<%=bcd.BankKhhName%>" id="textfield" class="yhgl_ser border w200 required" />
          <p tip></p>
		  <p errortip class="" style="display: none"></p>
          </td>
        </tr>
      </table>
    </div>
    <div class="clear"></div>
    <div class="dialog_btn pb10 bom mb10">
     	<input type="submit" fromname="form1"  class="btn btn001 sumbitForme" value="提交"/>
    	<input type="button" class="btn btn05 " onclick="var list=parent.art.dialog.list;for(var i in list)list[i].close();" value="取消"/>
    </div>
    <div>
    <span class="blue f16">温馨提示：</span><br >
1.如果您填写的开户支行不正确，可能将无法成功提现，由此产生的提现费用将不予返还。<br >
2.如果您不确定开户行支行名称，可打电话到所在地银行的营业网店询问或上网查询。<br >
3.不支持提现至信用卡账户
    </div>
  </div>
</div>
</form>
<%@include file="/WEB-INF/include/script.jsp"%>
<script type="text/javascript"
		src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
<script type="text/javascript"
		src="<%=controller.getStaticPath(request)%>/js/region.js"></script>
</body>
</html>
