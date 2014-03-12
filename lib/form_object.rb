class FormObject
  include ActiveModel::Model
  include Virtus.model

  # def initialize(attributes = {})
  #   attributes.each do |k, v|
  #     instance_variable_set("@#{k}", v) unless v.nil?
  #   end
  # end

  def persisted?
    false
  end

  def save
    if valid?
      persist!
      true
    else
      false
    end
  end
end
