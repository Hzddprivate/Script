----------------------------------------------------------------------------------------------------------
[{ MARU HUB }]
----------------------------------------------------------------------------------------------------------
repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.Players
repeat task.wait() until game.Players.LocalPlayer
repeat task.wait() until game.Players.LocalPlayer:FindFirstChild("PlayerGui")
_G.Team = "Pirate" -- Marine / Pirate
getgenv().Script_Mode = "Kaitun_Script"
_G.MainSettings = {
    ["EnabledHOP"] = true,
    ['FPSBOOST'] = true,
    ["FPSLOCKAMOUNT"] = 15,
    ['WhiteScreen'] = false,
    ['CloseUI'] = false,
    ["NotifycationExPRemove"] = true,
    ['AFKCheck'] = 150,
    ["LockFragments"] = 50000,
    ["LockFruitsRaid"] = {
        [1] = "Tiger-Tiger",
        [2] = "Kitsune-Kitsune",
        [3] = "Dragon-Dragon",
        [4] = "Yeti-Yeti",
        [5] = "Gas-Gas",
        [6] = "Dough-Dough",
        [7] = "Buddha-Buddha",
        [8] = "Spirit-Spirit",
    },
    }
}
_G.SharkAnchor_Settings = {
    ["Enabled_Farm"] = false,
    ['FarmAfterMoney'] = 2500000
}
_G.Quests_Settings = {        
    ['Rainbow_Haki'] = true,
    ["MusketeerHat"] = true,
    ["PullLever"] = true,
    ['DoughQuests_Mirror'] = {
        ['Enabled'] = true,
        ['UseFruits'] = true
    }        
}
_G.Races_Settings = {
    ['Race'] = {
        ['EnabledEvo'] = true,
        ["v2"] = true,
        ["v3"] = true,
        ["Races_Lock"] = {
            ["Races"] = {
                ["Mink"] = true,
                ["Human"] = true,
                ["Fishman"] = true
            },
            ["RerollsWhenFragments"] = 20000
        }
    }
}
_G.Fruits_Settings = {
    ['Main_Fruits'] = {'Dough-Dough', 'Buddha-Buddha'},
    ['Select_Fruits'] = {"Light-Light", "Dark-Dark", "Magma-Magma"}
}
_G.Settings_Melee = {
    ['Superhuman'] = true,
    ['DeathStep'] = true,
    ['SharkmanKarate'] = true,
    ['ElectricClaw'] = true,
    ['DragonTalon'] = true,
    ['Godhuman'] = true
}
_G.SwordSettings = {
    ['Saber'] = true,
    ["Pole"] = true,
    ['MidnightBlade'] = true,
    ['Shisui'] = true,
    ['Saddi'] = false,
    ['Wando'] = false,
    ['Yama'] = true,
    ['Rengoku'] = true,
    ['Canvander'] = true,
    ['BuddySword'] = true,
    ['TwinHooks'] = true,
    ['HallowScryte'] = true,
    ['TrueTripleKatana'] = false,
    ['CursedDualKatana'] = true
}
_G.GunSettings = {
    ['Kabucha'] = true,
    ['SerpentBow'] = true,
    ['SoulGuitar'] = false
}
_G.FarmMastery_Settings = {
    ['Melee'] = true,
    ['Sword'] = true,
    ['DevilFruits'] = true,
    ['Select_Swords'] = {
        ["AutoSettings"] = true,
        ["ManualSettings"] = {
            "Saber",
            "Buddy Sword"
        }
    }
}
_G.Hop_Settings = {
    ["Find Tushita"] = true
}
(getgenv()).key = "MARU0RMFMYMFPXOI6YYZUNUM";
(getgenv()).id = "878872687286571018";
loadstring(game:HttpGet("https://raw.githubusercontent.com/xshiba/MaruComkak/main/PCBit.lua"))()


----------------------------------------------------------------------------------------------------------
[{ QUARTYZ HUB }]
----------------------------------------------------------------------------------------------------------
getgenv().Mode = "OneClick"
getgenv().Setting = {
    ["Team"] = "Pirates", -- Options "Pirates", "Marines"
    ["FucusOnLevel"] = true,
    ["Fruits"] = {  -- setting for fruits u want
        ["Primary"] = { -- if current fruit is not in this list, eat/buy
            "Dough-Dough",
            "Tiger-Tiger",
            "Kitsune-Kitsune",
            "Dragon-Dragon",
            "Yeti-Yeti",
            "Gas-Gas",
            "Buddha-Buddha",
            "Spirit-Spirit",
            "Buddha-Buddha",
        },
        ["Normal"] = { -- it just a normal fruit list
            "Dark-Dark",
            "Light-Light",
            "Magma-Magma",
            -- u can configs add mores/remove and must end with , (comma symbol)
        }
        -- run this for get all fruit name `local t={};for _,v in pairs(game.ReplicatedStorage.Remotes.CommF_:InvokeServer("GetFruits"))do table.insert(t,v.Name)end;setclipboard(table.concat(t, "\n"))`
    },
    ["Lock Fruits"] = { -- don't use or eat fruits in this list
        "Tiger-Tiger",
        "Kitsune-Kitsune",
        "Dragon-Dragon",
        "Yeti-Yeti",
        "Gas-Gas",
        "Dough-Dough",
        "Buddha-Buddha",
        "Spirit-Spirit"
    },
    ["IdleCheck"] = 150, -- every (x) seconds if not moving rejoin
};

loadstring(game:HttpGet("https://raw.githubusercontent.com/xQuartyx/QuartyzScript/main/Loader.lua"))()
