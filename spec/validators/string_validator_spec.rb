require 'rails_helper'

class StringValidatable
  include ActiveModel::Validations
  validates :attr, string: true
  validates :score, string: false
  attr_accessor :attr, :score
end

describe StringValidator do 

  let(:subject)   { StringValidatable.new }
  let(:validator) { StringValidator.new }

  context "string: true" do
    it "validates strings" do
      subject.attr = "string"

      expect(subject).to be_valid
    end

    it "invalidates non-strings" do
      subject.attr = 44

      expect(subject).to be_invalid
    end
  end

  context "string: false" do

    it "invalidates strings" do
      subject.score = "a string"

      expect(subject).to be_invalid
    end

    it "validates non-strings" do
      subject.score = 46
      expect(subject).to be_invalid

      subject.score = true
      expect(subject).to be_invalid
    end
  end
  
end
