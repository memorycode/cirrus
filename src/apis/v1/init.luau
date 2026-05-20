local messaging = require("./v1/messaging")
local place = require("./v1/place")
local HttpClient = require("../HttpClient")

return function(http: HttpClient.HttpClient)
	return table.freeze({
		messaging = messaging(http),
		place = place(http),
	})
end
