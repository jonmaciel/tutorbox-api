require 'rails_helper'

describe TaskMutation do
  describe TaskMutation::Create do  
    it { is_expected.to have_an_input_field(:name).of_type('String!') }
    it { is_expected.to have_an_input_field(:videoId).of_type('ID!') }
    it { is_expected.to have_a_return_field(:task).returning(Types::TaskType) }
  end

  describe TaskMutation::Update do
    it { is_expected.to have_an_input_field(:id).of_type('ID!') }
    it { is_expected.to have_an_input_field(:name).returning('String') }
    it { is_expected.to have_an_input_field(:done).returning('Boolean') }
    it { is_expected.to have_a_return_field(:task).returning(Types::TaskType) }
  end

  describe TaskMutation::Destroy do
    it { is_expected.to have_an_input_field(:id).of_type('ID!') }
    it { is_expected.to have_a_return_field(:success).returning('Boolean') }
  end

  describe '#callcheck' do
    let(:current_user) { users(:user_organization_admin) }
    let(:target_video) { videos(:default_video_2) }
    let(:task_target) { tasks(:task_default_video_2) }

    let(:result) {
      TutorboxApiSchema.execute(
        mutation,
        context: { current_user: current_user }
      )
    }

    describe '#post' do
      let(:mutation) {
         <<-GRAPHQL
          mutation {
            createTask(
              input: {
                name: "new task",
                videoId: #{target_video.id},
              }
            ) {
              task { id }
            }
          }
        GRAPHQL
      }

      describe '#execute' do
        context 'when the task has been created' do
          it 'calls resolver and return task' do
            expect(Resolvers::Tasks::Create).to receive(:call).and_call_original
            expect(result['data']['createTask']['task']).to be_present
          end
        end
      end
    end

    describe '#edit' do
      let(:mutation) {
         <<-GRAPHQL
          mutation {
            updateTask(
              input: {
                id: #{task_target.id},
                name: "edited task",
                done: true,
              }
            ) {
              task { id }
            }
          }
        GRAPHQL
      }

      describe '#execute' do
        context 'when the task has been edited' do
          it 'calls resolver and return task' do
            expect(Resolvers::Tasks::Update).to receive(:call).and_call_original
            expect(result['data']['updateTask']['task']).to be_present
          end
        end
      end
    end

    describe '#destroy' do
      let(:mutation) {
         <<-GRAPHQL
          mutation {
            destroyTask(input: { id: #{task_target.id} }) {
              success
            }
          }
        GRAPHQL
      }

      describe '#execute' do
        context 'when the task has been destroyed' do
          it 'calls resolver and return task' do
            expect(Resolvers::Tasks::Destroy).to receive(:call).and_call_original
            expect(result['data']['destroyTask']['success']).to be_truthy
          end
        end
      end
    end
  end
end
