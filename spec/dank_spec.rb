require 'spec_helper'

describe Dank do

  describe '.parse' do

    subject { Dank }

    context 'when given a valid regular expression' do

      let(:regular_expression) { /[a-z]*/ }

      it 'converts it to dank' do
        expect(subject.parse(regular_expression)).to eq Dank.any_lowercase_letters
      end
    end
  end

  describe '.method_missing' do

    it 'sends the method name and args off to the evaluator for evaluation' do
      expect(Dank::Evaluator).to receive(:evaluate).with('some_method_that_doesnt_exist', ['arg1', 2, 'arg3'])
      subject.some_method_that_doesnt_exist('arg1', 2, 'arg3')
    end
  end

  describe 'evaluable expressions' do

    {
      'any_letters' => /[a-zA-Z]*/,
      'any_lowercase_letters' => /[a-z]*/,
      'any_uppercase_letters' => /[A-Z]*/,
      'any_numbers' => /\d*/,
      'at_least_one_number' => /\d+/,
      'at_least_one_letter' => /[a-zA-Z]+/,
      'at_least_one_lowercase_letter' => /[a-z]+/,
      'at_least_one_uppercase_letter' => /[A-Z]+/
    }.each do |expression, regex|

      it "evaluates '#{expression}' to: #{regex}" do
        expect(Dank.send(expression).regex).to eq regex
      end
    end
  end

  describe 'daisy chaining' do

    context 'given an evaluable expression' do

      let(:expression_one) { 'any_lowercase_letters' }

      context 'and another evaluable expression is chained on' do

        let(:expression_two) { 'any_numbers' }

        it 'combines them to build a new dank expression' do
          expected_dank = Dank::Models::Expression.new(regex: /[a-z]*\d*/, expression: ['any_lowercase_letters', 'any_numbers'])
          expect(subject.send(expression_one).send(expression_two)).to eq expected_dank
        end
      end
    end
  end
end