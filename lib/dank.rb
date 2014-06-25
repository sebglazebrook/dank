require "dank/version"
require "dank/evaluator"
require "dank/expression"
require "dank/unknown_expression_exception"
require "dank/unknown_regex_exception"

module Dank

  def self.parse(regular_expression)
    Dank::Evaluator.evaluate_regex(regular_expression)
  end

  def self.method_missing(method_name, *args, &block)
    Dank::Evaluator.evaluate(method_name.to_s, args)
  end

end
