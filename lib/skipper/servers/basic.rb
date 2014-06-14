module Skipper
  module Servers
    class Basic

      attr_reader :hosts

      def initialize(options)
        @hosts = options.servers
      end

      def to_s
        @hosts.join("\n")
      end

    end
  end
end
