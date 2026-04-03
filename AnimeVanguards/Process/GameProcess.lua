local function loadConfig(config)
    local file = "Nousigi Hub/Config/" .. config
    if not isfile(file) then
        return
    else
        local json = readfile(file)
        return game:GetService("HttpService"):JSONDecode(json);
    end
end

getgenv().Config = loadConfig("WinterConfig.json");

getgenv().Key = "kca5b6ee67b2bc3054d46849"
loadstring(game:HttpGet("https://nousigi.com/loader.lua"))()