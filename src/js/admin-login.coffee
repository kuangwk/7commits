config = require "./modules/config.coffee"


initApp = ->
    clickAndlogin()

clickAndlogin = ()->
    $loginBtn = $('button.submit')
    $wrapper = $('div.login-wrapper')
    $loginBtn.on 'click', (event)->
        event.preventDefault()
        userData = 
            username: $wrapper.find('input.username').val()
            password: $wrapper.find('input.password').val()
        console.log 'sendAjax', userData
        $.ajax
            url: "/members/session"
            type: "POST"
            data: userData
            success: (results)->
                window.location.reload()


if not config.testing then initApp()

module.exports = {initApp}
