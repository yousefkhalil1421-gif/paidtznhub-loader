-- PAID TZN HUB loader with debug prints
local HttpService = game:GetService("HttpService")
HttpService.HttpEnabled = true
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local hwid = game:GetService("RbxAnalyticsService"):GetClientId()

local key = getgenv().PAIDTZN_KEY
if not key then
    player:Kick("PAID TZN HUB | No key provided")
    return
end

print("Starting key validation...")

-- Send key and HWID to auth server
local success, response = pcall(function()
    return HttpService:PostAsync(
        "https://chilly-ants-fail.loca.lt/auth", -- your Localtunnel or public URL
        HttpService:JSONEncode({ key = key, hwid = hwid }),
        Enum.HttpContentType.ApplicationJson
    )
end)

if not success then
    player:Kick("PAID TZN HUB | Failed to contact auth server")
    return
end

print("Server response received:", response)

local data = HttpService:JSONDecode(response)

if data.status == "invalid_key" then
    player:Kick("PAID TZN HUB | Invalid key")
elseif data.status == "hwid_mismatch" then
    player:Kick("PAID TZN HUB | Key used on another PC")
elseif data.status == "bound" then
    print("Key bound to this PC")
elseif data.status == "ok" then
    print("Key validated")
else
    player:Kick("PAID TZN HUB | Unknown error")
end

-- Load your main script after validation
loadstring(game:HttpGet("https://github.com/yousefkhalil1421-gif/paidtznhub-loader/blob/main/loader.lua"))()
