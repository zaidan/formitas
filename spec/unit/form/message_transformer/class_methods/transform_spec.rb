require 'spec_helper'

describe Form::MessageTransformer, '.transform' do
  subject                { object.transform(violation)     }
  let(:object)           { described_class                 }
  let_mock(:violation)   { { :type => type }               }
  let_mock(:transformer) { { :translation => translation } }
  let_mock(:translation)

  context 'with type "blank"' do
    let(:type) { :blank }

    before do
      Form::MessageTransformer::Aequitas.stub(:new => transformer)
    end

    it { should be(translation) }
    
    it 'should call Form::MessageTransformer::Aequitas' do
      Form::MessageTransformer::Aequitas.should_receive(:new).
        with(violation).
        and_return(transformer)
      subject
    end
  end
  
  context 'with type "length_between"' do
    let(:type) { :length_between }

    before do
      Form::MessageTransformer::Aequitas.stub(:new => transformer)
    end

    it { should be(translation) }
    
    it 'should call Form::MessageTransformer::Aequitas' do
      Form::MessageTransformer::Aequitas.should_receive(:new).
        with(violation).
        and_return(transformer)
      subject
    end
  end
  
  context 'with other type' do
    let(:type) { :other_type }

    before do
      Form::MessageTransformer.stub(:new => transformer)
    end

    it { should be(translation) }
    
    it 'should call Form::MessageTransformer' do
      Form::MessageTransformer.should_receive(:new).
        with(violation).
        and_return(transformer)
      subject
    end
  end
end
