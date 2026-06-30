local SCRIPT_0 = "https://raw.githubusercontent.com/ragesploitadoptme/ragesploit/main/script0.lua"
local SCRIPT_1 = "https://raw.githubusercontent.com/ragesploitadoptme/ragesploit/main/script1.lua"
local SCRIPT_2 = "https://raw.githubusercontent.com/ragesploitadoptme/ragesploit/main/script2.lua"
local SCRIPT_3 = "https://raw.githubusercontent.com/ragesploitadoptme/ragesploit/main/script3.lua"
local SCRIPT_4 = "https://raw.githubusercontent.com/ragesploitadoptme/ragesploit/main/script4.lua"

getgenv().Script0Ready = false

local function run(name, url)
    print("====================================")
    print("[LOADER] STARTING:", name)
    print("====================================")

    local ok, err = pcall(function()
        loadstring(game:HttpGet(url))()
    end)

    print("[LOADER] DONE:", name, ok, err)
end

-- Script 0 runs first
task.spawn(function()
    run("Script 0", SCRIPT_0)
end)

print("[LOADER] Waiting for Script 0 to finish...")

repeat
    task.wait(1)
until getgenv().Script0Ready == true

print("====================================")
print("SCRIPT 0 READY")
print("STARTING SCRIPT 1")
print("====================================")

-- Script 1 starts once and stays running
task.spawn(function()
    run("Script 1", SCRIPT_1)
end)

local cycle = 1

while true do
    print("====================================")
    print("CYCLE " .. cycle .. " STARTED")
    print("====================================")

    task.wait(2)

    print("[CYCLE " .. cycle .. "] SCRIPT 2 STARTING")
    task.spawn(function()
        run("Script 2", SCRIPT_2)
    end)

    task.wait(7)

    print("[CYCLE " .. cycle .. "] SCRIPT 3 FIRST RUN STARTING")
    task.spawn(function()
        run("Script 3 FIRST RUN", SCRIPT_3)
    end)

    task.wait(3)

    print("[CYCLE " .. cycle .. "] SCRIPT 3 BACKUP RUN STARTING")
    task.spawn(function()
        run("Script 3 BACKUP RUN", SCRIPT_3)
    end)

    task.wait(16)

    print("[CYCLE " .. cycle .. "] SCRIPT 4 BACKUP #1 STARTING")
    task.spawn(function()
        run("Script 4 BACKUP #1", SCRIPT_4)
    end)

    task.wait(3)

    print("[CYCLE " .. cycle .. "] SCRIPT 4 MAIN STARTING")
    task.spawn(function()
        run("Script 4 MAIN", SCRIPT_4)
    end)

    task.wait(3)

    print("[CYCLE " .. cycle .. "] SCRIPT 4 BACKUP #2 STARTING")
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
