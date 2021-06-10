class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :like_count

  def like_count
    object.likes.count
  end

  belongs_to :user, key: :author


  
end
