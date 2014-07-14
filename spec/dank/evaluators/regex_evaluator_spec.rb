require 'spec_helper'

describe Evaluators::RegexEvaluator do

  describe '#evaluate' do

    subject { Evaluators::RegexEvaluator.new.evaluate(regex) }

    context 'when given ab evaluable regex' do

      let(:regex) { /[a-z]*/ }
      let(:dank_expression) { Dank::Models::Expression.new(regex: /[a-z]*/, expression: 'any_lowercase_letters') }

      it 'returns a Dank::Expression' do
        expect(subject).to eq dank_expression
      end
    end

    context 'when given a non-evaluable expression' do

      let(:regex) { '' }

      it 'raises an error' do
        expect{subject}.to raise_error Dank::Exceptions::UnknownRegex
      end
    end
  end
end