local loaders = {}

local HttpService = game:GetService("HttpService")

local folderName = "EMP Hub"
local fileName = folderName .. "/" .. game:GetService("Players").LocalPlayer.Name .. ".json"

function loaders.loadConfig()
    if not isfolder(folderName) then
        makefolder(folderName)
    end

    if not isfile(fileName) then
        writefile(fileName, HttpService:JSONEncode({}))
    else
        local jsonData = readfile(fileName)
        return HttpService:JSONDecode(jsonData)
    end
end

function loaders.saveConfig(config)
    writefile(fileName, HttpService:JSONEncode(config))
end

return loaders
