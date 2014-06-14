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
        @instances ||= find_instances
      end

      def hosts
        @hosts ||= instances.map { |instance| instance.ip_address }
      end

      def to_s
        @to_s ||= details_table
      end

      private

        def ec2
          @ec2 ||= AWS::EC2.new(region: options[:region])
        end

        def find_instances
          instances = ec2.instances
          options.tags.each do |tag, value|
            instances.filter("tag:{tag}", value.split(','))
          end
          instances
        end

        def details_table
          table = StringIO.new
          original_stdout, $stdout = $stdout, table

          tp(instances, :id, :ip_address)

          $stdout = original_stdout
          table.read
        end

    end
  end
end
