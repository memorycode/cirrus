-- https://create.roblox.com/docs/cloud/reference/types#fieldmask
local function createFieldMask(fields: { [any]: any }): string
	local flattened: { string } = {}
	local function traverse(tbl: any, prefix: string?)
		for key, value in tbl do
			if typeof(value) == "table" then
				traverse(value, `{if prefix then prefix else ""}{key}.`)
			else
				table.insert(flattened, `{if prefix then prefix else ""}{key}`)
			end
		end
	end

	traverse(fields)
	return table.concat(flattened, ",")
end

return createFieldMask
