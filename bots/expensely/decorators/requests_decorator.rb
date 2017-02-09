module Expensely
  module Decorators
    module RequestsDecorator

      def self.review(requests)
        lines = ["Requests", ("=" * 30)]

        requests.each do |type, reqs|
          lines << type.to_s.humanize.split.map(&:capitalize).join(' ')

          reqs.each do |req|
            lines << format_request_link(req)
          end

          lines << "\n"
        end

        lines.join("\n").gsub(/(\n)*$/, "")
      end

      def self.format_request_link(request)
        url = request.new_request_url
        #name = request.name || "Request Number #{request.id}"
        #"* <#{url}|#{name}>"
      end
    end
  end
end
