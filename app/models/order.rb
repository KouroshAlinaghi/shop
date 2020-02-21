class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy

  def user
    User.find_by(email: email)
  end

end
