# require 'spec_helper'
require 'rails_helper'
require './lib/csv_translator'

describe 'CSVTranslator' do
  let(:etching_model) { double("etching model") }
  let(:theme_model)   { double("theme model")}  
  let(:subject) { CSVTranslator.new 'file_name', etching_model, theme_model }

  before do
    silence(CSVTranslator)
    allow(CSV).to receive(:read) do
      [
        %w& title secret redundant_attribute &,
        %w& Cats the_first_secret 57 &,
        %w& Self-portrait unmarked 56 &
      ]
    end
    allow(etching_model).to receive_message_chain(:new, :attributes, :keys).and_return %w& title secret & 
  end

  it "is passed constants corresponding to Rails models" do
    expect{ subject }.not_to raise_error
  end

  it "raises an error if one of the constants doesn't exist" do
    expect{ CSVTranslator.new 'file_name', Marlon, Barry }.to raise_error
    expect{ CSVTranslator.new 'file_name', Etching, Print}.not_to raise_error
    expect{ CSVTranslator.new 'file_name', Etching, Marlon}.to raise_error
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

  describe "themes" do
    let(:translation) { subject.translations.first }
    before do
      allow(CSV).to receive(:read) do
        [
          ["title", "themes", "versiona"],
          ["Cats", "Black and White, Urban Decay, Humour", "black"],
          ["Self-portrait", "Urban Decay, Neon", "brown"]
        ]
      end
      allow(Theme).to receive(:first_or_create)
    end

    it "are accessible on each hash" do
      expect(translation.themes).to eq ["Black and White", "Urban Decay", "Humour"]
    end

    it "can be filtered with prints" do
      expected_translation =
      {
        title: "Cats",
        themes: ["Black and White", "Urban Decay", "Humour"],
        versions: ["black"]
      }
      expect(translation.filter_with_prints_and_themes).to eq expected_translation
    end
  end

  describe "populating database" do
    before do
      allow(etching_model).to receive(:create_with_prints)
    end

    it "can create new records from the CSV" do
      expect(etching_model).to receive(:create_with_prints).with({title: "Cats", secret: "the_first_secret", versions: []})
      expect(etching_model).to receive(:create_with_prints).with({title: "Self-portrait", secret: "unmarked", versions: []})
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
    let(:subject) { CSVTranslator.new 'file_name', Etching, Theme }

    it "powers through the stack" do
      expect{ subject.write_records_to_db }.to change{ Etching.count }.by 2
    end

    describe "errors" do
      before do
        allow(Etching).to receive(:create!).and_raise Exception.new "Record not created!"
        subject.write_records_to_db
      end

      it "get collected by each translation" do
        expect(subject.translations.first[:error].message).to eql("Record not created!")
      end

      it "are accessible by the Translator object" do
        expect(subject.translations_with_errors.count).to eq 2
        expect(subject.translations_with_errors.first[:error].message).to eql("Record not created!")
      end

      it "can be checked" do
        expect(subject.errors?).to be true
      end
    end

    context "with themes" do
      before do
        allow(CSV).to receive(:read) do
          [
            %w& title secret themes &,
            %w& Cats the_first_secret Celestial,Retro &,
            %w& Self-portrait unmarked Retro,Futuristic,Blithering &
          ]
        end
      end

      it "populates the DB with etchings and themes" do
        expect{ subject.write_records_to_db(themes: true) }.to change{ Theme.count }.by 4
      end
    end
  end

end
