# MongoSH Command Docker Action

This action will run your MongoDB commands passed as a JS snippet against a MongoDB Server using your provided connection string.
You can use it to seed a MongoDB database in your GitHub Actions or to create MongoDB users on the fly.

## Inputs

## `connectionString`

**Required** Your mongodb connection string. This will be passed to `connect()` in mongosh script file and return the db object for your JS snippet.

## `snippet`

**Required** Your mongodb commands as a JavaScript snippet. You already get a db-object from us to use in your snippet. See https://docs.mongodb.com/mongodb-shell/reference/methods/ for more information about what commands can be run.

## Outputs

As the output most likely resembles JavaScript code, it might interfere with bash/sh syntax. All output is surrounded with double-quotes. For example, this could be valid content of an log output variable:

```
"{
    foo: "bar"
}"
```

So if you want to parse the output, please remove the quotes beforehand. I am also looking for any ideas to make this better.

## `input-command`

The whole JS file that is run using mongosh.

## `output`

The output of the whole JS script (add output using `console.log()` in your command).

## Example usage

Basic usage:

```
uses: krassdanke/mongosh-command-action@v1
with:
  connectionString: 'mongodb://my-ci-user:my-ci-pass@my.mongo.example.com/mydatabase&ssl=false'
  snippet: "let res = db.createUser({name: 'foo', pwd: 'bar', roles: ["readWrite"]}); console.log(res); res = db.getUsers(); console.log(res);"
```

Create a user for a branch (works multiple times, changing the password):

```
- name: Extract branch name
  id: vars
  run: |
    echo "::set-output name=branch::dev"
- name: Generate password
  id: password
  run: |
    echo "::set-output name=password::SuperSecretPassword123!"
- name: Execute mongosh commands
  uses: krassdanke/mongosh-command-action@v1.1
  with:
    connectionString: 'mongodb://my-ci-user:my-ci-pass@my.mongo.example.com/mydatabase${{ steps.vars.outputs.branch }}&ssl=false'
    snippet: "db.createUser({name: 'ci-user-${{ steps.vars.outputs.branch }}', pwd: 'bar', roles: ["readWrite", "dbAdmin"]}); db.changeUserPassword('ci-user-${{ steps.vars.outputs.branch }}', '${{ steps.password.outputs.password }}')";"
```

## Was this helpful?

If this action was helpful to you and saved you some time, consider supporting my projects and

[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/yellow_img.png)](https://www.buymeacoffee.com/krassdanke)
