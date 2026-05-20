local v1 = require("./src/apis/v1")
local v2 = require("./src/apis/v2")
local robloxTypes = require("./src/robloxTypes")
local HttpClient = require("./src//HttpClient")

local Cirrus = {}
Cirrus.__index = Cirrus

function Cirrus.new(config: { apiKey: robloxTypes.ApiKey, retries: number? })
	local http = HttpClient.new(config.apiKey, config.retries or 0)
	return setmetatable({
		v1 = v1(http),
		v2 = v2(http),

		_http = http,
		_config = config,
	}, Cirrus)
end

export type Cirrus = typeof(Cirrus.new({ apiKey = "" }))
return Cirrus
