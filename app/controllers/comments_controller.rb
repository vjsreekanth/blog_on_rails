class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :create]
  before_action :find_comment, only: [:show, :edit, :update, :destroy]
  # before_action :authorize, only: [:edit, :update, :destroy, :create] 



    def create
        @post = Post.find params[:post_id]
        @comment = Comment.new comment_params
        @comment.post = @post
        @comment.user = current_user
        
        if @comment.save
            flash[:light] = 'Comment created'
          redirect_to post_path(@post)
        else
          @comments = @post.comments.order(created_at: :desc)
          render 'posts/show'
        end
    end

    def destroy
       
        @comment = Comment.find params[:id]
        if can?(:crud, @comment)
          @comment.destroy
          flash[:danger] = "Comment deleted"
          redirect_to post_path(@comment.post)
        else
          head :unauthorized
        end
        
     end
     private

        def find_comment
          @comment = Comment.find params[:id]
        end


        def comment_params
            params.require(:comment).permit(:body)
        end

        def authorize
          unless can?(:crud, @comment)
            flash[:danger] = "Not Authorized"
            redirect_to root_path
          end
        end

end
