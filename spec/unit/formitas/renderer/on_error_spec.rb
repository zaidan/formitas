require 'spec_helper'

unit_spec do
  object_args { [context] }

  subject { object.on_error { yields << :yield } }

  let(:yields) { [] }

  let(:context) do
    mock('Context', :error? => has_error)
  end

  context 'when object has error' do
    let(:has_error) { true }

    it 'should yield' do
      subject
      yields.should eql([:yield])
    end

    command_method
  end

  context 'when object NOT has error' do
    let(:has_error) { false }

    it 'should yield' do
      subject
      yields.should eql([])
    end

    command_method
  end
end
