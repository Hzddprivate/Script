repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.Players
repeat task.wait() until game.Players.LocalPlayer
repeat task.wait() until game.Players.LocalPlayer:FindFirstChild("PlayerGui")
_G.Team = "Pirate" -- Marine / Pirate
getgenv().Script_Mode = "Kaitun_Script"
_G.OneClickSettings = {
    ["LockFruits"] = {
        "Dough-Dough",
        "Dragon-Dragon",
        "Yeti-Yeti",
        "Kitsune-Kitsune",
        "Gas-Gas",
        "Spirit-Spirit",
        "Leopard-Leopard",
        "Venom-Venom",
        "T-Rex-T-Rex",
        "Mammoth-Mammoth"
    },
    ["MainFruits"] = {
        "Dough-Dough",
        "Buddha-Buddha"
    },
    ["RegularFruits"] = {
        "Magmag-Magma",
        "Dark-Dark"
    },
    ["FragmentsCap"] = 50000
}
(getgenv()).key = "MARU0RMFMYMFPXOI6YYZUNUM";
(getgenv()).id = "878872687286571018";
loadstring(game:HttpGet("https://raw.githubusercontent.com/xshiba/MaruComkak/main/PCBit.lua"))()
