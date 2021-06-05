class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body

  def like_count
    object.likes.count
  end

  belongs_to :user, key: :author

  # has_many :reviews
  
end
