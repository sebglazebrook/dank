module Dank
  class Evaluator

    @@expression_regex_lookup = {
        'any_lowercase_letters' => /[a-z]*/,
        'any_uppercase_letters' => /[A-Z]*/,
        'any_numbers' => /\d*/,
    }

    def self.evaluate(expression, *args)
      if @@expression_regex_lookup[expression]
        Dank::Expression.new(regex: @@expression_regex_lookup[expression], expression: expression)
      else
        raise Dank::UnknownExpressionException.new
      end
    end

    def self.evaluate_regex(regex)
      if @@expression_regex_lookup.invert[regex]
        Dank::Expression.new(regex: regex, expression: @@expression_regex_lookup.invert[regex])
      else
        raise Dank::UnknownRegexException.new
      end
    end

  end
end