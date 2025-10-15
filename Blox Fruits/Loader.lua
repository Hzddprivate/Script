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
