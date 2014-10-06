class FriendlyIdValidator < ActiveModel::EachValidator
  def validate_each record, attribute, value
    unless value =~ /[0-9a-z][0-9a-z-]+/
      record.errors[attribute] << (options[:message] || 'must_be_start_with_digit_or_small_alphabet_and_only_contains_digit_or_small_alphabet_and_hyphen')
    end
  end
end
