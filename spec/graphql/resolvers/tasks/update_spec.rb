require 'rails_helper'

describe Resolvers::Tasks::Update do
  let(:current_user) { users(:user_organization_admin) }
  let(:target_task) { tasks(:task_default_video_1) }
  let(:input) {
    {
      id: target_task.id,
      name: 'new body',
      done: true
    }
  }

  subject(:result) { described_class::call(nil, input, current_user: current_user ) }

  describe '#call' do
    context 'when the task has been created' do
      let(:updated_task) { result[:task] }

      it 'creates a new task with its rigth attributes' do
        expect(updated_task.id).to eql target_task.id
        expect(updated_task.name).to eql updated_task.name
        expect(updated_task.done).to eql updated_task.done
      end
    end

    context 'when the task has not been created' do
      let(:current_user) { users(:software_house_admin) }

      it 'does not create a task and returns error' do
        expect(result.is_a?(GraphQL::ExecutionError)).to be_truthy
      end
    end
  end
end