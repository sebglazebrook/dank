module Evaluators
  class ExpressionEvaluator

    attr_reader :original_expression, :evaluations
    attr_accessor :left_to_evaluate

    def evaluate expression
      self.original_expression = expression
      evaluate_next while more_to_evaluate?
      full_evaluation
    end

    def original_expression=(expression)
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
      response = Dank::Lookups::ExpressionRegexLookup.lookup(expression)
      if response
        evaluations << Dank::Models::Expression.new(regex: response, expression: expression)
        if original_expression.match(/(.*)_#{expression}/)
          self.left_to_evaluate = original_expression.match(/(.*)_#{expression}/)[1]
        else
          self.left_to_evaluate = nil
        end
      end
    end

    def next_expression
      if left_to_evaluate == original_expression
        expression = original_expression
        remove_a_word
      else
        expression = left_to_evaluate
        remove_a_word
      end
      expression
    end

    def remove_a_word
      if left_to_evaluate.match(/_(.*)$/)
        self.left_to_evaluate = left_to_evaluate.match(/_(.*)$/)[1]
      end
    end
  end
end
