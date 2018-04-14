require 'rails_helper'

describe Resolvers::Videos::Unassign do
  let(:current_user) { users(:user_admin) }
  let(:target_user) { users(:user_video_producer) }
  let(:target_video) { videos(:default_video_1) }
  subject(:result) {
    described_class::call(nil, { videoId: target_video.id, userId: target_user.id } , current_user: current_user )
  }

  before do
    target_user.videos << target_video
    target_user.save
  end

  describe '#call' do
    context 'when the video has been unassigned' do
      it 'Unassigns users' do
        expect(result).to be_truthy
        expect(target_video.reload.users).to match_array []
      end
    end

    context 'when the user ia a end_user trying to sign a tutormaker' do
      let(:current_user) { users(:user_system_member) }
      let(:target_user) { users(:user_script_writer) }

      it 'does not assign a video and returns error' do
        expect { subject }.to raise_error(Exceptions::PermissionDeniedError)
      end
    end

    context 'when the video has not been unassigned' do
      let(:current_user) { users(:software_house_admin) }

      it 'does not Unassign video and returns error' do
        expect { subject }.to raise_error(Exceptions::PermissionDeniedError)
      end
    end
  end
end