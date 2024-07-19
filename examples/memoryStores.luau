local Cirrus = require("../src")
local parseApiKey = require("./parseApiKey")

local client = Cirrus.new({ apiKey = parseApiKey() }).v2
client.memoryStore.sortedMap.listItems({ universeId = 0, name = "sortedMapName" })
