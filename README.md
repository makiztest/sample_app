# Chapter 3 - Mostly Static Pages

##### LEARN WEB DEVELOPMENT WITH RAILS - *by Michael Hartl*

<details>
<summary>Click this for Michael's instruction</summary>

# Ruby on Rails Tutorial sample application

This is the sample application for
[*Ruby on Rails Tutorial:
Learn Web Development with Rails*](http://www.railstutorial.org/)
by [Michael Hartl](http://www.michaelhartl.com/).

## License

All source code in the [Ruby on Rails Tutorial](http://railstutorial.org/)
is available jointly under the MIT License and the Beerware License. See
[LICENSE.md](LICENSE.md) for details.

## Getting started

To get started with the app, clone the repo and then install the needed gems:

```
$ bundle install --without production
```

Next, migrate the database:

```
$ rails db:migrate
```

Finally, run the test suite to verify that everything is working correctly:

```
$ rails test
```

If the test suite passes, you'll be ready to run the app in a local server:

```
$ rails server
```

For more information, see the
[*Ruby on Rails Tutorial* book](http://www.railstutorial.org/book).

</details>

`I dont own any of the content of this. I'm just using this for educational purposes to teach myself about ruby on rails and i highly recommended it.`

To learn more about this please go to this link [Ruby on Rails Tutorial by Michael Hartl](https://www.railstutorial.org/book)

```scss
// TYPE IN TERMINAL
$ rails new sample_app
```

> generating the application skeleton using the rails new command with a specific Rails version number

---
`You should have the same Gemfile codes`
<details>
<summary>Gemfile.rb</summary>

```rb
# In /Gemfile.rb
source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails', '~> 5.1.4'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
# gem 'therubyracer', platforms: :ruby
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
# gem 'redis', '~> 3.0'
# gem 'bcrypt', '~> 3.1.7'
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'sqlite3', '1.3.13'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'rails-controller-testing', '1.0.2'
  gem 'minitest-reporters',       '1.1.14'
  gem 'guard',                    '2.13.0'
  gem 'guard-minitest',           '2.4.4'
end

group :production do
  gem 'pg', '0.21.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
```

We will install the local gems while suppressing the installation of production gems using the --without production option

```scss
// TYPE IN TERMINAL

$ bundle install --without production
```

> This arranges to skip the pg gem for PostgreSQL in development and use SQLite for development and testing.

> `Heroku recommends against using different databases in development and production`, but for the sample application it won’t make any difference, and SQLite is much easier than PostgreSQL to install and configure locally.

> `In case you’ve previously installed a version of a gem` (such as Rails itself) other than the one specified by the Gemfile, `it’s a good idea to update the gems with bundle update` to make sure the versions match.

```scss
// TYPE IN TERMINAL

$ bundle update
```

</details>

---

Set the controller
```rb
# In application_controller.rb
#...

def hello
    render html: "Hello World!"
  end

#...
```

Set the routes 
```rb
# In application_controller.rb
#...

root "application#hello"

#...
```

> To avoid integration headaches later on, it’s also a good idea to deploy the app to Heroku even at this early stage

```scss
// IN TERMINAL TYPE
$ git add -A
$ git commit -am "Add hello"
$ git push
$ heroku create
$ git push heroku master
```
> If you run into problems at Heroku, make sure to take a look at the production logs to try to diagnose the problem.

```scss
// IN TERMINAL TYPE
$ heroku logs
```

## <u>Static pages</u>

- In this section, we’ll be working mainly in the app/controllers and app/views directories

It’s a good practice to do our work on a separate topic branch rather than the master branch

```scss
// IN TERMINAL TYPE
$ git checkout -b static-pages
```

## <u>Generated static pages</u>
- first generate a controller using the same Rails generate script we used to generate scaffolding.

```scss
// IN TERMINAL TYPE
$ rails generate controller StaticPages home help
```

- We create a static_pages_controller.rb
- We created the static_pages folder in views
- Inside that folder scaffold generated two erb files `home.html.erb & help.html.erb`
- Inside the routes.rb you will see the routes created for home & help

### `Some Rails Shortcut command`

|Full command    |Shortcut |
|----------------|---------|
|$ rails server  |$ rails s|
|$ rails console |$ rails c|
|$ rails generate|$ rails g|
|$ rails test    |$ rails t|
|$ bundle install|$ bundle |

```scss
// IN TERMINAL TYPE
$ rails generate controller StaticPages home help
```

---
## Undoing things
<details>
<summary>CLICK TO SEE SOLUTIONS TO UNDO</summary>

- Even when you’re very careful, things can sometimes go wrong when developing Rails applications. Happily, Rails has some facilities to help you recover.

```scss
$ rails generate controller StaticPages home help

//can be undo using this
$ rails destroy  controller StaticPages home help
```

```scss
$ rails generate model User name:string email:string

//can be undo using this
$ rails destroy model User
```

```scss
$ rails db:migrate

//can be undo using this
$ rails db:rollback
```

```scss
//To go all the way back to the beginning, we can use
$ rails db:migrate VERSION=0
```
</details>

---

```rb
# THE `home` and `help` routes was generated by the scaffold

Rails.application.routes.draw do
  get  'static_pages/home'
  get  'static_pages/help'
  root 'application#hello'
end
```

> When we do a get request for home or help the route respond to the request and will generate the home or help static page rendered by view. 

- `GET is the most common HTTP operation`, used for reading data on the web; it just means `“get a page”`.

- `POST requests` are typically used for `creating things` (although HTTP also allows POST to perform updates).
  - the POST request sent when you submit a registration form creates a new user on the remote site.

- The other two verbs, `PATCH` and `DELETE`, are designed for `updating` and `destroying` things on the remote server.

`To understand where this page comes from, let’s start by taking a look at the Static Pages controller`

- We see from the `class keyword` the static_pages_controller.rb defines a class.
  - class called `StaticPagesController`.

- Classes are simply a convenient way to organize functions (also called methods) like the home and help actions, which are defined using the def keyword.

- the `angle bracket <` indicates that `StaticPagesController inherits` from the Rails `class ApplicationController`.

In the case of the Static Pages controller, both of its methods are initially empty.

```rb
# See static_pages_controller.rb
# ...

def home
end

def help
end

#...
```

> In plain ruby this methods will define nothing. but because it inherits from application controller. rails looks in the static page controller and executes the code in home inside view and render the page.

> Check view to see what the code looks like. This wall auto generated by the scaffold.

--- 

## <u>Custom static pages</u>

Lets do some simple custom content in our home page.

```html
<!-- Go to app/views/static_pages/home.html.erb -->

<h1>Sample App</h1>
<p>
  This is the home page for the
  <a href="http://www.railstutorial.org/">Ruby on Rails Tutorial</a>
  sample application.
</p>
```

```html
<!-- Go to app/views/static_pages/help.html.erb -->

<h1>Help</h1>
<p>
  Get help on the Ruby on Rails Tutorial at the
  <a href="http://www.railstutorial.org/help">Rails Tutorial help page</a>.
  To get help on this sample app, see the
  <a href="http://www.railstutorial.org/book"><em>Ruby on Rails Tutorial</em>
  book</a>.
</p>
```

## <u>Getting started with testing</u>

- When making a change of this nature, it’s a good practice to write an automated test to verify that the feature is implemented correctly.

### `Our main testing tools`
1. controller tests `(We will do in this section)`
2. model tests 
3. integration tests

## Our first test
Now it’s time to add an About page to our application.

- Rails has already done the hardest part for us, because rails generate controller automatically generated a test file to get us started.

To see the rest of the test tutorial go to this link [Initial test](https://www.railstutorial.org/book/static_pages)