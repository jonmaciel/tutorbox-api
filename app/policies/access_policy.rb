class AccessPolicy
  include AccessGranted::Policy

  def configure
    role :admin, { user_role: :admin } do
      can :manage, Video
      can :cancel_state, Video
    end
  end
end
