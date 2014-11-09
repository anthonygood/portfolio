require 'rails_helper'

RSpec.describe Print, :type => :model do
  let(:etching) { Etching.create title: "Boo Radley"}

  context "invalid" do
    it "without an etching" do
      expect(Print.new).to be_invalid
    end
  end

  describe "create_with_image" do
    let(:print) { Print.create_with_image etching }

    it "creates a new print" do
      expect{ print }.to change { Print.count }.by 1
    end

    it "associates the new print with the etching" do
      print = Print.create_with_image etching

      expect(etching.prints.count).to eq 1
      expect(etching.prints.last).to eq print
      expect(print.etching).to eq etching
    end

    it "can accept optional file extension" do
      new_print = Print.create_with_image(etching, 'png')

      expect(new_print.large_url).to eq('/boo_radley.png')
    end

    it "won't duplicate the file extension if you include it by mistake!" do
      new_print = Print.create_with_image(etching, 'jpg')

      expect(new_print.large_url).to eq('/boo_radley.jpg')
    end

    context "valid" do
      let(:etching) { Etching.create(title: "The Golden Goose") }
      
      it "with an etching" do
        expect(Print.new(etching: etching)).to be_valid
      end
    end

  end

end
