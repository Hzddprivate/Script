repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.Players
repeat task.wait() until game.Players.LocalPlayer
repeat task.wait() until game.Players.LocalPlayer:FindFirstChild("PlayerGui")
setfpscap(15)
Config = {
    Team = "Pirates",
    Configuration = {
        HopWhenIdle = true,
        AutoHop = true,
        AutoHopDelay = 60 * 60,
        FpsBoost = true
    },
    Items = {

        -- Melees 
        AutoFullyMelees = true,

        -- Swords 
        Saber = true,
        CursedDualKatana = true,

        -- Guns 
        SoulGuitar = false,

        -- Upgrades 

        RaceV2 = true

    },
    Settings = {
        StayInSea2UntilHaveDarkFragments = false
    }
}


loadstring(game:HttpGet("https://raw.githubusercontent.com/sikmaduck/sikmaduck/refs/heads/main/god"))()
