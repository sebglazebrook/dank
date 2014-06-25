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
      'any_lowercase_letters' => /[a-z]*/,
      'any_uppercase_letters' => /[A-Z]*/,
      'any_numbers' => /\d*/

    }.each do |expression, regex|

      it "evaluates '#{expression}' to: #{regex}" do
        expect(Dank.send(expression).regex).to eq regex
      end
    end
  end
end