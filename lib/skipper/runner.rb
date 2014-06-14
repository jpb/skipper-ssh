require 'sshkit'
require 'sshkit/dsl'

module Skipper
  class Runner
    attr_reader :servers, :options

    def initialize(servers = [], options = {})
      @servers = servers
      @options = options

      SSHKit.config.output_verbosity = Logger::DEBUG if options.output?
    end

    def run(command)
      on servers, on_options do
        execute command
      end
    rescue SSHKit::Runner::ExecuteError => e
      puts e unless options.output?
    end

    private

      def run_in
        return options.run_in.to_sym if options.run_in?

        if options.limit?
          :groups
        elsif options.wait?
          :sequence
        else
          :parallel
        end
      end

      def on_options
        opts = { in: run_in }

        [:limit, :wait].each do |key|
          opts[key] = options[key] if options.key?(key) && !options[key].nil?
        end

        opts
      end

  end
end
