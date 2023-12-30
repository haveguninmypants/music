-- Function to mine logs above and move back down
function mineLogsUpAndDown()
    local upCount = 0  -- Variable to count how many times turtle goes up

    -- Move up while mining logs above
    while turtle.detectUp() do
        turtle.digUp()
        turtle.up()
        upCount = upCount + 1  -- Increment the count
    end

    -- Move back down to the original y-level
    for _ = 1, upCount do
        turtle.down()
    end
end

-- Function to plant a spruce sapling
function plantSpruceSapling()
    turtle.place()
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
    while true do
        if isTreeGrown() then do
            turtle.dig()
                turtle.foward()
                mineLogsUpAndDown()
                turtle.back()
                plantSpruceSapling()
            end
    end

    sleep(1)  -- Adjust the time based on the growth rate of the saplings
end
