require "dank/version"
require "dank/evaluator"
require "dank/evaluators/expression_evaluator"
require "dank/models/expression"
require "dank/exceptions/unknown_expression"
require "dank/exceptions/unknown_regex"

module Dank

  def self.parse(regular_expression)
    Dank::Evaluator.evaluate_regex(regular_expression)
  end

  def self.method_missing(method_name, *args, &block)
    Dank::Evaluator.evaluate(method_name.to_s, args)
  end

end
