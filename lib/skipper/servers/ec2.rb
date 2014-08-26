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
        @hosts ||= instances.map { |instance| instance.ip_address }.compact
      end

      def to_s
        @to_s ||= details_table(instances)
      end

      private

        def ec2
          @ec2 ||= AWS::EC2.new(region: options[:region])
        end

        def find_instances
          filtered = filter_tags(ec2.instances)
          filtered = filter_auto_scaling_groups(filtered)
          filter_auto_scaling_roles(filtered)
        end

        def filter_tags(filtered)
          options.tags.each do |tag, value|
            filtered = filtered.filter("tag:#{tag}", value.split(','))
          end
          filtered
        end

        def filter_auto_scaling_groups(filtered)
          options.auto_scaling_groups.each do |value|
            filtered = filtered.filter('tag:aws:autoscaling:groupName', value)
          end
          filtered
        end

        def filter_auto_scaling_roles(filtered)
          options.auto_scaling_roles.each do |value|
            filtered = filtered.filter('tag:aws:autoscaling:role', value)
          end
          filtered
        end

        def details_table(list)
          table = StringIO.new
          original_stdout, $stdout = $stdout, table

          tp(list, :id, :ip_address)

          $stdout = original_stdout
          table.read
        end

    end
  end
end
