local robloxTypes = require("../../robloxTypes")
local HttpClient = require("../../HttpClient")

type SortedMapItem = {
	path: string,
	value: string | number,
	id: string,
	stringSortKey: string?,
	numericSortKey: number?,
}

type SortedMapItemInput = SortedMapItem & {
	ttl: string,
}

type SortedMapItemOutput = SortedMapItem & {
	expireTime: robloxTypes.Timestamp,

	-- The server generated tag of the item
	etag: string,
}

local function createSortedMap(http: HttpClient.HttpClient)
	local sortedMap = {}

	--- @param name The name of the sorted map
	--- @param universeId The universe to list from
	--- @param maxPageSize The number of items to return
	sortedMap.listItems = function(
		_: typeof(sortedMap),
		data: {
			universeId: number,
			name: string,

			maxPageSize: number?,
			pageToken: string?,
			orderBy: string?,
			filter: string?,
		}
	)
		local params = table.clone(data) :: any
		params.name = nil
		params.universeId = nil
		params.maxPageSize = if params.maxPageSize then tostring(params.maxPageSize) else nil

		return http:get(
			`https://apis.roblox.com/cloud/v2/universes/{data.universeId}/memory-store/sorted-maps/{data.name}/items`,
			params
		) :: HttpClient.Response<{ memoryStoreSortedMapItems: { SortedMapItemOutput }, nextPageToken: string? }>
	end

	--- @param name The name of the sorted map
	--- @param id The key of the item
	sortedMap.deleteItem = function(_: typeof(sortedMap), params: { universeId: number, name: string, id: string })
		return http:delete(
			`https://apis.roblox.com/cloud/v2/universes/{params.universeId}/memory-store/sorted-maps/{params.name}/items/{params.id}`
		)
	end

	return sortedMap
end

local function memoryStore(http: HttpClient.HttpClient)
	return table.freeze({
		sortedMap = createSortedMap(http),
	})
end

return memoryStore
