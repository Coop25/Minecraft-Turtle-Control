local utils = {}

function utils.tunnel(length) {
    for i=1, length do
        turtle.dig()
        turtle.digUp()
        turtle.forward()
    end
    for i=1, length do
        turtle.back()
    end
    return
}


return utils