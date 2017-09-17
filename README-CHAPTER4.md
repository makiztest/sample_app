# Chapter 4 - Rails-flavored Ruby

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

## <u>Built-in helpers</u>

```rb
# See yield

<%= yield(:title) %> | Ruby on Rails Tutorial Sample App
```
```rb
# See provide

<% provide(:title, "Home") %>
<h1>Sample App</h1>
<p>
  This is the home page for the
  <a href="http://www.railstutorial.org/">Ruby on Rails Tutorial</a>
  sample application.
</p>
```
- To solve the problem of a missing page title, we’ll define a custom helper called `full_title`.
    - The `full_title helper` returns a base title, “Ruby on Rails Tutorial Sample App”, if no page title is defined, and adds a vertical bar preceded by the page title if one is defined
```rb
# In app/helpers/application_helper.rb

module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "Ruby on Rails Tutorial Sample App"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end
```
Now that we have a helper, we can use it to simplify our layout by replacing
```rb
# In application.html.erb

<title><%= yield(:title) %> | Ruby on Rails Tutorial Sample App</title>
```

with

```rb
<title><%= full_title(yield(:title)) %></title>
```

see link for test update here [Test update](https://www.railstutorial.org/book/rails_flavored_ruby)

---

## Method definitions
Define a function string_message that takes a single argument and returns a message based on whether the argument is empty or not.

```rb

def string_message(str = ' ')
  if str.empty?
  put 'Its an empty string'
  else 
  put 'The string is not empty'
end

```


