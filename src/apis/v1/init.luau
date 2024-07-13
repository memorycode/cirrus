local messaging = require("./messaging")
local place = require("./place")
local HttpClient = require("../../HttpClient")

return function(http: HttpClient.HttpClient)
	return table.freeze({
		messaging = messaging(http),
		place = place(http),
	})
end
