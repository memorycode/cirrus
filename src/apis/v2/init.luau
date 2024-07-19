local user = require("./user")
local place = require("./place")
local memoryStore = require("./memoryStore")
local HttpClient = require("../../HttpClient")

return function(http: HttpClient.HttpClient)
	return table.freeze({
		user = user(http),
		place = place(http),
		memoryStore = memoryStore(http),
	})
end
