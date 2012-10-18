require 'spec_helper'

unit_spec do
  object_args { [field, context] }

  let(:field)   { mock('Field', :name => :field)        }
  let(:context) { mock('Context', :html_id => 'example') }

  before do
    context.stub(:input_name).with(:field).and_return('example[field]')
    context.stub(:value).with(:field).and_return(is_true)
  end

  context 'when not checked' do
    let(:is_true) { false }

    it 'should produce correct html' do
      split_html(subject.to_s).should eql(compress(<<-HTML))
        <input type="hidden" name="example[field]" value="0"/>
        <input id="example_field" type="checkbox" name="example[field]" value="1" checked=""/>
      HTML
    end

    idempotent_method
  end

  context 'when checked' do
    let(:is_true) { true }

    it 'should produce correct html' do
      split_html(subject.to_s).should eql(compress(<<-HTML))
        <input type="hidden" name="example[field]" value="0"/>
        <input id="example_field" type="checkbox" name="example[field]" value="1" checked="checked"/>
      HTML
    end

    idempotent_method
  end
end
