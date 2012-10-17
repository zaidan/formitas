require 'spec_helper'
require 'virtus'

describe Formitas, 'rendering' do
  subject { object.render }

  let(:object) { Formitas::Renderer::Context::Form.new(form) }
  
  let(:form) do
    Formitas::Context::Form.new(
      attributes.merge(
        :method    => 'post',
        :enctype   => 'www-form-urlencoded',
        :action    => '/some/target',
      )
    )
  end

  let(:model) do
    Class.new do
      include Virtus
      attribute :surname, String
      attribute :name, String
    end
  end

  let(:fields) do
    [
      Formitas::Field::Select.build(:surname, :collection => %w(Mr Mrs)),
      Formitas::Field::Input::Text.build(:name)
    ]
  end

  context 'with empty input and errors' do
    let(:attributes) do
      {
        :name      => :person,
        :values    => Formitas::Values::Empty,
        :validator => Formitas::Validator::Valid,
        :fields    => Formitas::FieldSet.new(fields)
      }
    end

    it 'should render expected html' do
      subject.split('><').join(">\n<").should eql(compress(<<-HTML))
        <form action="/some/target" method="post" enctype="www-form-urlencoded">
          <div class="input">
            <label for="person_surname">Surname</label>
            <select id="person_surname" name="person[surname]">
              <option value="Mr">Mr</option>
              <option value="Mrs">Mrs</option>
            </select>
          </div>
          <div class="input">
            <label for="person_name">Name</label>
            <input id="person_name" type="text" name="person[name]" value=""/>
          </div>
        </form>
      HTML
    end

  end

  context 'with input' do
    let(:attributes) do
      {
        :name      => :person,
        :values    => Formitas::Values::Proxy.new(model.new(:surname => 'Mr', :name => 'Markus Schirp')),
        :validator => Formitas::Validator::Valid,
        :fields    => Formitas::FieldSet.new(fields)
      }
    end

    it 'should render expected html' do
      subject.split('><').join(">\n<").should eql(compress(<<-HTML))
        <form action="/some/target" method="post" enctype="www-form-urlencoded">
          <div class="input">
            <label for="person_surname">Surname</label>
            <select id="person_surname" name="person[surname]">
              <option value="Mr" selected="selected">Mr</option>
              <option value="Mrs">Mrs</option>
            </select>
          </div>
          <div class="input">
            <label for="person_name">Name</label>
            <input id="person_name" type="text" name="person[name]" value="Markus Schirp"/>
          </div>
        </form>
      HTML
    end

  end
end
