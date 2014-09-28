$(document).ready(function () {

    $msgs = $("#message").children();
    $msgs.each(function(){


        $.iGrowl({
            message: $(this).text(),
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