module Dank
  module Builders
    class RegexBuilder

      attr_writer :expressions

      def build
        Dank::Models::Expression.new(regex: combined_regexes, expression: combined_expressions)
      end

      def add(evaluation)
        self.expressions << evaluation
      end

      def expressions
        @expressions ||= []
      end

      private

      def combined_regexes
        regex_string = expressions.inject('') do |memo, expression|
          memo += expression.regex
        end
        Regexp.new(regex_string)
      end

      def combined_expressions
        expressions.reverse.inject('') do |memo, expression|
          memo += "#{expression.expression}_"
        end[0..-2]
      end
    end
  end
end