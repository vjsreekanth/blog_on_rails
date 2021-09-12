class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :new, :create]
  before_action :find_user, only: [:edit, :update]
  before_action :authorize, only: [:edit, :update]


    def new
        @user = User.new
      end

      def show
        @user = User.find(params[:id])
      end
    
      def create
        @user = User.new user_params
        if @user.save
          session[:user_id] = @user.id
          flash[:primary] = "New user #{@user.name} created"
          redirect_to root_path
        else
          render :new
        end
      end

      def edit
        # @user = User.find(params[:id])
      end

      def update
        # @user = User.find(params[:id])
        # if can?([:edit, :update], @user)
          if @user.update(user_params)
          flash[:success] = "Profile updated"
          redirect_to @user
          else
            render 'edit'
        end
      end

      def edit_password
        @user = User.find(params[:id])
      end

      
      def update_password
       
        @user = User.find(params[:id])
     
        if (@user&.authenticate params[:current_password ]) && params[:current_password] != params[:password] && params[:password_confirmation] == params[:password]
            if @user.update password: params[:password] 
                flash[:success] = "Password updated"
                redirect_to user_path
            else
                flash[:danger] = @user.errors.full_messages.join(', ')
                redirect_to request.referrer
            end
        else
            flash[:danger] = "You've entered invalid password form inputs, Please follow rules"
            redirect_to request.referrer    
        end
    end




     

      
      private

      def find_user
        @user = User.find(params[:id])
      end
    
      def user_params
        params.require(:user).permit(
          :name,
          :email,
          :password,
          :password_confirmation,
        )
      end

      def authorize
        unless can?(:crud, @user)
          flash[:danger] = "Not Authorized"
          redirect_to root_path
        end
      end

end
