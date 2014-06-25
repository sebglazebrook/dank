module Dank
  class Expression

    attr_accessor :regex, :expression

    def initialize(params = {})
      @regex = params[:regex]
      @expression = params[:expression]
    end

    def ==(operand)
      if operand.kind_of?(self.class) && instance_variables_match(operand)
        true
      else
        false
      end
    end

    def instance_variables_match(dank_expression)
      dank_expression.regex == self.regex && dank_expression.expression == self.expression
    end
  end
end