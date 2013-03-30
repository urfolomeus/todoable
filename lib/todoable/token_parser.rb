class Todoable::TokenParser
  TOKENS = "@#!\*"

  def initialize(todo_string)
    raise ArgumentError, "this is a string parser but you gave: #{todo_string.class}" unless todo_string.is_a?(String)
    @todo_string = todo_string
  end

  def description
    @todo_string[/[^#{TOKENS}]*/].strip
  end

  def location
    parse_token '@'
  end

  def priority
    parse_token '!'
  end

  def repeats
    parse_token '\*'
  end

  def tags
    parsed_string = parse_token('#')
    return nil unless parsed_string
    parsed_string.split(',').map(&:strip)
  end

  private

  def parse_token(char)
    matches = @todo_string.match(/#{char}([^#{TOKENS}]*)/)
    return nil unless matches
    matches[1].strip
  end
end
