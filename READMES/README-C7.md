# Chapter 7 - Sign Up

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

---

Like in previous chapters we will create a new branch before staring the sign up function that we will do

```rb
$ git checkout -b sign-up
```

- Adding some debug information to the site layout
```rb
# In app/views/layouts/application.html.erb

#<!DOCTYPE html>
#<html>
...

#  <body>
#    <%= render 'layouts/header' %>
#    <div class="container">
#      <%= yield %>
#      <%= render 'layouts/footer' %>
      <%= debug(params) if Rails.env.development? %>
#    </div>
#  </body>
#</html>
```

> to restrict the debug information to the development environment, which is one of three environments defined by default in Rails

### To make the debug output look nice, we’ll add some rules to the custom stylesheet.

```scss
// In app/assets/stylesheets/custom.scss

/* mixins, variables, etc. */

$gray-medium-light: #eaeaea;

@mixin box_sizing {
  -moz-box-sizing:    border-box;
  -webkit-box-sizing: border-box;
  box-sizing:         border-box;
}
.
.
.
/* miscellaneous */

.debug_dump {
  clear: both;
  float: left;
  width: 100%;
  margin-top: 45px;
  @include box_sizing;
}
```

`This introduces the Sass mixin facility, in this case called box_sizing. A mixin allows a group of CSS rules to be packaged up and used for multiple elements`

The debug output gives potentially useful information about the page being rendered.

```rb
# You will see this at the bottom of your webpage

controller: static_pages
action: home
```
This is a YAML5 representation of params, which is basically a hash, and in this case identifies the controller and action for the page.

## A Users resource
 - In order to make a user profile page, we need to have a user in the database

 We can get the routing for /users/1 to work by adding a single line to our routes file (config/routes.rb).

 - Adding a Users resource to the routes file

 ```rb
 # In config/routes.rb

 #Rails.application.routes.draw do
#  root 'static_pages#home'
#  get  '/help',    to: 'static_pages#help'
#  get  '/about',   to: 'static_pages#about'
#  get  '/contact', to: 'static_pages#contact'
#  get  '/signup',  to: 'users#new'
  resources :users
#end
```

### RESTful routes provided by the Users resource

|HTTP request  |URL       |Action |Named route         |Purpose                         |
|--------------|----------|-------|--------------------|--------------------------------|
|GET           |/users    |index  |users_path          |page to list all users          |
|GET           |/users/1  |show   |user_path(user)     |page to show user               |
|GET           |/users/new|new    |new_user_path       |page to make a new user (signup)|
|POST          |/users    |create |users_path          |create a new user               |
|GET           |/users/1/ |edit   |edit_user_path(user)|page to edit user with id 1     |
|PATCH         |/users/1  |update |user_path(user)     |update user                     |
|DELETE        |/users/1  |destroy|user_path(user)     |delete user                     |

## We’ll use the standard Rails location for showing a user

- Create a show template in view
```rb
# add this code temporarily 
<%= @user.name %>, <%= @user.email %>
```

### In order to get the user show view to work, we need to define an @user variable in the corresponding show action in the Users controller.

```rb
# In app/controllers/users_controller.rb

#class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

#  def new
#  end
#end
```

- Here we’ve used `params` to retrieve the `user id`
    - the effect is the same as the find method `User.find(1)`

## Debugger

Information in the debug could help us understand what’s going on in our application.
- using the byebug gem
    - To see how it works, we just need to add a line consisting of debugger to our application.

```rb
# In app/controllers/users_controller.rb

#class UsersController < ApplicationController

#  def show
#    @user = User.find(params[:id])
     debugger
#  end

#  def new
#  end
#end
```

