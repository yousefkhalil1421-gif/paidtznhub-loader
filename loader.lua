print("LOADER STARTED")

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local key = getgenv().PAIDTZN_KEY
if not key then
    player:Kick("PAID TZN HUB | No key provided")
    return
end

-- STATIC validation (temporary)
local ValidKeys = {
    ["PAIDTZNHUB4839201"] = true,
    ["PAIDTZNHUB9174628"] = true,
    ["PAIDTZNHUB5601834"] = true,
}

if not ValidKeys[key] then
    player:Kick("PAID TZN HUB | Invalid key")
    return
end

-- allowed
loadstring(game:HttpGet("RAW_MAIN_SCRIPT_LINK"))()
