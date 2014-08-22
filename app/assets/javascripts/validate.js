function showRequest(formData, jqForm, options) {
    var queryString = $.param(formData);
    return true;
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

    var optionsreg = {
        beforeSubmit : showRequest, // pre-submit callback
        success: showResponse, // post-submit callback

        // other available options:
        url: '/users', // override for form's 'action' attribute
        type: 'post', // 'get' or 'post', override for form's 'method' attribute
        dataType: 'script', // 'xml', 'script', or 'json' (expected server response type)
        clearForm: false // clear all form fields after successful submit
        //resetForm: true        // reset the form after successful submit
    };

    $('#reg_form_phone').ajaxForm(optionsreg);

});

function showResponse(responseText, statusText, xhr, $form) {

    alert('status: ' + statusText + '\n\nresponseText: \n' + responseText + '\n\nThe output div should have already been updated with the responseText.');
}


$("#reg_form_phone").validate({
    focusInvalid: true,
    focusCleanup: false,
    onkeyup: true,
    rules: {
        reg_phone: {
            required: true,
            remote: {
                url: "/agency/reg_check",
                type: "post"
            }

        }
    },
    messages: {
        reg_phone: {
            required: "电话号码不能为空",
            remote: "电话号码已经被注册"
        }
    },
    errorPlacement: function (error, element) {
        error.appendTo(element.parent().next());
    },

    /*submitHandler : function(form) {

     $("#loginform").ajaxSubmit();
     return false;
     },*/

    errorClass: "help-inline",
    errorElement: "span"
});




function regsuccess() {
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


