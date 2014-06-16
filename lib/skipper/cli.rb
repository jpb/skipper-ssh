  module Skipper
  class Cli < Thor
    include Thor::Actions

    namespace :skipper
    default_task :run_commands

    desc 'run_commands', 'Run a command on remote servers'
    method_option :servers,              type: :array

    method_option :region,               type: :string,   default: 'us-east-1'
    method_option :tags,                 type: :hash,     default: {}
    method_option :auto_scaling_groups,  type: :array,    default: []
    method_option :auto_scaling_roles,   type: :array,    default: []

    method_option :user,                 type: :string
    method_option :run_in,               type: :string
    method_option :wait,                 type: :string
    method_option :limit,                type: :string
    method_option :output,               type: :boolean,  default: true
    def run_commands
      Skipper::Banner.print
      Skipper::Repl.new(options, self).run
    end

  end
end
