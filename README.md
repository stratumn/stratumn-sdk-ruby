# Stratumn SDK for Ruby

Interact with your Stratumn agent from your ruby application

code  :: https://github.com/stratumn/stratumn-sdk-ruby

## Installation

```
$ gem install stratumn-sdk
```

## Quickstart

```ruby
application = StratumnSdk::Application.load('quickstart')

link = application.create_map('My message map')

link = link.addMessage('Hello, World')

puts link.meta
puts link.state
```
 
## Reference
 
#### StratumnSdk::Application.load(name)
 
Returns an instance of StratumnSdk::Application.
 
```ruby
application = StratumnSdk::Application.load('quickstart')
puts application.id
```

#### StratumnSdk::Application#create_map(*args)

Creates a new map in the application.

```ruby
application = StratumnSdk::Application.load('quickstart')
link = application.create_map('My message map')
```

#### StratumnSdk::get_link(hash)

Returns an existing link.

```ruby
application = StratumnSdk::Application.load('quickstart')
link = application.get_link('aee5427')
```

#### StratumnSdk::get_map(map_id, tags = [])

Returns the links in a map, optionally filtered by tags.

```ruby
application = StratumnSdk::Application.load('quickstart')
links = application.get_map('aee5427', ['tag1', 'tag2'])
```

#### StratumnSdk::get_branches(hash, tags = [])

Returns he links whose previous hashes are the given hash, optionally filters by tags.

```ruby
application = StratumnSdk::Application.load('quickstart')
links = application.get_branches('aee5427', ['tag1', 'tag2'])
```

#### StratumnSdk::Link#previous

Returns the previous link of a link (its parent).

```ruby
application = StratumnSdk::Application.load('quickstart')
link = application.get_link('aee5427')
previous = link.previous
```

#### StratumnSdk::Link#load

Load a full link. Can be useful when you only have the meta data of links.

```ruby
application = StratumnSdk::Application.load('quickstart')
links = application.get_branches('aee5427')

links.map { |link| link.load }
```

#### StratumnSdk::Link#get_branches(tags)

Returns the links whose previous hashes are the hash of the link, optionally filters by tags.

```ruby
application = StratumnSdk::Application.load('quickstart')
link = application.get_link('aee5427')
link.get_branches(['tag1'])
```

#### StratumnSdk::Link#transition_function(*args)

Executes a transition function and returns the new link.

```ruby
application = StratumnSdk::Application.load('quickstart')
link = application.get_link('aee5427')
new_link = link.addMessage('Hello, World!')
```


## Developers:

After checking out the source, run:

```
$ rake newb
```

This task will install any missing dependencies, run the tests/specs,
and generate the RDoc.

## License:

(The MIT License)

Copyright (c) 2016 FIX

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.