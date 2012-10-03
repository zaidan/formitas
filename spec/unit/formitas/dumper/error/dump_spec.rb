require 'spec_helper'

describe Formitas::Dumper::Error, '#dump' do
  include WebHelpers
  subject      { object.dump                    }
  let(:object) { described_class.new(error, base_id) }

  let_mock(:error) { { :rule => rule } }
  let_mock(:base_id)
  let_mock(:rule) { { :violation_type => type } }
  let_mock(:type)

  let(:expected_result) do
    "<p class=\"error\" id=\"#{escape_html(base_id)}_error_msg_#{escape_html(type)}\">#{escape_html(error)}</p>"
  end

  it 'should create correct html' do
    subject.should eq(expected_result)
  end
end
