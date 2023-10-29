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

        -- Check if the block name contains any of the specified keywords
        if string.find(blockName, "diamond") or
           string.find(blockName, "emerald") or
           string.find(blockName, "ancient") then
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

    -- Display ore data on the AR goggles with increased spacing and coloring
    local yPosition = 1

    for _, oreInfo in pairs(oreData) do
        local color = 0xFFFFFF -- Default color

        if string.find(oreInfo.name, "diamond") then
            color = 0x99CCFF -- Light Blue for diamond
        elseif string.find(oreInfo.name, "emerald") then
            color = 0x00FF00 -- Lime for emerald
        elseif string.find(oreInfo.name, "ancient") then
            color = 0xFFA500 -- Orange for ancient
        end

        arController.drawString("Ore: " .. oreInfo.name, 1, yPosition, color)
        arController.drawString("Location: X=" .. oreInfo.x .. ", Y=" .. oreInfo.y .. ", Z=" .. oreInfo.z, 1, yPosition + 1, color)
        arController.drawString("-----------------------", 1, yPosition + 2, 0xFFFFFF)
        yPosition = yPosition + 4
    end

    -- Update the AR goggles display
else
    print("Scan failed: " .. errorMessage)
end
