=begin
Copyright 2014 Michal Papis <mpapis@gmail.com>

See the file LICENSE for copying permission.
=end

require "shellwords"
require "command-designer/version"

# A concpet of command that can be extended multiple times
#
# @example
#
#   command = CommandDesigner::Command.new("test")
#   command.change {|command| "env #{command}" }
#   command.command # => "env test"
#
class CommandDesigner::Command

  # @return [String] current value of the command
  attr_reader :command

  # @return [Array] initial value of the command and parameters
  attr_reader :initial_command

  # initialize +command+ and +initial_command+
  # @param args [Array<String>] The command name to build upon
  def initialize(*args)
    @initial_command = args || []
    reset
  end

  # reset command to it's initial state
  def reset
    @command = Shellwords.join(@initial_command)
  end

  # Yields a block to change the command
  # @yield              [command] a block to change the command
  # @yieldparam command [String]  the current command
  # @return             [String]  the new command
  def change(&block)
    @command = yield @command
  end

  # @return [String] just the first part of the command: +command_name+
  def command_name
    @initial_command.first
  end

  # @return [Boolean] true if other object equals command_name, false otherwise
  def ==(other)
    self.command_name == other
  end

end
