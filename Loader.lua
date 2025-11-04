repeat task.wait() until game:IsLoaded()

local GameId = game.GameId

local GameList = {
    [994732206]      = { "Blox%20Fruits/Loader.lua", "Blox%20Fruits/Horst.lua" },
    [7326934954]     = { "99N/Loader.lua", "99N/Horst.lua" },
    [79546208627805] = { "99N/Loader.lua", "99N/Horst.lua" },
}

local BASE = "https://raw.githubusercontent.com/Hzddprivate/Script/main/%s"
local scripts = GameList[GameId]

if not scripts then
    warn("No scripts mapped for GameId: " .. tostring(GameId))
    return
end

-- รองรับกรณีเผื่อใส่มาเป็นสตริงเดียว
if type(scripts) == "string" then scripts = { scripts } end

-- ===== ทางเลือก A: รันเรียงลำดับ =====
for _, path in ipairs(scripts) do
    local ok, err = pcall(function()
        local src = game:HttpGet(BASE:format(path))
        local fn  = loadstring(src)
        if fn then fn() end
    end)
    if not ok then
        warn(("[sequential] Failed to run %s: %s"):format(path, tostring(err)))
    end
end
