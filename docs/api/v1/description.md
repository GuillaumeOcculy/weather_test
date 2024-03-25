The Weather Test API allows you to write and read data from the Weather Test application.
It conforms to [REST](https://en.wikipedia.org/wiki/REST).
It has predictable resource-oriented URLS, accepts JSON request bodies, returns JSON and uses standard HTTP status codes
and verbs.

# Authentication

The Weather Test API requires authentication.
It's a bearer authentication, also called token authentication.

To start your integration journey with the Weather Test API, you must send your **authentication token** in the 
`Authorization` header when making requests to the API.

```
Authorization: Bearer <token>
```


# Versioning

The API is versioned. The current version is 1.0 (referenced as v1 in the endpoints).

# Request headers

Every request should include the header `Content-Type: application/json`.



# Response format

The API only supports JSON format. 
All responses sent by the API will contain the header `Content-Type: application/json` and their content is present in 
the body in a JSON format to be de-serialized.

# Rate limit

The use of the API is limited.
You can make a maximum of 5 calls per 10 seconds. 
If you exceed this limit, you receive a `429 - Too Many Requests` error and are blocked for one minute.

# Response codes

The API may return the following codes:

| Code  | Name                  | Description                                                                      |
| ----  | --------              | --------                                                                         |
| `200` | Success               | Success                                                                          |
| `201` | Created               | Resource created                                                                 |
| `204` | No Content            | Success but the response does not contain any data (e.g., deletion)              |
| `400` | Bad Request           | The request is invalid                                                           |
| `401` | Unauthorized          | Authentication failed                                                            |
| `403` | Forbidden             | Insufficient rights to perform the requested action                              |
| `404` | Not Found             | The resource is not found                                                        |
| `422` | Unprocessable Entity  | The transmitted data is malformed                                                |
| `429` | Too Many Requests     | Too many requests have been made                                                 |
| `500` | Internal Server Error | An internal server error occurred (the technical team is automatically notified) |

# Errors

When an error occurs, the response code informs you about what is happening.
The response body contains:
- the status code,
- the status name, a.k.a the error title
- a human readable message.

See the error schemas below.

# Resources identification

All resources are identified by a unique ID.

