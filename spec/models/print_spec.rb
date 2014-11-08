require 'rails_helper'

RSpec.describe Print, :type => :model do
  let(:subject) { Print.create }

  it "can be initialized with a filename" do
    new_print = Print.create_with_image('filename')

    expect(new_print.large_url).to eq('/filename.jpg')
  end

  it "won't duplicate the file extension if you include it by mistake!" do
    new_print = Print.create_with_image('filename.jpg')

    expect(new_print.large_url).to eq('/filename.jpg')
  end

  it "can accept a file extension other than jpg" do
    new_print = Print.create_with_image('filename', 'png')

    expect(new_print.large_url).to eq('/filename.png')
  end

  it "will accept a whole filename" do
    new_print = Print.create_with_image('filename.png')

    expect(new_print.large_url).to eq('/filename.png')
  end

  context "invalid" do
    it "without an etching" do
      expect(Print.new).to be_invalid
    end
  end

  context "valid" do
    let(:etching) { Etching.create(title: "The Golden Goose") }
    
    it "with an etching" do
      expect(Print.new(etching: etching)).to be_valid
    end
  end

end
