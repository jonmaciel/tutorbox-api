require 'rails_helper'

describe Comment, type: :model do
  let(:comment) { comments(:comment_default_video_1) }

  it { is_expected.to act_as_paranoid }

  describe 'associations' do
    it { is_expected.to belong_to(:author) }
    it { is_expected.to belong_to(:video) }
  end

  describe '#public methods' do
    Comment.comment_destinations.each_key do |destination|
      describe "##{destination}?" do
        it "returns true if destination is #{destination} and opposite on the other side" do
          comment.comment_destination = destination
          expect(comment).to send("be_#{destination}")
        end
      end
    end
  end
end
