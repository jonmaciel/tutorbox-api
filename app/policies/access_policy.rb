class AccessPolicy
  include AccessGranted::Policy

  def configure
    role :admin, user_role: 'admin' do
      can :manage, User
      can :manage, Video
      can :cancel_state, Video
    end

    role :script_writer, user_role: 'script_writer' do
    end

    role :video_producer, user_role: 'video_producer' do
    end

    role :organization_admin, user_role: 'organization_admin' do
      can :manage, User do |target_user, current_user|
        target_user.organization == current_user.organization
      end
    end

    # role :system_admin, { user_role: :system_admin } do
    # end

    role :system_member, user_role: 'system_member' do
      can :create, Video
      can [:update, :destroy], Video do |target_video, current_user|
        target_video.created_by == current_user
      end
    end
  end
end
