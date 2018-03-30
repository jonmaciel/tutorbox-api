require 'rails_helper'

describe Resolvers::Videos::ChangeState do
  let(:current_user) { users(:user_organization_admin) }
  let(:target_video) { videos(:default_video_1) }
  let(:event) { 'cancel_video' }
  subject(:result) { described_class::call(nil, { id: target_video.id, event: event } , current_user: current_user ) }

  describe '#call' do
    context 'when the video state has been changed' do
       it 'changes video state' do
        expect_any_instance_of(Video).to receive(:permited_events).and_call_original
        expect_any_instance_of(User).to receive(:can?).with(event.to_sym, any_args).and_call_original
        expect(result).to be_truthy
      end
    end

    context 'when the video state has not been changed' do
      let(:current_user) { users(:software_house_admin) }

      it 'does not assing video and returns error' do
        expect { subject }.to raise_error(Exceptions::PermissionDeniedError)
      end
    end

    context 'when the video state is invalid' do
      let(:event) { 'fake_event' }

      it 'does not assing video and returns error' do
        expect { subject }.to raise_error(Exceptions::NotPermittedEvent)
      end
    end

    xcontext 'send alert email' do

    end
  end
end