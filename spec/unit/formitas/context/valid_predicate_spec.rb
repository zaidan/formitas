require 'spec_helper'

unit_spec do
  attributes do
    {
      :name      => :foo,
      :fields    => [],
      :values    => mock('Values'),
      :validator => mock('Validator', :valid? => is_valid)
    }
  end

  context 'when validator is valid' do
    let(:is_valid) { true }

    idempotent_method

    it { should be(true) }
  end

  context 'when validator is NOT valid' do
    let(:is_valid) { false }

    idempotent_method

    it { should be(false) }
  end
end
