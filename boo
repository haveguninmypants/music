-- Wrap the Geoscanner peripheral on the right side.
local geoscanner = peripheral.wrap("right")

-- Check if Geoscanner peripheral is found.
if geoscanner then
    -- Define the coordinates of the current chunk.
    local chunkX, chunkZ = math.floor(gps.locate())
    local minY, maxY = -20, 30  -- Set the Y-level range from -20 to 30.

    -- Create a table to store block information.
    local blockCounts = {}

    -- Initialize progress variables.
    local totalBlocks = (maxY - minY + 1) * 16 * 16
    local scannedBlocks = 0

    -- Create a function to update the progression bar.
    local function updateProgress()
        term.clear()
        term.setCursorPos(1, 1)
        print("Scanning Progress: " .. scannedBlocks .. " / " .. totalBlocks)

        local progress = scannedBlocks / totalBlocks
        local barLength = 20
        local progressChars = math.floor(barLength * progress)
        local progressBar = "[" .. string.rep("=", progressChars) .. string.rep(" ", barLength - progressChars) .. "]"
        print("Progress: " .. progressBar)
    end

    -- Main scanning loop.
    for y = minY, maxY do
        for x = 1, 16 do
            for z = 1, 16 do
                local blockData = geoscanner.scan(x, y, z)
                scannedBlocks = scannedBlocks + 1

                -- Update progress.
                updateProgress()

                if blockData then
                    local blockName = blockData.name
                    local blockAmount = blockData.count

                    -- Update block counts.
                    if not blockCounts[blockName] then
                        blockCounts[blockName] = 0
                    end
                    blockCounts[blockName] = blockCounts[blockName] + blockAmount

                    -- Display block information in real-time.
                    term.setCursorPos(1, 4)
                    term.clearLine()
                    print("Scanning Block: X=" .. chunkX * 16 + x .. " Y=" .. y .. " Z=" .. chunkZ * 16 + z)
                    print("Block: " .. blockName)
                    print("Amount: " .. blockAmount)
                end
            end
        end
    end

    -- Display a completion message with block counts.
    term.clear()
    term.setCursorPos(1, 1)
    print("Scanning completed.")
    print("Block Counts:")
    for blockName, blockCount in pairs(blockCounts) do
        print(blockName .. ": " .. blockCount)
    end
else
    -- Display a message if the Geoscanner is not found.
    print("Geoscanner not found.")
end
