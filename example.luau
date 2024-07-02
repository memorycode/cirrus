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

-- Call v2 endpoints
local response = client.v2.user:generateThumbnail({ userId = 4000, size = "48x48", format = "PNG", shape = "ROUND" })
if response.ok then
	print(response.data)
else
	print(response.reason)
end

-- Call v1 endpoints
client.v1.messaging:publish({
	message = "Hello",
	topic = "topic",
	universeId = 620237201,
})
