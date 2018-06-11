# Tilanne

Image analysis tool for lots of data.



**tila** (“*space*”) +‎ **-nne** (“*denominal suffix expressing a quality*”)

Name comes from Finnish and its meaning is  picture, situation, position, things, occasion ...

## API

#### GET /collections
- Response (application/json)
```
{
    "collections": [collections]
 ```   

  
#### POST /collections
- Request (application/json)y
```json
{
	"path": "path",
	"id": "id"
}
```
If you do not pass the body parameters, the request will not fail. Images from data directory from the project directory will be loaded. The generated id will be "default".

- Response (application/json)
```json
{
	"path": "path",
	"id": "id",
    "description": "creating collection ..."
}
```

  
#### GET /collections/:id
- Response (application/json)
```json
{
    "images": [images],
    "collection": "id"
}
```

#### GET /collections/:id/:selection
- Response (application/json)
```json
{
    "selection": "selection",
    "results": [results],
    "from": "id"
}
```









