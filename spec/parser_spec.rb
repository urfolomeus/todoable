require 'todoable'

describe Todoable::Parser do
  describe "initializing" do
    it "throws an argument error if no arg given" do
      expect {
        Todoable::Parser.new
      }.to raise_error(ArgumentError)
    end

    it "throws an argument error if arg is not a string" do
      expect {
        Todoable::Parser.new(123)
      }.to raise_error(ArgumentError, "this is a string parser but you gave: Fixnum")
    end

    it "instantiates with a string" do
      expect {
        Todoable::Parser.new("Valid todo string")
      }.to_not raise_error
    end
  end

  describe "#description" do
    it "provides the todo string text if todo string contains no special strings" do
      parser = Todoable::Parser.new("Valid todo string")
      parser.description.should == "Valid todo string"
    end
  end
end
