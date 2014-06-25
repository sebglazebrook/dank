module Dank
  class Evaluator

    @@expression_regex_lookup = {
        'any_lowercase_letters' => /[a-z]*/,
        'any_uppercase_letters' => /[A-Z]*/,
        'any_numbers' => /\d*/,
    }

    def self.can_evaluate?(expression, *args)
      evaluate(expression, *args).kind_of?(Exception) ? false : true
    end

    def self.evaluate(expression, *args)
      if @@expression_regex_lookup[expression]
        Dank::Models::Expression.new(regex: @@expression_regex_lookup[expression], expression: expression)
      else
        raise Dank::Exceptions::UnknownExpression.new
      end
    end

    def self.evaluate_regex(regex)
      if @@expression_regex_lookup.invert[regex]
        Dank::Models::Expression.new(regex: regex, expression: @@expression_regex_lookup.invert[regex])
      else
        raise Dank::Exceptions::UnknownRegex.new
      end
    end

  end
end