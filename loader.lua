-- PAID TZN HUB loader
local HttpService = game:GetService("HttpService")
HttpService.HttpEnabled = true

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local hwid = game:GetService("RbxAnalyticsService"):GetClientId()

-- SET THIS IN GAME BEFORE EXECUTING
local key = getgenv().PAIDTZN_KEY
if not key then
    player:Kick("PAID TZN HUB | No key provided")
    return
end

print("Starting key validation...")

-- Contact server
local success, response = pcall(function()
    return HttpService:PostAsync(
        "npm install -g localtunnel/auth", -- replace with your URL + /auth
        HttpService:JSONEncode({ key = key, hwid = hwid }),
        Enum.HttpContentType.ApplicationJson
    )
end)

if not success then
    player:Kick("PAID TZN HUB | Failed to contact auth server: "..tostring(response))
    return
end

if not response or response == "" then
    player:Kick("PAID TZN HUB | Server returned empty response")
    return
end

print("Server response received:", response)

-- Decode JSON
local data
local decodeSuccess, decodeErr = pcall(function()
    data = HttpService:JSONDecode(response)
end)

if not decodeSuccess then
    player:Kick("PAID TZN HUB | Failed to decode server response: "..tostring(decodeErr))
    return
end

-- Handle response
if data.status == "invalid_key" then
    player:Kick("PAID TZN HUB | Invalid key")
elseif data.status == "hwid_mismatch" then
    player:Kick("PAID TZN HUB | Key used on another PC")
elseif data.status == "bound" then
    print("Key bound to this PC")
elseif data.status == "ok" then
    print("Key validated")
else
    player:Kick("PAID TZN HUB | Unknown server response")
end

-- Load your main script
loadstring(game:HttpGet("https://raw.githubusercontent.com/yousefkhalil1421-gif/paidtznhub/main/mainscript.lua"))()
