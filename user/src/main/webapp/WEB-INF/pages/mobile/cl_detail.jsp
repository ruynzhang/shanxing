<!DOCTYPE html>
<html lang="en">
<head>
    <title>善行创投-收款明细</title>
    <%@include file="/WEB-INF/pages/mobile/meta.jsp" %>
    <%@include file="/WEB-INF/pages/mobile/style.jsp" %>
    <%@include file="/WEB-INF/pages/mobile/javascript.jsp" %>
</head>
<%CURRENT_CATEGORY="WEALTH";%>
<body>
<!---top--->
<%@include file="/WEB-INF/pages/mobile/header.jsp"%>
<!---我的投资内容----->
<!---nav tabs---->
<ul class="sj_list_tab sj_detail" >
    <li  class="select" onclick="loadList(1,0);"><span><em>待收款</em></span></li>
    <li onclick="loadList(2,1);"><span><em>已收款</em></span></li>
</ul>
<div class="sj_list_content" >

    <!----已收款----->
    <div class="content conFocus" id="list1"></div>
    <!----待收款----->
    <div class="content" id="list2"></div>

</div>

<!---footer-->
<%@include file="/WEB-INF/pages/mobile/footer.jsp"%>
<!--end footer-->
<!---tabs--->
<script type="text/javascript">
    $(function(){
    	 loadList(1,1);
        $(".sj_list_tab li").each(function(index){
            $(this).click(function(){
                $(".sj_list_tab li.select").removeClass("select");
                $(this).addClass("select");
                $(".sj_list_content .content:eq("+index+")").show().siblings().hide();

            });
        });
    });
    var page1 = 1,page2 = 1;
    var hasNext1 = true,hasNext2 = true;
    var noData="<div class=\"index-list\"><ul><li style=\"text-align: center;\">暂无数据</li></ul></div>";
    function loadList(type,num){
    	if(num!=1){
    		return;
    	}
    	var queryType="DS";
    	var page=page1;
    	var hasNext=hasNext1;
    	if(type>2 || type<1){
    		return;
    	}
    	if(type==2){
    		page=page2;    	
    		hasNext=hasNext2;
    		queryType="YS";
    	}
    	$("#loadMore"+type).hide();
    	if(!hasNext)
    		return;
    	$("#loading"+type).show();
    	$.ajax({
    		type : "POST",
    		url : "/user/mobile/backMoney.htm",
    		dataType:"json",
    		data : {"size":5, "page":page,"queryType":queryType},
    		success : function(data){
    			$("#loading"+type).hide();
    			$("#loadMore"+type).remove();
    			$("#loading"+type).remove();
    			hasNext = data.hasNext;
    			if(type==1){
					hasNext1 = hasNext;
					page1+=1;
				}
				if(type==2){
					hasNext2 = hasNext;
					page2+=1;
		    	}
    			if(data.content==""&&page==1){
    				$("#list"+type).append(noData);
    				return;
    			}
    			$.each(data.content, function(i,vo){
       				var content="<div class=\"sj_invest_pay\">"
           				+"<h1>"+vo.bdName+"</h1>"
           				+"<p class=\"sj_invest_line\"></p>"
           				+"<p class=\"sj_invest_mk\"><span>收款日期</span><span><b>"+vo.date+"</b></span><span>｜</span><span>回收本息</span><span class=\"sj_invest_gain\">￥"+vo.amount+"</span></p>"
           				+"</div>";
           			$("#list"+type).append(content);
       			});
    			if(hasNext){
    				$("#list"+type).append(
    					"<div class=\"list_load\" id=\"loadMore"+type+"\" style=\"display: none;\"><a onclick=\"loadList("+type+",1);\">加载更多</a></div>"
    					+"<div id=\"loading"+type+"\" style=\"text-align: center; padding: 5px 0px; display: none;\"><img src='/images/loading.gif'/></div>"
    				);
    				$("#loadMore"+type).show();
    			}
    		}
    	});
    }
</script>

</body>
</html>