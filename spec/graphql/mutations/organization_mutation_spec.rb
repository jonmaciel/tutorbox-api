require 'rails_helper'

describe OrganizationMutation do
  describe OrganizationMutation::Create do
    it { is_expected.to have_an_input_field(:newOrganizationAttributes).of_type(!OrganizationInput::Attributes) }
    it { is_expected.to have_an_input_field(:userAdminAttributes).of_type(UserInput::Attributes) }
    it { is_expected.to have_a_return_field(:organization).returning(Types::OrganizationType) }
  end

  describe OrganizationMutation::Update do
    it { is_expected.to have_an_input_field(:id).of_type('ID!') }
    it { is_expected.to have_an_input_field(:organizationAttributes).of_type(!OrganizationInput::Attributes) }
    it { is_expected.to have_a_return_field(:organization).returning(Types::OrganizationType) }
  end

  describe OrganizationMutation::Destroy do
    it { is_expected.to have_an_input_field(:id).of_type('ID!') }
    it { is_expected.to have_a_return_field(:success).returning('Boolean') }
  end

  describe '#callcheck' do
    let(:current_user) { users(:user_organization_admin) }
    let(:organization) { organizations(:default_organization) }

    let(:result) {
      TutorboxApiSchema.execute(
        mutation,
        context: { current_user: current_user }
      )
    }
    describe '#create' do
      let(:mutation) {
         <<-GRAPHQL
          mutation {
            createUser(
              input: {
                newUserAttributes: {
                  name: "User teste",
                  email: "usertest@mail.com",
                  password: "123123123",
                  password_confirmation: "123123123",
                  user_role: organizationAdmin,
                  organization_id: #{organization.id}
                }
              }
            ) {
              user { id }
            }
          }
        GRAPHQL
      }

      describe '#execute' do
        context 'when the organization has been created' do
          it 'calls resolver and return user' do
            expect(Resolvers::Users::Create).to receive(:call).and_call_original
            expect(result['data']['createUser']['user']).to be_present
          end
        end
      end
    end

    describe '#update' do
      let(:target_user) { users(:user_system_member) }
      let(:mutation) {
         <<-GRAPHQL
          mutation {
            updateUser(
              input: {
                id: #{target_user.id},
                userAttributes: {
                  email: "usertest@mail.com",
                  name: "User teste"
                }
              }
            ) {
              user { id }
            }
          }
        GRAPHQL
      }

      describe '#execute' do
        context 'when the organization has been created' do
          it 'calls resolver and return user' do
            expect(Resolvers::Users::Update).to receive(:call).and_call_original
            expect(result['data']['updateUser']['user']).to be_present
          end
        end
      end
    end

    describe '#destroy' do
      let(:target_user) { users(:user_system_member) }
      let(:mutation) {
         <<-GRAPHQL
          mutation {
            destroyUser(
              input: {
                id: #{target_user.id},
              }
            ) { success }
          }
        GRAPHQL
      }

      describe '#execute' do
        context 'when the organization has been created' do
          it 'calls resolver and return user' do
            expect(Resolvers::Users::Destroy).to receive(:call).and_call_original
            expect(result['data']['destroyUser']['success']).to be_truthy
          end
        end
      end
    end
  end
end