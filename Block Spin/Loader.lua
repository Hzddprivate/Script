local loader = loadstring
local url = "https://raw.githubusercontent.com/hermanos-dev/hermanos-hub/refs/heads/main/BlockSpin/blockspin-farm.lua"
local response = game:HttpGet(url)
loader(response)()
