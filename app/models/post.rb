class Post < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many :likes, dependent: :destroy
    has_many :likers, through: :likes, source: :user

    validates(:title, presence: true, uniqueness: true)

 
  validates(
    :body, 
    presence: { message: "must include a body" },
    length: { minimum: 50 }
  )

  before_save :titleize_title

  def titleize_title
    self.title = self.title.titleize
  end

end
