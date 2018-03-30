require 'rails_helper'

describe Resolvers::Comments::Destroy do
  let(:current_user) { users(:user_organization_admin) }
  let(:target_comment) { comments(:comment_default_video_1) }

  subject(:result) { described_class::call(nil, { id: target_comment.id } , current_user: current_user ) }

  describe '#call' do
    context 'when the comment has been destroyed' do

       it 'destroys comment with its rigth attributes' do
        expect { result }.to change { Comment.count }.by(-1)
      end
    end

    context 'when the comment has not been destroyed' do
      let(:current_user) { users(:software_house_admin) }

      it 'does not destroy a user and returns error' do
        expect { subject }.to raise_error(Exceptions::PermissionDeniedError)
      end
    end
  end
end