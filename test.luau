local fs = require("@lune/fs")
local process = require("@lune/process")
local serde = require("@lune/serde")
local Cirrus = require("src")

-- Load env from an env.toml file
local ENV_FILE_NAME = "env.toml"
if fs.isFile(ENV_FILE_NAME) then
	for key, value in serde.decode("toml", fs.readFile(ENV_FILE_NAME)) do
		process.env[key] = value
	end
end

-- Create Cirrus client
local client = Cirrus.new({
	apiKey = process.env.API_KEY,
	retries = 0,
})

print(client.v2.place:updateInfo({
	universeId = 4871172287,
	placeId = 14067098357,
	fields = {
		description = "test desc",
		displayName = "test name",
	},
}))
