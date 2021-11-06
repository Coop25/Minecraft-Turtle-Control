os.loadAPI("json")
-- local utils = require("utilities")

function wsLoop()
    local ws,err = http.websocket("ws://turtles.ngrok.io")
    if err then
        print(err)
    elseif ws then
        ws.send(json.encode({
            id = os.getComputerID(),
            label = os.getComputerLabel(),
            state = "hello",
            sender = "turtle"
        }))
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
            elseif obj.action == 'wget' then
                shell.run("delete", obj.program)
                shell.run("wget", obj.url, obj.program)
            elseif obj.action == 'reboot' then
                shell.run("reboot")
            end
            response.fuelLevel = turtle.getFuelLevel() 
            response.maxFuelLevel = turtle.getFuelLimit()
            ws.send(json.encode(response))
        end
    end
end

while true do
    local status, res = pcall(wsLoop)
    term.clear()
	term.setCursorPos(1,1)
	if res == 'Terminated' then
		print("BEEP BEEP ... fuck you :)")
		os.sleep(1)
		print("I cannot let you do that!")
		break
	end
    print("zzz ... sleeping please wait")
    os.sleep(5)
end