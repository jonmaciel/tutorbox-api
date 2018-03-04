require 'rails_helper'

describe Resolvers::Comments::Post do
  let(:current_user) { users(:user_organization_admin) }
  let(:video) { videos(:default_video_2) }
  let(:input) {
    {
      commentDestination: 'administrative',
      body: 'new comment',
      videoId: video.id,
    }
  }
  subject(:result) { described_class::call(nil, input, current_user: current_user ) }

  describe '#call' do
    context 'when the uses has been created' do
      let(:new_comment) { result[:comment] }

       it 'shoud create users whit its rigth attributes' do
        expect(new_comment).to be_persisted
        expect(new_comment.comment_destination).to eql input[:commentDestination]
        expect(new_comment.body).to eql input[:body]
        expect(new_comment.video_id).to eql input[:videoId]
        expect(new_comment.author).to eql current_user
      end
    end

    context 'when the uses has not been created' do
      let(:current_user) { users(:software_house_admin) }

      it 'does not create a user and returns error' do
        expect(result.is_a?(GraphQL::ExecutionError)).to be_truthy
      end
    end
  end
end