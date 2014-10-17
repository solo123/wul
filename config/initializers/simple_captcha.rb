SimpleCaptcha.setup do |sc|
  # default: 100x28
  sc.image_size = '90x25'

  # default: 5
  sc.length = 5
  sc.image_style = 'mycaptha'
  sc.add_image_style('mycaptha', [
      "-background '#F4F7F8'",
      "-fill '#86818B'",
      "-border 1",
      "-bordercolor '#E0E2E3'"])
  # default: simply_blue
  # possible values:
  # 'embosed_silver',
  # 'simply_red',
  # 'simply_green',
  # 'simply_blue',
  # 'distorted_black',
  # 'all_black',
  # 'charcoal_grey',
  # 'almost_invisible'
  # 'random'
  # sc.image_style = 'distorted_black'

  # default: low
  # possible values: 'low', 'medium', 'high', 'random'
  sc.distortion = 'medium'
  # sc.implode = 'medium'

  # default: medium
  # possible values: 'none', 'low', 'medium', 'high'
  # sc.implode = 'low'
end