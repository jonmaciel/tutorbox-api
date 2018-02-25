require 'rails_helper'

describe Resolvers::Users::Create do
  let(:current_user) { users(:user_organization_admin) }
  let(:organization) { organizations(:default_organization) }


  let(:input) {
    {
      name: 'User teste',
      email: 'usertest@mail.com',
      password: '123123123',
      password_confirmation: '123123123',
      user_role: 'organization_admin',
      organization_id: organization.id
    }
  }
  subject(:result) { described_class::call(nil, input, { current_user: current_user }) }

  describe '#call' do
    context 'when the uses has been created' do
      it { expect(result[:user]).to be_persisted }
    end

    context 'when the uses has not been created' do
      let(:current_user) { users(:software_house_admin) }

      it 'does not create a user and returns error' do
        expect(result.is_a?(GraphQL::ExecutionError)).to be_truthy
      end
    end
  end
end