require 'rails_helper'

describe Resolvers::Users::Create do
  let(:current_user) { users(:user_organization_admin) }
  let(:organization) { organizations(:default_organization) }
  let(:new_user_attributes) {
    {
      name: 'User teste',
      email: 'usertest@mail.com',
      password: '123123123',
      password_confirmation: '123123123',
      user_role: 'organization_admin',
      organization_id: organization.id
    }
  }
  subject(:result) { described_class::call(nil, { new_user_attributes: new_user_attributes } , current_user: current_user ) }

  describe '#call' do
    context 'when the uses has been created' do
      let(:new_user) { result[:user] }

       it 'shoud create users whit its rigth attributes' do
        expect(new_user).to be_persisted
        expect(new_user.name).to eql new_user_attributes[:name]
        expect(new_user.email).to eql new_user_attributes[:email]
        expect(new_user.user_role).to eql new_user_attributes[:user_role]
        expect(new_user.organization_id).to eql new_user_attributes[:organization_id]
      end
    end

    context 'when the uses has not been created' do
      let(:current_user) { users(:software_house_admin) }

      it 'does not create a user and returns error' do
        expect(result.is_a?(GraphQL::ExecutionError)).to be_truthy
      end
    end
  end
end