// common js
$(document).ready(function(){
    $(".back_top").click(function(){
	    $('body,html').animate({scrollTop:0},600);
	})
    var mW=$("#sx_m_main").width();
	
	$(".toReg2").mousedown(function(){
	    $(".overlay").show();
		$(".sx_popup").css("display","block");
		event.preventDefault();
	})
	$(".sx_err_btn").click(function(){
		$(".sx_popup").css("display","none");
		$(".overlay").hide();
	})
	$(".toReg").click(function(event){	
		event.preventDefault();
		$('html,body').animate({scrollTop:$(this.hash).offset().top-40},1000);
	});
	$(".showText").click(function(){
		$(".sx_m_showbox").fadeIn();
		$(".overlay").show();
		$(".sx_m_close").show();
	})
	$(".sx_m_close").click(function(){
	    $(".sx_m_showbox").fadeOut();
		$(".overlay").hide();
		$(this).hide();	
	})
})
