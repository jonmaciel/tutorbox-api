require 'rails_helper'

describe Resolvers::Attachments::Destroy do
  let(:current_user) { users(:user_organization_admin) }
  let(:target_attachment) { attachments(:default_attachment) }

  subject(:result) { described_class::call(nil, { id: target_attachment.id } , current_user: current_user ) }

  describe '#call' do
    context 'when the attachment has been destroyed' do

       it 'destroys attachment with its rigth attributes' do
        expect { result }.to change { Attachment.count }.by(-1)
      end
    end

    context 'when the attachment has not been destroyed' do
      let(:current_user) { users(:software_house_admin) }

      it 'does not destroy a user and returns error' do
        expect { subject }.to raise_error(Exceptions::PermissionDeniedError)
      end
    end
  end
end