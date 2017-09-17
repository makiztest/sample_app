# Chapter 6 - Modeling users

##### LEARN WEB DEVELOPMENT WITH RAILS - *by Michael Hartl*

`I dont own any of the content of this. I'm just using this for educational purposes to teach myself about ruby on rails and i highly recommended it.`

To learn more about this please go to this link [Ruby on Rails Tutorial by Michael Hartl](https://www.railstutorial.org/book)

## Generating a User model

```scss
// TYPE IN TERMINAL
$ rails generate model User name:string email:string
```
> This generate a User model with name and email attributes.

## Name conventions creating Controllers and Model

|Model                 |Controllers      |
|----------------------|-----------------|
|Singular - without `S`|Plural - with `S`|

- The migration itself consists of a `change method` that determines the change to be made to the database.
    - change uses a Rails method called `create_table` to create a table in the database for storing users.
    - The create_table method accepts a block with `one block variable`, in this case called `t`.

- Here the `table name is plural` (users) even though the model name is singular (User).
    - a model represents a single user, whereas a database table consists of many users.

Now we can run the migration.
```scss
// TYPE IN TERMINAL
$ rails db:migrate
```

## The model file

- The syntax class `User < ApplicationRecord` means that the User class inherits from the ApplicationRecord class.

- Which in turn inherits from `ActiveRecord::Base`, so that the `User model` automatically has `all the functionality` of the ActiveRecord::Base class.

## Creating user objects
Since we don’t (yet) want to make any changes to our database, we’ll start the console in a sandbox.

```scss
// TYPE IN TERMINAL
$ rails console --sandbox
```
> Any modifications you make will be rolled back on exit.

```scss
// TYPE IN THE CONSOLE
User.new
```
> User.new only creates an object in memory
```scss
// TYPE IN THE CONSOLE
user = User.new(name: "Mark Delos Reyes", email: "markdr@example.com")
```
> The notion of validity is important
```scss
// TYPE IN THE CONSOLE
user.valid?
```
In order to save the User object to the database, we need to call the `save method` on the user variable.
```scss
// TYPE IN THE CONSOLE
user.save
```
Let’s see if our save changed anything.
```scss
// TYPE IN THE CONSOLE
user
```
```scss
// TYPE IN THE CONSOLE
// You should see something like this
=> #<User:0x007fec44e41780
 id: 1,
 name: "Mark Delos Reyes",
 email: "markdr@example.com",
 created_at: Sun, 17 Sep 2017 13:29:31 UTC +00:00,
 updated_at: Sun, 17 Sep 2017 13:29:31 UTC +00:00>
[6] sample_app(main)>
user.save
```
- User model allow access to their attributes using a dot notation.

```scss
// TYPE IN THE CONSOLE
// You should see something like this
[6] sample_app(main)> user.name
=> "Mark Delos Reyes"
[7] sample_app(main)> user.email
=> "markdr@example.com"
[8] sample_app(main)> user.id
=> 1
[9] sample_app(main)>
```

Active Record also lets you combine them into one step with `User.create`
```scss
// TYPE IN THE CONSOLE
User.create(name: "A Nother", email: "another@example.org")

// You should see something like this
   (0.1ms)  SAVEPOINT active_record_1
  SQL (0.1ms)  INSERT INTO "users" ("name", "email", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["name", "A Nother"], ["email", "another@example.org"], ["created_at", "2017-09-17 13:36:36.511906"], ["updated_at", "2017-09-17 13:36:36.511906"]]
   (0.1ms)  RELEASE SAVEPOINT active_record_1
=> #<User:0x007fec4788a1e0
 id: 2,
 name: "A Nother",
 email: "another@example.org",
 created_at: Sun, 17 Sep 2017 13:36:36 UTC +00:00,
 updated_at: Sun, 17 Sep 2017 13:36:36 UTC +00:00>
[10] sample_app(main)>
```
```scss
// TYPE IN THE CONSOLE
foo = User.create(name: "Foo", email: "foo@bar.com")
```
> Note that User.create, rather than returning true or false, returns the User object itself

The inverse of create is `destroy`
```scss
// TYPE IN THE CONSOLE
foo.destroy
```

## Finding user objects
```scss
// TYPE IN THE CONSOLE
User.find(1)
```
> Here we’ve passed the id of the user to User.find; Active Record returns the user with that id

In addition to the generic find, Active Record also allows us to `find users by specific attributes`
```scss
// TYPE IN THE CONSOLE
User.find_by(email: "markdr@example.com")
```
We’ll end with a couple of more general ways of finding users. 

1 . `.first`
```scss
// TYPE IN THE CONSOLE
User.first
```
2. `.all`
```scss
// TYPE IN THE CONSOLE
User.all
```

## Updating user objects
`Once we’ve created objects, we often want to update them.`

- There are two basic ways to do this. 
    1. First, we can assign attributes individually

```rb
# TYPE IN THE CONSOLE
user.email = 'markdr@example.net'  #change .com to .net

# then save your changes
user.save

# We can see what happens without a save by using reload
user.reload.email 
```
2. The second main way to update multiple attributes is to use `update_attributes`
```rb
# TYPE IN THE CONSOLE
user.update_attributes(name: "The Dude", email: "dude@abides.org")
```
> The update_attributes method accepts a hash of attributes, and on success `performs both the update and the save in one step`.

## User validations
- we shouldn’t allow name and email to be just any strings; we should enforce certain constraints on their values.
    - Active Record allows us to impose such constraints using `validations`
    - the way to validate the presence of the `name attribute` is to use the validates method with argument `presence: true`
```rb
# In app/models/user.rb
class User < ApplicationRecord
  validates :name, presence: true
end
```

## Length validation
- we need to use the validation argument to `constrain length`, which is just length, along with the maximum parameter to enforce the upper bound.
```rb
# In app/models/user.rb
#class User < ApplicationRecord
  #validates :name,  presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }
#end
```

## Format validation
- Neither the tests nor the validation will be exhaustive, just good enough to accept most valid email addresses and reject most invalid ones

`VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i`

- Breaking down the valid email regex

|Expression                          |Meaning                                          |
|------------------------------------|-------------------------------------------------|
|/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i|full regex                                       |
|/                                   |start of regex                                   |
|\A                                  |match start of a string                          |
|[\w+\-.]+                           |at least one word character, plus, hyphen, or dot|
|@                                   |literal “at sign”                                |
|[a-z\d\-.]+                         |at least one letter, digit, hyphen, or dot       |
|\.                                  |literal dot                                      |
|[a-z]+                              |at least one letter                              |
|\z                                  |match end of a string                            |
|/	                                 |end of regex                                     |
|i                                   |case-insensitive                                 |

The [Rubular website](http://www.rubular.com/) has a beautiful interactive interface for making regular expressions.

## Validating the email format with a regular expression
```rb
# In app/models/user.rb

#your code should be like this
class User < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }
end
```

- Check again create a new user and test if its valid and see the error message.
```rb
# check if the user is valid
user.valid?

# see error message
user.errors.full_messages
```

## Disallowing double dots in email domain names
```rb
# In app/models/user.rb

#class User < ApplicationRecord
  #validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  #validates :email, presence:   true, length: { maximum: 255 },
                    #format:     { with: VALID_EMAIL_REGEX }
#end

# we add this regex code
(\.[a-z\d\-]+)*
```

## Uniqueness validation
- To enforce uniqueness of email addresses (so that we can use them as usernames), we’ll be using the `:unique option` to the validates method.

Validating the uniqueness of email addresses
```rb
# In app/models/user.rb

#class User < ApplicationRecord
#  validates :name,  presence: true, length: { maximum: 50 }
#  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
#  validates :email, presence: true, length: { maximum: 255 },
#                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
end
```