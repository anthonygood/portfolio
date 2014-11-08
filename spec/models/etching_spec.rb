require 'rails_helper'

RSpec.describe Etching, :type => :model do
  let (:subject) { Etching.new( title: 'Nude Descending Stairs', 
                                year: 1981, 
                                width: 550, 
                                height: 300, 
                                plates: 2,
                                print_run: 100 ) }

  context "title" do
    it "is present" do
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

  context "year" do
    it "is a four digit number" do
      subject.year = 1981
      expect(subject).to be_valid
    end

    it "is not a string" do
      subject.year = "not a year"
      expect(subject).to be_invalid
    end

    it "is not a short or long number" do
      subject.year = 198
      expect(subject).to be_invalid

      subject.year = 19888
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

      subject.plates = "three"
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
    let!(:subject){ Etching.create(title: "Nude Descending Stairs") }

    # it "sets the image url" do
    #   expect(subject.large_img_url).to eq '/nude_descending_stairs.jpg'
    # end

    # it "sets a thumbnail url" do
    #   expect(subject.thumbnail_url).to eq '/nude_descending_stairs_thumbnail.jpg'
    # end

    # it "changes Title Case to underscore_case" do
    #   subject.title = "Frog in the Drain"
    #   subject.save!

    #   expect(subject.large_img_url).to eq '/frog_in_the_drain.jpg'
    # end

    # it "can update the file extension" do
    #   subject.filetype = 'png'
    #   subject.save!

    #   expect(subject.large_img_url).to eq '/nude_descending_stairs.png'
    # end

    # it "doesn't change the url every time" do
    #   subject.title = "Nude in Garden"
    #   subject.filetype = "bmp"
    #   subject.save!
    #   expect(subject.large_img_url).to eq '/nude_in_garden.bmp'

    #   subject.plates = 2
    #   subject.year = 1979

    #   expect{ subject.save! }.not_to change{ subject.large_img_url }
    # end
  end

  context "association with prints" do
    let(:association) { Etching.reflect_on_association(:prints) }

    it "is :has_many" do
      expect(association.macro).to be :has_many
    end

    it "is :dependent_destroy" do
      expect(association.options).to eq dependent: :destroy
    end
  end

  describe "create_with_prints" do
    before do
      allow(Print).to receive(:create_with_image) { puts "CREATE!" }
    end

    it "creates prints", focus: true do
      expect(Print).to receive(:create_with_image).with("a_gallant_wind_1.jpg")
      expect(Print).to receive(:create_with_image).with("a_gallant_wind_2.jpg")

      etching = Etching.create_with_prints(
        title: "A Gallant Wind", 
        versions: ["a_gallant_wind_1.jpg", "a_gallant_wind_2.jpg"] 
        )
    end

    it "raises an exception if you don't specify prints" do
      expect{ Etching.create_with_prints}.to raise_error(ArgumentError)
    end
  end

end
