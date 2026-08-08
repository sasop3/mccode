---@diagnostic disable: undefined-global
local turtleSide = "right"
local desiredBlocks = {"mythicmetals:unobtainium_ore","mythicmetals:deepslate_unobtainium_ore"} --filter blocks

function Refuel(num)
    for i=1,num do
        local preFuel = turtle.getFuelLevel()
        turtle.refuel()
        local postFuel = turtle.getFuelLevel()
        local didFuel = (postFuel - preFuel == 0)
        if(didFuel) then
            break
        end
        print("refueled #" .. i)
    end
        if(turtle.getFuelLevel() ~= 100000) then
            print("Max Fuel Level Reached. Unable to refuel")
        else if (turtle.getFuelLevel() >= 0) then
            error("OUT OF FUEL")
        else
            print("No Fuel Material Found")
        end
    end
end

function CheckBlocks(...)
    local blocks = {...}
    local blockExists,block = turtle.inspect()
    if (blockExists) then
    for i=1,#blocks do
        if(block.name == blocks[i])
        then
            error("BLOCK FOUND")
        end
    end
    end
end

function CheckBlocks(blocks)
    local blockExists,block = turtle.inspect()
    if (blockExists) then
    for i=1,#blocks do
        if(block.name == blocks[i])
        then
            error("BLOCK FOUND")
        end
    end
    end
end

function TurnLoop(chunkSide,extraDigging)
    if(chunkSide == "left")
    then 
        if(extraDigging) then
        turtle.turnRight()
        CheckBlocks(desiredBlocks)
        turtle.dig()
        turtle.forward()
        turtle.turnRight()
        end
        return "right"
    else
        if(extraDigging) then
        turtle.turnLeft() 
        CheckBlocks(desiredBlocks)       
        turtle.dig()
        turtle.forward()
        turtle.turnLeft()
        end    
         return "left"
    end
end

function DigLine(line_length)
    for i = 1,line_length,1
    do
        CheckBlocks(desiredBlocks)
        turtle.dig()
        turtle.forward()
    end
end

function DigOneSquareLayer(size) -- Chunk is 16x16. to mine a single layer of a chunk use size 16
    for i = 1,size,1
    do
        DigLine(size-1)
        if (i ~= size)
        then
            turtleSide = TurnLoop(turtleSide,true)
        else
            turtleSide = TurnLoop(turtleSide,false)
        end
    end
end

function DigOneSquareLayer(x,y)
    for i = 1,x,1 --2 lines of size 16
    do
        DigLine(y-1)
        if (i ~= x)
        then
            turtleSide = TurnLoop(turtleSide,true)
        else
            turtleSide = TurnLoop(turtleSide,false)
        end   
    end
end


function DigNLayers(num,layerSize)
    for i= 1,num,1
    do
        turtleSide = TurnLoop(turtleSide,false)
        DigOneSquareLayer(layerSize)

        if i ~= num then
            turtle.digDown()
            turtle.down()
            --Turns 180
            turtle.turnLeft() 
            turtle.turnLeft()
        end
    end
end

function DigNLayers(depth,x,y)
    for i= 1,depth,1
    do
        turtleSide = TurnLoop(turtleSide,false)
        DigOneSquareLayer(x,y)

        if i ~= depth then
            turtle.digDown()
            turtle.down()
            --Turns 180
            turtle.turnLeft() 
            turtle.turnLeft()
        end
    end
end


function Main()
    DigNLayers(100,8,8)
end


Main()