var count = 10;
var counter;

$(document).ready(function () {
    show_flash_message();
    if ($("#timer").length) {
        counter = setInterval(timer, 1000); //1000 will  run it every 1 second
    }

    if ($("#verify_code").length) {
       alert("验证码是" + $("#verify_code").html() )
    }

    var options_reset = {
        beforeSubmit: function () {
            return $('#reset_form').validate().form()
        },

        url: '/reset_password', // override for form's 'action' attribute
        type: 'post', // 'get' or 'post', override for form's 'method' attribute
        dataType: 'script', // 'xml', 'script', or 'json' (expected server response type)
        clearForm: false // clear all form fields after successful submit
        //resetForm: true        // reset the form after successful submit
    };

//    $('#reset_form').ajaxForm(options_reset);

    $("#reset_form").validate({
        focusInvalid: false,
        focusCleanup: true,
        onkeyup: false,
        rules: {

            recover_password: {
                required: true,
                minlength: 6
            },
            recover_password_confirm: {
                required: true,
                minlength: 6,
                equalTo: "#recover_password"
            }


        },
        messages: {

            recover_password: {
                required: "密码不能为空",
                minlength: "密码不能少于6位"
            },
            recover_password_confirm: {
                required: "密码不能为空",
                minlength: "密码不能少于6位",
                equalTo: "确认密码不一致"
            }

        },

        success: function (label, element) {
            $(element).popover('destroy');
        },
        submitHandler: function (form) {

            // do other things for a valid form
            if ($('#reset_form').validate().form()) {
                form.submit();
            }
            else {
            }
        },

        errorPlacement: function (error, element) {
            error.appendTo(element.parent().parent().next());
        },
        errorClass: "alert-danger",
        errorElement: "span"
    });


});

function show_flash_message() {
    if (flash_exist()) {
        $("#flash-message").delay(500).show("slideUp");
        $("#flash-message").delay(2500).hide("slideUp");
    }
}

function flash_exist() {
    return $("#flash-message").children().length > 0;
}

function timer() {
    count = count - 1;
    if (count <= 0) {
        clearInterval(counter);
        $('#timer').html("");
        $('#phonebutton').removeAttr('disabled');
        return;
    }

    document.getElementById("timer").innerHTML = "(" + count + ")";
}



