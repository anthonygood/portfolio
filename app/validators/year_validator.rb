class YearValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    unless is_a_year?(value)
      record.errors[attribute] << (options[:message] || "not a year")
    end
  end

  def is_a_year?(value)
    # a year should be an integer four numerals long
    value.to_s.length == 4 && value.class == Fixnum
  end

end
