require 'rails_helper'

describe Resolvers::Users::Update do
  let(:current_user) { users(:user_organization_admin) }
  let!(:target_user) { users(:user_system_member) }
  let(:organization) { organizations(:default_organization) }
  let(:user_id) { target_user.id }
  let(:user_attributes) {
    {
      name: 'new name',
      email: 'new_emailt@mail.com',
      password: 'new_passwod_123123123',
      password_confirmation: 'new_passwod_123123123',
      user_role: 'system_admin',
      organization_id: organization.id
    }
  }
  subject(:result) do
    described_class::call(nil, { id: user_id, userAttributes: user_attributes }, { current_user: current_user })
  end
  let(:updated_user) { result[:user] }

  describe '#call' do
    context 'when the user has been updated' do
      it 'shoud update user with input attributes' do
        expect(updated_user.id).to eql user_id
        expect(updated_user.name).to eql user_attributes[:name]
        expect(updated_user.email).to eql user_attributes[:email]
        expect(updated_user.user_role).to eql user_attributes[:user_role]
        expect(updated_user.organization_id).to eql user_attributes[:organization_id]
        expect(updated_user.password_digest).to_not eql target_user.password_digest
      end
    end

    context 'when a attribute has now sent, it keep the the old' do
      let(:user_attributes) {
        {
          email: 'new_emailt@mail.com',
          user_role: 'system_admin',
        }
      }

    it 'update user with input attributes' do
        expect(updated_user.id).to eql user_id
        expect(updated_user.email).to eql user_attributes[:email]
        expect(updated_user.user_role).to eql user_attributes[:user_role]
        expect(updated_user.name).to eql target_user.name
        expect(updated_user.organization_id).to eql target_user.organization_id
        expect(updated_user.password_digest).to eql target_user.password_digest
      end
    end

    context 'when the user has not been updated' do
      let(:current_user) { users(:software_house_admin) }

      it 'does not create a user and returns error' do
        expect(result.is_a?(GraphQL::ExecutionError)).to be_truthy
      end
    end
  end
end