class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize, only: [:edit, :update, :destroy]

    def new
        @post = Post.new
    end

    def create
        @post = Post.new post_params
        @post.user = current_user
    
        if @post.save
          flash[:primary] = "#{@post.title} created"
          redirect_to post_path(@post.id)
        else
          render :new
        end
    end

    def show
      @comment= Comment.new
      @comments = @post.comments.order(created_at: :desc)
    end

    def index
        @posts = Post.all.order(created_at: :desc)
    end

    def edit
      @post = Post.find(params[:id])
    end
    
    def update
      @post = Post.find params[:id]
        if @post.update post_params
          flash[:dark] = "#{@post.title} updated"
          redirect_to post_path(@post)
        else
          render :edit 
        end
      end
      
      def destroy
        @post = Post.find params[:id]
        @post.destroy
        flash[:danger] = "#{@post.title} deleted"
        redirect_to posts_path
      end
    
      private
    
      def post_params
        params.require(:post).permit(:title, :body)
      end
    
      def find_post
        @post = Post.find params[:id]
      end

      def authorize
        unless can?(:crud, @post)
          flash[:danger] = "Not Authorized"
          redirect_to root_path
        end
      end

end
