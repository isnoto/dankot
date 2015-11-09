require 'rails_helper'

describe MainPagePhoto do
  subject { build :main_page_photo, position: 1 }

  describe "#get_position" do
    let(:another_photo) { build :main_page_photo }

    context "when there are photos" do
      before { subject.save }

      it "returns next number after last position" do
        expect(another_photo.get_position).to eq 2
      end
    end

    context "when there is no photos" do
      it "returns 1" do
        expect(another_photo.get_position).to eq 1
      end
    end
  end
end
