require 'sshkit'
require 'sshkit/dsl'

module Skipper
  class Runner
    attr_reader :servers, :options

    def initialize(servers = [], options = {})
      @servers = servers
      @options = options
    end

    def run(command)
      on servers, on_options do
        execute command
      end
    rescue SSHKit::Runner::ExecuteError => e
      puts e
    end

    private

      def on_options
        opts = {}

        [:in, :limit, :wait].each do |key|
          opts[key] = options[key] if options.key?(key) && !options[key].nil?
        end

        opts
      end

  end
end
