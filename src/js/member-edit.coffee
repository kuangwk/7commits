handlebars = require 'handlebars'
memberEditTpl = require '../tpl/member-add.tpl'

memberAddCompiler = handlebars.compile memberEditTpl

$editWrapper = $('div.member-edit-wrapper')

clickToAddMember = ->
    $addBtn = $('div.members-edit button.add')
    $addBtn.on 'click', (event)->
        console.log 'click'
        $editWrapper.empty()
        $editWrapper.append memberAddCompiler()

clickToAddMember()