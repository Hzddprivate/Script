repeat wait() until game:IsLoaded() and game.Players.LocalPlayer
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
            "T-rex-T-rex",
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
        "Dough-Dough"
    },
    ["IdleCheck"] = 150, -- every (x) seconds if not moving rejoin
};

loadstring(game:HttpGet("https://raw.githubusercontent.com/xQuartyx/QuartyzScript/main/Loader.lua"))()
