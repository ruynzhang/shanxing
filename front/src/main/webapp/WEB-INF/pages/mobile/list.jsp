<!DOCTYPE html>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F13"%>
<%@page import="com.dimeng.p2p.S62.entities.SxbaoType"%>
<%@page import="java.util.List"%>
<%@page import="com.dimeng.p2p.service.SxbaoManage"%>
<html lang="en">
<head>
    <title>善行创投</title>
    <%@include file="/WEB-INF/pages/mobile/meta.jsp" %>
    <%@include file="/WEB-INF/pages/mobile/style.jsp" %>
</head>
<%CURRENT_CATEGORY="FINANCING";%>
<body>
<!---top--->
<%@include file="/WEB-INF/pages/mobile/header.jsp"%>

<!---nav tabs---->
<ul class="sj_list_tab" >
    <li  class="select" onclick="loadBdList(0);"><span><em>项目列表</em></span></li>
    <li><span><em>善行宝</em></span></li>
    <li onclick="loadZqList();"><span><em>转让标</em><i></i></span></li>
</ul>
<div class="sj_list_content" >
    <!----项目列表----->
    <div class="content conFocus" id="bdList"></div>
    <!----善行宝----->
    <div class="content">
      <%SxbaoManage sxbaoManage = serviceSession.getService(SxbaoManage.class);
      List<SxbaoType> types = sxbaoManage.findAllType();
      for(SxbaoType sxbaoType : types){%>
       <div class="index-list" >
            <ul>
                <li class="index-list-title clearfix">
                    <span><%=sxbaoType.name%></span>
                </li>
                <li class="index-list-state">
                    <div class="index-list-rate"> <p>状态</p> <p><em class="index-list-p"><%=sxbaoType.sellStatus == T6230_F13.S?"在售":"停售"%></em></p> </div>
                    <div> <p>已售总额</p> <p><em class="index-list-p">￥<%=Formater.formatAmount(sxbaoType.totalAmount)%></em></p> </div>
                    <div class="index-hq-btn"> <a href="javascript:void(0);" class="index-btn repay">立即投资</a> </div>
                </li>
            </ul>
        </div>
       <%}%>
    </div>
    <!----转让标----->
    <div class="content" id="zqList"></div>
</div>

<!---footer-->
<%@include file="/WEB-INF/pages/mobile/footer.jsp"%>
<!--end footer-->
<!---tabs--->
<script src="js/jquery.js" type="text/javascript"></script>
<script type="text/javascript">
    $(function(){
    	loadBdList(1);
        $(".sj_list_tab li").each(function(index){

            $(this).click(function(){
                $(".sj_list_tab li.select").removeClass("select");
                $(this).addClass("select");
                $(".sj_list_content .content:eq("+index+")").show().siblings().hide();

            });
        });
    });
    var page = 1;
    var hasNext = true;
    var _page = 1;
    var _hasNext = true;
    var more="<div class=\"list_load\" id=\"loadMore\" style=\"display: none;\"><a onclick=\"loadBdList(1);\">加载更多</a></div>";
    var load="<div id=\"loading\" style=\"text-align: center; padding: 5px 0px; display: none;\"><img src='/images/loading.gif'/></div>";
    var _more="<div class=\"list_load\" id=\"_loadMore\" style=\"display: none;\"><a onclick=\"loadZqList();\">加载更多</a></div>";
    var _load="<div id=\"_loading\" style=\"text-align: center; padding: 5px 0px; display: none;\"><img src='/images/loading.gif'/></div>";
    var noData="<div class=\"index-list\"><ul><li style=\"text-align: center;\">暂无数据</li></ul></div>";
    function loadBdList(num){
    	if(num!=1){
    		return;
    	}
    	$("#loadMore").hide();
    	if(!hasNext)
    		return;
    	$("#loading").show();
    	$.ajax({
    		type : "POST",
    		url : "/mobile/list.htm",
    		dataType:"json",
    		data : {"size":5, "page":page},
    		success : function(data){
    			$("#loading").hide();
    			$("#loadMore").remove();
    			$("#loading").remove();
    			hasNext = data.hasNext;
    			if(data.content==""&&page==1){
    				$("#bdList").append(noData);
    				return;
    			}
    			page+=1;
    			$.each(data.content, function(i, n){
       				var _yuye="";
       				var _status="";
       				var bonus="";
       				var hkfs=n.hkfs;
       				if(n.investName!=null && n.investName!="null"){
       					_yuye="<span class=\"list-item-icon wx_icon_new\">预约</span>";
       				}
       				if(n.bonus>0){
       					bonus="+"+n.bonus+"%";
       				}
       				if(n.hkfs=="本息到期一次付清"){
       					hkfs="本息一次付清";
       				}else if(n.hkfs=="每月付息,到期还本"){
       					hkfs="先息后本";
       				} 
       				if(n.status=="投标中"){
       					_status="<div class=\"wx_progress\"><span style=\"width:"+n.proess+"%\"></span><em>进度<ins>"+n.proess+"%</ins></em></div>";
       				}else if(n.status=="预发布"){ 
       					_status="<p class=\"wx_flex_btw\"><span>即将开启</span><span>发布时间："+n.dateTime+"</span></p>";
       				}else if(n.status=="已结清"){  
       					_status="<p class=\"wx_flex_btw\"><span>"+n.status+"</span><span>结清时间："+n.dateTime+"</span></p>";
       				}else{
       					if(n.dateTime==""){
       						_status="<p class=\"wx_flex_btw\"><span>"+n.status+"</span></p>";
       					}else{
       						_status="<p class=\"wx_flex_btw\"><span>"+n.status+"</span><span>满标时间："+n.dateTime+"</span></p>";
       					}
       				}
       				var content="<div class=\"index-list\"><a href=\"/mobile/bidDetail.html?id="+n.id+"\"><ul>"
       					+_yuye
           				+"<li class=\"index-list-title clearfix\"><span>"+n.bdName+"</span></li>"
           				+"<li class=\"index-list-state\"><p class=\"wx_flex_btw\">"
           				+"<span><i>"+n.rate+"%"+bonus+"</i></span><span><i>"+n.qx+"</i></span><span><i>￥"+n.amount+"</i></span><span><i>"+hkfs+"</i></span></p>"
           				+_status
           				+"</li></ul></div>";
           			$("#bdList").append(content);
       			});
    			if(hasNext){
    				$("#bdList").append(more+load);
    				$("#loadMore").show();
    			}
    		}
    	});
    }
    function loadZqList(){
    	$("#_loadMore").hide();
    	if(!_hasNext)
    		return;
    	$("#_loading").show();
    	$.ajax({
    		type : "POST",
    		url : "/mobile/zqList.htm",
    		dataType:"json",
    		data : {"size":5, "page":_page},
    		success : function(data){
    			$("#_loading").hide();
    			$("#_loadMore").remove();
    			$("#_loading").remove();
    			_hasNext = data.hasNext;
    			if(data.content==""&&_page==1){
    				$("#zqList").append(noData);
    				return;
    			}
    			_page+=1;
   				$.each(data.content, function(i, n){
   					var content="<div class=\"index-list\"><a href=\"/user/mobile/bidZrDetail.html?zqApplyId="+n.id+"\"><ul>"
           				+"<li class=\"index-list-title clearfix\"><span>"+n.bdName+"</span></li>"
           				+"<li class=\"index-list-state\"><p class=\"wx_flex_btw\">"
           				+"<span><i>"+n.rate+"</i>%</span><span>"+n.qx+"</span><span>￥"+n.zrje+"</span></p>"
           				+"</li></ul></div>";
           			$("#zqList").append(content);
       			});
    			if(_hasNext){
    				$("#zqList").append(_more+_load);
    				$("#_loadMore").show();
    			}
    		}
    	}); 
    }
</script>

</body>
</html>