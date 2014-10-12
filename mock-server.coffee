express = require 'express'
app = express()

app.set 'views', './src/views'
app.set 'view engine', 'jade'

app.use express.static __dirname + '/bin'
app.use express.static __dirname

# mock data
indexMocks = require './src/mocks/index.coffee'
listMocks = require './src/mocks/list.coffee'
detailMocks = require './src/mocks/post-detail.coffee'
commentMocks = require './src/mocks/comments.coffee'
adminMocks = require './src/mocks/admin-dashboard.coffee'

# mock api
app.get '/', (req, res)->
    res.render 'index', indexMocks

# 所有博客列表
app.get '/posts', (req, res)->
    res.render 'list', listMocks

# 博客列表分页显示
app.get '/posts/:pageNum', (req, res)->
    res.render 'list', listMocks 

# 博客详细页面
app.get '/post-detail/:id', (req, res)->
    res.render 'post-detail', detailMocks

# 后台登录页面
isLogin = false 
app.get '/admin', (req, res)->
    if not isLogin 
        res.render 'admin-login', {title: 'admin-login'}
    else 
        res.render 'admin-dashboard', adminMocks

# post 编辑
app.get '/post-edit/:id', (req, res)->
    res.render 'post-edit', detailMocks

app.get '/post-create/', (req, res)->
    res.render 'post-edit'


# AJAX 

app.get '/comments/:from/:to', (req, res)->
    setTimeout ->
        res.send commentMocks
    , 1000

app.post '/comments/', (req, res)->
    res.send()

app.post '/members/session', (req, res)->
    isLogin = true
    res.send()

app.delete '/posts/:id', (req, res)->
    res.send()

app.put '/team', (req, res)->
    res.send()

app.listen 3000, ->
    console.log 'express server is working on port:3000 '
