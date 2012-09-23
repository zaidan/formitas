require 'spec_helper'

describe Formitas::MessageTransformer, '.transform' do
  subject                { object.transform(violation)     }
  let(:object)           { described_class                 }
  let_mock(:violation)   { { :type => type }               }
  let_mock(:transformer) { { :translation => translation } }
  let_mock(:translation)

  context 'with type "blank"' do
    let(:type) { :blank }

    before do
      Formitas::MessageTransformer::Aequitas.stub(:new => transformer)
    end

    it { should be(translation) }
    
    it 'should call Formitas::MessageTransformer::Aequitas' do
      Formitas::MessageTransformer::Aequitas.should_receive(:new).
        with(violation).
        and_return(transformer)
      subject
    end
  end
  
  context 'with type "length_between"' do
    let(:type) { :length_between }

    before do
      Formitas::MessageTransformer::Aequitas.stub(:new => transformer)
    end

    it { should be(translation) }
    
    it 'should call Formitas::MessageTransformer::Aequitas' do
      Formitas::MessageTransformer::Aequitas.should_receive(:new).
        with(violation).
        and_return(transformer)
      subject
    end
  end
  
  context 'with other type' do
    let(:type) { :other_type }

    before do
      Formitas::MessageTransformer.stub(:new => transformer)
    end

    it { should be(translation) }
    
    it 'should call Formitas::MessageTransformer' do
      Formitas::MessageTransformer.should_receive(:new).
        with(violation).
        and_return(transformer)
      subject
    end
  end
end
