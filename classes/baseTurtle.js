
class Turtle {
    constructor(socket, id, label) {
        this.ws = socket
        this.id = id;
        this.label = label;
    }
}

module.exports = Turtle