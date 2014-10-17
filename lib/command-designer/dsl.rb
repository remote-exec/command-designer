=begin
Copyright 2014 Michal Papis <mpapis@gmail.com>

See the file LICENSE for copying permission.
=end

require "command-designer/command"
require "context-filters"

# Add support for +command+ in +Context+ using +Filters+
class CommandDesigner::Dsl < ContextFilters::Context

  # evaluates the given command_name in current context (applies matching filters)
  # @param command_name [String] the command name to evaluate
  # @param args         [String] rest of command arguments
  # @return             [String] the evaluated value of command name
  def command(command_name, *args)
    cmd = CommandDesigner::Command.new(command_name, *args)
    evaluate_filters(cmd.method(:change))
    cmd.command
  end

end
