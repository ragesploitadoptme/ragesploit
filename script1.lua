local MAIN_USER_IDS = {
    591015339,
    10637972054,
    10334144307,
    -- 987654321,
}

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")

local LOOP_DELAY = 2

while true do
    for _, userId in ipairs(MAIN_USER_IDS) do
        local main = Players:GetPlayerByUserId(userId)

        if main then
            local success, err = pcall(function()
                local remote = RS.API:WaitForChild("TradeAPI/SendTradeRequest")
                remote:FireServer(main)
            end)

            if success then
                print("[Trade] Request sent to:", main.Name, userId)
            else
                warn("[Trade] Failed for:", userId, err)
            end
        end
    end

    task.wait(LOOP_DELAY)
end
