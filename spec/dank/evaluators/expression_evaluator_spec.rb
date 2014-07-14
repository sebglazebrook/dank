require 'spec_helper'

describe Evaluators::ExpressionEvaluator do

  describe '#evaluate' do

    subject { Evaluators::ExpressionEvaluator.new.evaluate(expression) }

    context 'when given an evaluable expression' do

      let(:expression) { 'any_lowercase_letters' }
      let(:dank_expression) { Dank::Models::Expression.new(regex: /[a-z]*/, expression: 'any_lowercase_letters') }

      it 'returns a Dank::Expression' do
        expect(subject).to eq dank_expression
      end
    end

    context 'when given a non-evaluable expression' do

      let(:expression) { '' }

      it 'raises an error' do
        expect{subject}.to raise_error Dank::Exceptions::UnknownExpression
      end
    end
  end
end