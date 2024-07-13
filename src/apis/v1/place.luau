local robloxTypes = require("../../robloxTypes")
local HttpClient = require("../../HttpClient")

local function place(http: HttpClient.HttpClient)
	local function publish(
		_,
		params: {
			universeId: robloxTypes.UniverseId,
			placeId: robloxTypes.PlaceId,
			versionType: "Saved" | "Published",
			place: buffer,
		}
	)
		return http:post(
			`https://apis.roblox.com/universes/v1/{params.universeId}/places/{params.placeId}/versions?versionType={params.versionType}`,
			params.place
		) :: HttpClient.Response<{ versionNumber: number }>
	end

	return table.freeze({
		publish = publish,
	})
end

return place
