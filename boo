-- Wrap the Geoscanner peripheral on the right side
local geoscanner = peripheral.wrap("right")

-- Wrap the AR goggles controller peripheral on the left side
local arController = peripheral.wrap("left")

-- Define the scan radius (e.g., 16 for a 16-block radius)
local scanRadius = 16

-- Output a message to the terminal
print("Scanning a radius of " .. scanRadius)

-- Use scan to get block data
local blockData, errorMessage = geoscanner.scan(scanRadius)

if blockData then
    -- Create a table to store the ore data
    local oreData = {}

    for _, blockInfo in pairs(blockData) do
        local blockName = blockInfo.name

        -- Check if the block name contains the word "Ore"
        if string.find(blockName, "Ore") then
            table.insert(oreData, {
                name = blockName,
                x = blockInfo.x,
                y = blockInfo.y,
                z = blockInfo.z
            })
        end
    end

    -- Clear the AR goggles display
    arController.clear()

    -- Display ore data on the AR goggles with increased spacing
    local yPosition = 1

    for _, oreInfo in pairs(oreData) do
        arController.drawString("Ore: " .. oreInfo.name, 1, yPosition, 0xFFFFFF)
        arController.drawString("Location: X=" .. oreInfo.x .. ", Y=" .. oreInfo.y .. ", Z=" .. oreInfo.z, 1, yPosition + 1, 0xFFFFFF)
        arController.drawString("-----------------------", 1, yPosition + 2, 0xFFFFFF)
        yPosition = yPosition + 4
    end

    -- You can choose to add a manual display function here if needed.
else
    print("Scan failed: " .. errorMessage)
end
