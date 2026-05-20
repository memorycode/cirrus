local robloxTypes = require("../../robloxTypes")
local HttpClient = require("../../HttpClient")
local createFieldMask = require("../../createFieldMask")

type Place = {
	path: string,
	displayName: string,
	description: string,
	serverSize: number,
}

type OptionalPlace = {
	path: string?,
	displayName: string?,
	description: string?,
	serverSize: number?,
	[string]: nil,
}

type OutputPlace = Place & {
	createTime: robloxTypes.Timestamp,
	updateTime: robloxTypes.Timestamp,
}

local function place(http: HttpClient.HttpClient)
	local function getInfo(_, params: { universeId: robloxTypes.UniverseId, placeId: robloxTypes.PlaceId })
		return http:get<<OutputPlace>>(
				`https://apis.roblox.com/cloud/v2/universes/{params.universeId}/places/{params.placeId}`
			)
	end

	local function updateInfo(
		_,
		params: {
			universeId: robloxTypes.UniverseId,
			placeId: robloxTypes.PlaceId,
			fields: OptionalPlace,
		}
	)
		local fieldMask = createFieldMask(params.fields)
		return http:patch<<OutputPlace>>(
			`https://apis.roblox.com/cloud/v2/universes/{params.universeId}/places/{params.placeId}?updateMask={fieldMask}`,
			params.fields
		)
	end

	return table.freeze({
		getInfo = getInfo,
		updateInfo = updateInfo,
	})
end

return place
