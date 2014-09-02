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
                digits: true,
                range: [200, 20000]
            },

            "delagator[min_invest_amount]": {
                required: true,
                digits: true,
                min: 50
            },
            "delagator[min_remain_balance]":{
                required: true,
                digits: true
            }
        },
        messages: {
            "delagator[each_invest_amount]": {
                required: "请输入投资金额",
                digits: "应该输入数字",
                range:"该金额只能在200到20000之间"
            },
            "delagator[min_invest_amount]": {
                required: "请输入最小投资金额",
                digits: "应该输入数字",
                min: "金额应该大于50"
            },
            "delagator[max_invest_period]": {
                required: "请输入借款期限上限",
                digits: "应该输入数字"
            },
            "delagator[min_remain_balance]": {
                required: "请输入最低余额",
                digits: "应该输入数字"
            }
        },
        errorPlacement: function (error, element) {
            error.appendTo(element.next());
        },

        submitHandler: function(form) {

            // do other things for a valid form
            if ($('#auto_invest_form').validate().form())
            {
                 form.submit();
            }
            else
            {alert("no");}
        },

        errorClass: "error-span",
        errorElement: "div"
    });

})












