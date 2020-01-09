class Order < ApplicationRecord
  belongs_to :cart
  has_one :user, through: :cart
  has_and_belongs_to_many :products

  validates :is_closed, :inclusion => { :in => [true, false] }

  def price
    price = 0
    for p in products
      price += p.price.to_f
    end
    price
  end

end
