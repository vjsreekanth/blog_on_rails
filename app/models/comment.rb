class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  before_save :titleize_body
  
  validates(
    :body, 
    presence:true,
    length: { minimum: 5 }
  )

  def titleize_body
    self.body = self.body.titleize
  end

end