var count = 60;
var counter;

function timer() {
    count = count - 1;
    if (count <= 0) {
        clearInterval(counter);
        $('#timer').html("");
        $("#getcode").attr('disabled', false);
        $("#getcode").removeClass('getcode_disable');
        $("#getcode").addClass('getcode_enable');
        return;
    }

    document.getElementById("timer").innerHTML = count;
}


function showRequest(formData, jqForm, options) {
    var queryString = $.param(formData);
    alert(queryString);
   // return $('#searchForm').validate().form();
    //return true;
}

$(document).ready(function () {


    var optionsphone = {
        beforeSubmit: function() {
            return $('#reg_form_phone').validate().form()
        },

        url: '/new_user', // override for form's 'action' attribute
        type: 'post', // 'get' or 'post', override for form's 'method' attribute
        dataType: 'script', // 'xml', 'script', or 'json' (expected server response type)
        clearForm: false // clear all form fields after successful submit
        //resetForm: true        // reset the form after successful submit
    };


    var optionsmail = {
        beforeSubmit: function() {
            return $('#reg_form_email').validate().form()
        },

        url: '/new_user', // override for form's 'action' attribute
        type: 'post', // 'get' or 'post', override for form's 'method' attribute
        dataType: 'script', // 'xml', 'script', or 'json' (expected server response type)
        clearForm: false // clear all form fields after successful submit
        //resetForm: true        // reset the form after successful submit
    };

//    $('#reg_form_phone').ajaxForm(optionsphone);
//    $('#reg_form_email').ajaxForm(optionsmail);

    $('#reg_form_email').validate({
        focusInvalid : true,
        focusCleanup :true,
        onkeyup : true,
        rules : {
            reg_email_pass : {
                required : true,
                minlength : 6
            },
            reg_email_conf : {
                required : true,
                minlength : 6,
                equalTo : "#reg_email_pass"
            },


            reg_email : {
                required : true,
                email : true,
                remote : {
                    url : "/checkemail",
                    type : "post"
                }
            }

        },
        messages : {
            reg_email_pass : {
                required : "密码不能为空",
                minlength : "密码至少为6位"
            },
            reg_email_conf : {
                required : "请确认密码",
                minlength : "密码至少为6位",
                equalTo : "两次输入密码不一致"
            },

            reg_email : {
                required : "需要您的邮箱",
                email : "需要有效邮箱",
                remote : "该邮箱已被使用"
            }
        },
        errorPlacement: function (error, element) {
            $(element).popover('destroy');
            $(element).popover({
                content:$(error).html(),
                trigger: "manual click",
                container: '#reg_panel',
                template: '<div class="popover" role="tooltip"><div class="arrow"></div><div class="popover-content error-msg"></div></div>'
            });
            $(element).popover('show');
//            error.appendTo(element.parent().parent().next());
        },

        success: function(label,element) {
            $(element).popover('destroy');
        },

        submitHandler: function(form) {

            // do other things for a valid form
            if ($('#reg_form_email').validate().form())
            {
                form.submit();
            }
            else
            {alert("no");}
        },

        errorClass : "alert alert-danger",
        errorElement : "span"
      });

    $("#reg_form_phone").validate({
        focusInvalid: true,
        focusCleanup: true,
        onkeyup: false,
        rules: {
            reg_phone: {
                required: true,
                minlength: 11,
                maxlength: 11,
                remote: {
                    url: "/checkmobile",
                    type: "post",
                    complete: function(data){
                        if( data.responseText == "false" ) {
                           disablecode();
                        }
                        else {
                            enablecode();
                        }
                    }
                 }
                },
            reg_code: {
                required: true
            },
            reg_password:{
              required:true,
              minlength: 6
            },
            reg_password_confirm: {
                required: true,
                minlength: 6,
                equalTo: "#reg_password"
            }


        },
        messages: {
            reg_phone: {
                required: "电话号码不能为空",
                minlength: "请确认手机号码长度",
                maxlength: "请确认手机号码长度",
                remote: "该电话号码已经被使用"
            },
            reg_code: {
                required: "验证码不能为空"
            },
            reg_password:{
                required: "密码不能为空",
                minlength:  "密码不能少于6位"
            },
            reg_password_confirm: {
                required:"密码不能为空",
                minlength:"密码不能少于6位",
                equalTo: "确认密码不一致"
            }

        },

        success: function(label,element) {
            $(element).popover('destroy');
        },
        submitHandler: function(form) {

            // do other things for a valid form
            if ($('#reg_form_phone').validate().form())
            {
                form.submit();
            }
            else
            {alert("no");}
        },

        errorPlacement: function (error, element) {
            $(element).popover('destroy');
            $(element).popover({
                content:$(error).html(),
                trigger: "manual click",
                container: '#reg_panel',
                template: '<div class="popover" role="tooltip"><div class="arrow"></div><div class="popover-content error-msg"></div></div>'
            });
            $(element).popover('show');
//            error.appendTo(element.parent().parent().next());
        },
        errorClass: "alert alert-danger",
        errorElement: "span"
    });

});

function showResponse(responseText, statusText, xhr, $form) {

    alert('status: ' + statusText + '\n\nresponseText: \n' + responseText + '\n\nThe output div should have already been updated with the responseText.');
}







function regsuccess() {
}
function enablecode() {
    $("#getcode").attr('disabled', false);
    $("#getcode").removeClass('getcode_disable');
    $("#getcode").addClass('getcode_enable');
    $("#reg_phone").removeClass("alert-danger");
    $('#reg_phone').popover('destroy');
}


function disablecode() {
    $("#getcode").attr('disabled',true);
    $("#getcode").removeClass('getcode_enable');
    $("#getcode").addClass('getcode_disable');
   $("#reg_phone").addClass("alert-danger");
    $('#reg_phone').popover({
        content:"该手机号码已经被使用",
        trigger: "manual click",
        container: 'body'
    });
    $('#reg_phone').popover('show');
}
function regfail() {
}

function userpasswrong() {
    str = "您的帐号和密码不匹配，或者用户不存在。";
    $("#username").notify(str, {
        className: "error",
        arrowShow: false,
        position: "top",
        autoHideDelay: 4000
    });

}


