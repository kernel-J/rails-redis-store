# README

Authenication service that serves to create users and authenticate users.

## Routes

ROUTE | METHOD | FUNCTION
--- | --- | ---
/api/v1/user | POST | Create a user
/api/v1/login | POST | Authenicating a user

## Usage

To create a user
```
curl -d '{"username":"user", "password":"Strongp@ssword1"}' -H "Content-Type: application/json" -X POST http://localhost:3000/api/v1/user

Example response:
{
  "id": "1",
  "bearer_id": "1",
  "bearer_type": "User",
  "token": "49742bb06a1ca28ed3e2607621fcaeab",
  "timestamp": "2022-11-29T08:58:37.148+00:00"
}

```
To authenicate a user
```
curl -d '{"username": "user", "password": "Strongp@ssword1"}' -H 'Authorization: Bearer 49742bb06a1ca28ed3e2607621fcaeab' -H "Content-Type: application/json" -X POST http://localhost:3000/api/v1/login

Example response:
{
  "message": "success"
}
```

## Data Storage

Passwords are stored in a hashed form. The gem [**bcrypt-ruby**](https://github.com/bcrypt-ruby/bcrypt-ruby) is used for the hashing algorithms and salting. To add an extra layer of security, the password is also peppered. The pepper string can be modified in the **.env** file.

To ensure secure passwords, validation requirements include:
* containing at least 1 uppercase letter
* containing at least 1 lowercase letter
* containing at least 1 special character
* containing at least 1 numeric
* having the length between 12 and 255 characters

Usernames also have a validation:
* must be between 3 and 25 characters

## Mapping
Since the main storage of data is Redis, the models are mapped using [**ohm**](https://github.com/soveran/ohm).

## Developement

To start the development server

```
docker-compose -f docker-compose.dev.yml up
```

To stop the server
```
docker-compose -f docker-compose.dev.yml down
```

## Production

To build the image for production
```
docker-compose build
```
To run
```
docker-compose up
```

## Testing
Test are written using rspec
```
bundle exec rspec
```

## Further Improvements
##### System
- [ ] Make a test deployment to remote server
- [ ] Change Http to Https
- [ ] Add load testing

##### Development
- [ ] Add [rubocop](https://github.com/rubocop/rubocop)
- [ ] Setup a CI/CD pipeline
