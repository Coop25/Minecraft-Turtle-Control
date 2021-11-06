const WebSocket = require("ws");
const { Server } = WebSocket;
const BaseTurtle = require("./classes/baseTurtle");
const controller = require("./commands/controller");

const wss = new Server({port: 4220});

let token = "asdf51g7e45w74q4fsd4fae68QWRE@!@44w5dr64s$5#@$"
let turtles = []

wss.on("connection", (ws)=>{
    ws.on("message", (message)=>{
        message = JSON.parse(message);
        console.log(message);
        if (message.sender === "controller" && message.token === token) {
          console.log(turtles.length)
          if (Object.keys(controller).includes(message.command)) {
            controller[message.command](turtles, message, ws)
            return
          }
          ws.send(JSON.stringify({
            status: "ERROR",
            message: `command: ${message.command} || NOT FOUND!`
          }))
          return
        }
        if (message.state === "hello" && message.sender === "turtle") {
          // initialize turtle class
          turtles = turtles.filter(turtle=> turtle.id !== message.id);
          turtles.push(new BaseTurtle(ws, message.id, message.label, message.fuelLevel, message.maxFuelLevel))
        } else if (message.state === "operations" && message.sender === "turtle") {
          let turtlesArrIndex = turtles.findIndex(obj => obj.id === message.id)
          turtles[turtlesArrIndex].setFuelLevel(message.fuelLevel)
          if (message.inventory){
            turtles[turtlesArrIndex].setInventory(message.inventory)  
          }
        }
        if (message.broadcast === true) {
            wss.clients.forEach(function each(client) {
              if (client !== ws && client.readyState === WebSocket.OPEN) {
                client.send(JSON.stringify(message));
              }
            });
        }
    })

    // setInterval(()=>{
    //     ws.send(JSON.stringify({
    //       action: "getInv",
    //       broadcast: true
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
      // ws.send(JSON.stringify({
      //   action: "wget",
      //   url: "https://raw.githubusercontent.com/Coop25/Minecraft-Turtle-Control/master/turtleLua/index.lua",
      //   program: "startup"
      // }))
  //     ws.send(JSON.stringify({
  //       action: "wget",
  //       url: "https://raw.githubusercontent.com/Coop25/Minecraft-Turtle-Control/master/turtleLua/utils.lua",
  //       program: "utilities"
  //     }))
  //   }, 10000)
})