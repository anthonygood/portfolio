require 'rails_helper'

class YearValidatable
  include ActiveModel::Validations
  validates :attr, year: true
  attr_accessor :attr
end

describe YearValidator do 

  let(:subject)   { YearValidatable.new }
  let(:validator) { YearValidator.new }

  context "year: true" do
    it "validates a year" do
      subject.attr = 1944

      expect(subject).to be_valid
    end

    context "invalidates" do

      it "booleans" do
        subject.attr = true

        expect(subject).to be_invalid
      end

      it "strings" do
        subject.attr = "string"

        expect(subject).to be_invalid
      end

      it "numbers of the wrong length" do
        subject.attr = 199

        expect(subject).to be_invalid

        subject.attr = 19999

        expect(subject).to be_invalid
      end
    end
  end
end
