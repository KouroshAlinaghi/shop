module CategoriesHelper

  def is_parent cat;  cat.parent_id.nil?; end

  def depth cat
    depth = 0
    while cat.parent_id
      depth += 1
      cat = Category.find(cat.parent_id)
    end
    depth
  end

end
