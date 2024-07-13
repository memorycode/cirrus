local Cirrus = require("../src")
local parseApiKey = require("./parseApiKey")

local client = Cirrus.new({ apiKey = parseApiKey() }).v2
print(client.memoryStore.sortedMap:listItems({ universeId = 6202372017, name = "host" }))
