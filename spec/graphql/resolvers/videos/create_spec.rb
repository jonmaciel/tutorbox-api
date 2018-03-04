require 'rails_helper'

describe Resolvers::Videos::Create do
  let(:current_user) { users(:user_organization_admin) }
  let(:organization) { organizations(:default_organization) }
  let(:system) { systems(:default_system) }
  let(:new_video_attributes) {
    {
      title: 'Video 1',
      description: 'video test',
      url: 'fake_url',
      labels: ['test', 'videos'],
      system_id: system.id
    }
  }
  subject(:result) { described_class::call(nil, { newVideoAttributes: new_video_attributes } , current_user: current_user ) }

  describe '#call' do
    context 'when the video has been created' do
      let(:new_video) { result[:video] }

       it 'creates video with its rigth attributes' do
        expect(new_video).to be_persisted
        expect(new_video.title).to eql new_video_attributes[:title]
        expect(new_video.description).to eql new_video_attributes[:description]
        expect(new_video.url).to eql new_video_attributes[:url]
        expect(new_video.labels).to eql new_video_attributes[:labels]
        expect(new_video.system_id).to eql new_video_attributes[:system_id]
      end
    end
  end
end