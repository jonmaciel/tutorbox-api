require 'rails_helper'

describe Video, type: :model do
  subject(:video) { videos(:default_video_1) }

  it { is_expected.to act_as_paranoid }

  describe 'associations' do
    it { is_expected.to belong_to(:system) }
    it { is_expected.to belong_to(:created_by) }
    it { is_expected.to have_many(:comments) }
    it { is_expected.to have_many(:tasks) }
    it { is_expected.to have_many(:attachments) }
  end

  describe '#public_events' do
    describe '#authorize_event!' do
      it { expect { video.authorize_event!(:fake) }.to raise_error(Exceptions::NotPermittedEvent) }
      it { expect(video.authorize_event!(:send_request)).to be_truthy }
    end
  end

  describe '#aasm' do
    context 'state transitions' do
      it { is_expected.to transition_from(:draft).to(:canceled).on_event(:cancel_video) }
      it { is_expected.to transition_from(:draft).to(:script_creation).on_event(:send_request) }
      it { is_expected.to transition_from(:script_creation).to(:draft).on_event(:cancel_request) }
      it { is_expected.to transition_from(:script_creation).to(:production).on_event(:send_to_production) }
      it { is_expected.to transition_from(:production).to(:script_creation).on_event(:cancel_production) }
      it { is_expected.to transition_from(:production).to(:screenwriter_revision).on_event(:send_to_screenwriter_revision) }
      it { is_expected.to transition_from(:screenwriter_revision).to(:customer_revision).on_event(:send_to_customer_revision) }
      it { is_expected.to transition_from(:customer_revision).to(:screenwriter_revision).on_event(:refused_by_customer) }
      it { is_expected.to transition_from(:customer_revision).to(:approved).on_event(:approved_by_customer) }
    end

    describe 'permited_events' do
      it do
        expect_any_instance_of(AASM::InstanceBase).to receive(:events).with(permitted: true).and_call_original
        video.permited_events
      end

      it 'does note permit going to production if description is emptu' do
        video.description = ''
         expect { is_expected.to transition_from(:draft).to(:script_creation).on_event(:send_request) }.to raise_error(AASM::InvalidTransition)
      end
    end

    context 'historing the transitions' do
      it { expect { video.cancel_video! }.to change{ StateHistory.count }.by(1) }

      it 'logs all state transitions' do
        expect do
          video.send_request!
          video.cancel_request!
          video.send_request!
          video.send_to_production!
          video.cancel_production!
          video.send_to_production!
          video.send_to_screenwriter_revision!
          video.send_to_customer_revision!
          video.refused_by_customer!
          video.send_to_customer_revision!
          video.approved_by_customer!
        end.to change{ StateHistory.count }.by(11)
      end
    end

    context 'versioning state transitions' do
      it { expect { video.cancel_video! }.to change{ StateHistory.count }.by(1) }

      it 'set version' do
        expect do
          video.send_request!
          video.cancel_request!
          video.send_request!
          video.send_to_production!
          video.cancel_production!
          video.send_to_production!
          video.send_to_screenwriter_revision!
          video.send_to_customer_revision!
          video.refused_by_customer!
          video.send_to_customer_revision!
          video.approved_by_customer!
        end.to change{ video.version }.from(0).to(7)
      end
    end
  end
end
