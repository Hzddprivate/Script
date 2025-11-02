repeat wait() until game:IsLoaded() and game.Players.LocalPlayer
getgenv().Key = "24e26bff48554cdacae1f244"
    getgenv().SettingFarm ={
        ["Hide UI"] = false,
        ["Reset Teleport"] = {
            ["Enabled"] = true,
            ["Delay Reset"] = 0.5,
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
        ["White Screen"] = false,
        ["Lock Fps"] = {
            ["Enabled"] = false,
            ["FPS"] = 20,
        },
        ["Get Items"] = {
            ["Saber"] = true,
            ["Godhuman"] =  true,
            ["Skull Guitar"] = false,
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
            ["Hop Find Rip Indra Get Valkyrie Helm or Get Tushita"] = false, 
            ["Hop Find Dough King Get Mirror Fractal"] = false,
            ["Hop Find Raids Castle [CDK]"] = false,
            ["Hop Find Cake Queen [CDK]"] = false,
            ["Hop Find Soul Reaper [CDK]"] = true,
            ["Hop Find Darkbeard [SG]"] = false,
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
            ["Fruit"] = {"Tiger-Tiger","Kitsune-Kitsune","Dragon-Dragon","Yeti-Yeti","Gas-Gas","Dough-Dough","Buddha-Buddha","Spirit-Spirit"},
        },
        ["Lock Fruit"] = {"Tiger-Tiger","Kitsune-Kitsune","Dragon-Dragon","Yeti-Yeti","Gas-Gas","Dough-Dough","Buddha-Buddha","Spirit-Spirit"},
        ["Webhook"] = {
            ["Enabled"] = false,
            ["WebhookUrl"] = "",
        }
    }
loadstring(game:HttpGet("https://raw.githubusercontent.com/obiiyeuem/vthangsitink/main/BananaCat-kaitunBF.lua"))()
task.delay(6,function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/SkibidiHub111/BloxFruit/refs/heads/main/ConfigBanana"))()
end)
