require 'rails_helper'

describe Resolvers::Videos::Assign do
  let(:current_user) { users(:user_admin) }
  let(:target_user) { users(:user_video_producer) }
  let(:target_video) { videos(:default_video_1) }
  subject(:result) {
    described_class::call(nil, { videoId: target_video.id, userId: target_user.id } , current_user: current_user )
  }

  describe '#call' do
    context 'when the uses has been assigned' do

      it 'assigns users' do
        expect(result).to be_truthy
        expect(target_video.reload.users).to match_array [target_user]
      end
    end

    context 'when the uses has not been assigned' do
      let(:current_user) { users(:software_house_admin) }

      it 'does not create a user and returns error' do
        expect(result.is_a?(GraphQL::ExecutionError)).to be_truthy
      end
    end
  end
end