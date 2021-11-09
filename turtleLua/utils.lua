local utils = {}


function isInvFull()
    for i = 3, 16 do
        local detail = turtle.getItemDetail(i)
        if detail ~= nil then
            if detail.name == "minecraft:cobblestone" then
                turtle.drop()
                return false
            end
        else
            return false
        end
    end
    return true
end

function checkInv()
    if isInvFull() then 
        local detail = turtle.getItemDetail(2)
        if detail.name == "minecraft:chest" then
            if detail.count < 2 then
                while true do
                    local chestDetail = turtle.getItemDetail(2)
                    if chestDetail > 2 then
                        break
                    end
                end
            end
            turtle.digDown()
            turtle.select(2)
            turtle.placeDown()
        end
        for i = 3,16 do
            if turtle.getItemCount(i) > 0 then
                turtle.select(i)
                turtle.dropDown()
            end
        end
    end
    return
end

function utils.tunnel(length)
    local placeLight = 1 
    for i=1, length do
        while turtle.detect() do
            turtle.dig()
        end
        turtle.forward()
        turtle.digUp()
        if placeLight == 7 then
            placeLight = 1
            turtle.turnLeft()
            turtle.dig()
            turtle.select(1)
            turtle.place()
            turtle.turnRight()
        else 
            placeLight = placeLight + 1
        end
        checkInv()
    end
    turtle.turnLeft()
    turtle.turnLeft()
    turtle.up()
    for i=1, length do
        while turtle.detect() do
            turtle.dig()
        end
        turtle.forward()
    end
    turtle.turnLeft()
    turtle.turnLeft()
    turtle.down()
    return
end


return utils