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

  def tags
    parsed_string = parse_special_char('#')
    return nil unless parsed_string
    parsed_string.split(',').map(&:strip)
  end

  private

  def parse_special_char(char)
    matches = @todo_string.match(/#{char}([^#{SPECIAL_CHARS}]*)/)
    return nil unless matches
    matches[1].strip
  end
end
