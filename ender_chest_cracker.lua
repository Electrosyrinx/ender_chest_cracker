-- Declare variables
-- The chest needs to be to the right of the computer
local enderChest = peripheral.wrap("right")
-- The chest needs to be on top of the computer
local enderTank = peripheral.wrap("top")

local colors = {"white", "red", "blue", "yellow", "green", "black", "cyan", "magenta", "pink", "orange", "lightblue", "lime", "gray", "lightgray", "purple", "brown"}

-- The % sign is called a modulo operator
function getChestFromPin(n)
    local third = n % 16
    n = n / 16
    n = math.floor(n);
    local second = n % 16
    n = n / 16
    n = math.floor(n);
    local first = n % 16
    return {colors[(first + 1)], colors[(second + 1)], colors[(third + 1)]}
end

-- This functions prints on the screen which chest color combos have items in them
function addPinToList(n, id)
    if id == "chest" then
        local chest = getChestFromPin(n)
        print("Items found in ["..chest[1]..", "..chest[2]..", "..chest[3].."]")
    elseif id == "tank" then
        local tank = getChestFromPin(n)
        local contents = enderTank.getTankInfo("")
        print(contents[1].name.." found in ["..tank[1]..", "..tank[2]..", "..tank[3].."]")
        contents = nil
    end
    return "Added pin to list"
end

-- Checks for existence of contents in ender tank
function tank()
    -- 4096 is the number of possible color combinations (16x16x16)
    for pin = 1, 4096, 1 do
        -- Call function based on current iteration's color combination
        local chest = getChestFromPin(pin)
    enderTank.setColorNames(chest[1], chest[2], chest[3])
        -- Checks for presence of any existing items in the chest of the current color combination
        local contents = enderTank.getTankInfo("")
        if contents[1].name ~= nil then
            addPinToList(pin, "tank")
        end
    end
    -- Print message once all iterations are complete
    print("Enter 'exit' to return to main menu.")
    input = read()
    if input == "exit" then
        main()
    end
    return "Scanned tank."
end

-- Checks for existence of contents in ender chest
function chest()
    -- 4096 is the number of possible color combinations (16x16x16)
    for pin = 1, 4096, 1 do
        -- Call function based on current iteration's color combination
        local chest = getChestFromPin(pin)
    enderChest.setColorNames(chest[1], chest[2], chest[3])
        -- Checks for presence of any existing items in the chest of the current color combination
        local contents = enderChest.getAllStacks()
        if contents[1] ~= nil then
            addPinToList(pin, "chest")
        end
    end
    -- Print message once all iterations are complete
    print("Enter 'exit' to return to main menu.")
    input = read()
    if input == "exit" then
        main()
    end
    return "Scanned chest."
end

-- Welcome message, tells user how to use the program and accept's user's prompt
function main()
    term.clear()
    term.setCursorPos(1, 1)

    print("Enter 'chest' (right) or 'tank' (top) to begin.")

    input = read()

    if input == "chest" then
        chest()
    elseif input == "tank" then
        tank()
    end
end

main()
