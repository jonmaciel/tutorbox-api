require 'rails_helper'

RSpec.describe 'organization' do
  let(:organization) { organizations(:default_organization) }
  let(:current_user) { users(:user_organization_admin) }

  let(:query) do
    <<-GRAPHQL
      {
       organization(id: #{organization.id}) { id }
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
    context 'when the user is allowed' do
      it 'should return rights values' do
        expect(result['data']['organization']).to be_present
      end
    end

    context 'when the user is not allowed' do
      let(:current_user) { users(:software_house_admin) }

      it 'should return rights values' do
        expect(result['data']['organization']).to be_nil
      end
    end
  end
end
