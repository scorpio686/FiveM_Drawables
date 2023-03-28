RegisterCommand("getdrawables", function()

	-- Get the ID of the current ped
	local playerPed = GetPlayerPed(-1)

	-- Create a table to store the results for all clothing categories
	local maxComponents = {}

	-- Loop for each clothing category available
	for i = 0, 11 do
		-- Get the maximum number of drawables for the current clothing category
		local maxDrawables = GetNumberOfPedDrawableVariations(playerPed, i)

		-- If the clothing category has any drawables available, get the maximum number of textures for each drawable
		if maxDrawables > 0 then
			local maxTextures = {}
			for j = 0, maxDrawables - 1 do
				table.insert(maxTextures, GetNumberOfPedTextureVariations(playerPed, i, j))
			end

			-- Add the results for the current clothing category to the maxComponents table
			local categoryTable = {
				drawables = maxDrawables,
				textures = maxTextures
			}
			maxComponents[i] = categoryTable
		end
	end

	-- Send the results to the server
	TriggerServerEvent("saveMaxComponents", maxComponents)
end)
