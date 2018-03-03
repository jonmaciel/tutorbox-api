require 'rails_helper'

describe Resolvers::Organizations::Create do
  let(:current_user) { users(:user_admin) }
  let(:organization) { organizations(:default_organization) }
  let(:new_organization_attributes) {
    {
      name: 'organization teste',
    }
  }

  let(:user_admin_attributes) {
    {
      name: 'User teste',
      email: 'usertest@mail.com',
      password: '123123123',
      password_confirmation: '123123123',
      user_role: 'organization_admin',
      organization_id: organization.id
    }
  }

  subject(:result) {
    described_class::call(
      nil,
      {
        newOrganizationAttributes: new_organization_attributes,
        userAdminAttributes: user_admin_attributes

      },
      current_user: current_user
    )
  }

  describe '#call' do
    context 'when the uses has been created' do
      let(:new_organization) { result[:organization] }
      let(:new_admin_user) { new_organization.users.first }

       it 'shoud create organizations whit its rigth attributes' do
        expect(new_organization).to be_persisted
        expect(new_organization.name).to eql new_organization_attributes[:name]

        expect(new_admin_user).to be_persisted
        expect(new_admin_user.name).to eql user_admin_attributes[:name]
        expect(new_admin_user.email).to eql user_admin_attributes[:email]
        expect(new_admin_user.user_role).to eql user_admin_attributes[:user_role]
        expect(new_admin_user.organization_id).to eql new_organization.id
      end
    end

    context 'when the user has been created without admin' do
      let(:new_organization) { result[:organization] }
      let(:user_admin_attributes) { nil }
      let(:new_admin_user) { new_organization.users.first }

       it 'shoud create organizations whit its rigth attributes' do
        expect(new_organization).to be_persisted
        expect(new_organization.name).to eql new_organization_attributes[:name]

        expect(new_admin_user).to be_blank
      end
    end

    context 'when the uses has not been created' do
      let(:current_user) { users(:software_house_admin) }

      it 'does not create a organization and returns error' do
        expect(result.is_a?(GraphQL::ExecutionError)).to be_truthy
      end
    end
  end
end
