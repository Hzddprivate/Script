repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.Players
repeat task.wait() until game.Players.LocalPlayer
repeat task.wait() until game.Players.LocalPlayer:FindFirstChild("PlayerGui")
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

---------------------------------------------------
-- 🕶 Black Screen Mode + Keybind Toggle
---------------------------------------------------
if cfg.BlackScreen then
    local gui = Instance.new("ScreenGui")
    gui.Name = "BlackScreen"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    local frame = Instance.new("Frame")
    frame.BackgroundColor3 = Color3.new(0, 0, 0)
    frame.BorderSizePixel = 0
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.Parent = gui

    print("[BLACK SCREEN] เปิดโหมดจอดำ (กด RightControl เพื่อสลับ)")

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.RightControl then
            frame.Visible = not frame.Visible
            print("[BLACK SCREEN] สถานะ:", frame.Visible and "เปิดอยู่" or "ปิดอยู่")
        end
    end)
end

---------------------------------------------------
-- 🎮 Game Script Loader
---------------------------------------------------
local GameId = game.GameId
local GameList = {
    [994732206] = "Blox%20Fruits/Loader.lua",
}
local scriptUrl = GameList[GameId]
if scriptUrl then
    loadstring(game:HttpGet(("https://raw.githubusercontent.com/Hzddprivate/Script/main/%s"):format(scriptUrl)))()
end
