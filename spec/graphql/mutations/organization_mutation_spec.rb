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
    let(:organization_target) { organizations(:default_organization) }

    let(:result) {
      TutorboxApiSchema.execute(
        mutation,
        context: { current_user: current_user }
      )
    }
    describe '#create' do
      let(:current_user) { users(:user_admin) }
      let(:mutation) {
         <<-GRAPHQL
          mutation {
            createOrganization(
              input: {
                newOrganizationAttributes: {
                  name: "User teste"
                }
              }
            ) {
              organization { id }
            }
          }
        GRAPHQL
      }

      describe '#execute' do
        context 'when the organization has been created' do
          it 'calls resolver and return user' do
            expect(Resolvers::Organizations::Create).to receive(:call).and_call_original
            expect(result['data']['createOrganization']['organization']).to be_present
          end
        end
      end
    end

    describe '#update' do
      let(:mutation) {
         <<-GRAPHQL
          mutation {
            updateOrganization(
              input: {
                id: #{organization_target.id},
                organizationAttributes: {
                  name: "Novo nome"
                }
              }
            ) {
              organization { id }
            }
          }
        GRAPHQL
      }

      describe '#execute' do
        context 'when the organization has been created' do
          it 'calls resolver and return user' do
            expect(Resolvers::Organizations::Update).to receive(:call).and_call_original
            expect(result['data']['updateOrganization']['organization']).to be_present
          end
        end
      end
    end

    describe '#destroy' do
      let(:mutation) {
         <<-GRAPHQL
          mutation {
            destroyOrganization(
              input: {
                id: #{organization_target.id},
              }
            ) { success }
          }
        GRAPHQL
      }

      describe '#execute' do
        context 'when the organization has been created' do
          it 'calls resolver and return user' do
            expect(Resolvers::Organizations::Destroy).to receive(:call).and_call_original
            expect(result['data']['destroyOrganization']['success']).to be_truthy
          end
        end
      end
    end
  end
end