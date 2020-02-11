class Product < ApplicationRecord
  include Filterable
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

  scope :filter_by_status, -> (status) { where status: status == 'on' }
  scope :filter_by_category_ids, -> (category_ids) {
    category_ids.map! { |c| c = c.to_i }
    where(category_id: category_ids)
  }
  scope :filter_by_search, -> (search) {
    where("name ILIKE ?", "%#{search}%")
    where("description ILIKE ?", "%#{search}%")
  }

end
