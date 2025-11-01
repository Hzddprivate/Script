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
    ['WhiteScreen'] = true,
    ['CloseUI'] = true,
    ["NotifycationExPRemove"] = true,
    ['AFKCheck'] = 150,
    ["LockFragments"] = 35000,
    ["LockFruitsRaid"] = {
        [1] = "Dough-Dough",
        [2] = "Dragon-Dragon", 
        [3] = "Yeti-Yeti",
        [4] = "Kitsune-Kitsune",
        [5] = "Gas-Gas",
        [6] = "Spirit-Spirit",
        [7] = "Tiger-Tiger",
        [8] = "Venom-Venom",
        [9] = "Leopard-Leopard",
        [10] = "Mammoth-Mammoth",
        [11] = "T-Rex-T-Rex",
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
    ['Select_Fruits'] = {"Quake-Quake", "Light-Light", "Dark-Dark", "Magma-Magma"}
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
    ['MidnightBlade'] = false,
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
