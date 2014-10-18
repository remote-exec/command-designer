# Command Designer

[![Gem Version](https://badge.fury.io/rb/command-designer.png)](https://rubygems.org/gems/command-designer)
[![Build Status](https://secure.travis-ci.org/remote-exec/command-designer.png?branch=master)](https://travis-ci.org/remote-exec/command-designer)
[![Dependency Status](https://gemnasium.com/remote-exec/command-designer.png)](https://gemnasium.com/remote-exec/command-designer)
[![Code Climate](https://codeclimate.com/github/remote-exec/command-designer.png)](https://codeclimate.com/github/remote-exec/command-designer)
[![Coverage Status](https://img.shields.io/coveralls/remote-exec/command-designer.svg)](https://coveralls.io/r/remote-exec/command-designer?branch=master)
[![Inline docs](http://inch-ci.org/github/remote-exec/command-designer.png)](http://inch-ci.org/github/remote-exec/command-designer)
[![Yard Docs](http://img.shields.io/badge/yard-docs-blue.svg)](http://rubydoc.info/github/remote-exec/command-designer/master/frames)
[![Github Code](http://img.shields.io/badge/github-code-blue.svg)](https://github.com/remote-exec/command-designer)

Build command text based on multiple filters

## About

This is framework to build command strings based on current context.

### DSL Methods

- `initialize(priorities_array)` - sets up initial context, execute all
  methods on this instance, try priorities: `[:first, nil, :last]`
- `filter(priority, options) { code }` - create priority based filter
  for given options with the code bloc to execute
- `local_filter(filter_block) { code }` - define local `filter_block` to
  take effect for the given `code` block, it's tricky as it takes two
  lambdas, try: `local_filter(Proc.new{|cmd| "cd path && #{cmd}"}) { code }`
- `context(options) { code }` - build new context, options are for
  matching filters, all code will be executes in context of given options
- `command(name, *args)` - build command by evaluate global and local filters
  in the order of given priority, local filters are called after the `nil`
  priority or on the end

### Example

```ruby
subject = CommandDesigner::Dsl.new([:first, nil, :last])

subject.filter(:last,  {:server => "::2" }) {|cmd| "command #{cmd}" }
subject.filter(:first, {:target => "true"}) {|cmd| "env #{cmd}" }

subject.local_filter(Proc.new{|cmd| "cd /path && #{cmd}" }) do

  subject.command("true")  # => "cd /path && env true"
  subject.command("false") # => "cd /path && false"

end

subject.context(:server => "::2") do |server2|

  # the :last filter with "command" was applied on the end
  server2.command("true") # => "command env false"
  # you do not have to use the block variable, subject works fine too
  subject.command("false") # => "command false"

end
```
