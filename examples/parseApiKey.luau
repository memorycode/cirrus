local fs = require("@lune/fs")
local serde = require("@lune/serde")

local FILE_PATH = "env.toml"

local function parseApiKey(): string
	if not fs.isFile(FILE_PATH) then
		return ""
	end

	local values = serde.decode("toml", fs.readFile(FILE_PATH))
	return values.API_KEY or ""
end

return parseApiKey
