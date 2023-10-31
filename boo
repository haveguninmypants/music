local term = require("term")
local peripheralName = "colonyIntegrator"

-- Function to retrieve citizens from the Colony Integrator peripheral
local function getCitizens()
    local peripheralList = peripheral.getNames()
    for _, name in ipairs(peripheralList) do
        if peripheral.getType(name) == peripheralName then
            local colonyIntegrator = peripheral.wrap(name)
            if colonyIntegrator then
                return colonyIntegrator.getCitizens()
            end
        end
    end
    return {}
end

local citizens = getCitizens()

local selectedCitizen = nil
local tabIndex = 1

local function clearScreen()
    term.clear()
    term.setCursorPos(1, 1)
end

local function displayCitizenList()
    clearScreen()
    term.setTextColor(colors.white)
    term.setBackgroundColor(colors.black)

    term.setCursorPos(2, 2)
    term.write("Citizen Selection Menu")

    for i, citizen in ipairs(citizens) do
        local text = citizen.name
        if citizen.request then
            text = text .. " [!]"
        end
        term.setCursorPos(2, 3 + i)
        term.write(text)
    end

    term.setCursorPos(2, 19)
    term.write("Press Q to exit")

    if selectedCitizen then
        displayCitizenDetails(citizens[selectedCitizen])
    end
end

local function displayCitizenDetails(citizen)
    clearScreen()

    term.setTextColor(colors.white)
    term.setBackgroundColor(colors.black)

    term.setCursorPos(2, 2)
    term.write("Citizen Details")

    -- Draw tabs
    term.setBackgroundColor(colors.gray)
    term.setTextColor(colors.white)
    for i = 1, 3 do
        term.setCursorPos(2 + (i - 1) * 15, 3)
        term.write(" Tab " .. i .. " ")
    end

    -- Draw content based on the selected tab
    if tabIndex == 1 then
        -- Draw citizen stats
        term.setTextColor(colors.black)
        term.setCursorPos(2, 5)
        term.write("Name: " .. citizen.name)
        term.setCursorPos(2, 6)
        term.write("Age: " .. citizen.age)
        term.setCursorPos(2, 7)
        term.write("Health: " .. (citizen.health or "N/A"))
    elseif tabIndex == 2 then
        -- Draw citizen request
        term.setTextColor(colors.black)
        term.setCursorPos(2, 5)
        term.write("Request: " .. (citizen.request and "Yes" or "No"))
    elseif tabIndex == 3 then
        -- Draw citizen work details
        term.setTextColor(colors.black)
        term.setCursorPos(2, 5)
        term.write("Job: " .. citizen.work.job)
        term.setCursorPos(2, 6)
        term.write("Location: " .. citizen.work.location)
    end
end

local function processInput()
    while true do
        local event, key = os.pullEvent("key")
        if event == "key" then
            if key == keys.q then
                return "exit"
            elseif key == keys.down and not selectedCitizen then
                selectedCitizen = 1
                displayCitizenList()
            elseif key == keys.up and not selectedCitizen then
                selectedCitizen = #citizens
                displayCitizenList()
            elseif key == keys.down and selectedCitizen then
                selectedCitizen = selectedCitizen % #citizens + 1
                displayCitizenList()
            elseif key == keys.up and selectedCitizen then
                selectedCitizen = (selectedCitizen - 2) % #citizens + 1
                displayCitizenList()
            elseif key == keys.enter and selectedCitizen then
                if tabIndex == 1 then
                    tabIndex = 2
                elseif tabIndex == 2 then
                    tabIndex = 3
                elseif tabIndex == 3 then
                    tabIndex = 1
                end
                displayCitizenDetails(citizens[selectedCitizen])
            elseif key == keys.left and tabIndex > 1 then
                tabIndex = tabIndex - 1
                displayCitizenDetails(citizens[selectedCitizen])
            elseif key == keys.right and tabIndex < 3 then
                tabIndex = tabIndex + 1
                displayCitizenDetails(citizens[selectedCitizen])
            end
        end
    end
end

term.clear()
term.setCursorBlink(false)

displayCitizenList()
local result = processInput()
term.clear()

if result == "exit" then
    term.setTextColor(colors.white)
    term.setBackgroundColor(colors.black)
    term.clear()
    term.setCursorPos(1, 1)
    term.write("Goodbye!")
end
