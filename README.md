# blog_turso_cli

This will be a simple CLI using [teashop](https://github.com/erikareads/teashop).

It's main role is to easily add/update/remove my markdown blogs from my Turso 
database for my main website found [here](www.ethanthoma.com).

## TODO

- implement a nice, easy way to go between states (i.e. menu -> add -> menu -> q)
- add web client to talk to Turso database
- add way to read md file, perform subs/regex to sanitize for SQL
- write tests on a test db so I don't nuke prod

## Development

```sh
    gleam run   # Run the project
    gleam test  # Run the tests
```
