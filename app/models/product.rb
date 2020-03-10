class Product < ApplicationRecord
  is_impressionable
  self.per_page = 3
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

  scope :filter_by_status, -> (status) { where status: status }

  scope :filter_by_category_ids, -> (category_ids) {
    where(category_id: category_ids.map! { |c| c = Category.find(c.to_i).chain } .flatten)
  }

  scope :filter_by_search, -> (search) {
    where("name ILIKE ?", "%#{search}%")
    where("description ILIKE ?", "%#{search}%")
  }

  scope :filter_by_lowest_price, -> (min_price) {
    where("price >= #{min_price}")
  }

  scope :filter_by_highest_price, -> (max_price) {
    where("price <= #{max_price}")
  }

end
