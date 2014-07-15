require 'spec_helper'

describe Dank::Builders::RegexBuilder do

  context 'when given a few Dank::Models::Expressions' do

    let(:expression_one) { Dank::Models::Expression.new(regex: '[a-z]', expression: 'lowercase_letters') }
    let(:expression_two) { Dank::Models::Expression.new(regex: '*', expression: 'any') }

    before do
      subject.add(expression_one)
      subject.add(expression_two)
    end

    it 'combines them into a new Dank::Models::Expression' do
      result = subject.build
      expect(result.regex).to eq /[a-z]*/
      expect(result.expression).to eq 'any_lowercase_letters'
    end
  end
end