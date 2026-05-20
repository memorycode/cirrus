local fs = require("@std/fs")
local process = require("@std/process")
local json = require("@std/json")
local pp = require("./src/vendor/pp")

local Cirrus = require("./src/")

-- Load env from an env.json file
local ENV_FILE_NAME = "env.json"
if fs.exists(ENV_FILE_NAME) then
	local env = assert(json.deserialize(fs.readFileToString(ENV_FILE_NAME)), "Failed to parse env.json")
	for key, value in env do
		if type(key) ~= "string" then
			continue
		end

		process.env[key] = value
	end
end

-- Create Cirrus client
local client = Cirrus.new({
	apiKey = process.env.API_KEY,
	retries = 0,
})

local placeInfo = client.v2.place:getInfo({ universeId = 6206874897, placeId = 18308356731 })
print(pp(placeInfo))
print(pp(client.v2.user:get(12233433)))
