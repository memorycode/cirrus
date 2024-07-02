local messaging = require("./messaging")
local place = require("./place")
local httpClient = require("../../httpClient")

return function(http: httpClient.HttpClient)
	return table.freeze({
		messaging = messaging(http),
		place = place(http),
	})
end
