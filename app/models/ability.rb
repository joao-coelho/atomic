class Ability
  include CanCan::Ability

  def initialize(user)
    case
    when user.nil?
      user = User.new # create guest user
    when user.admin?
      can :manage, User
      # can [:edit, :update, :new, :create], Activity
      # can [:index, :edit, :update], Signup
      # cannot [:change_admin_rights], User, id: user.id
    else
      # can [:index, :show], Activity
      # can [:edit, :update, :delete, :destroy], Signup, user_id: user.id
      # can [:new, :create], Signup
    end

    can [:index], Activity # everyone can index activities
  end
end
