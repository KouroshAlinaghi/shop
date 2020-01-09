class Product < ApplicationRecord
  has_one_attached :photo
  has_many :comments, dependent: :destroy
  belongs_to :category
  has_and_belongs_to_many :carts
  has_and_belongs_to_many :orders
  validates :description, presence: true
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true
  validates :photo, presence: true
  validates :status, :inclusion => { :in => [true, false] }
end
