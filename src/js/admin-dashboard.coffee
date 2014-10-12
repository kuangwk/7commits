config = require "./modules/config.coffee"

require './member-edit.coffee'

initApp = ->
    clickToDeletePost()
    clickToSaveTeam()

clickToDeletePost = ->
    $deleteButton = $('ul.posts li.post-info button.delete')
    $deleteButton.on 'click', (event)->
        event.preventDefault()
        isDelete = confirm '确定删除博客？'
        if isDelete
            $this = $(this)
            $post = $this.parent('li.post-info')
            postId = getPostId $post
            ajaxToDeletePost postId, $post

getPostId = ($post)-> 
    $post.find('span.id').attr('id')

ajaxToDeletePost = (postId, $post)->
    $.ajax 
        url: "/posts/" + postId
        type: "DELETE"
        data: {}
        success: (results)->
            $post.remove()

clickToSaveTeam = ->
    $teamEdit = $('div.team-edit')
    $btn = $('div.team-edit button.submit')
    $btn.on 'click', (event)->
        longIntro = $teamEdit.find('textarea.introduction').val()
        shortIntro = $teamEdit.find('input.short-introduction').val()
        ajaxToSaveTeam longIntro, shortIntro

ajaxToSaveTeam = (longIntro, shortIntro)->
    $.ajax 
        url: "/team"
        type: "PUT"
        data: 
            introduction : longIntro
            shortIntroduction: shortIntro
        success: (results)->
            alert '修改成功'

if not config.testing then initApp()

module.exports = {initApp}
