	function Transfer(zqId,zqValue){
		$("#zqId").val(zqId);
		$("#zqjz").html(zqValue);
		$("#zqValue").val(zqValue);
		$("#zrValue").addClass("yhgl_ser border w100 required isint min-size-1");
		$("div.popup_bg").show();
		$("div.dialog").show();
	}

