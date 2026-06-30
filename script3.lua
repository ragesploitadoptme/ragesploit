print("====================================")
print("SCRIPT 3 HAS STARTED")
print("ACCEPTING NEGOTIATION...")
print("====================================")

local remote = game.ReplicatedStorage.API:FindFirstChild("TradeAPI/AcceptNegotiation")

if not remote then
    warn("[SCRIPT 3] AcceptNegotiation remote not found")
    return
end

local ok, result = pcall(function()
    if remote:IsA("RemoteFunction") then
        return remote:InvokeServer()
    else
        remote:FireServer()
        return "sent"
    end
end)

print("[SCRIPT 3] Result:", ok, result)

print("====================================")
print("SCRIPT 3 FINISHED")
print("====================================")
