local messaging = require("./messaging")
local httpClient = require("../../httpClient")

return function(http: httpClient.HttpClient)
	return table.freeze({
		messaging = messaging(http),
	})
end
