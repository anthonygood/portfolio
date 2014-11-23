# require 'spec_helper'
require 'rails_helper'
require './lib/csv_translator'

describe 'CSVTranslator' do
  let(:subject) { CSVTranslator.new 'file_name', model }
  let(:model)   { double("fake model") }

  before do
    silence(CSVTranslator)
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


  it "verifies the CSV's column_titles" do
    expect(subject.invalid_column_titles).to eql ["redundant_attribute"]
  end

  it "reads the CSV file" do
    expect(CSV).to receive(:read).with('file_name')
    subject    
  end

  describe "translates" do
    let(:translation) { subject.translations }
    it "file into an array of hashes" do
      expect(translation.class).to be Array
    end

    describe "each hash" do
      it "has keys matching the column titles" do
        expect(translation.first.keys).to eql [:title, :secret, :redundant_attribute]
      end

      it "has the values defined by the CSV" do
        expect(translation.first[:title]).to eql "Cats"
        expect(translation.last[:secret]).to eql "unmarked"
      end

      it "can exclude invalid column_titles" do
        expect(translation.first.filter).to eql({title: "Cats", secret: "the_first_secret"})
        expect(translation.second.filter).to eql({title: "Self-portrait", secret: "unmarked"})
      end
    end
  end

  describe "populating database" do
    before do
      allow(model).to receive(:create_with_prints)
    end

    it "can create new records from the CSV" do
      expect(model).to receive(:create_with_prints).with({title: "Cats", secret: "the_first_secret", versions: []})
      expect(model).to receive(:create_with_prints).with({title: "Self-portrait", secret: "unmarked", versions: []})
      subject.write_records_to_db
    end
  end

  context "prints" do
    before do
      allow(CSV).to receive(:read) do
        [
          [ "title", "desc", "versiona", "versionb", "versionc" ],
          [ "Cats", "description", "black", "blue", "" ],
          [ "Self-portrait", "unmarked", "", "", "" ]
        ]
      end
    end

    it "can tell me how many versions of an etching there are" do
      expect(subject.translations.first.prints).to eql ["black", "blue"]
      expect(subject.translations.last.prints).to eql []
    end
  end

  context "<< integration >>" do
    before do
      allow(CSV).to receive(:read) do
        [
          %w& title secret redundant_attribute &,
          %w& Cats the_first_secret 57 &,
          %w& Self-portrait unmarked 56 &
        ]
      end
    end
    let(:subject) { CSVTranslator.new 'file_name', Etching }

    it "powers through the stack" do
      expect{ subject.write_records_to_db }.to change{ Etching.count }.by 2
    end

    describe "errors" do
      before do
        allow(Etching).to receive(:create!).and_raise Exception.new "Record not created"
        subject.write_records_to_db
      end

      it "get collected by each translation" do
        expect(subject.translations.first[:error].message).to eql("Record not created")
      end

      it "are accessible by the Translator object" do
        expect(subject.translations_with_errors.count).to eq 2
        expect(subject.translations_with_errors.first[:error].message).to eql("Record not created")
      end

      it "can be checked" do
        expect(subject.errors?).to be true
      end
    end
  end

end
