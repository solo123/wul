$(document).ready(function () {


    $("#inlineRadio1").change(function () {
        $("#phone-frame").show();
        $("#email-frame").hide();
        $(".tip_holder").popover("hide");
    });

    $("#inlineRadio2").change(function () {
        $("#phone-frame").hide();
        $("#email-frame").show()
        $(".tip_holder").popover("hide");
    });

    $("#reg_phone").keyup(function () {
        re = /^0{0,1}(13[4-9]|15[7-9]|15[0-2]|18[7-8])[0-9]{8}$/
        if (re.test($(this).val())) {
            $("#getcode").attr('disabled', false);
            $("#getcode").css('color', 'black');
            $("#getcode").css('background', 'orange');
        }
        else {
            $("#getcode").attr('disabled', true);
            $("#getcode").css('background', 'white');
            $("#getcode").css('color', '#999');
        }
    });

//    $("#reg_phone").focusout(function () {
//        re = /^0{0,1}(13[4-9]|15[7-9]|15[0-2]|18[7-8])[0-9]{8}$/
//        if (re.test($(this).val())) {
//            $("#getcode").attr('disabled', false);
//            $("#getcode").css('color', 'black');
//            $("#getcode").css('background', 'orange');
//        }
//        else {
//            $("#getcode").attr('disabled', true);
//            $("#getcode").css('background', 'white');
//            $("#getcode").css('color', '#999');
//        }
//    }

    $("#getcode").click(
        function () {
            $.post(
                "/get_code",
                {phone_num: $("#reg_phone").val()},
                'script'
            );
            $("#getcode").attr('disabled', true)
            $("#getcode").css('background', 'white')
            $("#getcode").css('color', '#999')
        }
    );

});



//#    $.post(
//#      "/get_code"
//#      phone_num: $("#reg_phone").val()
//#      'script'
//#    )
//#    $("#getcode").attr('disabled',true)
//#    $("#getcode").css('background','white')
//#    $("#getcode").css('color','#999')