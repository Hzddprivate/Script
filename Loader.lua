repeat task.wait() until game:IsLoaded()

local GameId = game.GameId

local GameList = {
    [994732206] = {"Blox%20Fruits/Loader.lua", "Blox%20Fruits/Horst.lua"},
    [7326934954] = {"99N/Loader.lua", "99N/Horst.lua"},
    [79546208627805] = {"99N/Loader.lua", "99N/Horst.lua"},
}

local BASE = "https://raw.githubusercontent.com/Hzddprivate/Script/main/%s"
local scripts = GameList[GameId]

if scripts then
    for _, path in ipairs(scripts) do
        local ok, err = pcall(function()
            loadstring(game:HttpGet(BASE:format(path)))()
        end)
        if not ok then
            warn(("Failed to run %s: %s"):format(path, tostring(err)))
        end
    end
else
    warn("No scripts mapped for GameId: " .. tostring(GameId))
end
