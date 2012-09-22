#encoding: utf-8
module Form
  class MessageTransformer < Aequitas::MessageTransformer

    def self.transform(violation)
      resource       = violation.resource
      model_name     = resource.class.name.split('::').last.downcase
      attribute_name = violation.attribute_name

      default_scope = [model_name,attribute_name]

      if [:length_between,:blank].include?(violation.type)
        options = {
          :attribute => ::I18n.translate(:label,:scope => default_scope),
          :scope     => [:aequitas,:violation]
        }.merge(violation.info)
      else
        options = {
          :attribute => ::I18n.translate(:name,:scope => default_scope),
          :value     => resource.validation_attribute_value(attribute_name),
          :scope     => default_scope + [:violation]
        }.merge(violation.info)
      end

      ::I18n.translate(violation.type, options)
    end
  end # class MessageTransformer
end
