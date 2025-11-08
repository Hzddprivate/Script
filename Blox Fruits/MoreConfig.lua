-- ==== MoreConfig.lua ====

repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer
local Player = game.Players.LocalPlayer

-- โหลด SettingFarm
local Setting = getgenv().SettingFarm or {}

-- 🥋 AUTO BUSO HAKI
if Setting["Auto Buso"] then
    task.spawn(function()
        local function check()
            local c = Player.Character or Player.CharacterAdded:Wait()
            if not c:FindFirstChild("HasBuso") and not c:FindFirstChild("Buso") then
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso")
            end
        end
        Player.CharacterAdded:Connect(function()
            task.wait(2)
            check()
        end)
        while task.wait(5) do
            pcall(check)
        end
    end)
end

-- ⚔️ FAST / MULTIPLE ATTACK
if Setting["Multiple Attack"] then
    task.spawn(function()
        local FastAttack = {}

        local Modules = game.ReplicatedStorage:WaitForChild("Modules")
        local RE_Attack = Modules.Net:WaitForChild("RE/RegisterAttack")
        local RunHitDetection
        local HIT_FUNCTION

        -- โหลด CombatUtil
        task.defer(function()
            local success, Env = pcall(getsenv, game:GetService("ReplicatedStorage").Modules.CombatUtil)
            if success and Env then
                HIT_FUNCTION = Env._G.SendHitsToServer
            end
            local success2, module = pcall(require, Modules:WaitForChild("CombatUtil"))
            if success2 and module then
                RunHitDetection = module.RunHitDetection
            end
        end)

        function FastAttack:IsAlive(v)
            return v
                and not v:FindFirstChild("VehicleSeat")
                and v:FindFirstChild("Humanoid")
                and v.Humanoid.Health > 0
                and v:FindFirstChild("HumanoidRootPart")
        end

        function FastAttack:GetDistance(x, xx)
            return ((typeof(x) == "Vector3" and CFrame.new(x) or x).Position
            - (xx == nil and Player.Character.PrimaryPart
            or (typeof(xx) == "Vector3" and Vector3.new(xx) or xx)).Position).Magnitude
        end

        function FastAttack:GetHits()
            local Hits = {}
            for _, v in next, workspace.Enemies:GetChildren() do
                if self:IsAlive(v) and self:GetDistance(v.HumanoidRootPart.Position) <= 60 then
                    table.insert(Hits, v)
                end
            end
            return Hits
        end

        function FastAttack:GetRandomHitbox(v)
            local HitBox = {
                "RightLowerArm",
                "RightUpperArm",
                "LeftLowerArm",
                "LeftUpperArm",
                "RightHand",
                "LeftHand",
                "HumanoidRootPart",
                "Head"
            }
            return v:FindFirstChild(HitBox[math.random(1, #HitBox)]) or v.HumanoidRootPart
        end

        function FastAttack:SuperFastAttack()
            local BladeHits = self:GetHits()
            local realenemy
            if #BladeHits == 0 then return end
            local Args = {[1] = nil, [2] = {}}
            for _, v in next, BladeHits do
                if not Args[1] then
                    Args[1] = self:GetRandomHitbox(v)
                end
                Args[2][#Args[2] + 1] = {
                    [1] = v,
                    [2] = self:GetRandomHitbox(v)
                }
                realenemy = v
            end
            RE_Attack:FireServer(0)
            if HIT_FUNCTION then
                HIT_FUNCTION(unpack(Args))
            end
        end

        function FastAttack:RunHitboxFastAttack()
            local Tool = Player.Character and Player.Character:FindFirstChildOfClass("Tool")
            if not Tool then return end

            local success, hitResult = pcall(function()
                return RunHitDetection(Player.Character, Tool)
            end)
            
            if not success or not hitResult or type(hitResult) ~= "table" or #hitResult == 0 then
                return
            end

            local Args = {[1] = nil, [2] = {}}
            for _, target in ipairs(hitResult) do
                if self:IsAlive(target) then
                    local hitPart = self:GetRandomHitbox(target)
                    if not Args[1] then Args[1] = hitPart end
                    table.insert(Args[2], {target, hitPart})
                end
            end

            RE_Attack:FireServer(0)
            if HIT_FUNCTION then
                HIT_FUNCTION(unpack(Args))
            end
        end

        -- รันตีเร็วต่อเนื่อง
        while task.wait(0.005) do
            pcall(function()
                FastAttack:SuperFastAttack()
                FastAttack:RunHitboxFastAttack()
            end)
        end
    end)
end

-- 🧬 AUTO ACTIVATE RACE V3
if Setting["Auto Active Race V3"] then
    task.spawn(function()
        local Remote = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommE")
        local lastUsed = 0
        while task.wait(1) do
            pcall(function()
                local c = Player.Character or Player.CharacterAdded:Wait()
                if c:FindFirstChild("Humanoid") and c.Humanoid.Health > 0 then
                    if not c:FindFirstChild("RaceTransformed") and not c:FindFirstChild("Hyper") then
                        if tick() - lastUsed >= 30 then -- cooldown 30 วิ
                            Remote:FireServer("ActivateAbility")
                            lastUsed = tick()
                        end
                    end
                end
            end)
        end
    end)
end
