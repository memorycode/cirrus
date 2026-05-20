local robloxTypes = require("./robloxTypes")
local net = require("@std/net")
local json = require("@std/json")

export type Response<T> = { ok: true, data: T, raw: net.Response } | { ok: false, reason: string, raw: net.Response }
export type UnknownResponse = Response<string | { [any]: any }>

export type Body = string | { [any]: any } | buffer

local HttpClient = {}
HttpClient.__index = HttpClient

function HttpClient.new(apiKey: robloxTypes.ApiKey, retries: number)
	return setmetatable({ _apiKey = apiKey, _retries = retries }, HttpClient)
end
export type HttpClient = typeof(HttpClient.new("", 0))

local function serialize(body: Body): { contentType: string, content: string }
	if typeof(body) == "buffer" then
		return { contentType = "application/octet-stream", content = buffer.tostring(body) }
	elseif typeof(body) == "table" then
		return { contentType = "application/json", content = json.serialize(body) }
	else
		return { contentType = "application/json", content = body }
	end
end

local function decode(body: string)
	local ok, result = pcall(json.deserialize, body)
	return if ok then result else body
end

function HttpClient._request(self: HttpClient, url: string, metadata: net.Metadata): UnknownResponse
	local response = net.request(url, metadata)
	if response.ok then
		return { ok = true, data = decode(response.body), raw = response }
	end

	local maxRetries = self._retries
	if maxRetries == 0 then
		return { ok = false, reason = response.body, raw = response }
	end

	for retryNumber = 1, maxRetries do
		response = net.request(url, metadata)
		if response.ok then
			return { ok = true, data = decode(response.body), raw = response }
		end

		if retryNumber < maxRetries then
			task.wait(1)
		end
	end

	return { ok = false, reason = response.body, raw = response }
end

function HttpClient.post<T>(self: HttpClient, url: string, body: Body): Response<T>
	local serialized = serialize(body)
	return self:_request(url, {
		method = "POST",
		headers = { ["Content-Type"] = serialized.contentType, ["x-api-key"] = self._apiKey },
		body = serialized.content,
	})
end

function HttpClient.delete(self: HttpClient, url: string): UnknownResponse
	return self:_request(url, {
		method = "DELETE",
		headers = { ["Content-Type"] = "application/json", ["x-api-key"] = self._apiKey },
	})
end

function HttpClient.patch<T>(self: HttpClient, url: string, body: Body): Response<T>
	local serialized = serialize(body)
	return self:_request(url, {
		method = "PATCH",
		headers = { ["Content-Type"] = serialized.contentType, ["x-api-key"] = self._apiKey },
		body = serialized.content,
	})
end

function HttpClient.get<T>(self: HttpClient, url: string): Response<T>
	return self:_request(url, {
		method = "GET",
		headers = { ["Content-Type"] = "application/json", ["x-api-key"] = self._apiKey },
	})
end

return HttpClient
