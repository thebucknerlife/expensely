module RequestsDecorator

  def self.decorate(requests)
    grouped_by_user(requests).map do |user, user_requests|
      User.new(user_attrs(user)).tap do |d_user|
        request_items_by_category = user_requests
        .flat_map(&:request_items)
        .group_by(&:category)

        d_user.categories = request_items_by_category.map do |category, items|
          Category.new(name: category, request_items: items)
        end

        d_user.receipts = request_items_by_category.flat_map do |_category, items|
          items.map do |request_item|
            Receipt.new(receipt_attrs(request_item))
          end
        end
      end
    end
  end

  def self.user_attrs(user)
    user.slice(:first_name, :last_name, :email)
  end

  def self.receipt_attrs(request_item)
    {
      url: request_item.receipt.cloudinary_json['secure_url'],
      description: request_item.description
    }
  end

  def self.grouped_by_user(requests)
    requests.group_by {|request| request.user }
  end

  class User
    include ::Initializable
    attr_accessor :first_name, :last_name, :email, :categories, :receipts

    def name
      "#{first_name} #{last_name}"
    end

    def sum
      categories.sum(&:sum)
    end
  end

  class Category
    include ::Initializable
    attr_accessor :name, :request_items

    def sum
      request_items.sum(&:amount)
    end
  end

  class Receipt
    include ::Initializable
    attr_accessor :url, :description
  end
end
