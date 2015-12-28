$(function(){
	$("input").keypress(function(){
		if(event.keyCode==13) {return false;}
	  });
	
	$('#tips0').hover(function(){
        $("#tips0Msg").show();
       },function(){
    	$("#tips0Msg").hide();
    });
	
	$('#tips0Msg').hover(function(){
        $("#tips0Msg").show();
       },function(){
    	$("#tips0Msg").hide();
    });
	$('#tips1').hover(function(){
        $("#tips1Msg").show();
       },function(){
    	$("#tips1Msg").hide();
    });
	
	$('#tips1Msg').hover(function(){
        $("#tips1Msg").show();
       },function(){
    	$("#tips1Msg").hide();
    });
	
	$("#tbButton").click(function(){
		checkBid();
	});
	
	$("#ok").click(function(){
		var form = document.forms[0];
		form.submit();
	});
});