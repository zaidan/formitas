require 'spec_helper'

unit_spec do
  let(:class_under_test) do 
    is_valid = self.is_valid
    Class.new(described_class) do
      define_method(:valid?) { is_valid }
    end
  end

  object_args { [mock,mock] }

  subject { object.on_error { yields << :yield } }

  let(:yields) { [] }

  context 'when object is NOT valid' do
    let(:is_valid) { false }

    it 'should yield' do
      subject
      yields.should eql([:yield])
    end

    command_method
  end

  context 'when object is valid' do
    let(:is_valid) { true }

    it 'should yield' do
      subject
      yields.should eql([])
    end

    command_method
  end
end
