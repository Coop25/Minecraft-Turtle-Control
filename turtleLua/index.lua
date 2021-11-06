os.loadAPI("json")
local ws,err = http.websocket("ws://turtles.ngrok.io:4220")

if err then
    print(err)
elseif ws then
    while true do
        local message = ws.receive()
        if message == nil then
            break
        end
        local obj = json.decode(message)
        local response = {
            id = os.getComputerID(),
            label = os.getComputerLabel()
        }
        if obj.action == 'function' then
            local func = loadstring(obj['func'])
            local result = func()
            response.data = result
        elseif obj.action == 'getInv' then
            response.inventory = {}
            for i=1,16 do
                response.inventory[i] = turtle.getItemDetail(i)
            end
        end
        response.fuelLevel = turtle.getFuelLevel() 
        response.maxFuelLevel = turtle.getFuelLimit()
        ws.send(json.encode(response))
    end
end