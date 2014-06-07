module Skipper
  class Runner
    attr_accessor :servers, :options

    def initialize(servers = [], options)
      @servers = servers
    end

    def run(command)
      on servers, on_options do
        as options.user do
          execute command
        end
      end
    end

    private

      def on_options
        opts = {}

        [:in, :limit, :wait].each do |key|
          opts[key] = options[key] unless options[key].nil?
        end

        opts
      end

  end
end
