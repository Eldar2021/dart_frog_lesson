# todo_api

### Pub get
```shell
dart pub get
```

### Generate code
```shell
dart run build_runner build --delete-conflicting-outputs
```
### Run dev
```shell
dart_frog dev
```
### Create a new todo
```shell
curl --request POST \
  --url http://localhost:8080/todos \
  --header 'Content-Type: application/json' \
  --data '{
  "title": "Eldi 01",
  "description": "Description 01",
  "isCompleted": true
}'
```
### Read all todos
```shell
curl --request GET \
  --url http://localhost:8080/todos
```
### Read a specific todo by [id]
```shell
curl --request GET \
  --url http://localhost:8080/todos/<id>
```
### Update a specific todo by [id]
```shell
curl --request PUT \
  --url http://localhost:8080/todos/<id> \
  --header 'Content-Type: application/json' \
  --data '{
  "title": "Eldi 02",
  "description": "Description 02",
  "isCompleted": false
}'
```
### Delete a specific todo by [id]
```shell
curl --request DELETE \
  --url http://localhost:8080/todos/<id>
```
### Delete all todos
```shell
curl --request DELETE \
  --url http://localhost:8080/todos
```