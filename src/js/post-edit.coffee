handlebars = require 'handlebars'
config = require './modules/config.coffee'
commentEditTpl = require '../tpl/comment-edit.tpl'

$loading = $('img.comments-loading')
$loadMore = $("button.load-more a")
$comments = $("#comments-wrapper ul")
comments = []

LIMIT = 10
commentCompiler = handlebars.compile commentEditTpl
isLoading = no

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

clickToLoadMore = ->
    $loadMore.on "click", (event)->
        event.preventDefault()
        loadComments comments.length
initApp = ->
    loadComments()
    $loading.show()
    clickToLoadMore()

initApp()