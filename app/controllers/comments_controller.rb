class CommentsController < ApplicationController


    def create
        @post = Post.find params[:post_id]
        @comment = Comment.new comment_params
        @comment.post = @post
        
        # @review.user = @current_user
        
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
        # if can?(:crud, @comment)
          @comment.destroy
          flash[:danger] = "Comment deleted"
          redirect_to post_path(@comment.post)
        # else
        #   head :unauthorized
        # end
        
     end
     private

        def comment_params
            params.require(:comment).permit(:body)
        end

end
