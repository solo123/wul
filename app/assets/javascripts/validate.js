function showRequest(formData, jqForm, options) {
    var queryString = $.param(formData);
    alert(queryString);
   // return $('#searchForm').validate().form();
    //return true;
}

$(document).ready(function () {
    var options = {
        target: '#output1', // target element(s) to be updated with server response
        beforeSubmit: showRequest, // pre-submit callback
        success: showResponse, // post-submit callback
        url: '/agency/usercheck', // override for form's 'action' attribute
        type: 'post', // 'get' or 'post', override for form's 'method' attribute
        dataType: 'script', // 'xml', 'script', or 'json' (expected server response type)
        clearForm: false // clear all form fields after successful submit
    };

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

    $('#reg_form_phone').ajaxForm(optionsphone);
    $('#reg_form_email').ajaxForm(optionsmail);

    $('#reg_form_email').validate({
        focusInvalid : true,
        focusCleanup : false,
        onkeyup : false,
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
                required : "请输入您的邮件地址",
                email : "请输入有效邮件地址",
                remote : "该邮件地址已被使用"
            }
        },
        errorPlacement : function(error, element) {
            error.appendTo(element.parent().parent().next());
        },

        /*submitHandler : function(form) {

         $("#loginform").ajaxSubmit();
         return false;
         },*/

        errorClass : "alert alert-danger",
        errorElement : "span",
    });

    $("#reg_form_phone").validate({
        focusInvalid: true,
        focusCleanup: false,
        onkeyup: false,
        rules: {
            reg_phone: {
                required: true,
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
            reg_password:{
              required:true,
              minlength: 6
            },
            reg_password_confirm: {
                required: true,
                minlength: 6,
                equalTo: "#reg_password"
            },

            reg_code: {
                required: true
            }
        },
        messages: {
            reg_phone: {
                required: "电话号码不能为空",
                remote: "该电话号码已经被使用"
            },
            reg_password:{
                required: "密码不能为空",
                minlength:  "密码不能少于6位"
            },
            reg_password_confirm: {
                required:"密码不能为空",
                minlength:"密码不能少于6位",
                equalTo: "确认密码不一致"
            },
            reg_code: {
                required: "验证码不能为空"
            }
        },
        errorPlacement: function (error, element) {
            error.appendTo(element.parent().parent().next());
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
    $("#getcode").attr('disabled', false)
    $("#getcode").css('color', 'black')
    $("#getcode").css('background', 'orange')
}


function disablecode() {
    $("#getcode").attr('disabled',true)
    $("#getcode").css('background','white')
    $("#getcode").css('color','#999')
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


