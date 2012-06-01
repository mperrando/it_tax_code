class ItTaxCodeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if vallue nil || value.empty?
    errors = ItTaxCode.errors_for(value)
    record.errors[attribute] << I18n.t(:invalid, :scope => 'errors.messages') unless errors.empty?
  end
end
