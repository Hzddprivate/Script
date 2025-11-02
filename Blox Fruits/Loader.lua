repeat wait() until game:IsLoaded() and game.Players.LocalPlayer
getgenv().Key = "24e26bff48554cdacae1f244"
    getgenv().SettingFarm = {
        ["Hide UI"] = false,
        ["Reset Teleport"] = {
            ["Enabled"] = true,
            ["Delay Reset"] = 3,
            ["Item Dont Reset"] = {
                ["Fruit"] = {
                    ["Enabled"] = true,
                    ["All Fruit"] = true, 
                    ["Select Fruit"] = {
                        ["Enabled"] = false,
                        ["Fruit"] = {},
                    },
                },
            },
        },
        ["White Screen"] = true,
        ["Lock Fps"] = {
            ["Enabled"] = true,
            ["FPS"] = 15,
        },
        ["Get Items"] = {
            ["Saber"] = true,
            ["Godhuman"] =  true,
            ["Skull Guitar"] = true,
            ["Mirror Fractal"] = true,
            ["Cursed Dual Katana"] = true,
            ["Upgrade Race V2-V3"] = true,
            ["Auto Pull Lever"] = true,
            ["Shark Anchor"] = false, --- if have cdk,sg,godhuman
        },
        ["Get Rare Items"] = {
            ["Rengoku"] = true,
            ["Dragon Trident"] = true, 
            ["Pole (1st Form)"] = true,
            ["Gravity Blade"]  = true,
        },
        ["Farm Fragments"] = {
            ["Enabled"]  = true,
            ["Fragment"] = 50000,
        },
        ["Auto Chat"] = {
            ["Enabled"] = false,
            ["Text"] = "",
        },
        ["Auto Summon Rip Indra"] = true, --- auto buy haki and craft haki legendary 
        ["Select Hop"] = { -- 70% will have it
            ["Hop Server If Have Player Near"] = false, 
            ["Hop Find Rip Indra Get Valkyrie Helm or Get Tushita"] = true, 
            ["Hop Find Dough King Get Mirror Fractal"] = true,
            ["Hop Find Raids Castle [CDK]"] = true,
            ["Hop Find Cake Queen [CDK]"] = true,
            ["Hop Find Soul Reaper [CDK]"] = true,
            ["Hop Find Darkbeard [SG]"] = true,
            ["Hop Find Mirage [ Pull Lever ]"] = false,
        },
        ["Farm Mastery"] = {
            ["Melee"] = true,
            ["Sword"] = true,
        },
        ["Buy Haki"] = {
            ["Enhancement"] = true,
            ["Skyjump"] = true,
            ["Flash Step"] = true,
            ["Observation"] = true,
        },
        ["Sniper Fruit Shop"] = {
            ["Enabled"] = true, -- Auto Buy Fruit in Shop Mirage and Normal
            ["Fruit"] = {"Tiger-Tiger","Dough-Dough","Spirit-Spirit","Kitsune-Kitsune","Dragon-Dragon","Yeti-Yeti","Gas-Gas","Buddha-Buddha"},
        },
        ["Lock Fruit"] = {"Tiger-Tiger","Dough-Dough","Spirit-Spirit","Kitsune-Kitsune","Dragon-Dragon","Yeti-Yeti","Gas-Gas"},
        ["Webhook"] = {
            ["Enabled"] = false,
            ["WebhookUrl"] = "https://discord.com/api/webhooks/1420746655820681216/zV6UA7Gcddtr2k4Pycku89W571UNs5FY64hmtIk4mTGkkPw_yRUnCSU5FydVfCco_5BY",
        }
    }
loadstring(game:HttpGet("https://raw.githubusercontent.com/obiiyeuem/vthangsitink/main/BananaCat-kaitunBF.lua"))()
