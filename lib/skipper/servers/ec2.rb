require 'aws'
require 'table_print'

module Skipper
  module Servers
    class EC2
      attr_reader :options

      def initialize(options)
        @options = options
      end

      def instances
        find_instances
      end

      def hosts
        instances.map { |instance| instance.ip_address }
      end

      def to_s
        tp instances, include: [ :id, :ip_address ]
      end

      private

        def ec2
          @ec2 ||= AWS::EC2.new(region: options[:region])
        end

        def find_instances
          instances = ec2.instances
          options.tags.each do |tag, value|
            instances.filter("tag:{tag}", value)
          end
          instances
        end

    end
  end
end
