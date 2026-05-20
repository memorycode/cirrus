local robloxTypes = require("../../robloxTypes")
local HttpClient = require("../../HttpClient")

type ThumbnailSize =
	"48x48"
	| "50x50"
	| "60x60"
	| "75x75"
	| "100x100"
	| "110x110"
	| "150x150"
	| "180x180"
	| "352x352"
	| "420x420"
	| "720x720"

type GetUserParams = {
			path: string,
			createTime: string,
			id: string,
			name: string,
			displayName: string,
			about: string,
			locale: string,

			-- These require additional scopes
			premium: boolean?,
			idVerified: boolean?,
			socialNetworkProfiles: {
				facebook: string?,
				twitter: string?,
				youtube: string?,
				twitch: string?,
				guilded: string?,
				visibility: string,
			}?,
		}

local function user(http: HttpClient.HttpClient)
	local function get(_, userId: robloxTypes.UserId)
		return http:get<<GetUserParams>>(`https://apis.roblox.com/cloud/v2/users/{userId}`) 
	end

	local function generateThumbnail(
		_,
		params: {
			userId: robloxTypes.UserId,
			size: ThumbnailSize,
			format: "PNG", 
			shape: "ROUND",
		}
	)
		local parsedSize = params.size:split("x")[1]
		return http:get<<robloxTypes.Operation<{ imageUri: string }>>>(
			`https://apis.roblox.com/cloud/v2/users/{params.userId}:generateThumbnail?size={parsedSize}&format={params.format}&shape={params.shape}`
		)
	end

	return table.freeze({
		get = get,
		generateThumbnail = generateThumbnail,
	})
end

return user
