local turtleSide = "right"


function turnLoop(chunkSide,extraDigging)
    if(chunkSide == "left")
    then 
        if(extraDigging) then
        turtle.turnRight()
        turtle.dig()
        turtle.forward()
        turtle.turnRight()
        end
        return "right"
    else
        if(extraDigging) then
        turtle.turnLeft()        
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
            turtleSide = turnLoop(turtleSide,true)
        else
            turtleSide = turnLoop(turtleSide,false)
        end
    end
end

function DigOneSquareLayer(x,y)
    for i = 1,x,1 --2 lines of size 16
    do
        DigLine(y-1)
        if (i ~= x)
        then
            turtleSide = turnLoop(turtleSide,true)
        else
            turtleSide = turnLoop(turtleSide,false)
        end   
    end
end


function DigNLayers(num,layerSize)
    for i= 1,num,1
    do
        turtleSide = turnLoop(turtleSide,false)
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
        turtleSide = turnLoop(turtleSide,false)
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


function main()
    DigNLayers(10,8,8)
end


main()