class Comment < ApplicationRecord
  belongs_to :article

  validates :commenter, presence:true
  validates :body, presence: true, length: { minimum: 5, maximum: 400}
end
