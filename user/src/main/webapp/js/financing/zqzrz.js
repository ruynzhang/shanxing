$(function(){
	
	$("#ok").click(function(){
		var zcbId=$("#zcbId").val();
		var form = document.forms[0];
		form.action = url_del+"?zcbId="+zcbId;
		form.submit();
	});
});

	function Cancel(zcbId){
		$("div.popup_bg").show();
		$("div.dialog").show();
		$("#zcbId").val(zcbId);
	}

