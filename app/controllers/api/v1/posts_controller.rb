class Api::V1::PostsController < Api::ApplicationController
    before_action :find_post, only:[:show, :destroy, :update]
    # before_action :authenticate_user!, only:[:create, :destroy, :update]

    def index
        posts = Post.order created_at: :desc
        render json: posts, each_serializer: PostSerializer
    end

    def show
        render json: @post
    end
   
    def create
        post = Post.new post_params
        post.user = User.first
        if post.save
            render json:{id: post.id}
        else
            render(json: {errors: post.errors},
                status: 422 )
        end
    end

    def update
        if @post.update post_params
            render json: {id: @post.id}
        else
            render(
                json: {errors: @post.errors},
                status: 422
            )
        end
    end

    def destroy
        if @post.destroy
            head :ok
        else
            head :bad_request
        end
    end

    private

        def find_post
            @post = Post.find params[:id]
        end

        def post_params
            params.require(:post).permit(:title, :body)
        end
end   
