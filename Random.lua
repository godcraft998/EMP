local random = {}

function random.wait(min, max)
    task.wait(math.random() * (max - min) + min)
end

return random