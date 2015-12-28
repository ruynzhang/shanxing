$(function(){	
	$("div.dialog_close").click(function(){
		$("#info").html("");
		$("div.popup_bg").hide();
		$("div.dialog").hide();
	});
	
	$("#cancel").click(function(){
		$("div.dialog").hide();
		$("div.popup_bg").hide();
	});
});
// 封装信息消息文本.
	function showDialogInfo(msg,type){
		return '<div class="dialog w510 thickpos" style="margin:-80px 0 0 -255px;">'+
			  '<div class="dialog_close fr" onclick="closeInfo()"><a></a></div>'+
			  '<div class="con clearfix">'+
			    '<div class="d_'+type+' fl"></div>'+
			    '<div class="info fr">'+
			      '<p class="f20 gray33">'+msg+'</p>'+
			    '</div>'+
			    '<div class="clear"></div>'+
			    '<div class="dialog_btn"><a onclick="closeInfo()"  class="btn btn001">关闭</a></div>'+
			  '</div>'+
			'</div>';
	}

	function showForwardInfo(msg,type,url){
		return '<div class="dialog w510"  style="margin:-150px 0 0 -255px;">'+
		'<div class="dialog_close fr" onclick="closeInfo()"><a></a></div>'+
	    '<div class="con clearfix">'+
	     ' <div class="d_'+type+' fl"></div>'+
	      '<div class="info fr"><p class="f20 gray33">'+msg+'</p></div>'+
	     ' <div class="dialog_btn"><a href="'+url+'" class="btn btn01">确 定</a><a onclick="closeInfo()" class="btn btn05">取 消</a></div> '+
	   ' </div>'+
	'</div>';
	}
	
	function showSuccInfo(msg,type,url){
		return '<div class="dialog w510"  style="margin:-150px 0 0 -255px;">'+
		'<div class="dialog_close fr" onclick="closeInfo()"><a></a></div>'+
	    '<div class="con clearfix">'+
	     ' <div class="d_'+type+' fl"></div>'+
	      '<div class="info"><p class="f20 gray33">'+msg+'</p></div>'+
	     ' <div class="dialog_btn"><a href="'+url+'" class="btn btn01">确 定</a></div> '+
	   ' </div>'+
	'</div>';
	}
	
	function closeInfo(){
		$("#info").html("");
		$("div.popup_bg").hide();
	}
	