local modules = {}

local supports = {
    "Volt", 
    "Potassium",
    "Synapse Z",
    "Velocity",
}

local function getExecutorName()
    local name = "Unknown"

    if identifyexecutor then
        name = identifyexecutor()
    elseif getexecutorname then
        name = getexecutorname()
    end

    -- bỏ version (cắt từ chữ "v")
    name = name:match("^[^v]+") or name

    -- trim khoảng trắng
    name = name:match("^%s*(.-)%s*$")

    return name
end

local function isSupported(executorName)
    for _, v in ipairs(supports) do
        if v == executorName then
            return true
        end
    end
    return false
end

function modules.isSupported()
    return isSupported(getExecutorName())
end

local functions = {
    request = {
        ['Volt'] = request,
        ['Potassium'] = request,
        ['Synapse Z'] = request,
        ['Velocity'] = http_request
    }
}

function modules.hook(name)
    local executor = getExecutorName()
    local funcTable = functions[name]

    if not funcTable then
        error("Function not found: " .. tostring(name))
    end

    local func = funcTable[executor] or funcTable.default

    if not func then
        error("No valid function for: " .. name)
    end

    return func
end

return modules