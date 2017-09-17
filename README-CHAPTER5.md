# Chapter 5 - Filling in the layout

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

## Site navigation

```html
<!-- In app/views/layouts/application.html.erb -->
...

    <header class="navbar navbar-fixed-top navbar-inverse">
      <div class="container">
        <%= link_to "sample app", '#', id: "logo" %>
        <nav>
          <ul class="nav navbar-nav navbar-right">
            <li><%= link_to "Home",   '#' %></li>
            <li><%= link_to "Help",   '#' %></li>
            <li><%= link_to "Log in", '#' %></li>
          </ul>
        </nav>
      </div>
    </header>
    <div class="container">
      <%= yield %>

    </div>
...
```

## The Home page with a link to the signup page

```html
<!-- app/views/static_pages/home.html.erb -->
...

    <header class="navbar navbar-fixed-top navbar-inverse">
      <div class="container">
        <%= link_to "sample app", '#', id: "logo" %>
        <nav>
          <ul class="nav navbar-nav navbar-right">
            <li class="nav-item"><%= link_to "Home", class: "nav-link" %></li>
            <li class="nav-item"><%= link_to "Help", class: "nav-link" %></li>
            <li class="nav-item"><%= link_to "Log in", class: "nav-link"%></li>
          </ul>
        </nav>
      </div>
    </header>
    <div class="container">
      <%= yield %>
    </div>
...
```
To see the rest of the layout see link below:

[Chapter 5 layout](https://www.railstutorial.org/book/filling_in_the_layout)

[Bootstrap-rubygem](https://github.com/twbs/bootstrap-rubygem)

[Bootstrap 4 Beta 4.0](https://getbootstrap.com/docs/4.0/getting-started/introduction/)

---

## Rails routes

To add the named routes for the sample app’s static pages, we’ll edit the routes file, config/routes.rb

```rb
# In routes.rb

root 'application#hello'    # in the hello app 

root 'users#index'          # in the toy app

root 'static_pages#home'    # in the sample app

```

- In Rails we follow the common convention of using the `_path form`.

- `except` when doing `redirects`, where we’ll use the _url form.

`Define shorter named routes for the Help, About, and Contact pages`.

```rb
# In routes.rb

get 'static_pages/help'                # from this

get  '/help', to: 'static_pages#help'  # to this

```

> This new pattern routes a GET request for the URL /help to the help action in the Static Pages controller. As with the rule for the root route, this creates two named routes, help_path and help_url

> Do this to the rest of the routes.

`It’s possible to use a named route other than the default using the as: option`

```rb
get  '/help', to: 'static_pages#help', as: 'helf'
```
---

