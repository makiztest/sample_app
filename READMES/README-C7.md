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

## A Gravatar image and a sidebar

We’ll now flesh it out a little with a `profile image` for each user and the first cut of the `user sidebar`.

- We’ll start by adding a `“globally recognized avatar”`, or `Gravatar`, to the user profile.
  - Gravatars are a convenient way to include user profile images without going through the trouble of managing image upload, cropping, and storage; all we need to do is construct the proper Gravatar image URL using the user’s email address and the corresponding Gravatar image will automatically appear.

Our plan is to define a gravatar_for helper function to return a Gravatar image for a given user.
```rb
# In app/views/users/show.html.erb

<% provide(:title, @user.name) %>
<h1>
  <%= gravatar_for @user %>
  <%= @user.name %>
</h1>
```

### Defining a gravatar_for helper method.
```rb
# In app/helpers/users_helper.rb
module UsersHelper

  # Returns the Gravatar for the given user.
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
```
> This helper Returns an image tag for the Gravatar with a gravatar CSS class and alt text equal to the user’s name (which is especially convenient for sight-impaired users using a screen reader)

> The profile page appears which shows the default Gravatar image, which appears because user@example.com isn’t a real email address.

### To get our application to display a custom Gravatar
- we’ll use `update_attributes` to change the user’s email to something I control.

```rb
# In the console TYPE
>> user = User.first
>> user.update_attributes(name: "Example User", email: "example@railstutorial.org", password: "foobar", password_confirmation: "foobar")
```

### Creating the sidebar

```rb
# In app/views/users/show.html.erb

<% provide(:title, @user.name) %>
<div class="row">
  <aside class="col-md-4">
    <section class="user_info">
      <h1>
        <%= gravatar_for @user %>
        <%= @user.name %>
      </h1>
    </section>
  </aside>
</div>
```

## Signup form

### Using `form_for`

```rb
# In app/controllers/users_controller.rb

#class UsersController < ApplicationController

#  def show
#    @user = User.find(params[:id])
#  end

#  def new
    @user = User.new
#  end
#end
```

# Create the form in views
```rb
# In app/views/users/new.html.erb

<% provide(:title, 'Sign up') %>
<h1>Sign up</h1>

<div class="row">
  <div class="col-md-6 col-md-offset-3">
    <%= form_for(@user) do |f| %>
      <%= f.label :name %>
      <%= f.text_field :name %>

      <%= f.label :email %>
      <%= f.email_field :email %>

      <%= f.label :password %>
      <%= f.password_field :password %>

      <%= f.label :password_confirmation, "Confirmation" %>
      <%= f.password_field :password_confirmation %>

      <%= f.submit "Create my account", class: "btn btn-primary" %>
    <% end %>
  </div>
</div>
```

## Signup form HTML

The presence of the do keyword indicates that form_for takes a block with one variable, which we’ve called f (for “form”).

- What we do need to know is what the f object does: when called with a method corresponding to an HTML form element—such as a text field, radio button, or password field—f returns code for that element specifically designed to set an attribute of the @user object.

This embedded Ruby
```rb
<%= f.label :name %>
<%= f.text_field :name %>
```
Produce the HTML
```html
<label for="user_name">Name</label>
<input id="user_name" name="user[name]" type="text" />
```

## A working form
-  In particular, it ensures that a POST request to /users is handled by the create action. Our strategy for the create action is to use the form submission to make a new user object using User.new

- this opportunity to introduce an `if-else` branching structure.

  - Which allows us to handle the cases of failure and success separately based on the value of @user.save.
  - Which is either true or false depending on whether or not the save succeeds.

### A create action that can handle signup failure
```rb
# In app/controllers/users_controller.rb
...

def create
    @user = User.new(params[:user])    # Not the final implementation!
    if @user.save
      # Handle a successful save.
    else
      render 'new'
    end
  end

...
```

if you try to signup you will get an error

`ActiveModel::ForbiddenAttributesError in UsersController#create
ActiveModel::ForbiddenAttributesError
`
- Users controller as symbols, so that params[:user] is the hash of user attributes

```rb
@user = User.new(params[:user])

# is the same as 
@user = User.new(name: "Foo Bar", email: "foo@invalid",
                 password: "foo", password_confirmation: "bar")
```

> But the reason is that initializing the entire params hash is extremely dangerous—it arranges to pass to User.new all data submitted by a user.

- In the present instance, we want to require the params hash to have a :user attribute, and we want to permit the name, email, password, and password confirmation attributes (but no others).

```rb
params.require(:user).permit(:name, :email, :password, :password_confirmation)
```

- To facilitate the use of these parameters, it’s conventional to introduce an `auxiliary method` called `user_params` (which returns an appropriate initialization hash) and use it in place of params[:user]

```rb
@user = User.new(user_params)
```

> Since `user_params` will only be used internally by the Users controller and need not be exposed to external users via the web, we’ll `make it private` using `Ruby’s private keyword`.

```rb
class UsersController < ApplicationController
...

#  def create
    @user = User.new(user_params)
#    if @user.save
      # Handle a successful save.
#    else
#      render 'new'
#    end
#  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
```