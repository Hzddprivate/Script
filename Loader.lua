-- ====== Loader.lua ======
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local cfg = _G.Config or {}
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
