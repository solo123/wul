$("#confirmphone").click(
    function () {
        $.post(
            "/confirm_code",
            {phone_num: $("#phone_number").val()},
            'script'
        )
    }
);

$("#jsontest").click(
    function () {
        $.post(
            "/test_json",
            {phone_num: 112},
            'script'
        )
    }
);


//$.ajax(
//    "http://127.0.0.1:3001/accounting/account/execute_cmd",
//    {phone_num: $("#phone_number").val(),
//        api_key: "secret"},
//    function (data) {
//        alert(data);
//    },
//    "jsonp"
//);