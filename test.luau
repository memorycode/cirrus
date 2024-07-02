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

local placeFile = fs.readFile("place.rbxl")
print(client.v1.place:publish({
	placeId = 18308356731,
	universeId = 6206874897,
	place = buffer.fromstring(placeFile),
	versionType = "Published",
}))
