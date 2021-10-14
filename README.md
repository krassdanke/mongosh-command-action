# MongoSH Command Docker Action

This action will run your MongoDB commands passed as a JS snippet against a MongoDB Server using your provided connection string.
You can use it to seed a MongoDB database in your GitHub Actions or to create MongoDB users on the fly.

## Inputs

## `connectionString`

**Required** Your mongodb connection string. This will be passed to connect() in mongosh script file and return the db object for your JS snippet.

## `snippet`

**Required** Your mongodb commands as a JavaScript snippet. You already get a db-object from us to use in your snippet. See https://docs.mongodb.com/mongodb-shell/reference/methods/ for more information about what commands can be run.

## Outputs

## `input-command`

The whole JS file that is run using mongosh.

## `output`

The output of the whole JS script (add output using "console.log()" in your command).

## Example usage

uses: krassdanke/mongosh-command-action@v1
with:
  connectionString: 'mongodb://myuser:mypass@my.mongo.example.com/mydatabase&ssl=false'
  snippet: "let res = db.createUser({name: 'foo', pwd: 'bar', roles: ["readWrite"]}); console.log(res); res = db.getUsers(); console.log(res);"
