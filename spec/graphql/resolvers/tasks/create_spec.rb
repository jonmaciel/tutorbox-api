require 'rails_helper'

describe Resolvers::Tasks::Create do
  let(:current_user) { users(:user_organization_admin) }
  let(:video) { videos(:default_video_2) }
  let(:input) {
    {
      name: 'new task',
      videoId: video.id,
    }
  }
  subject(:result) { described_class::call(nil, input, current_user: current_user ) }

  describe '#call' do
    context 'when the task has been created' do
      let(:new_task) { result[:task] }

       it 'creates task with its rigth attributes' do
        expect(new_task).to be_persisted
        expect(new_task.name).to eql input[:name]
        expect(new_task.video_id).to eql input[:videoId]
        expect(new_task.created_by).to eql current_user
      end
    end

    context 'when the task has not been created' do
      let(:current_user) { users(:software_house_admin) }

      it 'does not create a task and returns error' do
        expect { subject }.to raise_error(Exceptions::PermissionDeniedError)
      end
    end
  end
end