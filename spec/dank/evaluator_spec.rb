require 'spec_helper'

describe Dank::Evaluator do

  describe '.evaluate' do

    subject { Dank::Evaluator.evaluate(expression) }

    context 'when given an evaluable expression' do

      let(:expression) { 'any_lowercase_letters' }
      let(:dank_expression) { Dank::Expression.new(regex: /[a-z]*/, expression: 'any_lowercase_letters') }

      it 'returns a Dank::Expression' do
        expect(subject).to eq dank_expression
      end
    end

    context 'when given a non-evaluable expression' do

      let(:expression) { '' }

      it 'raises an error' do
        expect{subject}.to raise_error Dank::UnknownExpressionException
      end
    end
  end

  describe '.evaluate_regex' do

    subject { Dank::Evaluator.evaluate_regex(regex) }

    context 'when given an evaluable regex' do

      let(:regex) { /[a-z]*/ }
      let(:dank_expression) { Dank::Expression.new(regex: /[a-z]*/, expression: 'any_lowercase_letters') }

      it 'returns a Dank::Expression' do
        expect(subject).to eq dank_expression
      end
    end

    context 'when given a non-evaluable expression' do

      let(:regex) { '' }

      it 'raises an error' do
        expect{subject}.to raise_error Dank::UnknownRegexException
      end
    end
  end

end