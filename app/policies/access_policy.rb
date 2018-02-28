class AccessPolicy
  include AccessGranted::Policy

  def configure
    role :admin, user_role: 'admin' do
      can :manage, User
      can :manage, Video
      can :manage, Organization
      can :read_collection, Organization
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

      can [:create, :update, :destroy, :read], Video do |target_video, current_user|
        target_video.system.organization_id == current_user.organization_id
      end

      can :manage, Organization do |target_organization, current_user|
        target_organization.id == current_user.organization_id
      end
    end

    role :system_admin, user_role: 'system_admin' do
      can [:create, :update, :destroy, :read], Video do |target_video, current_user|
        target_video.system.organization_id == current_user.organization_id
      end
      can :read, Organization do |target_organization, current_user|
        target_organization.id == current_user.organization_id
      end
    end

    role :system_member, user_role: 'system_member' do
      can [:create, :update, :destroy, :read], Video do |target_video, current_user|
        target_video.system.organization_id == current_user.organization_id
        target_video.created_by == current_user
      end

      can :read, Organization do |target_organization, current_user|
        target_organization.id == current_user.organization_id
      end
    end
  end
end
