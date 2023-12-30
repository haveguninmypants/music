-- Mine and Plant Script

-- Function to mine a tree
function mineTree()
    -- Assuming the turtle is facing the tree and the tree is directly in front of it
    turtle.dig()
    turtle.forward()
    turtle.digUp()
    turtle.digDown()
    turtle.back()  -- Move back to the original position
end

-- Function to plant a sapling
function plantSapling()
    -- Assuming the turtle has saplings in slot 1
    turtle.select(1)
    turtle.place()  -- Place a sapling on the ground
end

-- Main loop
while true do
    -- Check if there is a tree in front of the turtle
    while not turtle.detect() do
        sleep(1)  -- Wait for a tree to grow
    end

    -- Mine the tree
    mineTree()

    -- Plant a new sapling
    plantSapling()

    -- Wait for the sapling to grow into a tree again
    sleep(300)  -- Adjust the time based on the growth rate of the saplings

    -- Return to the starting position (optional)
    turtle.turnLeft()
    turtle.turnLeft()
    while turtle.forward() do end
    turtle.turnLeft()
    turtle.turnLeft()
end
