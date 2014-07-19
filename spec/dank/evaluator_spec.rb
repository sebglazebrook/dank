require 'spec_helper'

describe Dank::Evaluator do

  describe '.can_evaluate?' do

    let(:expression) { 'an expression of some sort' }
    subject { Dank::Evaluator.can_evaluate?(expression) }

    context 'when given an evaluatable expression' do

      let(:positive_evaluation) { true }
      let(:expression_evaluator) { instance_double('Evaluators::ExpressionEvaluator') }

      before do
        allow(Evaluators::ExpressionEvaluator).to receive(:new).and_return expression_evaluator
        allow(expression_evaluator).to receive(:evaluate).and_return positive_evaluation
      end

      it 'returns true' do
        expect(subject).to eq true
      end
    end

    context 'when given an un-evaluatable expression' do

      let(:dank_exception) { Dank::Exceptions::Base.new }
      let(:expression_evaluator) { instance_double('Evaluators::ExpressionEvaluator') }

      before do
        allow(Evaluators::ExpressionEvaluator).to receive(:new).and_return expression_evaluator
        allow(expression_evaluator).to receive(:evaluate).and_return dank_exception
      end

      it 'returns false' do
        expect(subject).to eq false
      end
    end

    context 'an evaluation causes an unknown exception' do

      let(:expression_evaluator) { instance_double('Evaluators::ExpressionEvaluator') }

      before do
        allow(Evaluators::ExpressionEvaluator).to receive(:new).and_return expression_evaluator
        allow(expression_evaluator).to receive(:evaluate).and_raise NoMethodError
      end

      it 'throws an error' do
        expect{subject}.to raise_error(NoMethodError)
      end
    end
  end

  describe '.evaluate' do

    subject { Dank::Evaluator.evaluate(expression) }

    context 'when given an expression' do

      let(:expression) { 'any_lowercase_letters' }
      let(:expression_evaluator) { instance_double('Evaluators::ExpressionEvaluator') }

      before do
        allow(Evaluators::ExpressionEvaluator).to receive(:new).with(expression).and_return expression_evaluator
      end

      it 'sends it to the expression evaluator for evaluation' do
        expect(expression_evaluator).to receive(:evaluate)
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