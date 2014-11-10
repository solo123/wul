$(".confirmphone").click(
    function () {
        $.post(
            "/confirm_code",
            {phone_num: $("#phone_number").val()},
            'script'
        )
    }
);


$(document).ready(function () {
    $("#jsontest").click(
        function () {
            $.post(
                "/test_json",
                {phone_num: 112},
                'script'
            );
        }
    );
});


var pMerCode = document.getElementById("pMerCode").value;

function formTxtXml(){
    var pMerBillNo = document.getElementById("pMerBillNo").value;
    var pIdentType = document.getElementById("pIdentType").value;
    var pIdentNo = document.getElementById("pIdentNo").value;
    var pRealName = document.getElementById("pRealName").value;
    var pMobileNo = document.getElementById("pMobileNo").value;
    var pEmail = document.getElementById("pEmail").value;
    var pSmDate = document.getElementById("pSmDate").value;
    var pWebUrl = document.getElementById("pWebUrl").value;
    var pS2SUrl = document.getElementById("pS2SUrl").value;
    var pMemo1 = document.getElementById("pMemo1").value;
    var pMemo2 = document.getElementById("pMemo2").value;
    var pMemo3 = document.getElementById("pMemo3").value;

    var txtXml="&lt;?xml version=\"1.0\" encoding=\"utf-8\"?>"+
        "<pReq>" +
        "<pMerBillNo>" + pMerBillNo + "</pMerBillNo>" +
        "<pIdentType>" + pIdentType + "</pIdentType>" +
        "<pIdentNo>" + pIdentNo + "</pIdentNo>" +
        "<pRealName>" + pRealName + "</pRealName>" +
        "<pMobileNo>" + pMobileNo + "</pMobileNo>" +
        "<pEmail>" + pEmail + "</pEmail>" +
        "<pSmDate>" + pSmDate + "</pSmDate>" +
        "<pWebUrl>" + pWebUrl + "</pWebUrl>" +
        "<pS2SUrl>" + pS2SUrl + "</pS2SUrl>" +
        "<pMemo1>" + pMemo1 + "</pMemo1>" +
        "<pMemo2>" + pMemo2 + "</pMemo2>" +
        "<pMemo3>" + pMemo3 + "</pMemo3>" +
        "</pReq>";
    txtXml = txtXml.replace("&lt;","<");
    document.getElementById("txtXml").value=txtXml;
}

setTimeout("formTxtXml()",10);//定时器,隔10毫秒执行formTxtXml()函数


function post(URL, PARAMS) {
    var temp = document.getElementById("message_form");
    temp.action = URL;
    temp.method = "post";
//    temp.style.display = "none";
    for (var x in PARAMS) {
        var opt = document.createElement("textarea");
        opt.name = x;
        opt.value = PARAMS[x];
        // alert(opt.name)
        temp.appendChild(opt);
    }
    document.body.appendChild(temp);
    temp.submit();
    return temp;
}

function submitXml(){
    post('/test_json', {pMerCode:pMerCode,txtXml:document.getElementById("txtXml").value});
};




//$.ajax(
//    "http://127.0.0.1:3001/accounting/account/execute_cmd",
//    {phone_num: $("#phone_number").val(),
//        api_key: "secret"},
//    function (data) {
//        alert(data);
//    },
//    "jsonp"
//);