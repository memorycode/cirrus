local fs = require("@lune/fs")
local Cirrus = require("../src")

local client = Cirrus.new({ apiKey = "" })
client.v1.place:publish({
	placeId = 18308356731,
	universeId = 6206874897,
	place = buffer.fromstring(fs.readFile("place.rbxl")),
	versionType = "Published",
})
