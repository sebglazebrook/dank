module Evaluators
  class ExpressionEvaluator

    def expression_regex_lookup
      {
        'any_letters' => /[a-zA-Z]*/,
        'any_lowercase_letters' => /[a-z]*/,
        'any_uppercase_letters' => /[A-Z]*/,
        'any_numbers' => /\d*/,
        'at_least_one_number' => /\d+/,
        'at_least_one_letter' => /[a-zA-Z]+/,
        'at_least_one_lowercase_letter' => /[a-z]+/,
        'at_least_one_uppercase_letter' => /[A-Z]+/,
      }
    end

    def evaluate expression
      if expression_regex_lookup[expression]
        Dank::Models::Expression.new(regex: expression_regex_lookup[expression], expression: expression)
      else
        raise Dank::Exceptions::UnknownExpression.new
      end
    end

  end
end