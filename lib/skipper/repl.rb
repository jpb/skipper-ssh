require 'readline'

module Skipper
  class Repl
    attr_accessor :options, :runner, :cli, :servers

    def initialize(options, cli)
      @options = options
      @cli = cli

      if options.servers?
        @servers = Skipper::Servers::Basic.new(options)
      else
        @servers = Skipper::Servers::EC2.new(options)
      end

      @runner = Skipper::Runner.new(@servers, options, cli)
    end

    def run
      ARGV.clear
      loop do
        repl
      end
    end

    private

      def repl
        while command = Readline.readline("> ", true)
          handle_command(command.chomp)
        end
      end

      def handle_command(command)
        case command
        when 'h'
        when 'help'
          print_help
        when 'servers'
          print_servers
        when 'quit'
        when 'exit'
          quit
        else
          runner.run(command)
        end
      end

      def print_help
        puts %q[Skipper Help

help    - this message
servers - list the servers that commands will be executed on
exit    - bye, bye]
      end

      def print_servers
        puts servers.to_s
      end

      def quit
        puts 'See ya!'
        exit 0
      end

  end
end
