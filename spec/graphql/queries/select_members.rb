require 'rails_helper'

RSpec.describe 'organizations' do
  let(:organization) { organizations(:default_organization) }
  let(:organization_id) { organization.id }

  let(:query) do
    <<-GRAPHQL
      {
        selectMembers(organizationId: #{organization_id}) {
          id
          name
          user_role
        }
      }
    GRAPHQL
  end

  let(:result) {
    TutorboxApiSchema.execute(
      query,
      context: { current_user: current_user }
    )
  }

  describe '#callcheck' do
    describe 'tutormakers' do
      [:user_admin, :user_script_writer].each do |role|
        context "when the user is #{role}" do
          let(:current_user) { users(role) }
          let(:expected_roles) {
            ['admin', 'scriptWriter', 'videoProducer', 'organizationAdmin', 'systemAdmin', 'systemMember']
          }
          let(:returned_roles) {
            result['data']['selectMembers'].map { |member|  member['user_role'] }.uniq
          }

          it 'returns rights values' do
            expect(returned_roles).to match_array returned_roles
          end
        end
      end

      context "when the user is video_producer" do
        let(:current_user) { users(:user_video_producer) }

         it 'returns rights values' do
          expect(result['data']['selectMembers']).to be_nil
        end
      end
    end

    describe 'end_users' do
      [:user_organization_admin, :user_system_admin, :user_system_member].each do |role|
        context "when the user is #{role}" do
          let(:current_user) { users(role) }
          let(:expected_roles) { ['organizationAdmin', 'systemAdmin', 'systemMember'] }
          let(:returned_roles) {
            result['data']['selectMembers'].map { |member| member['user_role'] }.uniq
          }

          it 'returns rights values' do
            expect(returned_roles).to match_array returned_roles
          end
        end
      end
    end

    context 'when the user is not allowed' do
      let(:current_user) { users(:software_house_admin) }

      it 'does not return organizations' do
        expect(result['data']['selectMembers']).to be_nil
        expect(result['errors'][0]['message']).to eql 'Permission denied'
      end
    end
  end
end
