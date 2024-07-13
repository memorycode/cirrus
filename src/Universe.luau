export type Universe = { universeId: number }
local function new(universeId: number): Universe
	return { universeId = universeId }
end

return table.freeze({
	new = new,
})
