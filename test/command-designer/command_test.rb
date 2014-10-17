=begin
Copyright 2014 Michal Papis <mpapis@gmail.com>

See the file LICENSE for copying permission.
=end

require "test_helper"
require "command-designer/command"

describe CommandDesigner::Command do
  subject do
    CommandDesigner::Command.allocate
  end

  it "initializes command" do
    subject.send(:initialize, "true")
    subject.command.must_equal("true")
    subject.initial_command.must_equal(["true"])
  end

  it "builds and resets the command" do
    subject.send(:initialize, "true")
    subject.change {|command| "env #{command}"}
    subject.command.must_equal("env true")
    subject.reset
    subject.command.must_equal("true")
  end

end
