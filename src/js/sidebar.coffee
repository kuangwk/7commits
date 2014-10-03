$searchBtn = $("button.search")
$searchInput = $("input.search")

search = ->
    keyword = $searchInput.val()
    if not keyword
        return alert "不能为空"
    else
        window.location.href = "http://#{window.location.host}/search/#{keyword}"

$searchInput.on "keydown", (event)->        
    ENTER_KEY = 13
    if event.keyCode is ENTER_KEY then search()
    
$searchBtn.click search
