require 'rails_helper'

describe Resolvers::Videos::Destroy do
  let(:current_user) { users(:user_organization_admin) }
  let(:target_video) { videos(:default_video_1) }
  subject(:result) { described_class::call(nil, { id: target_video.id } , current_user: current_user ) }

  describe '#call' do
    context 'when the uses has been created' do

       it 'shoud create users whit its rigth attributes' do
        expect { result }.to change { Video.count }.by(-1)
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