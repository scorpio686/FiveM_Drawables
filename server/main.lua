RegisterServerEvent("saveMaxComponents")
AddEventHandler("saveMaxComponents", function(maxComponents)
    local logTable = {}
    local totalDrawablesSum = 0
    local totalTexturesSum = 0

    -- Loop for each clothing category available
    for i = 0, 11 do
        -- Check if the clothing category has any drawables available
        if maxComponents[i] ~= nil then
            -- Calculate the total number of drawables and textures for the current clothing category
            local drawableSum = maxComponents[i].drawables
            local textureSum = 0
            for j, v in ipairs(maxComponents[i].textures) do
                textureSum = textureSum + v
            end
            
            -- Add the results for the current clothing category to the logTable
            local categoryTable = {
                drawables = drawableSum,
                textures = maxComponents[i].textures,
                texturesSum = textureSum
            }
            logTable[i] = categoryTable
            
            -- Add the total number of drawables and textures for the current clothing category to the total sums
            totalDrawablesSum = totalDrawablesSum + drawableSum
            totalTexturesSum = totalTexturesSum + textureSum
        end
    end

    -- Add the total sums to the logTable
    logTable.totalDrawablesSum = totalDrawablesSum
    logTable.totalTexturesSum = totalTexturesSum

    -- Save the results to a JSON file in the resource directory
    local jsonStr = json.encode(logTable)
    local file = io.open("resources/" .. GetCurrentResourceName() .. "/ped_components.json", "w")
    file:write(jsonStr)
    file:close()
end)
