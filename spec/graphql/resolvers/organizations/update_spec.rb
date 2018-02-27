require 'rails_helper'

describe Resolvers::Organizations::Update do
  let(:current_user) { users(:user_admin) }
  let!(:target_organization) { organizations(:default_organization) }
  let(:organization_id) { target_organization.id }
  let(:organization_attributes) {
    {
      name: 'new name',
    }
  }
  subject(:result) do
    described_class::call(
      nil,
      { id: organization_id, organizationAttributes: organization_attributes },
      { current_user: current_user }
    )
  end
  let(:updated_organization) { result[:organization] }

  describe '#call' do
    context 'when the uses has been created' do

      it 'shoud update user whit input attributes' do
        expect(updated_organization.id).to eql organization_id
        expect(updated_organization.name).to eql organization_attributes[:name]
      end
    end

    context 'when a attribute has now sent, it keep the the old' do
      let(:organization_attributes) { { } }

    it 'shoud update user whit input attributes' do
        expect(updated_organization.id).to eql organization_id
        expect(updated_organization.name).to eql target_organization.name
      end
    end

    context 'when the uses has not been updated' do
      let(:current_user) { users(:user_system_member) }

      it 'does not create a user and returns error' do
        expect(result.is_a?(GraphQL::ExecutionError)).to be_truthy
      end
    end
  end
end