class Category < ApplicationRecord
  validates :title, presence: true
  has_many :subcategories, :class_name => "Category", :foreign_key => "parent_id", :dependent => :destroy
  belongs_to :parent_category, :class_name => "Category", optional: true
  has_many :products, dependent: :destroy 
  validates :is_parent, :inclusion => { :in => [true, false] }

  def parent
    Category.find(parent_id) if parent_id
  end

  def chain
    c = self
    arr = [c.id]
    ch = ->(cat) do
      arr << cat.id
      for i in cat.subcategories
        arr << i.id
      end
    end
    while c.subcategories.any?
      for i in c.subcategories
        ch.call(i)
        c = i
      end
    end
    arr
  end

end
