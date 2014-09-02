function showRequest(formData, jqForm, options) {
    var queryString = $.param(formData);
    alert(queryString);
}

$(document).ready(function () {
    var optionsphone = {
        beforeSubmit: function () {
            return $('#reg_form_phone').validate().form()
        },

        url: '/new_user', // override for form's 'action' attribute
        type: 'post', // 'get' or 'post', override for form's 'method' attribute
        dataType: 'script', // 'xml', 'script', or 'json' (expected server response type)
        clearForm: false // clear all form fields after successful submit
        //resetForm: true        // reset the form after successful submit
    };

//    $('#auto_invest_form').ajaxForm(optionsmail);

    $('#auto_invest_form').validate({
        focusInvalid: true,
        focusCleanup: false,
        onkeyup: false,
        rules: {
            "delagator[each_invest_amount]": {
                required: true,
                minlength: 6
            },

            "delagator[min_invest_amount]": {
                required: true,
                minlength: 6
            }

        },
        messages: {
            "delagator[each_invest_amount]": {
                required: "密码不能为空",
                minlength: "密码至少为6位"
            },
            "delagator[min_invest_amount]": {
                required: "密码不能为空",
                minlength: "密码至少为6位"
            }

        },
        errorPlacement: function (error, element) {
            error.appendTo(element.parent().next());
        },

        submitHandler: function(form) {

            // do other things for a valid form
            if ($('#auto_invest_form').validate().form())
            {
                alert("yes");
//                form.submit();
            }
            else
            {alert("no");}
        },

        errorClass: "help-inline",
        errorElement: "span"
    });

})












