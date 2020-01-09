class Cart < ApplicationRecord
  belongs_to :user
  has_many :orders
  has_and_belongs_to_many :products
  validates :user_id, uniqueness: true, presence: true
end
