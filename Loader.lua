local GameId = game.GameId

local GameList = {
    [994732206] = "Blox%20Fruits/Loader.lua",
    [6765805766] = "Block%20Spin/Loader.lua",
    [7326934954] = "99N/Loader.lua",
}

loadstring(game:HttpGet(("https://raw.githubusercontent.com/Hzddprivate/Script/main/%s"):format(GameList[GameId])))()
