-- ====== Loader.lua ======
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local cfg = _G.Config or {}

---------------------------------------------------
-- 🔁 Auto Rejoin System
---------------------------------------------------
local function AutoRejoin()
	task.wait(5)
	warn("[AUTO REJOIN] กำลังเข้าซ้ำ...")
	TeleportService:Teleport(game.PlaceId, LocalPlayer)
end

TeleportService.TeleportInitFailed:Connect(function(player, result, reason)
	warn("[TELEPORT FAIL]", result, reason)
	AutoRejoin()
end)

---------------------------------------------------
-- 🧠 NearbyPlayersHop System
---------------------------------------------------
if cfg.NearbyPlayersHop then
    local NearbyRadius = 50
    local HopThreshold = 90
    local CheckInterval = 1

    local previousServers = {}
    local trackingTime = 0

    local function GetNearbyPlayers(radius)
        local count = 0
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = player.Character.HumanoidRootPart
                local myhrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if myhrp then
                    local distance = (hrp.Position - myhrp.Position).Magnitude
                    if distance <= radius then
                        count += 1
                    end
                end
            end
        end
        return count
    end

    local function HopToNewServer()
        local PlaceId = game.PlaceId
        local success, result = pcall(function()
            return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
        end)
        if success and result and result.data then
            for _, server in pairs(result.data) do
                if server.playing < server.maxPlayers and server.id ~= game.JobId and not table.find(previousServers, server.id) then
                    table.insert(previousServers, server.id)
                    if #previousServers > 100 then
                        table.remove(previousServers, 1)
                    end
                    warn("[HOP] กำลังย้ายไปเซิร์ฟใหม่...")
                    local ok = pcall(function()
                        TeleportService:TeleportToPlaceInstance(PlaceId, server.id, LocalPlayer)
                    end)
                    if not ok then
                        AutoRejoin()
                    end
                    return
                end
            end
        else
            AutoRejoin()
        end
    end

    task.spawn(function()
        while task.wait(CheckInterval) do
            if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then continue end
            local nearby = GetNearbyPlayers(NearbyRadius)
            trackingTime = (nearby > 0) and (trackingTime + CheckInterval) or 0
            if trackingTime >= HopThreshold then
                HopToNewServer()
            end
        end
    end)
end

---------------------------------------------------
-- 🚀 FPS Boost
---------------------------------------------------
if cfg.FpsBoost then
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    game.Lighting.GlobalShadows = false
    game.Lighting.FogEnd = 9e9

    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            obj.Material = Enum.Material.Plastic
            obj.Reflectance = 0
        elseif obj:IsA("Decal") or obj:IsA("Texture") then
            obj.Transparency = 1
        elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
            obj.Enabled = false
        end
    end

    for _, effect in pairs(game.Lighting:GetChildren()) do
        if effect:IsA("BloomEffect") or effect:IsA("ColorCorrectionEffect") or effect:IsA("SunRaysEffect") then
            effect.Enabled = false
        end
    end

    print("[FPS BOOST] ลดกราฟิกเพื่อเพิ่มความลื่นเรียบร้อย")
end

local GameId = game.GameId

local GameList = {
    [994732206] = "Blox%20Fruits/Loader.lua",
    [6765805766] = "Block%20Spin/Loader.lua",
}

local scriptPath = GameList[GameId]
if scriptPath then
    warn(("[LOADER] กำลังโหลดสคริปต์สำหรับ Game ID: %d"):format(GameId))
    local success, result = pcall(function()
        return game:HttpGet(("https://raw.githubusercontent.com/Hzddprivate/Script/main/%s"):format(scriptPath))
    end)

    if success and result then
        local ok, err = pcall(function()
            loadstring(result)()
        end)
        if ok then
            warn("[LOADER] โหลดสำเร็จ ✅")
        else
            warn("[LOADER ERROR] โหลดสคริปต์ไม่สำเร็จ:", err)
        end
    else
        warn("[LOADER ERROR] ไม่สามารถดาวน์โหลดไฟล์จาก GitHub:", result)
    end
else
    warn(("[LOADER] ไม่มีสคริปต์ที่จับคู่กับ Game ID %d"):format(GameId))
end
