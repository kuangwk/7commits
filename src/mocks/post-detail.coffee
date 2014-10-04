marked = require "marked"
content = marked """
## First Title

* first
* two 
* three

License & Log
All parts of Skeleton are free to use and abuse under the open-source MIT license. The full licensing language can be found here: http://www.opensource.org/licenses/mit-license.php. More importantly, I would love to have a small community of contributors to Skeleton, so please feel free to jump over the Skeleton Github page and contribute to make Skeleton a better boilerplate for everyone!

A brief log of the history of Skeleton

V1.0.0 (5/15/2011): Initial release of Skeleton.
V1.0.1 (5/19/2011): Made some quick changes based on input from Github and fellow designers.
Refined the app.js to make faster and cleaner
Added Apple touch icons
Removed some bloated CSS lines from the base.css
Added an :active button class
Changed Skeleton favicon
Added MIT licensing

[shit baidu](http://www.baidu.com)
"""
post = {
    creator: {
        name: "Lucy"
        _id: "90-3143"
        avatar: "/assets/images/avatar.jpg"
    }
    title: "The every first post!!"
    createTime: "2014-05-03"
    editTime: "2014-09-24"
    content: content
    comments: [
        {name: "Jerry", content: "This is every good! I love it!!", createTime: "2014-09-23"}
        {name: "Harry", content: "No, this sucks. There flaws everywhere.", createTime: "2014-08-09"}
    ]
    commentsCount: 100
    tags: ["hot", "girl"]
}

exports.post = post
