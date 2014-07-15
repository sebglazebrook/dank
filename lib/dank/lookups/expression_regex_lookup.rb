module Dank
  module Lookups
    class ExpressionRegexLookup

      def self.lookup expression
        expression_regex_lookup[expression]
      end

      private

      def self.expression_regex_lookup
        {
            'any' => '*',
            'at_least_one' => '+',
            'letters' => '[a-zA-Z]',
            'lowercase_letters' => '[a-z]',
            'uppercase_letters' => '[A-Z]',
            'numbers' => '\d',
            'number' => '\d',
            'letter' => '[a-zA-Z]',
            'lowercase_letter' => '[a-z]',
            'uppercase_letter' => '[A-Z]',
        }
      end
    end
  end
end