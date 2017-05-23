module RequestsDecorator
  def self.decorate(requests)
    grouped_by_user(requests).map do |user, user_requests|
      User.new(user_attrs(user)).tap do |d_user|
        request_items_by_category = user_requests
        .flat_map(&:request_items)
        .group_by(&:category)

        d_user.categories = request_items_by_category.map do |category, items|
          request_items = items.map do |item|
            RequestItem.new(item_attrs(item)).tap do |i|
              i.receipt = Receipt.new(receipt_attrs(item.receipt))
            end
          end
          Category.new(name: category, request_items: request_items)
        end
      end
    end
  end

  def self.user_attrs(user)
    user.slice(:first_name, :last_name, :email)
  end

  def self.item_attrs(item)
    item.slice(:description, :amount, :paid_at)
  end

  def self.receipt_attrs(receipt)
    {
      url: receipt.accountant_url,
    }
  end

  def self.grouped_by_user(requests)
    requests.group_by {|request| request.user }
  end

  class User
    include ::Initializable
    include ActionView::Helpers
    attr_accessor :first_name, :last_name, :email, :categories, :receipts

    def name
      "#{first_name} #{last_name}"
    end

    def sum
      categories.sum(&:sum)
    end

    def total
      number_to_currency(sum/100.0)
    end
  end

  class Category
    include ::Initializable
    include ActionView::Helpers
    attr_accessor :name, :request_items

    def sum
      request_items.sum(&:amount)
    end

    def subtotal
      number_to_currency(sum/100.0)
    end
  end

  class RequestItem
    include ::Initializable
    include ActionView::Helpers
    attr_accessor :description, :paid_at, :amount, :receipt

    def date
      paid_at.try(:strftime, '%b %d, %Y')
    end

    def dollar_amount
      number_to_currency(amount/100.0)
    end
  end

  class Receipt
    include ::Initializable
    attr_accessor :url
  end
end
