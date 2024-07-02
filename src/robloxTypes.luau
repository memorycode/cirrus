export type ApiKey = string

export type UniverseId = number
export type PlaceId = number
export type UserId = number

export type Timestamp = string
export type FieldMask = string

export type Operation<T> = {
	path: string,
	done: boolean,
	response: T?,
	metadata: { [any]: any }?,
}

return table.freeze({})
