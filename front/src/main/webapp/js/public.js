// common js
$(document).ready(function(){
    //返回顶部
	  var bt = $('#sx_toTop');
        var sw = $(document.body)[0].clientWidth;

        var limitsw = (sw - 1000) / 2 - 100;
        /*if (limitsw > 0){
                limitsw = parseInt(limitsw);
                bt.css("right",limitsw);
        }*/
		var m= window.location.href;
        $(window).scroll(function() {
                var st = $(window).scrollTop();
                if(st > 100){
					bt.show();
                }else{
                        bt.hide();
                }
        });
		
		if(m.search(/ftnzzintro/)==-1) {$('.ftad_menu').hide()}
	 bt.click(function() {
		$('body,html').animate({scrollTop:0},600);
		});

	$(".middle").hover(function(){
		$(".sx_blank").css("display","block");
	},function(){
		$(".sx_blank").fadeOut();
	})

	$(".loadBt1").click(function(){
	    $(".sx_overlay").show();
		$(".sx_popupbox").css("display","block");
		event.preventDefault();
	})
	$(".sx_close").click(function(){
		$(".sx_popupbox").css("display","none");
		$(".sx_overlay").hide();
	})
	$(".sx_bluebt1").click(function(){
		$(".sx_popupbox").css("display","none");
		$(".sx_overlay").hide();
	})
})
