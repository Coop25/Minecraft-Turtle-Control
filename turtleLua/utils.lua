local utils = {}

function utils.tunnel(length) 
    for i=1, length do
        while turtle.detect() do
            turtle.dig()
        end
        turtle.forward()
        turtle.digUp()
    end
    turtle.turnLeft()
    turtle.turnLeft()
    for i=1, length do
        while turtle.detect() do
            turtle.dig()
        end
        turtle.back()
    end
    turtle.turnLeft()
    turtle.turnLeft()
    return
end


return utils