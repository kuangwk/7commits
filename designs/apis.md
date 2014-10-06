## Views:
* 首页：
    - / => home.jade
    - Data: {/*TODO*/}
* 所有博文列表：
    - /posts/<Number:page> => list.jade
    - Data: {/*TODO*/}
* 标签搜索博文：
    - /posts/tag/<String:Tag>/<Number:page> => list.jade
    - Data: {/*TODO*/}
* 关键字搜索博文：
    - /posts/search/<String:filter(Tag, Keyword, Creator)>/<Number:page> => list.jade
    - Data: {/*TODO*/}
* 博文详细页：
    - /post-detail/<Id:PostId> => post-detail.jade
    - Data: {/*TODO*/}
* 编辑博文：
    - /post-edit/<Id:PostId> => post-edit.jade
    - Data: {/*TODO*/}
* 新建博文：
    - /post-create => post-edit.jade
    - Data: {/*TODO*/}
* 成员详细介绍：
    - /members/<Id:MemberId> => member-detail.jade
    - Data: {/*TODO*/}
* 成员登陆：
    - /admin => (not login) admin-login.jade
             => (login) admin-dashboard.jade
    - Data: {/*TODO*/}
* 关于：
    - /about => about.jade
    - Data: {/*TODO*/}

## RESTful JSON APIs(Ajax):
* 新增评论：
    - POST /comments
    - Data: {email, name, content [comment_id]} // 如果是回复性的评论，需要提供要回复的comment的id
    - Responses:
        + 200: {result: "success"}
        + 400: {result: "fail", msg: "email|name|content is not correct"}
* 加载更多评论： 
    - GET /comments/<Number:start>/<Number:limit>
    - Data: {}
    - Responses:
        + 200: [{email, name, content, createTime}]
* 成员登陆：
    - POST /login
    - Data: {name, password}
    - Responses:
        + 200: {result: "success"}
        + 404: {result: "fail", msg: "User is not found."}
        + 400: {result: "fail", msg: "Password is not correct."}
* 新建博文
    - POST /posts
    - Data: {title, content, tags}
    - Responses:
        + 200: {id}
        + 400: {result: "fail", msg: "Title|Content|Tags is not correct."}
* 删除博文
    - DELETE /posts/<String:postId>
    - Data: {}
    - Responses:
        + 200: {result: "success"}
        + 404: {result: "fail", msg: "Post is not found."}
* 修改博文
    - PUT /posts/<String:postId>
    - Data: {content, title, tags}
    - Responses:
        + 200: {result: "success"}
        + 400: {result: "fail", msg: "Title|Content|Tags is not correct."}
        + 404: {result: "fail", msg: "Post is not found."}
* 新增成员
    - POST /members
    - Data: {name, password, avatar, email, signature, introdution, isAdmin, showMember}
    - Responses:
        + 200: {id}
        + 400: {result: "fail", msg: "Name|Password|email is not correct."}
        + 409: {result: "fail", msg: "Username is existed."}
* 删除成员
    - DELETE /members/<String:memberId>
    - Data: {}
    - Responses:
        + 200: {result: "fail"}
        + 404: {result: "fail", msg: "User is not found."}
* 修改成员
    - PUT /members/<String:memberId>
    - Data: {name, password, avatar, email, signature, introdution, isAdmin, showMember}
    - Responses:
        + 200: {result: "success"}
        + 400: {result: "fail", msg: "Name|Password|email is not correct."}
        + 409: {result: "fail", msg: "Username is existed."}
* 修改团队介绍
    - PUT /team
    - Data: {introduction, shortIntroduction}
    - Responses:
        + 200: {result: "success"}
