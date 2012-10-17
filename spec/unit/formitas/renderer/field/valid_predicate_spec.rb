require 'spec_helper'

unit_spec do
  object_args { [field, context] }

  let(:field)     { mock('Field', :name => :foo) }
  let(:context)   { mock('Context')              }
  let(:violation) { mock('Violation')            }

  before do
    context.stub(:violations => violations)
  end

  context 'when there are errors' do
    let(:violations) { [violation] }

    it { should be(false) }

    idempotent_method
  end

  context 'when there are NO errors' do
    let(:violations) { [] }

    it { should be(true) }

    idempotent_method
  end
end
