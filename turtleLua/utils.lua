os.loadAPI("json")
local utils = {}

local throwOut = {
    'create:granite_cobblestone',
    'create:diorite_cobblestone',
    'minecraft:dirt',
    'minecraft:cobblestone',
    'minecraft:stone',
    'minecraft:granite'
}


local function contains(table, val)
    for i=1,#table do
       if table[i] == val then 
          return true
       end
    end
    return false
 end

function isInvFull()
    for i = 3, 16 do
        local detail = turtle.getItemDetail(i)
        if detail ~= nil then
            if contains(throwOut, detail.name) then
                turtle.select(i)
                turtle.drop()
                return false
            end
        else
            return false
        end
    end
    return true
end

function checkInv(ws, response)
    if isInvFull() then 
        local detail = turtle.getItemDetail(2)
        if detail.count < 2 then
            while true do
                local chestDetail = turtle.getItemDetail(2)
                if chestDetail > 2 then
                    break
                end
                response.message = "Need more chests"
                ws.send(json.encode(response))
                sleep(2)
            end
        end
        turtle.digDown()
        turtle.select(2)
        turtle.placeDown()
        for i = 3,16 do
            if turtle.getItemCount(i) > 0 then
                turtle.select(i)
                turtle.dropDown()
            end
        end
    end
    return
end

function moveToNextStrip()
    while turtle.detect() do
        turtle.dig()
    end
    turtle.forward()
    turtle.digUp()
    while turtle.detect() do
        turtle.dig()
    end
    turtle.forward()
    turtle.digUp()
    while turtle.detect() do
        turtle.dig()
    end
    turtle.forward()
    turtle.digUp()
    return
end

function checkWalls()
    local bool, detail = turtle.inspectDown()
    if contains(throwOut, detail.name) == false then
        turtle.digDown()
    end
    turtle.turnLeft()
    bool, detail = turtle.inspect()
    if contains(throwOut, detail.name) == false then
        turtle.dig()
    end
    turtle.up()
    bool, detail = turtle.inspect()
    if contains(throwOut, detail.name) == false then
        turtle.dig()
    end
    bool, detail = turtle.inspectUp()
    if contains(throwOut, detail.name) == false then
        turtle.digUp()
    end
    turtle.turnLeft()
    turtle.turnLeft()
    bool, detail = turtle.inspect()
    if contains(throwOut, detail.name) == false then
        turtle.dig()
    end
    turtle.down()
    bool, detail = turtle.inspect()
    if contains(throwOut, detail.name) == false then
        turtle.dig()
    end
    turtle.turnLeft()
    return
end

function utils.tunnel(length, left, right, ws, response)
    local num = left+right+1
    while true do
        local placeLight = 1 
        for i=1, length do
            while turtle.detect() do
                turtle.dig()
            end
            turtle.forward()
            turtle.digUp()
            checkWalls()
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
        for i=1, length do
            while turtle.detect() do
                turtle.dig()
            end
            turtle.forward()
        end
        turtle.turnLeft()
        turtle.turnLeft()
        if right > 0 then
            turtle.turnRight()
            moveToNextStrip()
            turtle.turnLeft()
        elseif left > 0 then
            turtle.turnLeft()
            moveToNextStrip()
            turtle.turnRight()
        end
        num = num-1
        if num == 0 then
            break
        end
    end
    return
end


return utils