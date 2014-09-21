class StringValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    unless value.class == String
      record.errors[attribute] << (options[:message] || "not a string")
    end
  end

end
