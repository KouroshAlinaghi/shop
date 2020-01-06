class Comment < ApplicationRecord
  belongs_to :product
  belongs_to :user
  validates :body, presence: true
  validates :product_id, presence: true
  
end
