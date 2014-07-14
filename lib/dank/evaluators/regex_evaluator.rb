module Evaluators
  class RegexEvaluator
    
    def evaluate regex
      if expression_regex_lookup.invert[regex]
        Dank::Models::Expression.new(regex: regex, expression: expression_regex_lookup.invert[regex])
      else
        raise Dank::Exceptions::UnknownRegex.new
      end
    end

    private

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

  end
end