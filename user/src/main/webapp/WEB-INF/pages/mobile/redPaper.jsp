<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <title>善行创投-我的红包</title>
    <%@include file="/WEB-INF/pages/mobile/meta.jsp" %>
    <%@include file="/WEB-INF/pages/mobile/style.jsp" %>
    <%@include file="/WEB-INF/pages/mobile/javascript.jsp" %>
</head>
<body onload="loadList(1);">
<!---top--->
<%CURRENT_CATEGORY="WEALTH";%>
<%@include file="/WEB-INF/pages/mobile/header.jsp"%>
<!---我的投资内容----->
<!---nav tabs---->
<ul class="sj_list_tab" >
    <li  class="select" onclick="loadList(1);"><span><em>未使用</em></span></li>
    <li onclick="loadList(2);"><span><em>已使用</em></span></li>
    <li onclick="loadList(3);"><span><em>已过期</em><i></i></span></li>
</ul>
<div class="sj_list_content" >

    <!----未使用----->
    <div class="content conFocus" id="list1"></div>
    <!----已使用----->
    <div class="content" id="list2"></div>
    <!----已过期----->
    <div class="content" id="list3"></div>
</div>

<%@include file="/WEB-INF/pages/mobile/footer.jsp"%>
<!--end footer-->
<!---tabs--->
<script type="text/javascript">
    $(function(){
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
    function loadList(type){
    	var post_url="/user/mobile/redPaper.htm";
    	var page="";
    	var hasNext="";
    	if(type==1){
        	page=page1;
            hasNext=hasNext1;	
    	}else if(type==2){
    		 page=page2;    	
    		 hasNext=hasNext2;
    	}else if(type==3){
    		 page=page3;    	
    		 hasNext=hasNext3;
    	}
    	$("#loadMore"+type).hide();
    	if(!hasNext)
    		return;  
    	$("#loading"+type).show();
    	
     	$.ajax({
    		type : "POST",
    		url : post_url,
    		dataType:"json",
    		data : {"size":5, "page":page,"type":type},
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
    				var style="";
    				var str="";
    				if(vo.state=="3" || vo.state=="4" || vo.state=="5"){
    					style="sj_paper_out";
    				}
    				if(vo.state==5){
    					str="(未激活)";
    				}
       				var content=" <div class=\"sj_paper_use\">"
           				+"<div class=\"sj_paper_price "+style+"\"><h1>￥"+vo.ramount+"</h1></div>"
           				+"<div class=\"sj_paper_info\"><p>来源："+vo.rsource+str+"</p><p>起投金额："+vo.ranges+"元</p><p class=\"sj_paper_time\">"+vo.startTime+"至"+vo.endTime+"</p></div>"
           				+"</div>";
           			$("#list"+type).append(content);
       			});
    			if(hasNext){
    				$("#list"+type).append(
    					"<div class=\"list_load\" id=\"loadMore"+type+"\" style=\"display: none;\"><a onclick=\"loadList("+type+");\">加载更多</a></div>"
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