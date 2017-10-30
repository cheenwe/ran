Login = do ->
  { init: ->
    # init background slide images
    $('.login-bg').backstretch [
      'http://7xl5z9.com1.z0.glb.clouddn.com/bg1.jpg'
      'http://7xl5z9.com1.z0.glb.clouddn.com/bg2.jpg'
      'http://7xl5z9.com1.z0.glb.clouddn.com/bg3.jpg'
      'http://7xl5z9.com1.z0.glb.clouddn.com/bg4.jpg'
    ],
      transition: 'fade',
      transitionDuration: 500,
      duration: 6000
    $('.forget-form').hide()
    $('.register-form').hide()
    return
 }

jQuery(document).ready ->
  Login.init()
  return