require 'spec_helper'

describe Dank::Evaluator do

  describe '.evaluate' do

    subject { Dank::Evaluator.evaluate(expression) }

    context 'when given an expression' do

      let(:expression) { 'any_lowercase_letters' }
      let(:expression_evaluator) { instance_double('Evaluators::ExpressionEvaluator') }

      before do
        allow(Evaluators::ExpressionEvaluator).to receive(:new).and_return expression_evaluator
      end

      it 'sends it to the expression evaluator for evaluation' do
        expect(expression_evaluator).to receive(:evaluate).with expression
        subject
      end
    end
  end

  describe '.evaluate_regex' do

    subject { Dank::Evaluator.evaluate_regex(regex) }

    context 'when given a regex' do

      let(:regex) { /[a-z]*/ }
      let(:regex_evaluator) { instance_double('Evaluators::RegexEvaluator') }

      before do
        allow(Evaluators::RegexEvaluator).to receive(:new).and_return regex_evaluator
      end

      it 'sends it to the expression evaluator for evaluation' do
        expect(regex_evaluator).to receive(:evaluate).with regex
        subject
      end
    end
  end
end