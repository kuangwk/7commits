posts = []

for i in [1..10]
    post = 
        _id: "134314#{i}"
        content: "#{i}-FUCKYOU cotnent fuck you everyday." 
        createTime: "2014-04-#{i}",
        editTime: "2014-09-#{i}",
        creator: {
            name: "Lucy-#{i}",
            avatar: "/assets/images/avatar.jpg"
        }
        tags: ["Fuck-#{i}", "You-#{i}"]
        comments: [1..i]
        title: "#{i} - This is my First Post!"

    posts.push post

exports.currentPage = 50
exports.totalCount = 100
exports.prefix = "/posts/"
exports.posts = posts