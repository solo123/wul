$(document).ready(function () {

    $msgs = $("#message").children();
    $msgs.each(function(){


        $.iGrowl({
            message: "新消息:" + $(this).text() + "请查看消息中心",
            icon: 'feather-mail',
            animShow: 'fadeInDown',
            animHide: 'fadeOutUp',
            offset : {
                y: 	100
            },
            delay: 2000,
            spacing:15

            // other properties...
        });
    });


})