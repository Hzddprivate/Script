repeat task.wait() until game:IsLoaded()
_G.WebhookLink = "https://discord.com/api/webhooks/1420746655820681216/zV6UA7Gcddtr2k4Pycku89W571UNs5FY64hmtIk4mTGkkPw_yRUnCSU5FydVfCco_5BY"
_G.OPFarmGem = true

_G.Class = {
    Enabled = true,
    Target = "Cyborg" -- Class Name or Target = {"Gambler" , "Cyborg"}
}

_G.LockDiamond = {
    Enabled = true,
    Amount = 1000, -- 1000,2000,3000
    SendWebhook = {
        Enabled = true,
        WebhookLink = "https://discord.com/api/webhooks/1420746655820681216/zV6UA7Gcddtr2k4Pycku89W571UNs5FY64hmtIk4mTGkkPw_yRUnCSU5FydVfCco_5BY",
        Message = "Reached Target", 
    }
}
loadstring(game:HttpGet("https://raw.githubusercontent.com/NAVAAI098/Thunder-Hub/main/Kaitun.lua"))()
