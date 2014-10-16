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
#   command.command_name # => "env test"
#
class CommandDesigner::Command

  # @return [String] current value of the command
  attr_reader :command_name

  # @return [Array] initial value of the command and parameters
  attr_reader :initial_command_name

  # initialize command and initila command name
  # @param command_name [String] The command name to build upon
  def initialize(*args)
    @initial_command_name = args || []
    reset
  end

  # reset command to it's initial state
  def reset
    @command_name = Shellwords.join(@initial_command_name)
  end

  # Yields a block to change the command_name
  # @yield      [command_name] a block to change the command
  # @yieldparam command_name [String] the current command
  # @return     [String] the new command
  def change(&block)
    @command_name = yield @command_name
  end

end
