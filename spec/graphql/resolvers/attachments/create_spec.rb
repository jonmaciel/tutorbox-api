require 'rails_helper'

describe Resolvers::Attachments::Create do
  let(:current_user) { users(:user_organization_admin) }
  let(:video) { videos(:default_video_2) }
  let(:input) {
    {
      name: 'task',
      url: '/fake/url',
      sourceId: video.id,
    }
  }
  subject(:result) { described_class::call(nil, input, current_user: current_user ) }

  describe '#call' do
    context 'when the attachment has been created' do
      let(:new_attachment) { result[:attachment] }

       it 'creates attachment with its rigth attributes' do
        expect(new_attachment).to be_persisted
        expect(new_attachment.name).to eql input[:name]
        expect(new_attachment.url).to eql input[:url]
        expect(new_attachment.source_id).to eql input[:sourceId]
        expect(new_attachment.created_by).to eql current_user
      end
    end

    context 'when the attachment has not been created' do
      let(:current_user) { users(:software_house_admin) }

      it 'does not create a attachment and returns error' do
        expect { subject }.to raise_error(Exceptions::PermissionDeniedError)
      end
    end
  end
end