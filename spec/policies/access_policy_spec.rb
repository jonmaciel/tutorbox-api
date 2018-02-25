require 'rails_helper'

describe AccessPolicy do
  subject(:ability) { described_class.new(current_user) }
  let!(:fullrole) { [:create, :update, :destroy, :read] }

  describe 'admin abilities' do
    let(:current_user) { users(:user_admin) }

    describe '#video' do
      it { expect(ability.can?(:cancel_state, Video)).to be_truthy }
      it ':manage' do
        fullrole.each do |role|
          expect(ability.can?(role, Video)).to be_truthy
        end
      end
    end

    describe '#user' do
      it ':manage' do
        fullrole.each do |role|
          expect(ability.can?(role, User)).to be_truthy
        end
      end
    end
  end

  describe 'organization_admin abilities' do
    let(:current_user) { users(:user_organization_admin) }

    context 'when the target user is from same org' do
      let(:same_org_user) { users(:user_system_member) }

      it ':manage' do
        fullrole.each do |role|
          expect(ability.can?(role, same_org_user)).to be_truthy
        end
      end
    end

    context 'when the target user is from same org' do
      let(:other_org_user) { users(:software_house_member) }

      it 'cannot manage' do
        fullrole.each do |role|
          expect(ability.can?(role, other_org_user)).to be_falsey
        end
      end
    end
  end

  describe 'user_system_member abilities' do
    let(:current_user) { users(:software_house_member) }

    context 'when the target user is from same org' do
      it { expect(ability.can?(:create, Video)).to be_truthy }
    end

    context 'when the target user is from same org' do
      let(:created_video) { videos(:software_house_video) }

      it { expect(ability.can?(:update, created_video)).to be_truthy }
      it { expect(ability.can?(:destroy, created_video)).to be_truthy }
    end

    context 'when the target user is from same org' do
      let(:radom_video) { videos(:simple_video) }

      it 'cannot manage' do
        expect(ability.can?(:update, radom_video)).to be_falsey
        expect(ability.can?(:destroy, radom_video)).to be_falsey
      end
    end
  end
end
