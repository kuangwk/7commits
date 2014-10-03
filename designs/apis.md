## Views:
* / => home

* /posts/<Number:page> => list.jade
* /posts/tag/<String:Tag>/<Number:page> => list.jade
* /posts/search/<String:filter(Tag, Keyword, Creator)>/<Number:page> => list.jade

* /post-detail/<Id:PostId> => post-detail.jade
* /post-edit/<Id:PostId> => post-edit.jade
* /post-create => post-edit.jade
* /user-detail/<Id:MemberId> => member-detail.jade

* /admin => (not login) admin-login.jade
         => (login) admin-dashboard.jade

## RESTful JSON APIs(Ajax):
* 新增评论：
    - POST /comments
    - Data: {email, name, content}
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
