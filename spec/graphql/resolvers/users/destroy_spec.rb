require 'rails_helper'

describe Resolvers::Users::Destroy do
  let(:current_user) { users(:user_organization_admin) }
  let(:target_user) { users(:user_system_member) }
  subject(:result) { described_class::call(nil, { id: target_user.id } , current_user: current_user ) }

  describe '#call' do
    context 'when the uses has been created' do

       it 'shoud create users whit its rigth attributes' do
        expect { result }.to change { User.count }.by(-1)
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