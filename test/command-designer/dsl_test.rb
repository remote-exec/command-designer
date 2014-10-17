=begin
Copyright 2014 Michal Papis <mpapis@gmail.com>

See the file LICENSE for copying permission.
=end

require "test_helper"
require "command-designer/dsl"

describe CommandDesigner::Dsl do
  subject do
    CommandDesigner::Dsl.new
  end

  describe "top level" do

    it "handles top level commands" do
      subject.command("true").must_equal("true")
    end

    it "handles filtered commands" do
      subject.filter(nil) do |command| "env #{command}" end
      subject.command("true").must_equal("env true")
      subject.command("false").must_equal("env false")
    end

    it "does not filter commands that are not in context" do
      subject.filter(nil, :commands) do |command| "command #{command}" end
      subject.command("true").must_equal("true")
    end

    it "does not call evaluate_command for no filters" do
      subject.expects(:evaluate_filters).once
      subject.command("true")
    end

    it "handles filtered targeted commands" do
      subject.filter(nil, {:target => "true"}) do |command| "env #{command}" end
      subject.command("false").must_equal("false")
      subject.command("true").must_equal("env true")
    end

    it "handles filtered targeted commands in context" do
      subject.filter(nil, {:target => "true"}) do |command| "env #{command}" end
      subject.in_context({:a=>3}) do
        subject.command("false").must_equal("false")
        subject.command("true").must_equal("env true")
      end
    end

  end #"top level"

end
