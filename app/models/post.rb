class Post < ApplicationRecord
    has_many :comments, dependent: :destroy

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
