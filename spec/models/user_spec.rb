require 'rails_helper'

describe User, type: :model do
  let(:user) { users(:user_admin) }

  describe 'associations' do
    it { is_expected.to belong_to(:organization) }
    it { is_expected.to have_many(:videos) }
  end

  describe '#public methods' do
    User.user_roles.keys.each do |user_role|
      describe "##{user_role}?" do
        it "returns true if user_role is #{user_role} and opposite on the other side" do
          user.user_role = user_role
          expect(user).to send("be_#{user_role}")
        end
      end
    end

    describe '#access_policy' do
      it 'calls AccessPolicy' do
        expect(AccessPolicy).to receive(:new).with(user)
        user.access_policy
      end
    end
  end
end
