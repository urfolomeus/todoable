class Todoable::DateTimeParser
  def initialize(string)
    raise ArgumentError.new("this is a string parser but you gave: #{string.class}") unless string.is_a?(String)
    @string = string
  end

  def date
    date_string = @string.match(/(\d{1,2}[\/\-]\d{1,2}[\/\-]\d{2,4})/)
    return nil unless date_string
    Date.parse date_string[1]
  end
end

