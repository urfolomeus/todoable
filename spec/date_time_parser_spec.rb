require 'spec_helper'
require 'date'

describe Todoable::DateTimeParser do
  describe "initializing" do
    it "throws an argument error if no arg given" do
      expect {
        Todoable::DateTimeParser.new
      }.to raise_error(ArgumentError)
    end

    it "throws an argument error if arg is not a string" do
      expect {
        Todoable::DateTimeParser.new(123)
      }.to raise_error(ArgumentError, "this is a string parser but you gave: Fixnum")
    end

    it "instantiates with a string" do
      expect {
        Todoable::DateTimeParser.new("Valid todo string")
      }.to_not raise_error
    end
  end

  describe "#date" do
    context "when there is no date in the given string" do
      Given(:parser) { Todoable::DateTimeParser.new("There is no date.") }
      Then { parser.date == nil }
    end

    context "when a date is given in format 23/03/2013" do
      Given(:parser) { Todoable::DateTimeParser.new("The date is 23/03/2013.") }
      Then { parser.date == Date.parse("23/03/2013") }
    end
  end
end

