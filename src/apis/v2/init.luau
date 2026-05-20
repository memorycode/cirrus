local user = require("./v2/user")
local place = require("./v2/place")
local memoryStore = require("./v2/memoryStore")
local HttpClient = require("../HttpClient")

return function(http: HttpClient.HttpClient)
	return table.freeze({
		user = user(http),
		place = place(http),
		memoryStore = memoryStore(http),
	})
end
