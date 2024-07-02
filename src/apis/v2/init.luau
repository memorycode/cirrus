local user = require("./user")
local place = require("./place")
local httpClient = require("../../httpClient")

return function(http: httpClient.HttpClient)
	return table.freeze({
		user = user(http),
		place = place(http),
	})
end
