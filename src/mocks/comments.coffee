comments = []

for i in [1..10]
    comment = 
        email: 'qq@qq.qq'
        name: "jjlong#{i}"
        content: 'well done!!'
        createTime : "2014-04-#{i}"
        isReply: false

    comments.push comment

module.exports = comments