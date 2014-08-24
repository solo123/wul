$ ->
  $("#phonetab").change ->
    $("#phone-frame").css("display","block")
    $("#email-frame").css("display","none")

$ ->
  $("#emailtab").change ->
    $("#phone-frame").css("display","none")
    $("#email-frame").css("display","block")

$ ->
  $("#reg_phone").keyup ->
    re= /^0{0,1}(13[4-9]|15[7-9]|15[0-2]|18[7-8])[0-9]{8}$/
    if re.test($(this).val())
      $("#getcode").attr('disabled',false)
      $("#getcode").css('color','black')
      $("#getcode").css('background','orange')
    else
      $("#getcode").attr('disabled',true)
      $("#getcode").css('background','white')
      $("#getcode").css('color','#999')

$ ->
  $("#getcode").click ->
    alert "验证码已经发送，请查收"
    $("#getcode").attr('disabled',true)
    $("#getcode").css('background','white')
    $("#getcode").css('color','#999')