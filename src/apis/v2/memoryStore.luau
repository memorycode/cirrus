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

	--- @param universeId The universe to access
	--- @param name The name of the sorted map
	--- @param maxPageSize The number of items to return
	--- @param pageToken
	--- @param orderBy
	--- @param filter
	function sortedMap:listItems(data: {
		universeId: robloxTypes.UniverseId,
		name: string,

		maxPageSize: number?,
		pageToken: string?,
		orderBy: string?,
		filter: string?,
	})
		local params = table.clone(data) :: any
		params.name = nil
		params.universeId = nil
		params.maxPageSize = if params.maxPageSize then tostring(params.maxPageSize) else nil

		return http:get(
			`https://apis.roblox.com/cloud/v2/universes/{data.universeId}/memory-store/sorted-maps/{data.name}/items`,
			params
		) :: HttpClient.Response<{ memoryStoreSortedMapItems: { SortedMapItemOutput }, nextPageToken: string? }>
	end

	--- @param universeId The universe to access
	--- @param name The name of the sorted map
	--- @param id The key of the item to delete
	function sortedMap:deleteItem(data: { universeId: robloxTypes.UniverseId, name: string, id: string })
		return http:delete(
			`https://apis.roblox.com/cloud/v2/universes/{data.universeId}/memory-store/sorted-maps/{data.name}/items/{data.id}`
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
