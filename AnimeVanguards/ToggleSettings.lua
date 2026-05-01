local RS = game:GetService("ReplicatedStorage")
local SP = game:GetService("StarterPlayer")

local Handler = require(SP.Modules.Gameplay.SettingsHandler)

local ToggleConfig = {
    AutoSkipWaves = true,
    DisableMatchEndRewardsView = true,
    SelectUnitOnPlacement = false,
    HideOthersUnits = true,
    DisableStatMultiplierPopups = true,
    DisableVisualEffects = true,
    DisableDamageIndicators = true,
    DisableEnemyTags = true,
    SimplifiedEnemyGui = true,
    DisableCameraShake = true,
    DisableDepthOfField = true,
    LowDetailMode = true,
    HideFamiliars = true,
    DisableViewCutscenes = true,
    SkipSummonAnimation = true,
    DisableGlobalMessages = true,
    AutoSellUnitsWithTraits = true,
    AutoFuseUnitsWithTraits = true,
    SummonMaxAffordable = true
}

local AutoSellConfig = {
    AutoSellUnits = {
        Rare = true,
        Epic = true,
        Legendary = true,
        Mythic = true,
        Exclusive = true,
        Vanguard = false
    },
    AutoSellMemorias = {
        Rare = true,
        Epic = true,
        Legendary = true,
        Mythic = true,
        Exclusive = true,
        Vanguard = false
    },
    AutoSellUnitsWithTraits = {
        Vigor = true,
        Range = true,
        Swift = true,
        Scholar = true,
        Marksman = true,
        Fortune = true,
        Blitz = true,
        Solar = true,
        Deadeye = true,
        Ethereal = true,
        Monarch = false
    }
}

local function ToggleSetting(setting, toggle)
    if Handler:GetSetting(setting) ~= toggle then
        local args = {
            "Toggle",
            setting
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Networking"):WaitForChild("Settings"):WaitForChild("SettingsEvent"):FireServer(unpack(args))
    end
end

local function ChangeValue(setting, name, value)
    if (Handler:GetSetting(setting)[name] ~= value) then
        local args = {
            "ChangeValue",
            {
                Value = name,
                Name = setting,
                DeepValue = value
            }
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Networking"):WaitForChild("Settings"):WaitForChild("SettingsEvent"):FireServer(unpack(args))
    end
end

while not Handler.SettingsLoaded do
    task.wait(1)
end

warn("EmP: Disable Settings")

for setting, toggle in pairs(ToggleConfig) do
    ToggleSetting(setting, toggle)
    wait(0.15)
end

for setting, values in pairs(AutoSellConfig) do
    for name, value in pairs(values) do
        ChangeValue(setting, name, value)
        wait(0.15)
    end
end

warn("EmP: Disabed All Settings!")