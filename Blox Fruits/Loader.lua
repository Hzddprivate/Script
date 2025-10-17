getgenv().Mode = "OneClick"
getgenv().Setting = {
    ["Team"] = "Pirates",
    ["FucusOnLevel"] = true,
    ["Fruits"] = {  
        ["Primary"] = { 
            "Dough-Dough",
            "Dragon-Dragon",
        },
        ["Normal"] = { 
            "Dark-Dark",
            "Buddha-Buddha",
            "Quake-Quake",
            "Magma-Magma",
        }
    },
    ["Lock Fruits"] = { -- don't use or eat fruits in this list
        "Yeti-Yeti",
        "T-Rex-T-Rex",
        "Kitsune-Kitsune",
        "Leopard-Leopard",
        "Mammoth-Mammoth",
        "Dough-Dough",
        "Gas-Gas",
        "Spirit-Spirit",
        "Gravity-Gravity",
        "Venom-Venom"
    },
    ["IdleCheck"] = 150, -- every (x) seconds if not moving rejoin
};

loadstring(game:HttpGet("https://raw.githubusercontent.com/xQuartyx/QuartyzScript/main/Loader.lua"))()
