module CategoriesHelper

  def is_parent cat
    cat.parent_id.nil?
  end

  def depth cat
    depth = 0
    while cat.parent_id
      depth += 1
      cat = Category.find(cat.parent_id)
    end
    depth
  end

  def max_depth
    depths = []
    Category.all.each { |cat| depths << depth(cat) }
    depths.max
  end

  def set_groups
#    @groups = Category.all.group_by { |cat| depth cat } 
#    @groups.each_value do |arr| 
#      arr.each { |category| arr[arr.index category] = category.title }
#    end
#    @groups
     Category.all.group_by { |cat| depth cat }
  end

end
