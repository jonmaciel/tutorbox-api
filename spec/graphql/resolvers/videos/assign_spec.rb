require 'rails_helper'

describe Resolvers::Videos::Assign do
  let(:current_user) { users(:user_admin) }
  let(:target_user) { users(:user_video_producer) }
  let(:target_video) { videos(:default_video_1) }
  subject(:result) {
    described_class::call(nil, { videoId: target_video.id, userId: target_user.id } , current_user: current_user )
  }

  describe '#call' do
    context 'when the video has been assigned' do
      it 'assigns video' do
        expect(result).to be_truthy
        expect(target_video.reload.users).to match_array [target_user]
      end
    end

    context 'when the video has not been assigned' do
      let(:current_user) { users(:software_house_admin) }

      it 'does not assign a video and returns error' do
        expect { subject }.to raise_error(Exceptions::PermissionDeniedError)
      end
    end
  end
end