Login = do ->
  handleLogin = ->
    $('.login-form').validate
      errorElement: 'span'
      errorClass: 'help-block'
      focusInvalid: false
      rules:
        username: required: true
        password: required: true
        remember: required: false
      messages:
        username: required: 'Username is required.'
        password: required: 'Password is required.'
      invalidHandler: (event, validator) ->
        #display error alert on form submit
        $('.alert-danger', $('.login-form')).show()
        return
      highlight: (element) ->
        # hightlight error inputs
        $(element).closest('.form-group').addClass 'has-error'
        # set error class to the control group
        return
      success: (label) ->
        label.closest('.form-group').removeClass 'has-error'
        label.remove()
        return
      errorPlacement: (error, element) ->
        error.insertAfter element.closest('.input-icon')
        return
      submitHandler: (form) ->
        form.submit()
        # form validation success, call ajax form submit
        return
    $('.login-form input').keypress (e) ->
      if e.which == 13
        if $('.login-form').validate().form()
          $('.login-form').submit()
          #form validation success, call ajax form submit
        return false
      return
    $('.forget-form input').keypress (e) ->
      if e.which == 13
        if $('.forget-form').validate().form()
          $('.forget-form').submit()
        return false
      return
    $('#forget-password').click ->
      $('.login-form').hide()
      $('.forget-form').show()
      return
    $('#back-btn').click ->
      $('.login-form').show()
      $('.forget-form').hide()
      return
    $('#sign-up').click ->
      console.log '.........'
      $('.register-form').show()
      $('.forget-form').hide()
      $('.login-form').hide()
      return
    return

  { init: ->
    handleLogin()
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