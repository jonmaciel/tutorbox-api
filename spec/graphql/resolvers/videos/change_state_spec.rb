require 'rails_helper'

describe Resolvers::Videos::ChangeState do
  let(:current_user) { users(:user_organization_admin) }
  let(:target_video) { videos(:default_video_1) }
  let(:event) { 'cancel_video' }
  subject(:result) { described_class::call(nil, { id: target_video.id, event: event } , current_user: current_user ) }

  describe '#call' do
    context 'when the uses has been created' do
       it 'shoud create users whit its rigth attributes' do
        expect_any_instance_of(Video).to receive(:permited_events).and_call_original
        expect_any_instance_of(User).to receive(:can?).with(event.to_sym, any_args).and_call_original
        expect(result).to be_truthy
      end
    end

    context 'when the uses has not been created' do
      let(:current_user) { users(:software_house_admin) }

      it 'does not create a user and returns error' do
        expect(result.is_a?(GraphQL::ExecutionError)).to be_truthy
      end
    end

    context 'when the uses has not been created' do
      let(:event) { 'fake_event' }

      it 'does not create a user and returns error' do
        expect(result.is_a?(GraphQL::ExecutionError)).to be_truthy
      end
    end

    xcontext 'send alert email' do

    end
  end
end