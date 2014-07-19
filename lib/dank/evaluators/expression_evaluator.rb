require 'kapture'

module Evaluators
  class ExpressionEvaluator

    attr_reader :original_expression, :evaluations
    attr_accessor :left_to_evaluate

    def evaluate expression
      self.original_expression = expression
      evaluate_next while more_to_evaluate?
      full_evaluation
    end

    def original_expression= expression
      self.left_to_evaluate = expression
      @original_expression = expression
    end

    def evaluations
      @evaluations ||= []
    end

    private

    def full_evaluation
      raise Dank::Exceptions::UnknownExpression.new if evaluations.empty?
      expression_builder = Dank::Builders::RegexBuilder.new
      self.evaluations.each{ |evaluation| expression_builder.add(evaluation) }
      expression_builder.build
    end

    def more_to_evaluate?
      if left_to_evaluate && !left_to_evaluate.empty?
        left_to_evaluate =~ /_/ || original_expression.match(/^#{left_to_evaluate}_(.*)/) || original_expression.end_with?(left_to_evaluate)
      else
        false
      end
    end

    def evaluate_next
      expression = next_expression
      if response = Dank::Lookups::ExpressionRegexLookup.lookup(expression)
        evaluations << Dank::Models::Expression.new(regex: response, expression: expression)
        self.left_to_evaluate = original_expression.capture_first(/(.*)_#{expression}/)
      end
    end

    def next_expression
      expression = (left_to_evaluate == original_expression ? original_expression : left_to_evaluate)
      remove_a_word
      expression
    end

    def remove_a_word
      self.left_to_evaluate = left_to_evaluate.capture_first(/_(.*)$/)
    end
  end
end
