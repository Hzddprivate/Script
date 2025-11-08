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

if Setting and Setting["Auto Active Race V3"] then
    --// Services
    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")

    --// Locals
    local player  = Players.LocalPlayer
    local Remotes = ReplicatedStorage:WaitForChild("Remotes")
    local CommE   = Remotes:WaitForChild("CommE")

    --// Tunables (ปรับได้ตามเครื่อง/เซิร์ฟเวอร์)
    local BASE_TICK       = 0.75   -- จังหวะเช็กปกติ (ยิ่งมากยิ่งเบา)
    local MAX_TICK        = 2.00   -- เพดานการนอนสูงสุด (เวลาคูลดาวน์ยาว)
    local FIRE_THROTTLE   = 1.25   -- เวลาขั้นต่ำระหว่างการยิงซ้ำ (กันสแปม)
    local SAFETY_COOLDOWN = 2.00   -- กันช้ำหลังยิง (เผื่อ latency/UI)

    --// State
    local lastFire, manualCooldownUntil = 0, 0
    local currentChar = player.Character

    -- อัปเดต currentChar และรีเซ็ตสถานะเมื่อรีส폰
    player.CharacterAdded:Connect(function(c)
        currentChar = c
        lastFire, manualCooldownUntil = 0, 0
    end)

    -- ชื่อแอททริบิวต์ที่จะอ่าน (ULTRA-STRICT: Attributes only)
    local ACTIVE_ATTR_NAMES    = {"Active","Activated","IsActive","Running"}
    local CD_LEFT_ATTR_NAMES   = {"Cooldown","CoolDown","CD","RaceCooldown","RaceCD"}       -- จำนวนวิที่เหลือ
    local CD_UNTIL_ATTR_NAMES  = {"CooldownUntil","NextUseAt","NextUse","ReadyAt"}          -- เวลาเป้าหมาย (timestamp)

    --// Helpers (ไม่แตะ BoolValue/NumberValue; อ่านเฉพาะ Attribute)
    local function getHumanoid(c)
        return c and c:FindFirstChildOfClass("Humanoid")
    end

    local function isAlive(c)
        local h = getHumanoid(c)
        return h and h.Health > 0
    end

    local function getRaceObj(c)
        return c and c:FindFirstChild("RaceAbility")
    end

    local function isRaceActiveAttr(r)
        for _, n in ipairs(ACTIVE_ATTR_NAMES) do
            local ok, v = pcall(function() return r:GetAttribute(n) end)
            if ok and type(v) == "boolean" then
                return v
            end
        end
        return false
    end

    local function cooldownLeftAttr(r)
        -- คืนค่า "วินาทีที่เหลือ" ถ้าอ่านได้, ไม่งั้นคืน nil
        local now = os.clock()
        for _, n in ipairs(CD_LEFT_ATTR_NAMES) do
            local ok, v = pcall(function() return r:GetAttribute(n) end)
            if ok and type(v) == "number" and v > 0 then
                return v
            end
        end
        for _, n in ipairs(CD_UNTIL_ATTR_NAMES) do
            local ok, v = pcall(function() return r:GetAttribute(n) end)
            if ok and type(v) == "number" and v > now then
                return v - now
            end
        end
        -- กันช้ำฝั่งสคริปต์เอง
        if manualCooldownUntil > now then
            return manualCooldownUntil - now
        end
        return nil
    end

    local function canActivate(c, r)
        if not isAlive(c) then return false end
        if not r then return false end                 -- STRICT: ต้องมี RaceAbility
        if isRaceActiveAttr(r) then return false end   -- STRICT: อ่านเฉพาะ Attribute
        local cdLeft = cooldownLeftAttr(r)
        if cdLeft and cdLeft > 0 then return false end -- STRICT: อ่านเฉพาะ Attribute
        if (os.clock() - lastFire) < FIRE_THROTTLE then return false end
        return true
    end

    local function activate()
        lastFire = os.clock()
        CommE:FireServer("ActivateAbility")
        manualCooldownUntil = os.clock() + SAFETY_COOLDOWN
    end

    --// Main loop: ULTRA-LIGHT (Adaptive Sleep)
    task.spawn(function()
        while true do
            local sleepFor = BASE_TICK  -- ค่าเริ่มต้น: เบาเป็นหลัก
            pcall(function()
                local c = currentChar or player.Character
                local r = getRaceObj(c)

                if c and r then
                    -- ถ้ามีข้อมูลคูลดาวน์ ให้ "นอนตามเวลาที่เหลือ" (แต่ไม่เกิน MAX_TICK)
                    local cdLeft = cooldownLeftAttr(r)
                    if cdLeft and cdLeft > 0 then
                        sleepFor = math.clamp(cdLeft, BASE_TICK, MAX_TICK)
                    elseif canActivate(c, r) then
                        activate()
                        -- หลังยิงเสร็จ นอนยาว ๆ เพื่อลดภาระ (กันช้ำ)
                        sleepFor = SAFETY_COOLDOWN
                    else
                        -- กรณีเงื่อนไขยังไม่พร้อม แต่ไม่มีคูลดาวน์ชัดเจน
                        sleepFor = BASE_TICK
                    end
                else
                    -- ยังไม่มีตัวละครหรือยังไม่เจอ RaceAbility: ผ่อนเบา ๆ
                    sleepFor = math.max(1.0, BASE_TICK)
                end
            end)
            task.wait(sleepFor)
        end
    end)
end

