$(document).ready(function () {


    $("#inlineRadio1").change(function () {
        $("#phone-frame").show();
        $("#email-frame").hide();
        $(".tip_holder").popover('destroy');
    });

    $("#inlineRadio2").change(function () {
        $("#phone-frame").hide();
        $("#email-frame").show();
        $(".tip_holder").popover('destroy');
    });

    $("#reg_phone").keyup(function () {
        re = /^0{0,1}(13[4-9]|15[7-9]|15[0-2]|18[7-8])[0-9]{8}$/
        if (count == 0) {
            if (re.test($(this).val())) {
                $("#getcode").attr('disabled', false);
                $("#getcode").removeClass('getcode_disable');
                $("#getcode").addClass('getcode_enable');
            }
            else {
                $("#getcode").attr('disabled', true);
                $("#getcode").removeClass('getcode_enable');
                $("#getcode").addClass('getcode_disable');
            }
        }
    });


    $("#getcode").click(
        function () {
            $.post(
                "/get_code",
                {phone_num: $("#reg_phone").val()},
                'script'
            );
            $("#getcode").attr('disabled', true)
            $("#getcode").removeClass('getcode_enable')
            $("#getcode").addClass('getcode_disable')

            if ($("#timer").length) {
                count = 60;
                counter = setInterval(timer, 1000); //1000 will  run it every 1 second
            }

        }
    );

});


