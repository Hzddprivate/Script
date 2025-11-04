repeat task.wait() until game:IsLoaded()
getgenv().HorstConfig = {
    ["EnableLog"] = true, -- ปรับเป็น true ถ้าอยากให้มันเช็คของ 
    ["Whitescreen"] = false,
    ["EnableAddFriends"] = false, -- แอดเพื่อนให้เอง ทุกๆ 1นาที
    ["LockFps"] = {
        ["EnableLockFps"] = true,
        ["LockFpsAmount"] = 15
    }
}
loadstring(game:HttpGet("https://raw.githubusercontent.com/HorstSpaceX/last_update/main/on_loaded.lua"))()
