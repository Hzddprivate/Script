-- Roblox Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local RunService = game:GetService("RunService")

-- Config
local NearbyRadius = 50
local HopThreshold = 90 -- วินาที
local CheckInterval = 1

-- ระบบ hop
local previousServers = {}
local trackingTime = 0

-- ฟังก์ชัน: ตรวจจับผู้เล่นใกล้
local function GetNearbyPlayers(radius)
	local count = 0
	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			local distance = (player.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
			if distance <= radius then
				count += 1
			end
		end
	end
	return count
end

-- ฟังก์ชัน: Hop Server (ข้าม server ที่อยู่ใน previousServers)
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
					table.remove(previousServers, 1) -- จำกัดไว้ที่ 100 เซิร์ฟเวอร์ล่าสุด
				end
				TeleportService:TeleportToPlaceInstance(PlaceId, server.id, LocalPlayer)
				return
			end
		end
	end
end

-- เริ่มทำงานหากเปิดใช้งาน
if _G.NearbyPlayersHop then
	task.spawn(function()
		while true do
			task.wait(CheckInterval)

			-- ตรวจสอบตัวละครก่อน
			if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
				continue
			end

			local nearby = GetNearbyPlayers(NearbyRadius)
			if nearby > 0 then
				trackingTime += CheckInterval
			else
				trackingTime = 0
			end

			if trackingTime >= HopThreshold then
				warn("[HOP] พบผู้เล่นใกล้เคียงนานเกินกำหนด กำลังย้ายเซิร์ฟเวอร์...")
				HopToNewServer()
			end
		end
	end)
end
local GameId = game.GameId

local GameList = {
    [994732206] = "Blox%20Fruits/Loader.lua",
}

loadstring(game:HttpGet(("https://raw.githubusercontent.com/Hzddprivate/Script/main/%s"):format(GameList[GameId])))()
