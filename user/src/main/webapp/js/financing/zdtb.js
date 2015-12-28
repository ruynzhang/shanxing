$(function(){
	$("#yjtb_close").click(function(){
		$("div.popup_bg").hide();
		$("#yjtb_dialog").hide();
	});
	
	$("#yjtb").click(function(){
		$("div.popup_bg").show();
		$("#yjtb_dialog").show();
	});
	
	$("#zztb_close").click(function(){
		$("div.popup_bg").hide();
		$("#zztb_dialog").hide();
	});
	
	$("#zztb").click(function(){
		$("div.popup_bg").show();
		$("#zztb_dialog").show();
	});
});

