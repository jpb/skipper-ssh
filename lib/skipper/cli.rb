module Skipper
  class Cli < Thor
    include Thor::Actions

    namespace :default
    default_task :ssh

    desc 'ssh', 'Run a command on remote servers'
    method_option :servers,              type: :array

    method_option :region,               type: :string,   default: 'us-east-1'
    method_option :tags,                 type: :hash,     default: {}
    method_option :auto_scaling_groups,  type: :array,    default: []
    method_option :auto_scaling_roles,   type: :array,    default: []

    method_option :identity_file,        type: :string
    method_option :forward_agent,        tyep: :boolean,  default: false
    method_option :user,                 type: :string,   default: `whoami`.strip

    method_option :run_in,               type: :string
    method_option :wait,                 type: :numeric
    method_option :limit,                type: :numeric
    method_option :output,               type: :boolean,  default: true

    method_option :file,                 type: :string
    def ssh
      warn_options unless enough_options?

      Skipper::Banner.print

      if Skipper::File.stdin_has_data?
        Skipper::File.new(options, self).run($stdin)
      elsif options.file?
        Skipper::File.new(options, self).run(::File.new(options.file))
      else
        Skipper::Repl.new(options, self).run
      end
    end

    private

      def warn_options
        error "You haven't provided me any way to find servers\n\n"
        help :ssh
        exit 1
      end

      def enough_options?
        options.servers? or aws_options?
      end

      def aws_options?
        ! (options.tags.count == 0 and options.auto_scaling_groups.count == 0 and options.auto_scaling_roles.count == 0)
      end

  end
end
