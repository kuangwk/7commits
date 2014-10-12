handlebars = require "handlebars"
config = require "./modules/config.coffee"
commentTpl = require "../tpl/comment.tpl"

$loadMore = null
$comments = null
$commentsCreator = null
$loading = $('img.comments-loading')
comments = []

LIMIT = 10
commentCompiler = handlebars.compile commentTpl
isLoading = no

initApp = ->
    comments.length = 0
    $loadMore = $("div.load-more a")
    $comments = $("#comments-wrapper ul")
    $commentsCreator = $('div.comments-creator')
    loadComments(comments.length)
    clickToLoadMore()
    clickToAddComment()
    $loading.show()

loadComments = (start, callback)->
    if isLoading then return
    isLoading = yes
    $loading.show()
    $.ajax 
        url: "/comments/#{start}/#{LIMIT}"
        type: "GET"
        success: (results)->
            isLoading = no
            $loading.hide()
            for comment in results
                comments.push comment
                renderComment comment
            callback?results

renderComment = (comment, isPrepend)->
    if isPrepend
        $comments.prepend commentCompiler(comment)
    else 
        $comments.append commentCompiler(comment)


clickToAddComment = ->
    $submit = $('button.submit')
    $submit.on 'click', (event)->
        event.preventDefault() 
        addCommentToList()

addCommentToList = ->
    comment = 
        email : $commentsCreator.find('input.email').val()
        name : $commentsCreator.find('input.name').val()
        content : $commentsCreator.find('textarea.content').val()
        createTime : new Date().toLocaleDateString()
        isReply : false

    $.ajax 
        url: "/comments"
        type: 'POST'
        data: comment
        success: (results)->
            console.log 'result' + results, comment
            renderComment comment, true

clickToLoadMore = ->
    $loadMore.on "click", (event)->
        event.preventDefault()
        loadComments comments.length

if not config.testing then initApp()

module.exports = {initApp, loadComments, comments}
