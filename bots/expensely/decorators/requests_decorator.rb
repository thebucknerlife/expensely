module Expensely
  module Decorators
    module RequestsDecorator

      def self.review(requests)
        str = "Requests\n"
        reqs_string = requests.flat_map do |k, reqs|
          sub_str = [k.to_s.capitalize]
          foo = reqs.map do |req|
            req.new_request_url
          end
          sub_str = sub_str.concat foo
          sub_str.join("\n")
        end.join("\n")
        str << reqs_string
      end
    end
  end
end
