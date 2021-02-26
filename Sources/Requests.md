#  HTTP Requests

- GET All employees
http://localhost:8080/employee

- GET Employee by id
http://localhost:8080/employee/{UUID}

- DELETE Employee by id
http://localhost:8080/employee/{UUID}

- POST employee
http://localhost:8080/employee
```
{
    "data": [
        {
            "firstName" : "Teste",
            "lastName": "Deconto",
            "title": "CEO",
            "salary": 2000.0,
            "age": 20,
            "department" : "Deconto"
        },
        {
            "firstName" : "Teste",
            "lastName": "Deconto",
            "title": "CEO",
            "salary": 2000.0,
            "age": 20,
            "department" : "Deconto"
        }
    ]
}
```
- DELETE Employees batch
http://localhost:8080/employee
```
{
    "data": [
        {
            "salary": 2000,
            "firstName": "Teste",
            "id": "56ECB5F6-ECF3-4352-B0C9-E484308C5AAC",
            "age": 20,
            "title": "CEO",
            "department": "Deconto",
            "lastName": "Deconto"
        }
    ]
}
```
