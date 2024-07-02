local user = require("./user")
local httpClient = require("../../httpClient")

return function(http: httpClient.HttpClient)
	return table.freeze({
		user = user(http),
	})
end
