require 'rails_helper'

RSpec.describe Theme, :type => :model do

  let!(:etching1) { Etching.create title: "A Fine Etching" }
  let!(:etching2) { Etching.create title: "Another Fine Etching" }
  let!(:theme1)   { Theme.create name: "Fine Etchings", etchings: [etching1, etching2] }
  let!(:theme2)   { Theme.create name: "Oddities", etchings: [etching2] }

  it "has a name" do
    expect(Theme.first.name).to eq "Fine Etchings"
  end

  it "each name is unique" do
    expect(Theme.create(name: "Fine Etchings").errors.first).to eq [:name,"has already been taken"]
    expect{Theme.create!(name: "Fine Etchings")}.to raise_error
  end


  context "association with etchings" do
    let(:association) { Theme.reflect_on_association(:etchings) }

    it "is :has_and_belongs_to_many" do
      expect(association.macro).to be :has_and_belongs_to_many
    end
  end

  it "has many etchings" do
    expect(theme1.etchings).to eq [etching1, etching2]
  end

  it "belongs to many etchings" do
    expect(etching2.themes).to eq [theme1, theme2]
  end
end
