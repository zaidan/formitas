require 'spec_helper'

describe Formitas::Dumper, '.dump' do
  subject { class_under_test.dump(dump_subject) }

  let(:dump_subject) { mock('Dump Subject', :attribute => dump_result) }
  let(:dump_result)  { mock('Result')                                  }
  
  let(:class_under_test) do
    dump_result = self.dump_result

    Class.new(described_class) do
      define_method(:dump) do
        dump_result
      end
    end
  end
  
  it { should eql(dump_result)}
end
