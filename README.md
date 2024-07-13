# Cirrus
Cirrus is a Luau (Lune) library for interacting with Roblox's Open Cloud.

> [!WARNING]
The API is unstable and changing often.

## Supported Endpoints
✅ full
🟡 some
❌ none

| V2 | Status | &nbsp; &nbsp; &nbsp; &nbsp; | V1 | Status |
| :---: | :---: | :---: | :---: | :---: |
| Creator Store | ❌ | | Assets | ❌
| Groups | ❌ | | Data Stores |  ❌
| Instances | ❌ | | Messaging | ✅ 
| Inventory | ❌ | | Place Publishing | ✅ 
| Memory Stores | 🟡
| Places | ✅
| Subscriptions | ❌
| Universes | ❌
| Users | 🟡



## Example
```luau
-- Create Cirrus client
local cirrus = Cirrus.new({
	apiKey = process.env.API_KEY,
	retries = 0,
})

local v1, v2 = cirrus.v1, cirrus.v2

-- Call v2 endpoints
local response = v2.user:generateThumbnail({ userId = 4000, size = "48x48", format = "PNG", shape = "ROUND" })
if response.ok then
	print(response.data)
else
	print(response.reason)
end 

-- Call v1 endpoints
v1.messaging:publish({
	message = "Hello",
	topic = "topic",
	universeId = 1,
})
```