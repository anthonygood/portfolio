require 'rails_helper'

RSpec.describe Etching, :type => :model do
  let (:subject) { Etching.new( title: 'Nude Descending Stairs', 
                                date_created: 1981, 
                                width: 550, 
                                height: 300, 
                                plates: 2,
                                print_run: 100 ) }

  context "title" do
    it "is has a title" do
      expect(subject.title).to eq 'Nude Descending Stairs'
    end

    it "must be a string" do
      expect(subject).to be_valid

      subject.title = 4

      expect(subject).to be_invalid
    end

    it "saves the title" do
      subject.title = "New Title"
      subject.save!
      subject.reload

      expect(subject.title).to eq "New Title"
    end
  end

  context "date" do
    it "is a year" do
      # subject.date_created = 1981
      # expect(subject).to be_valid

      subject.date_created = "not a year"
      expect(subject).to be_invalid
    end
  end

  context "height, width, plates, print_run" do
    it "are all integers" do
      subject.width = "Blah"
      expect(subject).to be_invalid

      # subject.width = 1
      # expect(subject).to be_valid

      # subject.print_run = 100.1
      # expect(subject).to be_invalid

      # subject.print_run = 100
      # expect(subject).to be_valid

      # subject.plates = true
      # expect(subject).to be_invalid

      # subject.plates = 1
      # expect(subject).to be_valid

      # subject.height = "Blah"
      # expect(subject).to be_invalid

      # subject.height = 10
      # expect(subject).to be_valid
    end
  end

  context "saving" do
    let!(:subject){ Etching.create(title: "Nude Descending Stairs") }

    it "sets the image url" do
      expect(subject.large_img_url).to eq '/images/nude_descending_stairs.jpeg'
    end

    it "sets a thumbnail url" do
      expect(subject.thumbnail_url).to eq '/images/nude_descending_stairs_thumbnail.jpeg'
    end

    it "changes Title Case to underscore_case" do
      subject.title = "Frog in the Drain"
      subject.save!

      expect(subject.large_img_url).to eq '/images/frog_in_the_drain.jpeg'
    end

    it "can update the file extension" do
      subject.filetype = 'png'
      subject.save!

      expect(subject.large_img_url).to eq '/images/nude_descending_stairs.png'
    end

    it "doesn't change the url every time" do
      subject.title = "Nude in Garden"
      subject.filetype = "bmp"
      subject.save!
      expect(subject.large_img_url).to eq '/images/nude_in_garden.bmp'

      subject.plates = 2
      subject.date_created = 1979

      expect{ subject.save! }.not_to change{ subject.large_img_url }
    end
  end

end
