repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.Players
repeat task.wait() until game.Players.LocalPlayer
repeat task.wait() until game.Players.LocalPlayer:FindFirstChild("PlayerGui")
setfpscap(15)
getgenv().Mode = "OneClick"
getgenv().Setting = {
    ["Team"] = "Pirates", -- Options "Pirates", "Marines"
    ["FucusOnLevel"] = true,
    ["Fruits"] = {  -- setting for fruits u want
        ["Primary"] = { -- if current fruit is not in this list, eat/buy
            "Dough-Dough",
            "Dragon-Dragon",
        },
        ["Normal"] = { -- it just a normal fruit list
            "Quake-Quake",
            "Dark-Dark",
            "Buddha-Buddha",
            "Magma-Magma",
            -- u can configs add mores/remove and must end with , (comma symbol)
        }
        -- run this for get all fruit name `local t={};for _,v in pairs(game.ReplicatedStorage.Remotes.CommF_:InvokeServer("GetFruits"))do table.insert(t,v.Name)end;setclipboard(table.concat(t, "\n"))`
    },
    ["Lock Fruits"] = { -- don't use or eat fruits in this list
        "Yeti-Yeti",
        "T-Rex-T-Rex",
        "Leopard-Leopard",
        "Spirit-Spirit",
        "Kitsune-Kitsune",
        "Venom-Venom",
        "Gas-Gas",
        "Mammoth-Mammoth",
    },
    ["IdleCheck"] = 150, -- every (x) seconds if not moving rejoin
};

loadstring(game:HttpGet("https://raw.githubusercontent.com/xQuartyx/QuartyzScript/main/Loader.lua"))()
