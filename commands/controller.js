const WebSocket = require("ws");

module.exports = {
    getTurtlesState: (turtles, message, ws) => {
        let localTurtles = turtles.map(turtle => {
            return turtle.jsonData();
        })
        console.log(localTurtles)
        ws.send(JSON.stringify({
            data: localTurtles
        }))
    },

    commandTurtle: (turtles, message, ws) => {
        let turtle = turtles.filter(turtle=> turtle.id === message.turtleID)[0]
        delete message.sender
        delete message.token
        delete message.command

        console.log(turtle.id)
        
        if (turtle.ws.readyState === WebSocket.OPEN) {
            turtle.ws.send(JSON.stringify(message))
            ws.send(JSON.stringify(message))
        }
    },

    commandAllTurtles: (turtles, message, ws) => {
        delete message.sender
        delete message.token

        for(let i = 0; i < turtles.length; i++) {
            if (turtles[i].ws.readyState === WebSocket.OPEN) {
                turtles[i].ws.send(JSON.stringify(message))
            }
        }
        ws.send(JSON.stringify({
            command: "commandAllTurtles",
            status: "sent"
        }))
    }
}