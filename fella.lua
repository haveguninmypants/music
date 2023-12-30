-- Mine and Plant Script

-- Function to mine a spruce tree
function mineSpruceTree()
    while turtle.detect() do
        turtle.dig()
        turtle.forward()
        mineUp()  -- Mine blocks above
        mineDown()  -- Mine blocks below
    end
end

-- Function to mine blocks above the turtle
function mineUp()
    while turtle.detectUp() do
        turtle.digUp()
        turtle.up()
    end
    while not turtle.detectDown() and not turtle.detect() do
        turtle.down()
    end
end

-- Function to mine blocks below the turtle
function mineDown()
    while turtle.detectDown() do
        turtle.digDown()
        turtle.down()
    end
    while not turtle.detectUp() and not turtle.detect() do
        turtle.up()
    end
end

-- Function to plant a spruce sapling
function plantSpruceSapling()
    turtle.back()  -- Move back to the previous position
    turtle.turnLeft()
    turtle.turnLeft()
    turtle.place()  -- Place a spruce sapling on the ground
    turtle.turnLeft()
    turtle.turnLeft()
    turtle.forward()  -- Move back to the starting position
end

-- Function to check if a tree has grown in front
function isTreeGrown()
    local success, data = turtle.inspect()
    return success and data.name:lower():find("log")
end

-- Main loop
while true do
    -- Check if there is a spruce log in front of the turtle
    while not turtle.detect() do
        sleep(1)  -- Wait for a tree to grow
    end

    -- Wait for the sapling to grow into a tree
    while not isTreeGrown() do
        sleep(1)
    end

    -- Mine the entire spruce tree
    mineSpruceTree()

    -- Plant a new spruce sapling
    plantSpruceSapling()

    -- Wait for the sapling to grow into a tree again
    sleep(300)  -- Adjust the time based on the growth rate of the saplings
end
