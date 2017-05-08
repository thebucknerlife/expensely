module RequestsByUserDecorator

  def self.decorate(requests)
    grouped_by_user(requests).map do |user, user_requests|
      User.new(
        user.slice(:first_name, :last_name, :email)
      ).tap do |decorated_user|
        decorated_user.categories = user_requests
          .flat_map(&:request_items)
          .group_by do |item|
            item.category
          end.map do |category, items|
            Category.new(name: category, request_items: items)
          end
      end
    end
  end

  def self.grouped_by_user(requests)
    requests.group_by {|request| request.user }
  end

  class User
    include ::Initializable
    attr_accessor :first_name, :last_name, :email, :categories

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
  class Category
    include ::Initializable
    attr_accessor :name, :request_items

    def sum
      request_items.sum(&:amount)
    end
  end
end
