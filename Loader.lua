local GameId = game.GameId

local GameList = {
    [994732206] = "Blox%20Fruits/Loader.lua",
}

loadstring(game:HttpGet(("https://raw.githubusercontent.com/Hzddprivate/Script/main/%s"):format(GameList[GameId])))()
