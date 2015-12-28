<!DOCTYPE html>
<html lang="en">
<head>
    <title>善行创投-我的投资</title>
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
<ul class="sj_list_tab" >
    <li  class="select" onclick="loadList(1,0);"><span><em>投标中</em></span></li>
    <li onclick="loadList(2,1);"><span><em>回款中</em></span></li>
    <li onclick="loadList(3,1);"><span><em>已完成</em><i></i></span></li>
</ul>
<div class="sj_list_content" >

    <!----投标中----->
    <div class="content conFocus" id="list1"></div>
    <!----回款中----->
    <div class="content" id="list2"></div>
    <!----已完成----->
    <div class="content" id="list3"></div>
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
    var page1 = 1,page2 = 1,page3 = 1;
    var hasNext1 = true,hasNext2 = true,hasNext3 = true;
    var noData="<div class=\"index-list\"><ul><li style=\"text-align: center;\">暂无数据</li></ul></div>";
    function loadList(type,num){
    	if(num!=1){
    		return;
    	}
    	var post_url="/user/mobile/investTbz.htm";
    	var page=page1;
    	var hasNext=hasNext1;
    	if(type>3 || type<1){
    		return;
    	}
    	if(type==2){
    		page=page2;    	
    		hasNext=hasNext2;
    		post_url="/user/mobile/investHk.htm";
    	}
    	else if(type==3){
    		page=page3;
    		hasNext=hasNext3;
    		post_url="/user/mobile/investYwc.htm";
    	}
    	$("#loadMore"+type).hide();
    	if(!hasNext)
    		return;
    	$("#loading"+type).show();
    	$.ajax({
    		type : "POST",
    		url : post_url,
    		dataType:"json",
    		data : {"size":5, "page":page},
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
		    	else if(type==3){
		    		hasNext3 = hasNext;
		    		page3+=1;
		    	}
    			if(data.content==""&&page==1){
    				$("#list"+type).append(noData);
    				return;
    			}
    			$.each(data.content, function(i,vo){
       				var content="<div class=\"sj_invest_pay\">"
           				+"<h1>"+vo.bdName+"</h1>"
           				+"<p class=\"sj_invest_time\">"+vo.date+"</p>"
           				+"<p class=\"sj_invest_line\"></p>"
           				+"<p class=\"sj_invest_mk\"><span>投资金额</span><span><b>￥"+vo.amount+"</b></span><span>｜</span><span>项目收益</span><span class=\"sj_invest_gain\">￥"+vo.proSj+"</span></p>"
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