require 'rails_helper'

describe Resolvers::Tasks::Destroy do
  let(:current_user) { users(:user_organization_admin) }
  let(:task_target) { tasks(:task_default_video_2) }

  subject(:result) { described_class::call(nil, { id: task_target.id } , current_user: current_user ) }

  describe '#call' do
    context 'when the task has been destroyed' do

       it 'destroys task with its rigth attributes' do
        expect { result }.to change { Task.count }.by(-1)
      end
    end

    context 'when the task has not been destroyed' do
      let(:current_user) { users(:software_house_admin) }

      it 'does not destroy a user and returns error' do
        expect(result.is_a?(GraphQL::ExecutionError)).to be_truthy
      end
    end
  end
end