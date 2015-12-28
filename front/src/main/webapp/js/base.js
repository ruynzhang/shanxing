try{
$(document).ready(
	function() { 
	$.ajaxSetup({   
		contentType:"application/x-www-form-urlencoded;charset=utf-8",   
		complete:function(XMLHttpRequest,textStatus){
			// 通过XMLHttpRequest取得响应头，sessionstatus，
			var sessionstatus=XMLHttpRequest.getResponseHeader("sessionStatus");
			if(sessionstatus=="sessionOut"){   
				//window.location.replace(webPath+"/common/toIndex.html");   
				alert("登陆超时，请刷新页面后重试！");
				location.reload();
			}
			
//			// 通过XMLHttpRequest取得响应头，sessionstatus，
//			var location=XMLHttpRequest.getResponseHeader("Location");
//			var status=XMLHttpRequest.status;
//			alert(status);
//			alert(location);
//			if(status==302 && location.endWith("/login")){   
//				//window.location.replace(webPath+"/common/toIndex.html");   
//				alert("登陆超时，请刷新页面后重试！");
//			}
		}
	});

	}
);
}
catch(e){alert(e);}


String.prototype.endWith=function(str){
	if(str==null||str==""||this.length==0||str.length>this.length)
	  return false;
	if(this.substring(this.length-str.length)==str)
	  return true;
	else
	  return false;
	return true;
	}
	
function changeImgSize(obj,maxWidth){//本函数用于在图片加载时对图片大小等进行设置
		var imgWidth = obj.width;
		var imgHeight = obj.height;
		if(imgWidth > maxWidth){
			$(obj).width(maxWidth);	
		}
		$(obj).bind( "click" , function (){  
				var viewWidth=($(window).width()-100);
				if(imgWidth<viewWidth) viewWidth=imgWidth;
					$.layer({
						type: 1,
						title: false,
						area: [viewWidth, imgHeight],
						fix: false,
						shadeClose: true,
						//closeBtn: true,
					//	offset: [($(window).height() - 700)/2+'px', ''], //上下垂直居中
						border : true,
						border: [0],
						shade : [0.9, '#000'],
						page: {
							html: '<div style="width:'+viewWidth+'px;overflow-x:auto;"><img src="'+ $( obj ).attr("src")+'" /><\/div>' //此处放了防止html被解析，用了\转义，实际使用时可去掉
						}
					});
		})
	 }
	 
function ImgInit(parentObj,maxWidth) {
//点击图片即可触发
$(window).load(function() {
	$(parentObj).find("img").each(function(){
		changeImgSize(this,maxWidth);
	});	
});
}