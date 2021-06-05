class Api::V1::UsersController < Api::ApplicationController
    def create
        user = User.new user_params
        if user.save
            session[:user_id] = user.id
            render json: {id: user.id}
        else
            render(
                json: {errors: user.errors.messages},
                status: 422
            )
        end
    end
   

    private
    def user_params
        user_params = params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
