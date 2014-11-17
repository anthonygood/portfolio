# require 'spec_helper'
require 'rails_helper'
require './lib/csv_translator'



describe 'CSVTranslator' do
  let(:subject) { CSVTranslator.read 'file_name', model }
  let(:model)   { double("fake model") }

  before do
    allow(CSV).to receive(:read) do
      [
        %w& title secret redundant_attribute &,
        %w& Cats the_first_secret 57 &,
        %w& Self-portrait unmarked 56 &
      ]
    end
    allow(model).to receive_message_chain(:new, :attributes, :keys).and_return %w& title secret & 
  end

  it "is passed a constant corresponding to a Rails model" do
    expect{ subject }.not_to raise_error
  end

  it "raises an error if the constant doesn't exist" do
    expect{ CSVTranslator.new 'file_name', Marlon }.to raise_error
  end

  describe "validating column titles" do
    it "uses the passed model" do
      expect(model).to receive_message_chain(:new, :attributes, :keys)

      subject.valid_column_titles
    end

    it "verifies the CSV's column_titles" do
      expect(subject.valid_column_titles).to eql ["title", "secret"]
      expect(subject.invalid_column_titles).to eql ["redundant_attribute"]
    end

    it "collects the indices of bad column titles" do
      expect(subject.invalid_column_indices).to eql [2]
    end
  end

  it "reads the CSV file" do
    expect(CSV).to receive(:read).with('file_name')
    subject    
  end

  describe "translates" do
    let(:translation) { subject.translate }
    it "file into an array of hashes" do
      expect(translation.class).to be Array
    end

    describe "each hash" do
      it "has keys matching the column titles" do
        expect(translation.first.keys).to eql [:title, :secret, :redundant_attribute]
      end

      it "has the values defined by the CSV" do
        binding.pry
        expect(translation.first[:title]).to eql "Cats"
        expect(translation.last[:secret]).to eql "unmarked"
      end

      it "can exclude invalid column_titles" do
        # expect(translation.)
      end
    end
  end

end