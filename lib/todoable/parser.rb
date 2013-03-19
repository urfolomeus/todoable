class Todoable::Parser
  def initialize(todo_string)
    raise ArgumentError, "this is a string parser but you gave: #{todo_string.class}" unless todo_string.is_a?(String)
    @todo_string = todo_string
  end

  def description
    result = @todo_string.match(/^(.*)@.*$/)
    return @todo_string unless result
    result[1].strip
  end

  def location
    result = @todo_string.match(/^.*@(.*)$/)
    return nil unless result
    result[1]
  end
end
