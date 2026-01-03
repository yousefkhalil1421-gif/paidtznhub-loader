local Players = game:GetService("Players")
local player = Players.LocalPlayer
local hwid = game:GetService("RbxAnalyticsService"):GetClientId()

local key = getgenv().PAIDTZN_KEY
if not key then
    player:Kick("PAID TZN HUB | No key provided")
    return
end

local Keys = {
    ["PAIDTZNHUB4839201"] = "UNBOUND",
    ["PAIDTZNHUB9174628"] = "UNBOUND",
    ["PAIDTZNHUB5601834"] = "UNBOUND",
}

if not Keys[key] then
    player:Kick("PAID TZN HUB | Invalid key")
    return
end

if Keys[key] == "UNBOUND" then
    Keys[key] = hwid
elseif Keys[key] ~= hwid then
    player:Kick("PAID TZN HUB | Key already used on another PC")
    return
end

loadstring(game:HttpGet("https://RAW_MAIN_SCRIPT_LINK_HERE"))()
