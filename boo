-- Wrap the Geoscanner peripheral on the right side
local geoscanner = peripheral.wrap("right")

-- Define the Y-level to scan (e.g., 10 for Y = 10)
local scanY = 10

-- Output a message to the terminal
print("Scanning layer at Y = " .. scanY)

-- Use chunkAnalyze to get ore data
local oreData, errorMessage = geoscanner.chunkAnalyze()

if oreData then
    for oreName, oreCount in pairs(oreData) do
        print("Ore: " .. oreName .. ", Count: " .. oreCount)
        for i = 1, oreCount do
            local blockInfo = geoscanner.find(oreName)
            if blockInfo then
                print("Location: X=" .. blockInfo.x .. ", Y=" .. blockInfo.y .. ", Z=" .. blockInfo.z)
            end
        end
    end
else
    print("Analyze failed: " .. errorMessage)
end
