local Cirrus = require("../src")
local parseApiKey = require("./parseApiKey")

local client = Cirrus.connectToUniverse({ apiKey = parseApiKey(), universeId = 0 }).v2
print(client.memoryStore.sortedMap:listItems({ universeId = 6202372017, name = "host", filter = "sortKey > 100" }))

--print(client.memoryStore.sortedMap:deleteItem({ universeId = 6202372017, name = "host", id = "20335418" }))
