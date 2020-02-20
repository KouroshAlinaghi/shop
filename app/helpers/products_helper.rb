module ProductsHelper

  def status_to_string product
    return product.status ? 'Availabe' : 'Unaivalbe'
  end

end
