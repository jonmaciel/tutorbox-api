require 'rails_helper'

describe Resolvers::Organizations::Destroy do
  let(:current_user) { users(:user_organization_admin) }
  let(:target_organization) { organizations(:default_organization) }
  subject(:result) { described_class::call(nil, { id: target_organization.id } , current_user: current_user ) }

  describe '#call' do
    context 'when the organization has been destroyed' do

       it 'destroys organization with its rigth attributes' do
        expect { result }.to change { Organization.count }.by(-1)
      end
    end

    context 'when the organization has not been destroyed' do
      let(:current_user) { users(:software_house_admin) }

      it 'does not destroy a organization and returns error' do
        expect(result.is_a?(GraphQL::ExecutionError)).to be_truthy
      end
    end
  end
end