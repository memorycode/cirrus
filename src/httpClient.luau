local robloxTypes = require("./robloxTypes")
local net = require("@lune/net")
local serde = require("@lune/serde")
local task = require("@lune/task")

export type Response<T> =
	{ ok: true, data: T, raw: net.FetchResponse }
	| { ok: false, reason: string, raw: net.FetchResponse }

export type UnknownResponse = Response<string | { [any]: any }>

local HttpClient = {}
HttpClient.__index = HttpClient

function HttpClient.new(apiKey: robloxTypes.ApiKey, retries: number)
	return setmetatable({ _apiKey = apiKey, _retries = retries }, HttpClient)
end
export type HttpClient = typeof(HttpClient.new("", 0))

local function decode(body: string)
	local ok, result = pcall(serde.decode, "json" :: "json", body)
	return if ok then result else body
end

function HttpClient._request(self: HttpClient, params: net.FetchParams): UnknownResponse
	local response = net.request(params)
	if response.ok then
		return { ok = true, data = decode(response.body), raw = response }
	end

	local maxRetries = self._retries
	if maxRetries == 0 then
		return { ok = false, reason = decode(response.body), raw = response }
	end

	for retryNumber = 1, maxRetries do
		response = net.request(params)
		if response.ok then
			return { ok = true, data = decode(response.body), raw = response }
		end

		if retryNumber < maxRetries then
			task.wait(1)
		end
	end

	return { ok = false, reason = decode(response.body), raw = response }
end

function HttpClient.post(self: HttpClient, url: string, body: string): UnknownResponse
	return self:_request({
		method = "POST",
		url = url,
		headers = { ["Content-Type"] = "application/json", ["x-api-key"] = self._apiKey },
		body = body,
	})
end

function HttpClient.get(self: HttpClient, url: string): UnknownResponse
	return self:_request({
		method = "GET",
		url = url,
		headers = { ["Content-Type"] = "application/json", ["x-api-key"] = self._apiKey },
	})
end

return HttpClient
