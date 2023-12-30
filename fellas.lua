-- Function to mine logs above and move back down
function mineLogsUpAndDown()
    local startingY = turtle.getY()

    -- Move up while mining logs above
    while turtle.detectUp() do
        turtle.digUp()
        turtle.up()
    end

    -- Move back down to the original y-level
    while turtle.getY() > startingY do
        turtle.down()
    end
end

-- Function to plant a spruce sapling
function plantSpruceSapling()
    turtle.turnLeft()
    turtle.turnLeft()
    turtle.back()  -- Move back to the previous position
    turtle.place()  -- Place a spruce sapling on the ground
    turtle.forward()  -- Move back to the starting position
    turtle.turnLeft()
    turtle.turnLeft()
end

-- Function to check if a tree has grown in front
function isTreeGrown()
    local success, data = turtle.inspect()
    return success and data.name:lower():find("log")
end

-- Function to refuel using coal from inventory
function refuelWithCoal()
    for slot = 1, 16 do
        local item = turtle.getItemDetail(slot)
        if item and item.name:lower():find("coal") then
            turtle.select(slot)
            turtle.refuel()
            return true
        end
    end
    return false
end

-- Main loop
while true do
    -- Refuel with coal from inventory
    if not turtle.getFuelLevel() or turtle.getFuelLevel() < 10 then
        if not refuelWithCoal() then
            print("No coal found in inventory. Please add fuel.")
            break
        end
    end

    -- Check if there is a spruce log in front of the turtle
    while not turtle.detect() do
        sleep(1)  -- Wait for a tree to grow
    end

    -- Wait for the sapling to grow into a tree
    while not isTreeGrown() do
        sleep(1)
    end

    -- Mine logs up and move back down
    mineLogsUpAndDown()

    -- Plant a new spruce sapling
    plantSpruceSapling()

    -- Wait for the sapling to grow into a tree again
    sleep(300)  -- Adjust the time based on the growth rate of the saplings
end
