require 'spec_helper'

describe Todoable::TokenParser do
  Given(:description)     { "Valid todo string" }

  describe "initializing" do
    it "throws an argument error if no arg given" do
      expect {
        Todoable::TokenParser.new
      }.to raise_error(ArgumentError)
    end

    it "throws an argument error if arg is not a string" do
      expect {
        Todoable::TokenParser.new(123)
      }.to raise_error(ArgumentError, "this is a string parser but you gave: Fixnum")
    end

    it "instantiates with a string" do
      expect {
        Todoable::TokenParser.new("Valid todo string")
      }.to_not raise_error
    end
  end

  describe "#description" do
    Given(:tokens)          { "" }
    Given(:string_to_parse) { description + tokens }
    Given(:parser)          { Todoable::TokenParser.new(string_to_parse) }

    context "when todo string contains no tokens" do
      Then { parser.description == description }
    end

    context "when string contains a location token" do
      Given(:tokens) { " @work" }
      Then { parser.description == description }
    end

    context "when string contains a priority token" do
      Given(:tokens) { " !high" }
      Then { parser.description == description }
    end

    context "when string contains a repeater token" do
      Given(:tokens) { " *weekly" }
      Then { parser.description == description }
    end

    context "when string contains tags" do
      Given(:tokens) { " #stuff, things" }
      Then { parser.description == description }
    end

    context "when string contains a priority, a location, a repeater and tags" do
      Given(:tokens) { " !high @work *weekly #stuff, things" }
      Then { parser.description == description }
    end

    context "when string contains a repeater, tags, a priority and a location" do
      Given(:tokens) { " *weekly #stuff, things !high @work" }
      Then { parser.description == description }
    end
  end

  describe "#location" do
    Given(:tokens)          { "" }
    Given(:string_to_parse) { description + tokens }
    Given(:parser)          { Todoable::TokenParser.new(string_to_parse) }

    context "is nil when no location is given" do
      Then { parser.location == nil }
    end

    context "when location is given" do
      context "provides the location" do
        Given(:tokens) { " @work" }
        Then { parser.location.should == 'work' }
      end

      context "doesn't include any other tokens before it" do
        Given(:tokens) { " #stuff !high @work" }
        Then { parser.location.should == 'work' }
      end

      context "doesn't include any other tokens around it" do
        Given(:tokens) { " !high @work #stuff" }
        Then { parser.location.should == 'work' }
      end

      context "doesn't include any other tokens after it" do
        Given(:tokens) { " @work #stuff !high" }
        Then { parser.location.should == 'work' }
      end
    end
  end

  describe "#priority" do
    it "is nil when no priority is given" do
      parser = Todoable::TokenParser.new("Valid todo string")
      parser.priority.should be_nil
    end

    it "provides the priority if one is given" do
      parser = Todoable::TokenParser.new("Valid todo string !high")
      parser.priority.should == 'high'
    end

    it "doesn't include any other tokens before it" do
      parser = Todoable::TokenParser.new("Valid todo string @work #stuff !high")
      parser.priority.should == 'high'
    end

    it "doesn't include any other tokens around it" do
      parser = Todoable::TokenParser.new("Valid todo string @work !high #stuff")
      parser.priority.should == 'high'
    end

    it "doesn't include any other tokens after it" do
      parser = Todoable::TokenParser.new("Valid todo string !high #stuff @work")
      parser.priority.should == 'high'
    end
  end

  describe "#repeats" do
    it "is nil when no repeat is given" do
      parser = Todoable::TokenParser.new("Valid todo string")
      parser.repeats.should be_nil
    end

    it "provides the repeat if one is given" do
      parser = Todoable::TokenParser.new("Valid todo string *weekly")
      parser.repeats.should == 'weekly'
    end

    it "doesn't include any other tokens before it" do
      parser = Todoable::TokenParser.new("Valid todo string @work #stuff *weekly")
      parser.repeats.should == 'weekly'
    end

    it "doesn't include any other tokens around it" do
      parser = Todoable::TokenParser.new("Valid todo string @work *weekly #stuff")
      parser.repeats.should == 'weekly'
    end

    it "doesn't include any other tokens after it" do
      parser = Todoable::TokenParser.new("Valid todo string *weekly #stuff @work")
      parser.repeats.should == 'weekly'
    end
  end

  describe "#tags" do
    it "is nil when no tags are given" do
      parser = Todoable::TokenParser.new("Valid todo string")
      parser.tags.should be_nil
    end

    it "provides a tag if one is given" do
      parser = Todoable::TokenParser.new("Valid todo string #stuff")
      parser.tags.should == ['stuff']
    end

    it "separates multiple tags by commas" do
      parser = Todoable::TokenParser.new("Valid todo string #stuff, things")
      parser.tags.should == ['stuff', 'things']
    end

    it "doesn't include any other tokens before it" do
      parser = Todoable::TokenParser.new("Valid todo string @work !high #stuff")
      parser.tags.should == ['stuff']
    end

    it "doesn't include any other tokens around it" do
      parser = Todoable::TokenParser.new("Valid todo string @work #stuff !high")
      parser.tags.should == ['stuff']
    end

    it "doesn't include any other tokens after it" do
      parser = Todoable::TokenParser.new("Valid todo string #stuff @work !high")
      parser.tags.should == ['stuff']
    end
  end
end

