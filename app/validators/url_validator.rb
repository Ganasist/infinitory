class UrlValidator < ActiveModel::EachValidator
 
  def validate_each(record, attribute, value)
    valid = begin
      URI.parse(value).kind_of?(URI::HTTP)
    rescue URI::InvalidURIError
      false
    end
    unless valid
      record.errors[attribute] << (options[:message] || "is an invalid URL. Please include http:// or https://")
    end
  end
 
end