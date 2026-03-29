if not game:IsLoaded() then
    game.Loaded:Wait()
end

local RS = game:GetService("ReplicatedStorage")
local SP = game:GetService("StarterPlayer")

local TutorialHandler

local GamePlaceId = 16277809958
if game.PlaceId == GamePlaceId then
    TutorialHandler = require(SP.Modules.Gameplay.Tutorial.ClientTutorialHandler)
else
    TutorialHandler = require(SP.Modules.Gameplay.ClientTutorialHandler)
end

local ConfigAPI = loadstring(game:HttpGet("https://raw.githubusercontent.com/godcraft998/EMP/refs/heads/main/ConfigAPI.lua"))()

local function printObject(instance)
    local count = 1;
    warn("--- ᴘʀɪɴᴛ ᴏʙᴊᴇᴄᴛ ---")
    if typeof(instance) == 'table' then
        for k, v in pairs(instance) do
            warn(count .. ":", k, "-", v)
            count += 1;
        end
    else
        warn(instance)
    end
end

local GamePlaceId = 16277809958

if game.PlaceId == GamePlaceId and TutorialHandler.IsInTutorial then
    local ConfigFile = ConfigAPI:CreateConfig();
    ConfigFile:SetPath("EmP Hub/Tutorial.json")
    local Loaded = ConfigFile:LoadConfig()

    if not Loaded then
        Loaded = {
            InTutorial = true,
        }
    end

    ConfigFile:SaveConfig(Loaded)

    wait(0.5)

    local args = {
        "PartOne",
        "Skip"
    }
    game:GetService("ReplicatedStorage"):WaitForChild("Networking"):WaitForChild("ClientListeners"):WaitForChild("NEWTutorialEvent"):FireServer(unpack(args))
else
    local ConfigFile = ConfigAPI:CreateConfig();
    ConfigFile:SetPath("EmP Hub/Tutorial.json")
    local Loaded = ConfigFile:LoadConfig()

    if Loaded and Loaded.InTutorial then
        Loaded.InTutorial = false

        ConfigFile:SaveConfig(Loaded)

        wait(0.5)

        local args = {
            "PartTwo",
            "Skip"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Networking"):WaitForChild("ClientListeners"):WaitForChild("NEWTutorialEvent"):FireServer(unpack(args))
    else
        print("normal server")
    end
end