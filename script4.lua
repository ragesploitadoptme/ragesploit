print("====================================")
print("SCRIPT 4 HAS STARTED")
print("CONFIRMING TRADE...")
print("====================================")

local remote = game.ReplicatedStorage.API:FindFirstChild("TradeAPI/ConfirmTrade")

if not remote then
    warn("[SCRIPT 4] ConfirmTrade remote not found")
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

print("[SCRIPT 4] Result:", ok, result)

print("====================================")
print("SCRIPT 4 FINISHED")
print("====================================")
