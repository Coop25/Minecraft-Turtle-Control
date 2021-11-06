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
    //       action: "function",
    //       test: `Hi!
    //               NewLine!`,
    //       func: `local bool, fuel = turtle.inspectDown()
    //       print(fuel)
    //       return fuel`
    //     }))
    // }, 1000)

  //   setInterval(()=>{
  //     ws.send(JSON.stringify({
  //       action: "function",
  //       test: `Hi!
  //               NewLine!`,
  //       func: `shell.run("wget", "https://raw.githubusercontent.com/Coop25/Minecraft-Turtle-Control/master/turtleLua/index.lua", "startup")
  //       shell.run("wget", "https://raw.githubusercontent.com/Coop25/Minecraft-Turtle-Control/master/turtleLua/utils.lua", "utils")
  //       shell.run("reboot")
  //       return`
  //     }))
  // }, 1000)
  // setInterval(()=>{
  //     // ws.send(JSON.stringify({
  //     //   action: "wget",
  //     //   url: "https://raw.githubusercontent.com/Coop25/Minecraft-Turtle-Control/master/turtleLua/index.lua",
  //     //   program: "startup"
  //     // }))
  //     ws.send(JSON.stringify({
  //       action: "wget",
  //       url: "https://raw.githubusercontent.com/Coop25/Minecraft-Turtle-Control/master/turtleLua/utils.lua",
  //       program: "utilities"
  //     }))
  //   }, 10000)
})