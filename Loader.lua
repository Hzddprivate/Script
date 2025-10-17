local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local Config = _G.Config or {}

----------------------------------------------------
-- 💨 FPS BOOST FUNCTION
----------------------------------------------------
local function FpsBoost()
	for _, v in pairs(Lighting:GetChildren()) do
		if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") then
			v:Destroy()
		end
	end

	sethiddenproperty(Lighting, "Technology", Enum.Technology.Compatibility)

	Lighting.GlobalShadows = false
	Lighting.FogEnd = 1e10
	Lighting.Brightness = 0

	local function simplify(obj)
		for _, child in ipairs(obj:GetDescendants()) do
			if child:IsA("BasePart") then
				child.Material = Enum.Material.Plastic
				child.Reflectance = 0
			elseif child:IsA("Decal") or child:IsA("Texture") then
				child:Destroy()
			elseif child:IsA("ParticleEmitter") or child:IsA("Trail") then
				child:Destroy()
			end
		end
	end

	for _, obj in pairs(workspace:GetChildren()) do
		simplify(obj)
	end
end

----------------------------------------------------
-- 🖤 BLACK SCREEN TOGGLE GUI FUNCTION
----------------------------------------------------
local blackScreenEnabled = false
local screenGui

local function CreateBlackScreen()
	screenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
	screenGui.Name = "BlackScreenOverlay"
	screenGui.ResetOnSpawn = false

	local frame = Instance.new("Frame", screenGui)
	frame.Name = "BlackFrame"
	frame.Size = UDim2.new(1, 0, 1, 0)
	frame.BackgroundColor3 = Color3.new(0, 0, 0)
	frame.BorderSizePixel = 0
	frame.Visible = true
end

local function ToggleBlackScreen()
	if not screenGui or not screenGui:FindFirstChild("BlackFrame") then return end
	local frame = screenGui:FindFirstChild("BlackFrame")
	frame.Visible = not frame.Visible
	blackScreenEnabled = frame.Visible
end

local function CreateToggleButton()
	local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
	gui.Name = "BlackScreenToggle"
	gui.ResetOnSpawn = false

	local button = Instance.new("TextButton", gui)
	button.Size = UDim2.new(0, 120, 0, 40)
	button.Position = UDim2.new(0, 10, 0, 10)
	button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	button.TextColor3 = Color3.new(1, 1, 1)
	button.Text = "Black Screen: ON"
	button.Font = Enum.Font.SourceSansBold
	button.TextSize = 14

	button.MouseButton1Click:Connect(function()
		ToggleBlackScreen()
		button.Text = "Black Screen: " .. (blackScreenEnabled and "ON" or "OFF")
	end)
end

local function BlackScreenToggleSystem()
	CreateBlackScreen()
	CreateToggleButton()
	blackScreenEnabled = true
end

----------------------------------------------------
-- 👥 NEARBY PLAYER HOP FUNCTION
----------------------------------------------------
local previousServers = {}
local trackingTime = 0
local checkInterval = 1
local hopThreshold = 90
local nearbyRadius = 50

local function GetNearbyPlayers(radius)
	local count = 0
	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			local dist = (player.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
			if dist <= radius then
				count += 1
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
				TeleportService:TeleportToPlaceInstance(PlaceId, server.id, LocalPlayer)
				return
			end
		end
	end
end

local function StartNearbyPlayerCheck()
	task.spawn(function()
		while true do
			task.wait(checkInterval)
			if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
				continue
			end

			local nearby = GetNearbyPlayers(nearbyRadius)
			if nearby > 0 then
				trackingTime += checkInterval
			else
				trackingTime = 0
			end

			if trackingTime >= hopThreshold then
				warn("[HOP] พบผู้เล่นใกล้เคียงนานเกินกำหนด กำลังย้ายเซิร์ฟเวอร์...")
				HopToNewServer()
			end
		end
	end)
end

----------------------------------------------------
-- 🔁 เรียกใช้ฟีเจอร์ตาม Config
----------------------------------------------------

if Config.FpsBoost then
	FpsBoost()
end

if Config.BlackScreen then
	BlackScreenToggleSystem()
end

if Config.NearbyPlayersHop then
	StartNearbyPlayerCheck()
end

local GameList = {
    [994732206] = "Blox%20Fruits/Loader.lua",  -- Example Game ID
}

local GameId = game.GameId
local scriptPath = GameList[GameId]

if scriptPath then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Hzddprivate/Script/main/" .. scriptPath))()
else
    warn("[Loader] ❌ GameId not found in GameList: " .. tostring(GameId))
end
