repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.Players
repeat task.wait() until game.Players.LocalPlayer
repeat task.wait() until game.Players.LocalPlayer:FindFirstChild("PlayerGui")
getgenv().Script_Mode = "Kaitun_Script"
_G.OneClickSettings = {
    ["LockFruits"] = {
        "Tiger-Tiger",
        "Kitsune-Kitsune",
        "Dragon-Dragon",
        "Yeti-Yeti",
        "Gas-Gas",
        "Dough-Dough"
    },
    ["MainFruits"] = {
        "Dough-Dough",
        "Tiger-Tiger",
        "Kitsune-Kitsune",
        "Dragon-Dragon",
        "Yeti-Yeti",
        "Gas-Gas",
        "Buddha-Buddha",
        "Spirit-Spirit",
        "Buddha-Buddha",
        "T-rex-T-rex"
    },
    ["RegularFruits"] = {
        "Flame-Flame",
        "Magmag-Magma",
        "Dark-Dark",
        "Light-Light"
    },
    ["FragmentsCap"] = 70000,
    ["Farm Shark Anchor"] = false
}
(getgenv()).key = "MARU0RMFMYMFPXOI6YYZUNUM";
(getgenv()).id = "878872687286571018";
loadstring(game:HttpGet("https://raw.githubusercontent.com/xshiba/MaruComkak/main/PCBit.lua"))()
