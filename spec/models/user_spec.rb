require 'rails_helper'

describe User, type: :model do
  let(:user) { users(:user_admin) }

  it { is_expected.to act_as_paranoid }

  describe 'associations' do
    it { is_expected.to belong_to(:organization) }
    it { is_expected.to have_many(:created_videos) }
  end

  describe 'basic validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:user_role) }
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

    describe '#end_user?' do
      end_user = ['organization_admin', 'system_admin', 'system_member']

      User.user_roles.each do |user_role, key|
        describe "##{user_role}" do
          it "says that #{user_role} is #{user_role.in?(end_user) ? 'a' : 'not'} end-user" do
            user.user_role = user_role
            expect(user.end_user?).to send("be_#{user_role.in?(end_user) ? 'truthy' : 'falsey'}")
          end
        end
      end
    end

    describe '#authorize!' do
      subject {  user.authorize!(:create, Video) }

      context 'when is authorized' do
        before { allow_any_instance_of(AccessPolicy).to receive(:can?).and_return(true) }
        it { is_expected.to be_truthy }
      end

      context 'when is not authorized' do
        before { allow_any_instance_of(AccessPolicy).to receive(:can?).and_return(false) }
        it { expect { subject }.to raise_error(Exceptions::PermissionDeniedError) }
      end
    end
  end

  describe '#callbacks' do
    context 'creating user' do
      let(:user) { build(:user, user_role: :system_admin, password: nil, password_confirmation: nil) }

      context 'when a new end_user has been created' do
        it 'creates a new passwod' do
          expect(user).to receive(:create_random_password).and_call_original
          expect(user).to receive(:send_welcome_email)
          expect(user.save!).to be_truthy
          expect(user.password_digest).to be_present
        end
      end

      context 'when a non end_user has been created' do
        let(:user) { build(:user, user_role: :system_admin, password: '123123123', password_confirmation: '123123123') }

        it 'does not create passwod' do
          expect(user).to_not receive(:create_random_password).and_call_original
          expect(user).to receive(:send_welcome_email)
          expect(user.password).to eql '123123123'
          expect(user.save!).to be_truthy
          expect(user.password_digest).to be_present
        end
      end
    end

    context 'updating user' do
      context 'when a new end_user has been created' do
        it 'creates a new passwod' do
          expect(user).to_not receive(:create_random_password)
          expect(user).to_not receive(:send_welcome_email)
          user.save
        end
      end
    end
  end

  describe '#scopes' do
    describe '#end_users' do
      let(:received_users) { User.end_users }
      let(:received_roles) { received_users.map(&:user_role).uniq }

      it { expect(received_roles).to match_array User::END_USER }
    end

    describe '#tutormakers' do
      let(:received_users) { User.tutormakers }
      let(:received_roles) { received_users.map(&:user_role).uniq }

      it { expect(received_roles).to_not match_array User::END_USER }
    end
  end
end
