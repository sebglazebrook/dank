module Dank
  module Models
    class Expression

      attr_accessor :regex, :expression

      def initialize(params = {})
        @regex = params[:regex]
        @expression = params[:expression]
      end

      def ==(operand)
        if operand.kind_of?(self.class) && instance_variables_match(operand)
          true
        else
          false
        end
      end

      def instance_variables_match(dank_expression)
        dank_expression.regex == self.regex && dank_expression.expression == self.expression
      end

      def method_missing(method_name, *args, &block)
        if Dank::Evaluator.can_evaluate?(method_name.to_s, args)
          merge(Dank::Evaluator.evaluate(method_name.to_s, args))
        else
          super
        end
      end

      private

      def merge(new_expression)
        add_expression(new_expression.expression)
        merge_regex(new_expression.regex)
        self
      end

      def add_expression(new_expression)
        if expression.is_a?(String)
          @expression = [expression, new_expression]
        else
          @expression << new_expression
        end
      end

      def merge_regex(new_regex)
        current_string = regex.to_s.match(/\(\?-mix:(.*)\)/)[1]
        new_string = new_regex.to_s.match(/\(\?-mix:(.*)\)/)[1]
        @regex = Regexp.new(current_string + new_string)
      end
    end
  end
end