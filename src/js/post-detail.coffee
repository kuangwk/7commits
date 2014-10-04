handlebars = require "handlebars"
config = require "./modules/config.coffee"
commentTpl = require "../tpl/comment.tpl"

$loadMore = null
$comments = null
comments = []

LIMIT = 10
commentCompiler = handlebars.compile commentTpl
isLoading = no

initApp = ->
    comments.length = 0
    $loadMore = $("div.load-more a")
    $comments = $("#comments-wrapper ul")
    loadComments(comments.length)
    clickToLoadMore()

loadComments = (start, callback)->
    if isLoading then return
    isLoading = yes
    $.ajax 
        url: "/comments/#{start}/#{LIMIT}"
        type: "GET"
        success: (results)->
            isLoading = no
            for comment in results
                comments.push comment
                renderComment comment
            callback?results

renderComment = (comment)->
    $comments.append commentCompiler(comment)

clickToLoadMore = ->
    $loadMore.on "click", (event)->
        event.preventDefault()
        loadComments comments.length

if not config.testing then initApp()

module.exports = {initApp, loadComments, comments}
