class ShopOrderValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    unless is_valid_shop_order(value)
      record.errors[attribute] << 'is not a valid shop order.'
    end
  end

  def is_valid_shop_order(value)
    url = "http://remoteapi.varland.com:8882/v1/so?shop_order=292565#{value}"
    uri = URI(url)
    response = Net::HTTP.get(uri)

    if JSON.parse(response)["customer"].blank?
      false
    else
      true
    end
  end

end