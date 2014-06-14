module Skipper
  class Cli < Thor
    include Thor::Actions

    namespace :skipper
    default_task :run_commands

    desc 'run_commands', 'Run a command on remote servers'
    method_option :servers, type: :array
    method_option :filter,  type: :hash
    def run_commands
      Skipper::Banner.print
      Skipper::Repl.new(options).run
    end

  end
end
