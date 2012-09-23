require 'spec_helper'

describe Formitas::MessageTransformer, '#translation' do
  subject                { object.translation              }
  let(:object)           { described_class.new(violation)  }
  let_mock(:translation)
  
  let_mock(:violation)   do
    {
      :type           => type,
      :attribute_name => attribute_name,
      :resource       => resource,
      :info           => info
    }               
  end

  let_mock(:type)
  let_mock(:attribute_name)
  let_mock(:resource)
  let_mock(:value)
  let_mock(:attribute)

  let(:info)          { { :info => 'info' }      }
  let(:default_scope) { ['mock', attribute_name] }
  
  let(:options) do
    {
      :attribute => attribute,
      :value => value,
      :scope => default_scope + [:violation]
    }
  end

  before do
    I18n.stub(:translate => translation)
    I18n.stub(:t => attribute)
    resource.stub(:validation_attribute_value => value)
  end

  it { should be(translation) }

  it 'should call I18n.translate' do
    I18n.should_receive(:translate).
      with(type, options.merge(info)).
      and_return(translation)
    subject
  end
  
  it 'should call I18n.t' do
    I18n.should_receive(:t).
      with(:name, :scope => default_scope).
      and_return(translation)
    subject
  end

  it 'should call resource.validation_attribute_value' do
    resource.should_receive(:validation_attribute_value).
      with(attribute_name).
      and_return(value)
    subject
  end
end
