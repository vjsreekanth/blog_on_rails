class User < ApplicationRecord
    has_secure_password
    
    validates(
        :email, 
        presence: true, 
        uniqueness: true,
        format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
      )

      # def change_password
      #   update_attribute :password, params[:user][:new_password]
      #   update_attribute :password_confirmation, params[:user],[:new_password_confirmation]
      # end

end
