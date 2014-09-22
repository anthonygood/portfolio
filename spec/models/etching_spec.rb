require 'rails_helper'

RSpec.describe Etching, :type => :model do
  let (:subject) { Etching.new( title: 'Nude Descending Stairs', 
                                date: 1981, 
                                width: 550, 
                                height: 300, 
                                plates: 2,
                                print_run: 100 ) }

  context "title" do
    it "is has a title" do
      expect(subject.title).to eq('Nude Descending Stairs')
    end

    it "must be a string" do
      expect(subject).to be_valid

      subject.title = 4

      expect(subject).to be_invalid
    end
  end

  context "date" do
    it "is a year" do
      subject.date = 1981

      expect(subject).to be_valid
      expect(subject.save!).to be true

      subject.date = "not a year"

      expect(subject).to be_invalid
    end
  end

  context "height, width, plates, print_run" do
    it "are all integers" do
      subject.width = "Blah"
      expect(subject).to be_invalid

      subject.width = 1
      expect(subject).to be_valid

      subject.print_run = 100.1
      expect(subject).to be_invalid

      subject.print_run = 100
      expect(subject).to be_valid

      subject.plates = true
      expect(subject).to be_invalid

      subject.plates = 1
      expect(subject).to be_valid

      subject.height = "Blah"
      expect(subject).to be_invalid

      subject.height = 10
      expect(subject).to be_valid
    end
  end

  context "saving" do

    before :each do
      subject.title = "Nude Descending Stairs"
      subject.save!
      subject.reload
    end

    it "sets the image url" do
      expect(subject.large_img_url).to eq('/images/nude_descending_stairs.jpeg')
    end

    it "sets a thumbnail url" do
      expect(subject.thumbnail_url).to eq('/images/nude_descending_stairs_thumbnail.jpeg')
    end

    it "changes Title Case to Underscore case" do
      subject.title = "Frog in the Drain"
      subject.save!
      subject.reload

      expect(subject.large_img_url).to eq('/images/frog_in_the_drain.jpeg')
    end
  end

end
