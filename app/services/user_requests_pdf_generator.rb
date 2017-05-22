# may not need this
class UserRequestsPdfGenerator

  def generate(user, requests)
    decorated_requests  = decorate(requests: requests)
    html                = render_html(decorated_requests)
    WickedPdf.new.pdf_from_string(html)
  end

  def decorate(requests:)
    RequestsDecorator.decorate(requests)
  end

  def render_html(decorated_requests)
    ApplicationController.render(
      template: 'requests/index',
      layout: 'pdf',
      assigns: {
        decorated: decorated_requests
      }
    )
  end
end
