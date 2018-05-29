class AccessPolicy
  include AccessGranted::Policy

  def configure
    role :admin, user_role: 'admin' do
      can :manage, User
      can :manage, Video
      can :assign, Video
      can :manage, Organization
      can :manage, Task
      can :manage, System
      can :manage, Attachment
      can :read_collection, Organization
      can :read_collection, System
      can :read_collection, User
      can :read_tutormakers, User
      can :read_collection, Video
      can :read_collection, Attachment
      can [:cancel_video, :send_request, :send_to_production, :cancel_request, :refused_by_screenwriter, :send_to_customer_revision], Video
      can [:read_comments, :video_attachments], Video
      can [:post, :edit, :destroy], Comment
    end

    role :script_writer,  lambda { |u| u.user_role.in?(['script_writer', 'fullproducer']) } do
      can :manage, Video
      can :manage, Task
      can :read_collection, Video
      can [:cancel_video, :send_request, :send_to_production, :cancel_request, :refused_by_screenwriter, :send_to_customer_revision], Video
      can :assign, Video
      can :read, Organization
      can [:post, :edit, :destroy], Comment
      can [:read_comments, :video_attachments], Video do |target_video, current_user|
        current_user.video_ids.include?(target_video.id)
      end
    end

    role :video_producer, lambda { |u| u.user_role.in?(['video_producer', 'fullproducer']) } do
      can [:post, :edit, :destroy], Comment do |target_comment, current_user|
        current_user.video_ids.include?(target_comment.video_id)
      end

      can [:update], Task do |task_target, current_user|
        current_user.video_ids.include?(task_target.video.id)
      end

      can [:create, :destroy], Attachment do |target_attatchment, current_user|
        current_user.video_ids.include?(target_attatchment.video_id)
      end

      can [
        :read,
        :update,
        :read_comments,
        :video_attachments,
        :accept_production,
        :cancel_production_request,
        :cancel_production,
        :send_to_screenwriter_revision
      ], Video do |target_video, current_user|
        current_user.video_ids.include?(target_video.id)
      end
    end

    role :organization_admin, user_role: 'organization_admin' do
      can :read_collection, System

      can :manage, User do |target_user, current_user|
        target_user.organization == current_user.organization
      end

      can :manage, System do |target_system, current_user|
        target_system.organization_id == current_user.organization_id
      end

      can [:create, :update, :destroy, :read, :cancel_video, :assign, :send_request, :refused_by_customer, :approved_by_customer], Video do |target_video, current_user|
        target_video.system.organization_id == current_user.organization_id
      end

      can [:create, :destroy], Attachment do |target_attatchment, current_user|
        target_attatchment.source.system.organization_id == current_user.organization_id
      end

      can [:update, :destroy, :read], Organization do |target_organization, current_user|
        target_organization.id == current_user.organization_id
      end

      can [:post, :edit, :destroy], Comment do |target_comment, current_user|
        target_comment.video.system.organization_id == current_user.organization_id
      end

      can [:read_comments, :video_attachments], Video do |target_video, current_user|
        target_video.system.organization_id == current_user.organization_id
      end

      can :manage, Task do |task_target, current_user|
        task_target.video.system.organization_id == current_user.organization_id
      end
    end

    role :system_admin, user_role: 'system_admin' do
      can :read_collection, System

      can [:create, :update, :destroy, :read, :cancel_video, :assign, :send_request, :refused_by_customer, :approved_by_customer], Video do |target_video, current_user|
        target_video.system.organization_id == current_user.organization_id
      end

      can :read, Organization do |target_organization, current_user|
        target_organization.id == current_user.organization_id
      end

      can [:post, :edit, :destroy], Comment do |target_comment, current_user|
        target_comment.video.system_id == current_user.system_id
      end

      can :manage, Task do |task_target, current_user|
        task_target.video.system.organization_id == current_user.organization_id
      end

      can [:read_comments, :video_attachments], Video do |target_video, current_user|
        target_video.system_id == current_user.system_id
      end

      can [:create, :destroy], Attachment do |target_attatchment, current_user|
        target_attatchment.source.system.organization_id == current_user.organization_id
      end
    end

    role :system_member, user_role: 'system_member' do
      can [:create, :update, :destroy, :read, :cancel_video, :assign, :send_request, :refused_by_customer, :approved_by_customer], Video do |target_video, current_user|
        target_video.system.organization_id == current_user.organization_id
        target_video.created_by == current_user
      end

      can :read, Organization do |target_organization, current_user|
        target_organization.id == current_user.organization_id
      end

      can [:post, :edit, :destroy], Comment do |target_comment, current_user|
        target_comment.video.system_id == current_user.system_id &&
        target_comment.author_id == current_user.id
      end

      can :manage, Task do |task_target, current_user|
        task_target.video.system.organization_id == current_user.organization_id
      end

      can [:read_comments, :video_attachments], Video do |target_video, current_user|
        current_user.video_ids.include?(target_video.id) &&
        target_video.system_id == current_user.system_id
      end

      can [:create, :destroy], Attachment do |target_attatchment, current_user|
        target_attatchment.source.system.organization_id == current_user.organization_id
      end
    end
  end
end
