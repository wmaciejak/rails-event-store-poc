module Command
  class Base
    include ActiveModel::Model
    include ActiveModel::Validations
    include ActiveModel::Conversion

    ValidationError = Class.new(StandardError)

    def initialize(attributes={})
      super
    end

    def validate!
      raise ValidationError, errors unless valid?
    end

    def persisted?
      false
    end
  end
end
