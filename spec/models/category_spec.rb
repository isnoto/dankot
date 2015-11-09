require 'rails_helper'

describe Category do
  subject { build :category, name: "WeddInG" }

  describe "#to_lower" do
    it "sets category name to lowercase" do
      subject.save
      expect(subject.name).to eq("wedding")
    end
  end
end
