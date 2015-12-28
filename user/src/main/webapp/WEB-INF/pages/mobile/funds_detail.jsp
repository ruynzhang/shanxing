<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <title>善行创投-资金明细</title>
    <%@include file="/WEB-INF/pages/mobile/meta.jsp" %>
    <%@include file="/WEB-INF/pages/mobile/style.jsp" %>
	<%@include file="/WEB-INF/pages/mobile/javascript.jsp" %>
</head>
<%CURRENT_CATEGORY="WEALTH";%>
<body onload="loadfdList(1);">
<!---top--->
<%@include file="/WEB-INF/pages/mobile/header.jsp"%>

<!----资金明细------->
 <div class="sj_wealth_list" id="sj_wealth_list" ></div>
<!------end---------------->
<!---footer-->
<%@include file="/WEB-INF/pages/mobile/footer.jsp"%>
<!--end footer-->
<script type="text/javascript">
var page = 1;
var hasNext = true;
var more="<div class=\"list_load\" id=\"loadMore\" style=\"display: none;\"><a onclick=\"loadfdList(1);\">加载更多</a></div>";
var load="<div id=\"loading\" style=\"text-align: center; padding: 5px 0px; display: none;\"><img src='/images/loading.gif'/></div>";
var noData="<div class=\"index-list\"><ul><li style=\"text-align: center;\">暂无数据</li></ul></div>";

function loadfdList(num){
	$("#loadMore").hide();
	if(!hasNext){
		return;
	}	
	$("#loading").show();
	$.ajax({
		type : "POST",
		url : "/user/mobile/fdetailList.htm",
		dataType:"json",
		data : {"size":10, "page":page},
		success : function(data){
			$("#loading").hide();
			$("#loadMore").remove();
			$("#loading").remove();
			hasNext = data.hasNext;
			if(data.content==""&&page==1){
				$("#sj_wealth_list").append(noData);
				return;
			}
			if(num>0){
    			page+=1;
    			$.each(data.content, function(i, n){
    				var _status="";
    				if(n.gcrMoney!=""){
    				   _status="<span class=\"sj_wealth_profit\">+"+n.gcrMoney+"</span>";
    				}else{
    				   _status="<span class=\"sj_wealth_loss\">-"+n.raMoney+"</span>";
    				}
       				var content="<div class=\"sj_wealth_funds\"><p>"+n.typeName+"</p><p><span class=\"sj_wealth_time\">"
       				+n.crDatetime+"</span>"+_status+"</p></div>";
           			$("#sj_wealth_list").append(content);
       			});
			}
			if(hasNext){
				$("#sj_wealth_list").append(more+load);
				$("#loadMore").show();
			}
		}
	});
}
</script>
</body>
</html>