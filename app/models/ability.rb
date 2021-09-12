# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
  

    alias_action :create, :read, :update, :destroy, to: :crud


    # for post
    can :crud, Post do|post|
      post.user == user
    end
    # user_id: user.id

    
    # for comment
    can [:crud], Comment do |comment|
      comment.user == user || comment.post.user == user
    end

    can [:create, :read], Comment do |comment|
      user
    end



    can :crud, User do |u|
      user.id == u.id
    end
     

    # for Admin 
    if user.is_admin?
      can :manage, :all 
    end

  end
end
