const { Server } = require("ws");

const wss = new Server({port: 4220});

wss.on("connection", (ws)=>{
    ws.on("message", (message)=>{
        console.log(JSON.parse(message));
    })

    setInterval(()=>{
        ws.send(JSON.stringify({
            test: `Hi!
                   NewLine!`,
            func: `local fuel = turtle.getFuelLevel()
            print(fuel)
            return`
        }))
    }, 1000)
})