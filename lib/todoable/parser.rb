class Todoable::Parser
  SPECIAL_CHARS = "@#"

  def initialize(todo_string)
    raise ArgumentError, "this is a string parser but you gave: #{todo_string.class}" unless todo_string.is_a?(String)
    @todo_string = todo_string
  end

  def description
    @todo_string[/[^#{SPECIAL_CHARS}]*/].strip
  end

  def location
    parse_special_char '@'
  end

  def list
    parse_special_char '#'
  end

  private

  def parse_special_char(char)
    result = @todo_string.match(/#{char}([^#{SPECIAL_CHARS}]*)/)
    return nil unless result
    result[1].strip
  end
end
