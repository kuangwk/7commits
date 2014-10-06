express = require 'express'
app = express()

app.set 'views', './src/views'
app.set 'view engine', 'jade'

app.use express.static __dirname + '/bin'
app.use express.static __dirname

app.get '/', (req, res)->
    mocks = require './src/mocks/index.coffee'
    res.render 'index', mocks

app.get '/posts', (req, res)->
    mocks = require './src/mocks/list.coffee'
    res.render 'list', mocks

app.listen 3000, ->
    console.log 'express server is working on port:3000 '
