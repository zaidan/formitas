#encoding: utf-8
require 'spec_helper'

describe Formitas::Field, '#render' do
  subject        { object.render(tag_name)          }
  let(:object)   { class_under_test.new(attributes) }
  let(:tag_name) { :div                             }

  let(:attributes) do
    {
      :name     => name,
      :basename => basename,
      :input    => input
    }
  end

  let(:class_under_test) do
    Class.new(described_class) do
      def input_tag
        html_value
      end
    end
  end

  let(:value)      { '<p>Content</p>' }
  let(:error_dump) { '<p>Errors</p>'}
  let(:name)       { 'field'   }
  let(:basename)   { 'base'    }
  let_mock(:input) do
    {
      :input_hash => {name => value}
    }
  end

  let(:html)   { subject.split("><").join(">\n<") }

  before do
      I18n.stub(:translate => 'Label')
  end

  context 'when input is not valid' do

    let_mock(:input_errors)
    let_mock(:errors)
    
    before do
      Formitas::Dumper::Errors.stub(:dump => error_dump)
      input.stub(:valid? => false)
      input.stub(:errors => input_errors)
      input_errors.stub(:on => errors)
    end


    it 'should create correct html' do
      html.should == compress(<<-HTML)
        <div class="input">
          <label for="base_field">Label</label>
          <p>Content</p>
          <p>Errors</p>
        </div>
      HTML
    end
    
    it 'should call Error.dump with errors and base id' do
      Formitas::Dumper::Errors.should_receive(:dump).
        with(errors, 'base_field').
        and_return(error_dump)

      subject
    end
  end

  context 'when input is valid' do
    
    before do
      input.stub(:valid? => true)
    end

    it 'should create correct html' do
      html.should == compress(<<-HTML)
        <div class="input">
          <label for="base_field">Label</label>
          <p>Content</p>
        </div>
      HTML
    end
  end
end