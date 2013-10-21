We are on Heroku at eyepark.herokuapp.com

**To interact with locally:**

```
bundle install
rake db:create db:migrate
rake db:seed
rails server
```

After starting the server locally for the first time you will have to create a test user to interact with the site.

**To run the tests:**

```
rake db:test:prepare
rspec
```