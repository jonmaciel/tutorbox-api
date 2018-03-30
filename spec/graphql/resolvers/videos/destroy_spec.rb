require 'rails_helper'

describe Resolvers::Videos::Destroy do
  let(:current_user) { users(:user_organization_admin) }
  let(:target_video) { videos(:default_video_1) }
  subject(:result) { described_class::call(nil, { id: target_video.id } , current_user: current_user ) }

  describe '#call' do
    context 'when the video has been destroyed' do

      it 'destroys video' do
        expect { result }.to change { Video.count }.by(-1)
      end
    end

    context 'when the video has not been destroyed' do
      let(:current_user) { users(:software_house_admin) }

      it 'does not destroy' do
        expect { subject }.to raise_error(Exceptions::PermissionDeniedError)
      end
    end
  end
end