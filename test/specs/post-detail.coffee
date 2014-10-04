postDetail = require "../../src/js/post-detail.coffee"
postDetailMocks = require "../../src/mocks/post-detail.coffee"

describe "Test post detail page interaction", ->
    app = null
    server = null
    mockCmts = postDetailMocks.post.comments

    before ->
        $("#comments-wrapper").remove()
        $("body").append "<div id='comments-wrapper'><ul></ul> <div class='load-more'><a></a></div></div>"
        server = sinon.fakeServer.create()
        comments = JSON.stringify(mockCmts) 
        server.respondWith "GET", /\/comments\/\d\/\d/, [200, { "Content-Type": "application/json" }, comments]
        app = postDetail.initApp()
        server.respond()

    after -> 
        server.restore()

    it "Ajax Load comments", (done)->
        callback = sinon.spy()
        postDetail.loadComments 0, callback
        server.respond()
        callback.should.have.been.calledWith mockCmts
        done()

    it "Load comments and change dom", (done)->
        previousCount = postDetail.comments.length
        previousDomCount = $("#comments-wrapper").find("li").size()
        postDetail.loadComments 0, ->
            postDetail.comments.length.should.equal previousCount + mockCmts.length
            $("#comments-wrapper").find("li").size().should.equal previousDomCount + mockCmts.length
            done()
        server.respond()
