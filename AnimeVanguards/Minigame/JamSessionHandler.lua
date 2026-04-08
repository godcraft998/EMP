-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- Requires (giữ đường dẫn gốc)
local SoundHandler = require(ReplicatedStorage.Modules.Shared.SoundHandler)
local NumberUtils = require(ReplicatedStorage.Modules.Utilities.NumberUtils)
local GuitarMinigame = loadstring(game:HttpGet("https://raw.githubusercontent.com/godcraft998/EMP/refs/heads/main/AnimeVanguards/Minigame/GuitarMinigame.lua"))()

-- Remote events / functions
local JamSessionEvents = ReplicatedStorage.Networking.Events.JamSession
local Remote_UpdateScore = JamSessionEvents.UpdateScore

-- PlayerGui reference
local PlayerGui = Players.LocalPlayer.PlayerGui

local modules = {}

local availableSongs = {
    "Skele King's Theme",
    "Vanguards!",
    "Selfish Intentions",
    "Petals Beneath the Ice",
    "Steel Against Flesh",
    "Crown of the Sun"
}

function modules._Init()
    GuitarMinigame._Init()
end

function modules.StartMinigame(songName, difficulty)
    -- Tạo key âm thanh dựa trên index bài
    local soundKey = ("KingOfString%d"):format(table.find(availableSongs, songName))
    local soundInstance = SoundHandler:PlayLocalSound(soundKey)
    if not soundInstance then
        return warn("Could not play the minigame music")
    end

    -- Mở giao diện minigame (module GuitarMinigame chịu trách nhiệm UI/logic)
    GuitarMinigame.Open()

    -- Đợi sound load nếu cần
    if not soundInstance.IsLoaded then
        repeat
            task.wait()
        until soundInstance.IsLoaded
    end

    -- Bắt đầu chơi chart (tham số: songName, difficulty, trackIndex)
    GuitarMinigame.PlayChart(songName, difficulty, 2)

    -- Khởi tạo playback chậm rồi tăng tốc sau 2 giây để đồng bộ hiệu ứng
    soundInstance.PlaybackSpeed = 0
    soundInstance.TimePosition = 0
    task.delay(2, function()
        soundInstance.PlaybackSpeed = 1
    end)

    -- Lắng nghe kết thúc minigame (MinigameEnded:Once)
    GuitarMinigame.MinigameEnded:Once(function(result)
        -- Nếu có kết quả (ví dụ score), gửi lên server
        if result then
            Remote_UpdateScore:FireServer(songName, difficulty, result)
        end

        -- Đóng giao diện minigame, bật lại HUD và dừng nhạc local
        GuitarMinigame.Close()
        if PlayerGui and PlayerGui:FindFirstChild("HUD") then
            PlayerGui.HUD.Enabled = true
        end
        SoundHandler:StopLocalSound(soundKey)
    end)
end

return modules