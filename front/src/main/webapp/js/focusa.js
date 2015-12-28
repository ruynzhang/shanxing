// JavaScript Document
$(function() {
	var sWidth = $("#focusa").width(); //获取焦点图的宽度（显示面积）
	var len = $("#focusa ul li").length; //获取焦点图个数
	var index = 0;
	var picTimer;
	
	//以下代码添加数字按钮和按钮后的半透明条，还有上一页、下一页两个按钮
	var btn = "<div class='btnBg'></div><div class='btn'>";
	for(var i=0; i < len; i++) {
		btn += "<span></span>";
	}
	btn += "</div><div class='preNext pre'></div><div class='preNext next'></div>";
	$("#focusa").append(btn);
	$("#focusa .btnBg").css("opacity",0.5);

	//为小按钮添加鼠标滑入事件，以显示相应的内容
	$("#focusa .btn span").css("opacity",0.4).mouseover(function() {
		index = $("#focusa .btn span").index(this);
		showPics(index);
	}).eq(0).trigger("mouseover");

	//上一页、下一页按钮透明度处理
	$("#focusa .preNext").css("opacity",0.1).hover(function() {
		$(this).stop(true,false).animate({"opacity":"0.5"},300);
	},function() {
		$(this).stop(true,false).animate({"opacity":"0.2"},300);
	});

	//上一页按钮
	$("#focusa .pre").click(function() {
		index -= 1;
		if(index == -1) {index = len - 1;}
		showPics(index);
	});

	//下一页按钮
	$("#focusa .next").click(function() {
		index += 1;
		if(index == len) {index = 0;}
		showPics(index);
	});

	//本例为左右滚动，即所有li元素都是在同一排向左浮动，所以这里需要计算出外围ul元素的宽度
	$("#focusa ul").css("width",sWidth * (len));
	
	//鼠标滑上焦点图时停止自动播放，滑出时开始自动播放
	$("#focusa").hover(function() {
		clearInterval(picTimer);
	},function() {
		picTimer = setInterval(function() {
			try{
			 $("#focusa img.lazy").trigger("sporty");
			  $("#channlViews img.lazy").trigger("sporty");
			}catch(e){}
			showPics(index);
			index++;
			if(index == len) {index = 0;}
		},4000); //此4000代表自动播放的间隔，单位：毫秒
	}).trigger("mouseleave");
	
	//显示图片函数，根据接收的index值显示相应的内容
	function showPics(index) { //普通切换
		var nowLeft = -index*sWidth; //根据index值计算ul元素的left值
		$("#focusa ul").stop(true,false).animate({"left":nowLeft},300); //通过animate()调整ul元素滚动到计算出的position
		//$("#focus .btn span").removeClass("on").eq(index).addClass("on"); //为当前的按钮切换到选中的效果
		$("#focusa .btn span").stop(true,false).animate({"opacity":"0.4"},300).eq(index).stop(true,false).animate({"opacity":"1"},300);

		//为当前的按钮切换到选中的效果
		try{
//		if(index==0){
		amm($($("#focusa ul li")[index]).find("span:first").attr("id").split("showbox_").join(""));
//		}
//		else if(index==1){
//		amm('x_11');
//		}
		}catch(e){
		}
	}
});

//导航下拉菜单
$(document).ready(function(){
			 $('li.mainlevel').mousemove(function(){
				$(this).addClass("kang_yau");
				$(this).find(".sub").width($(this).find(".sub .gates").length * (172+1));
				$(this).find(".sub").slideDown();
			});
			$('li.mainlevel').mouseleave(function(){
				$(this).removeClass("kang_yau");
				$(this).find(".sub").slideUp("fast");
			});
});