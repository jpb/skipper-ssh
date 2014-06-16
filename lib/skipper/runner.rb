require 'sshkit'
require 'sshkit/dsl'

module Skipper
  class Runner
    attr_reader :servers, :options, :cli

    def initialize(servers, options = {}, cli)
      @servers = servers
      @options = options
      @cli = cli

      SSHKit::Backend::Netssh.configure do |ssh|
        ssh.ssh_options = ssh_options
      end

      SSHKit.config.output_verbosity = Logger::DEBUG if options.output?
    end

    def run(command)
      on servers.hosts, on_options do
        execute command
      end
    rescue SSHKit::Runner::ExecuteError => e
      cli.say e, :red
    rescue Interrupt
      puts ''
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
          opts[key] = options[key].to_i if options.send("#{key}?")
        end

        opts
      end

      def ssh_options
        opts = {}
        opts[:keys]          = [options.identity_file] if options.identiy_file?
        opts[:user]          = options.user
        opts[:forward_agent] = options.foward_agent
        opts
      end

  end
end
