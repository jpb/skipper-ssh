require 'readline'

module Skipper
  class Repl
    attr_accessor :options, :runner

    def initialize(options)
      @options = options
      @runner = Skipper::Runner.new(options[:servers], options)
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
          help
        when 'servers'
          servers
        when 'quit'
        when 'exit'
          quit
        else
          runner.run(command)
        end
      end

      def help
        puts %q[Skipper Help

help    - this message
servers - list the servers that commands will be executed on
exit    - bye, bye]
      end

      def servers
        puts options.servers.join("\n")
      end

      def quit
        puts 'See ya!'
        exit 0
      end

  end
end
