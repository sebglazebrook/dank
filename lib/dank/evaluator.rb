module Dank
  class Evaluator

    def self.can_evaluate?(expression, *args)
      evaluate(expression, *args).kind_of?(Dank::Exceptions::Base) ? false : true
    end

    def self.evaluate(expression, *args)
      Evaluators::ExpressionEvaluator.new.evaluate expression
    end

    def self.evaluate_regex(regex)
      Evaluators::RegexEvaluator.new.evaluate regex
    end

  end
end