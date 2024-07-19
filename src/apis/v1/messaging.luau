local robloxTypes = require("../../robloxTypes")
local HttpClient = require("../../HttpClient")

local function messaging(http: HttpClient.HttpClient)
	local function publish(
		_,
		data: { universeId: robloxTypes.UniverseId, topic: string, message: string, [string]: nil }
	)
		return http:post(
			`https://apis.roblox.com/messaging-service/v1/universes/{data.universeId}/topics/{data.topic}`,
			('{"message": "%s"}'):format(data.message)
		)
	end

	return table.freeze({
		publish = publish,
	})
end

return messaging
