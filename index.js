const WebSocket = require("ws");
const { Server } = WebSocket;

const wss = new Server({port: 4220});

wss.on("connection", (ws)=>{
    ws.on("message", (message)=>{
        message = JSON.parse(message);
        console.log(message);
        if (message.broadcast = true) {
            wss.clients.forEach(function each(client) {
                if (client !== ws && client.readyState === WebSocket.OPEN) {
                  client.send(JSON.stringify(message));
                }
              });
        }
    })

    // setInterval(()=>{
    //     ws.send(JSON.stringify({
    //         test: `Hi!
    //                NewLine!`,
    //         func: `local fuel = turtle.getFuelLevel()
    //         print(fuel)
    //         return`
    //     }))
    // }, 1000)
})