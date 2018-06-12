# Tilanne

Image analysis tool for lots of data.



**tila** (“*space*”) +‎ **-nne** (“*denominal suffix expressing a quality*”)

Name comes from Finnish and its meaning is  picture, situation, position, things, occasion ...

## API

#### GET /collections
- Response (application/json)
```json
{
	"collections": [collections]
}
```


  
#### POST /collections
- Request (application/json)
```json
{
	"path": "path",
	"id": "id"
}
```
If you do not pass the body parameters, the request will not fail. Images from data directory from the project directory will be loaded. The generated id will be "default". To perform any query on this collection you pass "default" as "id" parameter.

```json
{
	"id": "models"
}
```
If you pass the body parameters as "id": "models" and do not specify the path, the default models directory will be loaded.
You can use pictures from this directory as templates when performin the patterns query

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
Selection may be of value "overexposed" or "blurry".

#### POST /collections/patterns
- Request (application/json)
```json
{
	"id": "id",
	"model": "picture"
}
```
Model parameter must be a picture name loaded as MODEL PICTURE.







