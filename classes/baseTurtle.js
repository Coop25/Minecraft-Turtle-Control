
class Turtle {
    constructor(socket, id, label, fuelLevel, maxFuelLevel) {
        this.ws = socket
        this.id = id;
        this.label = label;
        this.fuelLevel = fuelLevel;
        this.maxFuelLevel = maxFuelLevel;
    }

    setFuelLevel(fuelLevel){
        this.fuelLevel = fuelLevel
        return this.fuelLevel
    }

    setInventory(inv){
        this.inventory = inv
        return this.inventory
    }
}

module.exports = Turtle