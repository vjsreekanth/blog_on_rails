class User < ApplicationRecord
    has_secure_password
    
    validates(
        :email, 
        presence: true, 
        uniqueness: true,
        format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
      )
      has_many :likes, dependent: :destroy
      has_many :liked_posts, through: :likes, source: :post
      # def change_password
      #   update_attribute :password, params[:user][:new_password]
      #   update_attribute :password_confirmation, params[:user],[:new_password_confirmation]
      # end

end
