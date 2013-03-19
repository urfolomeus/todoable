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

    it "only provides the description if todo string contains a location" do
      parser = Todoable::Parser.new("Valid todo string @location")
      parser.description.should == "Valid todo string"
    end
  end

  describe "#location" do
    it "is nil when no location is given" do
      parser = Todoable::Parser.new("Valid todo string")
      parser.location.should be_nil
    end

    it "provides the location if one is given" do
      parser = Todoable::Parser.new("Valid todo string @location")
      parser.location.should == 'location'
    end
  end
end
