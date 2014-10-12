posts = require('./list.coffee').posts

team = 
    introduction: '这个是长的介绍'
    shortIntroduction: '这个是短的介绍'

members = require('./members.coffee').members

userInfo = 
    name: 'weike'
    isAdmin: true

module.exports = {posts, team, members, userInfo}

