require 'execjs'

module Jade
  class Compiler
    attr_accessor :options

    def initialize(options={})
      @options = {
        :compileDebug => false
      }.merge options
    end

    def source
      @source ||= %{
        var window = {};
        #{Jade::Source::jade}
        var jade = window.jade;
      }
    end

    def context
      @context ||= ExecJS.compile source
    end

    def jade_version
      "1.3.0"
    end

    def compile(template)
      template = template.read if template.respond_to?(:read)
      context.eval(
        "jade.compileClient(#{template.to_json}, #{@options.to_json})")
    end
  end
end
