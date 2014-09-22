require 'rails_helper'

class Validatable
  include ActiveModel::Validations
  validates :title, string: true
  validates :score, string: false
  attr_accessor :title, :score
end

describe StringValidator do 

  let(:subject)   { Validatable.new }
  let(:validator) { StringValidator.new }

  context "string: true" do
    it "validates strings" do
      subject.title = "string"

      expect(subject).to be_valid
    end

    it "invalidates non-strings" do
      subject.title = 44

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
