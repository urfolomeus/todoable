class Todoable::Parser
  def initialize(todo_string)
    raise ArgumentError, "this is a string parser but you gave: #{todo_string.class}" unless todo_string.is_a?(String)
    @todo_string = todo_string
  end

  def description
    @todo_string
  end
end
