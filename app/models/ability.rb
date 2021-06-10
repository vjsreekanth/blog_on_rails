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

    can :like, Post do |post|
      # This unsures that you cannot like your own question
      user.persisted? && post.user != user

      # If the current_user is not logged in we set "user" to
      # be a new user (guest) from line 15:
      # user ||= User.new # (guest user) not logged in
      # If "user" is a guest user, then"
      # question.user != user
      # will also be true. Therefore we'll also check if the user
      # is in the database as well (logged in) because we don't 
      # guests to be able to like.
    end
    
    can :destroy, Like do |like|
      like.user == user
    end

    # for Admin 
    if user.is_admin?
      can :manage, :all 
    end

  end
end
