require 'spec_helper'

describe Formitas::Dumper::Errors, '#dump' do
  include Formitas::WebHelpers
  subject      { object.dump                    }
  let(:object) { described_class.new(errors, base_id) }

  let_mock(:base_id)

  context 'with errors' do
    let_mock(:error1)
    let_mock(:error2)
    let(:errors) { [error1, error2] }
    let(:dump_items) {[error1, error2]}

    let(:expected_result) do
      "<div class=\"error\" id=\"#{escape_html(base_id)}_error\">#{dump_items.join('')}</div>"
    end
      
    before do
      Formitas::Dumper::Error.stub(:dump_items => dump_items)
    end

    it { should eql(expected_result)}

    it 'should call Error.dump_items with errors and base id' do
      Formitas::Dumper::Error.should_receive(:dump_items).
        with(errors, base_id).
        and_return(dump_items)

      subject
    end
  end

  context 'without errors' do
    let(:errors) {[]}

    it { should be_nil }
  end
end
