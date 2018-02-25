require 'rails_helper'

describe UserMutation::Create do
  let(:current_user) { users(:user_organization_admin) }
  let(:organization) { organizations(:default_organization) }

  let(:result) {
    TutorboxApiSchema.execute(
      mutation,
      context: { current_user: current_user }
    )
  }

  let(:mutation) {
     <<-GRAPHQL
      mutation {
        createUser(
          input: {
            name: "User teste",
            email: "usertest@mail.com",
            password: "123123123",
            password_confirmation: "123123123",
            user_role: "organization_admin",
            organization_id: #{organization.id}
          }
        ) {
          user { id }
        }
      }
    GRAPHQL
  }

  describe '#execute' do
    context 'when the uses has been created' do
      it 'calls resolver and return user' do
        expect(Resolvers::Users::Create).to receive(:call).and_call_original
        expect(result['data']['createUser']['user']).to be_present
      end
    end
  end
end