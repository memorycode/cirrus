# Cirrus
Cirrus is a Luau (Lune) library for interacting with Roblox's Open Cloud.

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
| Memory Stores | ❌
| Places | ✅
| Subscriptions | ❌
| Universes | ❌
| Users | 🟡



## Example
```luau
-- Create Cirrus client
local client = Cirrus.new({
	apiKey = process.env.API_KEY,
	retries = 0,
})

-- Call v2 endpoints
local response = client.v2.user:generateThumbnail({ userId = 4000, size = "48x48", format = "PNG", shape = "ROUND" })
if response.ok then
	print(response.data)
else
	print(response.reason)
end 

-- Call v1 endpoints
client.v1.messaging:publish({
	message = "Hello",
	topic = "topic",
	universeId = 1,
})
```