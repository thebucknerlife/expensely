class RequestsPdfGenerator
  def generate(requests)
    decorated = decorate(requests)
    html = render_html(decorated)
    WickedPdf.new.pdf_from_string(html)
  end

  def decorate(requests)
    RequestsByUserDecorator.decorate(requests)
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
