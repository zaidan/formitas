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

  let(:membership_a) do 
    Class.new do 
      def self.name; 'MembershipA'; end
    end
  end

  let(:membership_b) do 
    Class.new do 
      def self.name; 'MembershipB'; end 
    end
  end

  let(:model) do
    Class.new do
      include Virtus
      attribute :membership,        Object
      attribute :surname,           String
      attribute :name,              String
      attribute :terms_of_service,  Virtus::Attribute::Boolean
    end
  end

  let(:fields) do
    [
      Formitas::Field::Select.build(
        :surname, 
        :collection => Formitas::Collection::String.new(
          :strings => %w(Mr Mrs)
        )
      ),
      Formitas::Field::String.build(:name),
     #Formitas::Field::Select.build(
     #  :membership,
     #  :collection => Formitas::Collection::DomainMap.new(
     #    'membership-a' => membership_a,
     #    'membership-b' => membership_b
     #  )
     #),
      Formitas::Field::Boolean.build(:terms_of_service)
    ]
  end

  context 'with empty input and no errors' do
    let(:attributes) do
      {
        :name      => :person,
        :values    => Formitas::Values::Empty,
        :validator => Formitas::Validator::Valid,
        :fields    => Formitas::FieldSet.new(fields)
      }
    end

    it 'should render expected html' do
      subject.to_s.split('><').join(">\n<").should eql(compress(<<-HTML))
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
          <div class="input">
            <label for="person_terms_of_service">Terms of service</label>
            <input type="hidden" name="person[terms_of_service]" value="0"/>
            <input id="person_terms_of_service" type="checkbox" name="person[terms_of_service]" value="1" checked=""/>
          </div>
        </form>
      HTML
    end

  end

  context 'with input' do

    let(:resource) do
      model.new(:surname => 'Mr', :name => 'Markus Schirp', :terms_of_service => true)
    end

    let(:attributes) do
      {
        :name      => :person,
        :values    => Formitas::Values::Proxy.new(resource),
        :validator => Formitas::Validator::Valid,
        :fields    => Formitas::FieldSet.new(fields)
      }
    end

    it 'should render expected html' do
      subject.to_s.split('><').join(">\n<").should eql(compress(<<-HTML))
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
          <div class="input">
            <label for="person_terms_of_service">Terms of service</label>
            <input type="hidden" name="person[terms_of_service]" value="0"/>
            <input id="person_terms_of_service" type="checkbox" name="person[terms_of_service]" value="1" checked="checked"/>
          </div>
        </form>
      HTML
    end
  end

  context 'with input and errors' do

    let(:validator) do
      Class.new do
        include Aequitas::Validator
        validates_presence_of :surname
        validates_presence_of :name
        validates_acceptance_of :terms_of_service
      end
    end

    let(:resource) do
      model.new(:name => 'Markus Schirp')
    end

    let(:attributes) do
      {
        :name      => :person,
        :values    => Formitas::Values::Proxy.new(resource),
        :validator => validator.new(resource),
        :fields    => Formitas::FieldSet.new(fields)
      }
    end

    it 'should render expected html' do
      subject.to_s.split('><').join(">\n<").should eql(compress(<<-HTML))
        <form action="/some/target" method="post" enctype="www-form-urlencoded">
          <div class="input error">
            <label for="person_surname">Surname</label>
            <select id="person_surname" name="person[surname]">
              <option value="Mr">Mr</option>
              <option value="Mrs">Mrs</option>
            </select>
            <div class="error-messages">
              <ul>
                <li class="error-message">Surname: Blank</li>
              </ul>
            </div>
          </div>
          <div class="input">
            <label for="person_name">Name</label>
            <input id="person_name" type="text" name="person[name]" value="Markus Schirp"/>
          </div>
          <div class="input">
            <label for="person_terms_of_service">Terms of service</label>
            <input type="hidden" name="person[terms_of_service]" value="0"/>
            <input id="person_terms_of_service" type="checkbox" name="person[terms_of_service]" value="1" checked=""/>
          </div>
        </form>
      HTML
    end

  end
end
