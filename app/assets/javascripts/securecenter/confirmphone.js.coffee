$ ->
  $("#confirmphone").click ->
    if $("#phone_number").val() is ""
      alert "电话号码为空"
    else
      $.post(
        "/securecenter/secure/verify_code"
        phone: $("#phone_number").val()
        (data)-> alert(data.verify)
        'json'
      )