module Formitas
  class Form
    include Anima, Immutable

    attribute :validator
    attribute :input
  end
end

input     = ContactInput.new(params)
validator = ContactValidator.new(input)

form = Form.new(input, validator)

puts form.html

class Contact < Action
  def response
    if validator.valid?
      sendmail(input)
      success_response
    else
      form_response
    end
  end

  def input
    if post?
      Input::Contact.new(params)
    else
      Input::Contact.empty
    end
  end
  memoize :input

  def validator
    if post?
      Validator::Contact.new(input)
    else
      Validator::Contact.empty
    end
  end
  memoize :validator

  def success_response
  end

  def form_response
    render(View::Contact, :input => input, :validator => validator)
  end
end


