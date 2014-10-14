=begin
Copyright 2014 Michal Papis <mpapis@gmail.com>

See the file LICENSE for copying permission.
=end

require "command-designer/version"

# Store and apply filters using blocks
class CommandDesigner::Filters

  # initialize the filters hash
  def initialize
    @filters = {}
  end

  # stores the block for given options, if the options have a block
  # already the new one is added to the list
  # @param options [Hash,nil] options for filtering blocks
  # @param block   [Proc]     block of code to add to the list of blocks
  #                           for this options
  def store(options = {}, &block)
    @filters[options] ||= []
    @filters[options] << block
  end

  # applies matching filters to the given method
  # @param method  [Method] an object method that takes a transformation
  #                         block as param
  # @param options [Hash]   a filter for selecting matching blocks
  def apply(method, options = {})
    @filters.fetch(options, []).each{|block| method.call(&block) }
  end

  # Array of already defined filters
  def filters
    @filters.keys
  end

end
