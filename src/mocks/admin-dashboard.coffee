posts = require('./list.coffee').posts

team = 
    introduce: '这个是长的介绍'
    shortIntroduce: '这个是短的介绍'

members = require('./members.coffee').members

userInfo = 
    name: 'weike'
    isAdmin: true

module.exports = {posts, team, members, userInfo}

