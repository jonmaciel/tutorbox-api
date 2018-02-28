require 'rails_helper'

describe Resolvers::Videos::Update do
  let(:current_user) { users(:user_organization_admin) }
  let!(:target_video) { videos(:default_video_2) }
  let(:organization) { organizations(:default_organization) }
  let(:system) { systems(:default_system) }
  let(:video_id) { target_video.id }
  let(:video_attributes) {
    {
      title: 'Video 1',
      description: 'video test',
      url: 'fake_url',
      labels: ['test', 'videos'],
      system_id: system.id
    }
  }
  subject(:result) do
    described_class::call(nil, { id: video_id, videoAttributes: video_attributes }, { current_user: current_user })
  end
  let(:updated_video) { result[:video] }

  describe '#call' do
    context 'when the uses has been created' do

      it 'shoud update user whit input attributes' do
        expect(updated_video).to be_persisted
        expect(updated_video.id).to eql video_id
        expect(updated_video.title).to eql video_attributes[:title]
        expect(updated_video.description).to eql video_attributes[:description]
        expect(updated_video.url).to eql video_attributes[:url]
        expect(updated_video.labels).to eql video_attributes[:labels]
        expect(updated_video.system_id).to eql video_attributes[:system_id]
      end
    end

    context 'when a attribute has now sent, it keep the the old' do
      let(:video_attributes) {
        {
          title: 'Video 2',
          description: 'video test 2',
        }
      }

    it 'shoud update user whit input attributes' do
        expect(updated_video).to be_persisted
        expect(updated_video.title).to eql video_attributes[:title]
        expect(updated_video.description).to eql video_attributes[:description]
        expect(updated_video.url).to eql target_video.url
        expect(updated_video.labels).to eql target_video.labels
        expect(updated_video.system_id).to eql target_video.system_id
      end
    end

    context 'when the uses has not been updated' do
      let(:current_user) { users(:software_house_admin) }

      it 'does not create a user and returns error' do
        expect(result.is_a?(GraphQL::ExecutionError)).to be_truthy
      end
    end
  end
end