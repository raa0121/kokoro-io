class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can :manage, User, id: user.id
      can [ :read, :create, :update, :destroy ], AccessToken, user: user, essential: false
      can [ :read ], AccessToken, user: user, essential: true

      can :create, Message
      can :create, Room
      can :manage, Bot, user: user
      can :read, Room do |room|
        room.public? || user.rooms.include?(room)
      end
      can :read, Notification do |notification|
        uotification.user == user
      end
      can :update, Room do |room|
        room.maintainable? user
      end
      can :destroy, Room do |room|
        room.destroyable? user
      end
    end
    can :read, Room, private: false
    can :read, Message
    can :read, User
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
