local modules = {}

local function TraitRerollListening()
    local Event = game:GetService("ReplicatedStorage"):WaitForChild("Networking"):WaitForChild("Units"):WaitForChild("TraitEvent")

    local done = false
    local response

    local conn
    conn = Event.OnClientEvent:Connect(function(name, trait)
        if name == 'Replicate' then
            response = trait
            done = true
            conn:Disconnect()
        end
    end)

    local timeout = 1.5
    local start = tick()

    repeat
        task.wait()
    until done or (tick() - start >= timeout)

    return response[1], response[2]
end

function modules:TraitReroll(UniqueID)
    local args = {
        [1] = "Reroll",
        [2] = {
            [1] = UniqueID,
            [2] = "Trait"
        }
    }

    TraitRerollListening()
    game:GetService("ReplicatedStorage"):WaitForChild("Networking"):WaitForChild("Units"):WaitForChild("TraitEvent"):FireServer(unpack(args))
end

function modules:StatReroll(UniqueID, RollType)
    RollType = RollType or "All"
    local args = {
        [1] = RollType,
        [2] = UniqueID
    }

    game:GetService("ReplicatedStorage"):WaitForChild("Networking"):WaitForChild("Units"):WaitForChild("StatRerollEvent"):FireServer(unpack(args))
end


return modules
