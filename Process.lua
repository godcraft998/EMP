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

local RS = game:GetService("ReplicatedStorage")
local SP = game:GetService("StarterPlayer")

local Handler = require(SP.Modules.Gameplay.SettingsHandler)

printObject(Handler.OnSettingsLoaded())