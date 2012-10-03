#encoding: utf-8
require 'spec_helper'

describe 'Field rendering with errors' do
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
    Class.new(Formitas::Field) do
      def input_tag
        html_value
      end
    end
  end

  let(:value)     { '<p>Content</p>' }
  let(:name)      { 'field'   }
  let(:basename)  { 'base'    }
  let_mock(:input) do
    {
      :input_hash => {name => value}
    }
  end

  let_mock(:error1)
  let_mock(:error2)
  let_mock(:rule1)
  let_mock(:rule2)
  let(:errors) { [error1,error2] }
    


  let(:html)   { subject.split("><").join(">\n<") }

  before do
      I18n.stub(:translate => 'Label')
  end

  context 'when input is not valid' do
    
    before do
      input.stub(:valid? => false)
      error1.stub(:rule => rule1) 
      error2.stub(:rule => rule2)
      error1.stub(:to_s => 'error text 1')
      error2.stub(:to_s => 'error text 2')
      rule1.stub(:violation_type => 'error1')
      rule2.stub(:violation_type => 'error2')
      input_errors = mock('input_errors')
      input.stub(:errors => input_errors)
      input_errors.stub(:on => errors)
    end


    it 'should create correct html' do
      html.should == compress(<<-HTML)
        <div class="input">
          <label for="base_field">Label</label>
          <p>Content</p>
          <div class="error" id="base_field_error">
            <p class="error" id="base_field_error_msg_error1">error text 1</p>
            <p class="error" id="base_field_error_msg_error2">error text 2</p>
          </div>
        </div>
      HTML
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
