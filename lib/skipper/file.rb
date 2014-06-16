require 'fcntl'

module Skipper
  class File
    attr_reader :options, :cli

    def initialize(options, cli)
      @options = options
      @cli = cli

      if options.servers?
        servers = Skipper::Servers::Basic.new(options)
      else
        servers = Skipper::Servers::EC2.new(options)
      end

      @runner = Skipper::Runner.new(servers, options, cli)
    end

    def self.stdin_has_data?
      $stdin.fcntl(Fcntl::F_GETFL, 0) == 0
    end

    def run(file)
      @runner.run(file.read)
    end
  end
end
