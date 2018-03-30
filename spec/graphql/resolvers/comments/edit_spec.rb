require 'rails_helper'

describe Resolvers::Comments::Edit do
  let(:current_user) { users(:user_organization_admin) }
  let(:target_comment) { comments(:comment_default_video_1) }
  let(:input) {
    {
      id: target_comment.id,
      body: 'new body',
      read: true
    }
  }

  subject(:result) { described_class::call(nil, input, current_user: current_user ) }

  describe '#call' do
    context 'when the comment has been created' do
      let(:updated_comment) { result[:comment] }

      it 'creates a new comment with its rigth attributes' do
        expect(updated_comment.id).to eql target_comment.id
        expect(updated_comment.body).to eql updated_comment.body
        expect(updated_comment.read).to eql updated_comment.read
      end
    end

    context 'when the comment has not been created' do
      let(:current_user) { users(:software_house_admin) }

      it 'does not create a comment and returns error' do
        expect { subject }.to raise_error(Exceptions::PermissionDeniedError)
      end
    end
  end
end